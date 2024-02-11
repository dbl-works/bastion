#!/bin/sh

#
# Environment Variables:
#   PERMITTED_GITHUB_USERNAMES - List of github usernames that can use this host
#

# keep in a function to avoid polluting the global namespace with variables
# that contain sensitive data
function pull_ssh_keys_from_github_and_write_to_authorized_keys() {
  local AUTHORIZED_KEYS=""

  #
  # to test this in zsh, run `for usr in $=PERMITTED_GITHUB_USERNAMES`
  # note the extra `=` sign that enables splitting by whitespace
  # read https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion
  #
  for usr in $PERMITTED_GITHUB_USERNAMES
  do
    local KEYS=$(curl -s https://github.com/$usr.keys)
    echo "Fetched $(echo $KEYS | wc -w | xargs) keys for user '$usr'"

    # Alpine/POSIX compliant way of adding new lines, since "\n" is treated as a literal character
    # also: must left-align here to avoid extra whitespace at the beginning of each line
    local comment="# github.com/$usr"
    local keys_block="$comment
$KEYS

"

    AUTHORIZED_KEYS="${AUTHORIZED_KEYS}${keys_block}"
  done

  echo "$AUTHORIZED_KEYS" > ~/.ssh/authorized_keys
  echo "...initializing of SSH keys complete."
}

echo "Initializing SSH keys..."

pull_ssh_keys_from_github_and_write_to_authorized_keys

echo "Ready to serve incoming SSH connections."

# Run command as is passed in
exec "$@"
