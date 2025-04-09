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

----
**GEMINI GENERATED NEEDS TO BE INSPECTED**


## Step 5: Running Initial Setup (run)

After abliterating through the macOS default changes and everything the next step of the bootstrap script is to try and install all the necessary additional things for the development enviroment. Util this posint everything that was done was nothing more then just setting up a new mac and changing the factory reset way that the macOS comes in. This part of the script now is all about installing apps and things to run the development enviroment. 

The [run script](../../run.sh) will be called which basically looks inside the [scripts dir](../../scripts) and executes them one by onem, some of those script just run some brew installs or taps others go do a bit more then that. Just for referance below is a full list of of all the scripts and more or less an explanation of what they do. 

*Note: There are comments/notes insdie each script file more or less detailing what each script does but most of them are pretty much self explanatory once you look at the code and if you are more or less familiar witth basic bash*


| Script File                               | Description                                      | 
| ----------------------------------------- | ------------------------------------------------ |
| [apps](../../scripts/apps.sh)             | Installs various apps through home brew          | 
| [aws](../../scripts/aws-credentials.sh)   | Install the AWS CLI                              | 
| [cdk](../../scripts/cdk)                  | Install AWS CDK                                  | 
| [aws-credentials](../../scripts/aws.sh)   | Configures AWS Credentials                       | 
| [borders](../../scripts/borders.sh)       | Install Borders with homebrew                    | 
| [git](../../scripts/git.sh)               | Configures Git Credentials                       | 
| [go](../../scripts/go.sh)                 | Installs Go Lang                                 | 
| [libs](../../scripts/libs.sh)             | Install additional tools                         | 
| [nvim](../../scripts/nvim.sh)             | Downsloads nvim latest version from git          | 
| [pullumi](../../scripts/pulumi.sh)        | Installs Pulumi                                  | 
| [terraform](../../scripts/terraform.sh)   | Installs Terraform                               | 
| [kubctl](../../scripts/kubectl.sh)        | Installs Kubctl                                  | 
| [minikube](../../scripts/minikube.sh)     | Installs Minikube (local kubernetes)             | 
| [tilt](../../scripts/tilt.sh)             | Installs Tilt                                    | 
| [sketchybar](../../scripts/sketchybar.sh) | Installs Sketchybar (replaces macOS top bar)     | 
| [tmux](../../scripts/tmux.sh)             | Installs Tmux                                    | 
| [node](../../scripts/node.sh)             | Installs Node                                    | 
| [zsh](../../scripts/zsh.sh)               | Installs ZSH                                     |


*Note: the order in each they show on the table above is not necessarly the order the files are structure in the folder*

## Step 6: Applying Environment Configuration (env/dev-env.sh)

There is a script file called dev-env that basically everytime you run it (unless with the flag `--dry-run`) it will absolutly Nuke everything you have inside your `$HOME/.config` and replace it with whatever is inside your `$HOME/personal/dev/env/.config`. 

Essential all configuration files for all the applications are stored in [env/.config/](../../env/.config/). There is also an alias `dev-env` that can be run from anywhere after this which calls this script [dev-env.sh](../../dev-env.sh). I recomend you to always run this first with the flag `--dry-mode`. This will give you a output of what the script will do before it actually does it.

**IMPORTANT: If you plan on using any of this or specially this script make sure to backup everything or just renaming or root `.config/` dir before you go beyound repair.**

-----
## Final Step

The final step of the [Bootstrap Script](../../bootstrap.sh) essential forces a restart to your computer. This is required because some of the changes that we have made will only take effect after a complete computer retart. So if after running all this your computer just goes black it kinda normal, its just restarting.





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
