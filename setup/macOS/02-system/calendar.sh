#!/usr/bin/env bash

echo "------------------- Calendar App ---------------------"

set -x

calendar_settings=(
    # ----------------- Viewing Options -----------------

    # Default calendar view (day=0, week=1, month=2, year=3)
    "CalendarViewStyle -int 1"

    # Start week on Monday (Sunday=0, Monday=1)
    "first day of week -int 1"

    # Show week numbers
    "ShowWeekNumbers -bool true"

    # Days per week to display (5 or 7)
    "n days of week -int 7"

    # Show declined events
    "Show Declined Events -bool false"

    # Show event times in month view
    # "Show time in month view -bool true"

    # Show event location in month view
    # "Show location in month view -bool true"

    # ----------------- Time & Date Format -----------------

    # Use 24-hour time
    "Use24HourTime -bool false"

    # Show events in year view
    "Show heat map in year view -bool true"

    # Show today's date in icon
    "ShowDateInDockIcon -bool true"

    # Default hours in day view (start hour, in 24hr format)
    "first hour of day -int 5"

    # Default event duration (in minutes)
    "Default duration in minutes -int 15"

    # ----------------- Alerts & Notifications -----------------
    # Play sound with alerts
    # "AlarmSoundName -string \"Basso\""

    # Default alert time for events (in minutes before event)
    "DefaultAlarmOffset -int 5"

    # Default alert time for all-day events (in seconds, 86400 = 1 day)
    "DefaultAlarmOffsetAllDay -int 86400"

    # Time to leave alerts based on location
    "TimeToLeaveEnabled -bool true"

    # ----------------- Calendar Week Numbers -----------------
    # Week numbering system (0=US, 1=ISO)
    "CalendarWeekNumberingSystem -int 1"

    # ----------------- New Events -----------------
    # Default calendar for new events (use calendar ID, e.g., "calendar_ID_here")
    # "DefaultCalendarIdentifier -string \"calendar_ID_here\""

    # Time zone support for events
    "TimeZoneSupport -bool true"

    # Add invitees without asking
    "AddInviteesWithoutAskingOnNewEvents -bool false"

    # Show invitee decline reason
    "ShowInviteeDeclineReasonOnNewEvents -bool true"

    # ----------------- Apperance -----------------
    # Show calendar sidebar
    "CalendarSidebarVisible -bool true"

    # Show mini-month in sidebar
    "MiniMonthVisible -bool true"

    # Show current date in red
    "HighlightCurrentDate -bool true"

    # Calendar uses bold font (events and day numbers)
    "CalendarUseBoldFonts -bool true"

    # Scroll in week view when using arrow keys
    "ScrollWeekViewToWorkingHours -bool true"

    # ----------------- Birthdays Calendr -----------------
    # Show birthdays calendar
    "BirthdaysCalendarVisible -bool true"

    # ----------------- Invitations -----------------
    # Automatically retrieve invitations from Mail
    "AutomaticallyRetrieveInvitationsFromMail -bool true"

    # Show shared calendar messages in Notification Center
    "SharedCalendarNotificationsEnabled -bool true"

    # Suggest invitees from previous events
    "SuggestInviteesFromPreviousEvents -bool true"

    # ----------------- Search  -----------------
    # Search across all calendars by default
    "SearchScope -int 2"

    # ----------------- Advanced -----------------
    # Days per week in custom view
    "days in custom view -int 5"

    # Enable calendar URLs (webcal://)
    "EnableCalendarURLs -bool true"

    # Warn before sending updates to all attendees
    "WarnBeforeSendingUpdates -bool true"
)

# Apply
for setting in "${calendar_settings[@]}"; do
    defaults write com.apple.iCal $setting
done

# Restart Calendar app to apply changes
killall Calendar

set +x
