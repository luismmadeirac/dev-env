# Fresh Mac Configuration - Getting Started Guide

When you just finished configuring your mac unless is part of some MDM configuration of some sorts, your should not have git installed or anything like that and if so why the hell would you be using this...

After completing the default mac os configuration setps whatever how many they are nowdays, run the following script throught your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/luismmadeirac/dev-env/main/bootstrap.sh | bash
```

*Note: I will try make this work later for both Windows the Linux Implementation unfortunetly is not part of this repo for the moement.*

## Step 1

Once you execute this script the first things it will do is check for [HomeBrew](https://brew.sh/) (basically it should also not be installed on a brand new machine) It will then proceed to install homebrew into your system if it is already install into your system for some reaons it will then try and update it.

## Step 2

Now that homebrew should be installed you should see the version of home brew being outputed to the console. It will then straight away start to install `git` into your system. 

## Step 3

The script will check if you have a personal directory if not create one at `$HOME/personal`. Once this has been created then it will clone this entire repository into that folder just created (or existing in case the folder already existed prior).

## Step 4 [DANGER]

I will iterate again if you like the normal configuration of MacOS and find it enjoyable do not run this... Anyways, step 4 will run a the [MacOS init Script](../../resources/mac/init.sh); This script will do many, many things. To highlight some: 

- Your `Caps Lock` no longer will be that will become `Control` (why ? Why not ? - Told you this configu is highly personal)
- Your ScreenShoots will no longer endup in Desktop like you expect them too
- A bunch of default applications like (Numbers, Keynote, Garageband, Etc..) will completely be Nuked out of the System
- Your Top Bar from mac-os will dissaper
- The mouse sensativity will be at the absolute MAX
- etc... 

I think you get the point by now this will just perform way too many System changes, that honestly you may or may not want.

I advice you to Investigate further what each script does and maybe twick them before running the `bootstrap` blindly. I've attached a list of the System Scripts below so you can reference the actual scripts and check them. I believe the scripts a pretty self explanatory and contian enough notes so you know what does what.


## List of MacOs System Script

The table below is a list of quick links to all the scripts in used int he mac configuration so you can easily reference and jump to them.

*Side note: The order in which the scripts are listed below is the actual order in which the scripts get executed through the [Init](../../resources/mac/init.sh)*


| Script Name (Link)                                             | Description          | 
| -------------------------------------------------------------- | -------------------- |
| [Nuke Init Apps](../../resources/mac/ActivityMonitor.sh)       | short description... | 
| [System Preferences](../../resources/mac/sys-preferences.sh)   | short description... |   
| [Energy](../../resources/mac/energy.sh)                        | short description... | 
| [Finder](../../resources/mac/Finder.sh)                        | short description... | 
| [Activity Monitor](../../resources/mac//ActivityMonitor.sh)    | short description... | 
| [Peripherals](../../resources/mac/peripherals.sh)              | short description... | 
| [UI](../../resources/mac/ui.sh)                                | short description... | 
| [Dock](../../resources/mac/dock.sh)                            | short description... | 
| [Desktop](../../resources/mac/desktop.sh)                      | short description... | 
| [ScreenShots](../../resources/mac/screenshots.sh)              | short description... | 
| [Terminal](../../resources/mac/terminal.sh)                    | short description... | 
| [Safari](../../resources/mac/Safari.sh)                        | short description... | 
| [Mail](../../resources/mac/mail.sh)                            | short description... | 
| [Calendar](../../resources/mac/calendar.sh)                    | short description... |
