#!/usr/bin/env sh

base_url="https://$HOST"
base_download_url="https://github.com/$REPO/releases/download"

latest=$LATEST_TAG
new=$NEW_TAG
diff="$(git diff "$latest".."$new" --name-status | grep "$LIB")"

[ -z "$diff" ] && exit 0

n=$(echo "$diff" | wc -l | xargs)
body="This release updates **${n}** asset$(if [ "$n" -gt 1 ]; then echo "s"; fi).<br>"
body="$body<table><tr><th>Filename</th><th>Status</th><th><code>$latest</code></th><th><code>$new</code></th></tr>"

while read -r d; do
  l=$(echo "$d" | cut -c1)
  f=$(echo "${d#"$l"}" | xargs)
  fn=$(echo "$f" | sed "s/$LIB\///g")

  case $l in
    A)
      body="$body<tr><td><code>$fn</code></td><td>Added</td><td></td><td align=\"center\"><img src=\"$base_url/$fn?v=$new\" height=\"40\"></td></tr>"
      ;;
    M)
      body="$body<tr><td><code>$fn</code></td><td>Modified</td><td align=\"center\"><img src=\"$base_url/$fn?v=$latest\" height=\"40\"></td><td align=\"center\"><img src=\"$base_url/$fn?v=$new\" height=\"40\"></td></tr>"
      ;;
    D)
      body="$body<tr><td><code>$fn</code></td><td>Deleted</td><td align=\"center\"><img src=\"$base_url/$fn?v=$latest\" height=\"40\"></td><td></td></tr>"
      ;;
  esac
done << EOF
$diff
EOF

echo "$body</table>"
