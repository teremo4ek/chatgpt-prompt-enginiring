#!/bin/sh

# @raycast.schemaVersion 1
# @raycast.title Summarize Safari page
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon ✨
#
# @raycast.packageName Things

set -e

# Check if Safari is the frontmost application
isFrontmost=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true')
if [ "$isFrontmost" != "Safari" ]; then
  echo "Safari is not in focus. Please focus the Safari window and try again."
  exit 1
fi

content=$(osascript -e '
tell application "Safari"
    set theText to text of front document
end tell
')

echo "$content" | OPENAI_OMIT_HISTORY=true OPENAI_API_KEY=sk-хххххх chatgpt "Please summarize the main points in a few sentences. Then, list up to five detailed bullet points. Provide the response in plain text. Finally, include a sentiment analysis of the text. Do not add any additional information."

# requires chatgpt-cli installed, see https://github.com/kardolus/chatgpt-cli.
# requires OPENAI_API_KEY
# to change the model use `chatgpt --set-model=<model>`
