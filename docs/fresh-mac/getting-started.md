# Fresh Mac Configuration - Getting Started Guide

When you have just finished configuring your Mac, unless it's part of some MDM configuration of some sort, you should not have Git installed or anything similar. If you do, why would you be using this guide?

After completing the default macOS configuration steps, however many there are nowadays, run the following script through your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/luismmadeirac/dev-env/main/bootstrap.sh | bash
```

*Note: I will try to make this work later for both Windows. The Linux implementation, unfortunately, is not part of this repo for the moment.*

## Step 1

Once you execute this script, the first thing it will do is check for [HomeBrew](https://brew.sh/) (which should also not be installed on a brand new machine). It will then proceed to install Homebrew on your system. If it is already installed on your system for some reason, it will then try to update it.

## Step 2

Now that Homebrew should be installed, you should see the version of Homebrew being output to the console. It will then immediately start to install git on your system.

## Step 3


The script will check if you have a personal directory; if not, it will create one at $HOME/personal. Once this has been created, it will clone this entire repository into that newly created folder (or the existing one if the folder already existed previously).

## Step 4 [DANGER]


I will reiterate: if you like the normal configuration of macOS and find it enjoyable, do not run this. Anyways, Step 4 will run the [MacOS init Script](../../resources/mac/init.sh). This script will do many, many things. To highlight a few:

- Your `Caps Lock` will no longer be Caps Lock; it will become `Control` (Why? Why not? - Told you this configuration is highly personal).
- Your Screenshots will no longer end up on the Desktop like you expect them to.
- A bunch of default applications (like Numbers, Keynote, GarageBand, etc.) will be completely Nuked from the system.
- Your macOS Top Bar will disappear.
- The mouse sensativity will be at the absolute MAX
- etc... 

I think you get the point by now this will just perform way too many System changes, that honestly you may or may not want.

I advice you to Investigate further what each script does and maybe twick them before running the `bootstrap` blindly. I've attached a list of the System Scripts below so you can reference the actual scripts and check them. I believe the scripts a pretty self explanatory and contian enough notes so you know what does what.


## List of MacOs System Script

The table below is a list of quick links to all the scripts used in the macOS configuration so you can easily reference and jump to them.

*Side note: The order in which the scripts are listed below is the actual order in which the scripts get executed through the[Init](../../resources/mac/init.sh)*


| Script Name (Link)                                             | Description                                                                  | 
| -------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Nuke Init Apps](../../resources/mac/ActivityMonitor.sh)       | Script responsible for basically Nuking some of macOS default apps           | 
| [System Preferences](../../resources/mac/sys-preferences.sh)   | Updates various system preferences                                           |   
| [Energy](../../resources/mac/energy.sh)                        | Makes changes to the battery settings on Mac                                 | 
| [Finder](../../resources/mac/Finder.sh)                        | Makes changes to Finder view settings                                        | 
| [Activity Monitor](../../resources/mac//ActivityMonitor.sh)    | Small changes to the macOS Activity Monitor app                              | 
| [Peripherals](../../resources/mac/peripherals.sh)              | Sets trackpad to maximum speed and configures other settings                 | 
| [UI](../../resources/mac/ui.sh)                                | Makes things disappear and change behavior                                   | 
| [Dock](../../resources/mac/dock.sh)                            | Hides the Dock by default, disables animations, and changes its location     | 
| [Desktop](../../resources/mac/desktop.sh)                      | Hides files by default on the Desktop                                        | 
| [ScreenShots](../../resources/mac/screenshots.sh)              | Changes the default format type of screenshots and their location            | 
| [Terminal](../../resources/mac/terminal.sh)                    | Various default macOS Terminal changes                                       | 
| [Safari](../../resources/mac/Safari.sh)                        | Enables the Safari debug menu for development                                | 
| [Mail](../../resources/mac/mail.sh)                            | Changes a variety of settings in the default macOS Mail App                  |   
| [Calendar](../../resources/mac/calendar.sh)                    | Changes various settings on the default Calendar App on Mac                  |
