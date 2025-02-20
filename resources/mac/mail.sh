#!/usr/bin/env bash

echo "------------------- Mail App  ---------------------"

# Enable Command Tracking
set -x

mail_settings=(
    # ----------------- Viewing & Reading -----------------
    # Set default message list font size
    "MessageListFont -string \"System 12\""

    # Set message font size in points
    "MessageFont -string \"System 14\""

    # Show contact photos in the message list
    "EnableContactPhotos -bool true"

    # Organize mail by conversation threads
    "OrganizeByThread -bool true"

    # Number of messages to show in conversations
    "ConversationViewSpanSize -int 20"

    # Mark all messages in conversation as read when opening
    "ConversationViewMarkAllAsRead -bool false"

    # Hide deleted messages (move straight to trash)
    "HideDeletedMessages -bool true"

    # Show To/Cc label in message list
    "EnableToCcIndicator -bool true"

    # ----------------- Composing -----------------
    # Set composing font and size
    "ComposingFont -string \"System 14\""

    # Automatically Cc yourself when sending mail
    "AlwaysCcMyself -bool false"

    # Automatically Bcc yourself when sending mail
    "AlwaysBccMyself -bool false"

    # Use the same format for replies as the original message
    "AutoReplyFormat -bool true"

    # Default Rich Text formatting for new messages (use false for plain text)
    "ComposePlainText -bool false"

    # Include original attachment with replies
    "IncludeAttachmentsWithReply -bool false"

    # Include all attachments when forwarding
    "IncludeAttachmentsWithForward -bool true"

    # ----------------- Signatures -----------------
    # Automatically append signature to messages
    "SignatureEnabled -bool true"

    # Place signature above quoted text
    "SignaturePlacedAboveQuotedText -bool true"

    # ----------------- Attachments -----------------
    # Send attachments with Windows-friendly filenames
    "SendWindowsFriendlyAttachments -bool true"

    # When sending large attachments, offer to use Mail Drop
    "MailDropUsageForLargeAttachments -bool false"

    # Default size threshold for Mail Drop (in bytes - 15MB = 15728640)
    # "MailDropSizeThreshold -int 15728640"

    # ----------------- Notifications -----------------
    # Play sounds for new mail
    "NewMailSoundEnabled -bool true"

    # Set the new mail sound (must be in /System/Library/Sounds/)
    "NewMailSoundName -string \"Ding\""

    # Badge dock icon with unread count
    "BadgeUnreadCount -bool true"

    # ----------------- Accounts & Privacy -----------------
    # Load remote content in messages
    "LoadRemoteContent -bool false"

    # Automatically update contacts when receiving emails
    "AutomaticallyUpdateContacts -bool false"

    # Ask before deleting messages
    "ConfirmDelete -bool true"

    # ----------------- Layout & Display -----------------
    # Show Favorites bar
    "ShowFavoritesBar -bool true"

    # Default sort order for messages (date received)
    "DefaultMessageListSortOrder -int 0"

    # Display messages in preview (0=no preview, 1=1 line, 2=2 lines, etc)
    "NumberOfSnippetLines -int 2"

    # Show all message headers (expanded view)
    "AlwaysShowFullHeaders -bool false"

    # Show contact first name only
    "ShowFirstNameOnly -bool false"

    # ----------------- Search -----------------
    # Include Smart Mailboxes when searching
    "SearchSmartMailboxes -bool true"

    # Include trash when searching
    "SearchTrash -bool false"

    # Include junk mail when searching
    "SearchJunk -bool false"
)

# Apply
for setting in "${mail_settings[@]}"; do
    defaults write com.apple.mail $setting
done

# Restart Mail app to apply changes
killall Mail

set +x
