#!/bin/bash

# Default styles
spaces=(
  ignore_association=on
  updates=on
  associated_display=1
  background.height=16
  margin_left=10
  icon.padding_left=$PADDINGS
  icon.padding_right=$PADDINGS
  label.drawing=off
  label.padding_left=0
  label.padding_right=$PADDINGS
)

# Define spaces
space_properties="[
  {
    \"icon\": \"$ICON_WEB\",
    \"label\": \"\",
    \"color\": \"cyan\"
  },
  {
    \"icon\": \"$ICON_MAIL\",
    \"label\": \"\",
    \"color\": \"orange\"
  },
  {
    \"icon\": \"$ICON_TERM\",
    \"label\": \"\",
    \"color\": \"teal\"
  },
  {
    \"icon\": \"$ICON_MUSIC\",
    \"label\": \"\",
    \"color\": \"red\"
  },
  {
    \"icon\": \"$ICON_FIGMA\",
    \"label\": \"\",
    \"color\": \"blue\"
  },
  {
    \"icon\": \"$ICON_DOCUMENTS\",
    \"label\": \"\",
    \"color\": \"purple\"
  }
]"

# Get number of spaces from Aerospace
SPACE_COUNT=$(aerospace --query spaces | jq '. | length')
if [[ -z "$SPACE_COUNT" || "$SPACE_COUNT" -eq 0 ]]; then
  # Fallback if Aerospace query fails
  SPACE_COUNT=$(echo "$space_properties" | jq '. | length')
fi

for ((SID = 1; SID <= SPACE_COUNT; SID++)); do
  SIDJSON=$((SID - 1))

  # Make sure we don't go beyond our defined properties
  if [[ $SIDJSON -lt $(echo "$space_properties" | jq '. | length') ]]; then
    SPACE_COLOR=$(getcolor $(echo "$space_properties" | jq -r .[$SIDJSON].color))
    SPACE_ICON=$(echo "$space_properties" | jq -r ".[$SIDJSON].icon")
    SPACE_LABEL=$(echo "$space_properties" | jq -r ".[$SIDJSON].label")
  else
    # Default values for spaces beyond our defined properties
    SPACE_COLOR=$(getcolor white)
    SPACE_ICON=$ICON_APP
    SPACE_LABEL=""
  fi

  sketchybar --add space space.$SID left \
    --set space.$SID "${spaces[@]}" \
    associated_space=$SID \
    icon=$SPACE_ICON \
    label=$SPACE_LABEL \
    icon.highlight_color=$SPACE_COLOR \
    label.highlight_color=$SPACE_COLOR \
    script="$PLUGIN_DIR/app_space_simple.sh $SID $SPACE_COLOR" \
    --subscribe space.$SID mouse.clicked space_change front_app_switched
done
