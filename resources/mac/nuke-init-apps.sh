#!/usr/bin/env bash

echo "------------------- NUKE SOME MACOS APPS  ---------------------"

# Remove GarageBand and associated files
echo "Deleting GarageBand"
sudo /bin/rm -rf /Applications/GarageBand.app
sudo /bin/rm -rf /System/Applications/GarageBand.app
sudo /bin/rm -rf /Library/Application\ Support/GarageBand/
sudo /bin/rm -rf /Library/Audio/Apple\ Loops/
sudo /bin/rm -rf ~/Library/Application\ Support/GarageBand/
sudo /bin/rm -rf ~/Library/Containers/com.apple.garageband/

# Remove iMovie and associated files
echo "Removing iMovie..."
sudo /bin/rm -rf /Applications/iMovie.app
sudo /bin/rm -rf /System/Applications/iMovie.app
sudo /bin/rm -rf /Library/Application\ Support/iMovie/
sudo /bin/rm -rf ~/Library/Containers/com.apple.iMovieApp/
sudo /bin/rm -rf ~/Library/Application\ Support/iMovie/

# Remove Pages
echo "Removing Pages..."
sudo /bin/rm -rf /Applications/Pages.app
sudo /bin/rm -rf /System/Applications/Pages.app
sudo /bin/rm -rf ~/Library/Containers/com.apple.Pages/
echo "Pages removed."

# Remove Numbers
echo "Removing Numbers..."
sudo /bin/rm -rf /Applications/Numbers.app
sudo /bin/rm -rf /System/Applications/Numbers.app
sudo /bin/rm -rf ~/Library/Containers/com.apple.Numbers/
echo "Numbers removed."

# Remove Keynote
echo "Removing Keynote..."
sudo /bin/rm -rf /Applications/Keynote.app
sudo /bin/rm -rf /System/Applications/Keynote.app
sudo /bin/rm -rf ~/Library/Containers/com.apple.iWork.Keynote/
echo "Keynote removed."

# Remove News app
echo "Removing News app..."
sudo /bin/rm -rf /Applications/News.app
sudo /bin/rm -rf /System/Applications/News.app
sudo /bin/rm -rf ~/Library/Containers/com.apple.news/
echo "News app removed."

# Remove Stocks app
echo "Removing Stocks app..."
sudo /bin/rm -rf /Applications/Stocks.app
sudo /bin/rm -rf /System/Applications/Stocks.app
sudo /bin/rm -rf ~/Library/Containers/com.apple.stocks/
echo "Stocks app removed."

# Remove Podcasts app
echo "Removing Podcasts app..."
sudo /bin/rm -rf /Applications/Podcasts.app
sudo /bin/rm -rf /System/Applications/Podcasts.app
sudo /bin/rm -rf ~/Library/Containers/com.apple.podcasts/
echo "Podcasts app removed."

# Remove Chess app
echo "Removing Chess app..."
sudo /bin/rm -rf /Applications/Chess.app
sudo /bin/rm -rf /System/Applications/Chess.app
echo "Chess app removed."

# Remove Stickies app
echo "Removing Stickies app..."
sudo /bin/rm -rf /Applications/Stickies.app
sudo /bin/rm -rf /System/Applications/Stickies.app
sudo /bin/rm -rf ~/Library/Containers/com.apple.Stickies/
echo "Stickies app removed."

# Clear caches
echo "Clearing caches..."
sudo /bin/rm -rf /Library/Caches/*
sudo /bin/rm -rf ~/Library/Caches/*
echo "Caches cleared."

# Force empty trash
echo "Emptying trash..."
sudo rm -rf ~/.Trash/*
echo "Trash emptied."
