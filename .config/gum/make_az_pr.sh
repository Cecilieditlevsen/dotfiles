#!/bin/bash

gum style --border normal --margin "1" --padding "1 2" --border-foreground "#8ec07c" "Making a pull-request!"

echo -e "What should the PR title be?"
TITLE=$(gum input --placeholder "Title")

echo -e "What should the PR description be?"
DESCRIPTION=$(gum write --placeholder "Description (ctrl+d to finish)")

echo -e "What work-items relates to this PR?"
WORK_ITEMS=$(gum input --placeholder "Work items")

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


echo-e "$(gum style --bold --padding "5 0" --foreground "	#458588" "Pull-request summary:")"
echo -e "$(gum style --foreground "#8ec07c" "The PR title is: ")$TITLE"
echo -e "$(gum style --foreground "#8ec07c" "The PR description is: ")$DESCRIPTION"
echo -e "$(gum style --foreground "#8ec07c" "The work items are: ")$WORK_ITEMS"
echo -e "$(gum style --foreground "#8ec07c" "Reviewers are: ")$REVIEWERS"
echo -e "$(gum style --foreground "#8ec07c" "Is marked as draft: ")$IS_DRAFT"

gum confirm --selected.background "#d79921" "Does this look right? 🙈" && IS_CONFIRMED=true || IS_CONFIRMED=false

clear

if [ "$IS_CONFIRMED" = true ]; then
  echo -e "Generating pull-request command"
  sleep 1
  echo -e "$(gum style --bold --foreground "#8ec07c" "Here is what you need to create a PR 🎉")"
  echo -e "az repos pr create --title \"$TITLE\" --description \"$DESCRIPTION\" --work-items \"$WORK_ITEMS\" --draft $IS_DRAFT --reviewers $REVIEWERS"
else
  echo -e "Exiting..."
fi











