#!/bin/bash

set -e

gum style --border normal --margin "1" --padding "1 2" --border-foreground "#8ec07c" "Making a pull-request!"

echo -e "What should the PR title be?"
TITLE=$(gum input --placeholder "Title")

echo -e "Make a PR description"
DESCRIPTION=$(gum write --char-limit "0" --placeholder "Description")

echo -e "What work-items relates to this PR?"
WORK_ITEMS=$(az boards query --org https://dev.azure.com/Dagrofa -o json --wiql "SELECT
    [System.Id],
    [System.Title]
FROM workitems
WHERE
    [System.AssignedTo] = @me")

IDS=($(echo $WORK_ITEMS | jq '.[].fields."System.Id"'))

SELECTED_WORK_ITEM=$(gum choose  --cursor-prefix "[ ] " --selected-prefix "[✓] "  --no-limit  ${IDS[@]})


REVIEWER_ONE="Kristoffer Kjelde"; REVIEWER_TWO="Magdalena Otrebska"
echo -e "Who should review this code? (press space to select)"
ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit "$REVIEWER_ONE" "$REVIEWER_TWO")

REVIEWERS=""

grep -q "$REVIEWER_ONE" <<< "$ACTIONS" && REVIEWERS="$REVIEWERS \"$REVIEWER_ONE\""
grep -q "$REVIEWER_TWO" <<< "$ACTIONS" && REVIEWERS="$REVIEWERS \"$REVIEWER_TWO\""

echo -e "Set as draft"
IS_DRAFT=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --limit=1 "true" "false")

clear

gum spin -s monkey --title "Summarizing pull-request" -- sleep 1

echo -e "$(gum style --bold --padding "5 0" --foreground "    #458588" "Pull-request summary:")"
echo -e "$(gum style --foreground "#8ec07c" "The PR title is: ")$TITLE"
echo -e "$(gum style --foreground "#8ec07c" "The PR description is: ")\n$(gum format -- "$DESCRIPTION")"
echo -e "$(gum style --foreground "#8ec07c" "The work items are: ")$SELECTED_WORK_ITEM"
echo -e "$(gum style --foreground "#8ec07c" "Reviewers are: ")$REVIEWERS"
echo -e "$(gum style --foreground "#8ec07c" "Is marked as draft: ")$IS_DRAFT"

gum confirm --selected.background "#d79921" "Does this look right? 🙈" && IS_CONFIRMED=true || IS_CONFIRMED=false

clear

if [ "$IS_CONFIRMED" = true ]; then
  $(gum spin -s line --title "Generating pull-request" -- sleep 1)
  clear
  echo -e "$(gum style --bold --foreground "#8ec07c" "PR script copied to clipboard🎉")"
  echo "az repos pr create --title \"$TITLE\" --description \"$DESCRIPTION\" --work-items \"$WORK_ITEMS\" --draft $IS_DRAFT --reviewers $REVIEWERS" | pbcopy
  echo "az repos pr create --title \"$TITLE\" --description \"$DESCRIPTION\" --work-items \"$WORK_ITEMS\" --draft $IS_DRAFT --reviewers $REVIEWERS"
else
  echo -e "Exiting..."
  sleep 1
  clear
  exit 1
fi
