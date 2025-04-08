# Dev Env

XX min script to setup new mac.

## Getting Started

**[IMPORTANT]: There's a nuke script in [./resources/mac/nuke-init-apps.sh](./resources/mac/nuke-init-apps.sh) that just kills / deletes a bunch of default mac-os apps. If you don't want to have that happen then update that file or just remove it from [./resources/mac/init.sh](./resources/mac/init.sh)**

### Run

Copy and past the command below, this will run the entire thing, no need to have git installed or anything installed at this point, simply run this, script on terminal and let it go.

```bash
curl -fsSL https://raw.githubusercontent.com/luismmadeirac/dev-env/main/mac-bootstrap.sh | bash
```

If you have git installed already just clone the repo.


## Some of my ZSH Alias

Below is a table of some of the alias configured in [zsh alias file](./env/.zsh_alias) just for reference you can very well just delete this... they very specific to some annoying personal things with myself.

| Alias | What the hell it does | 
| --- | --- | 
| nr | Calls [next-race.sh](./env/.local/scripts/next-race.sh) script which basically returns the next upcoming F1 Race | 
| bo | Calls [blackout.sh](./env/.local/scripts/backout.sh) script which basically makes macos background to the color black |
| bg | Calls [background.sh](./env/.local/scripts/background.sh) script which basically returns a list of background wallpaper options located in [backgrounds dir](./backgrounds/). <br /> <br /> (Like i said useless sometimes 90% of the time im in blackout `bo` but ocasionally put something on the wallpaper, you can just add wallpaper images to the [backgrounds dir](./backgrounds/) and when u run `bg` they will be listed based on the file name of the) |
| wifi | Calls [wifi.sh](./env/.local/scripts/wifi.sh) script which basically kills the wifi on macos (useful for me for some reaons when i'm connected through ethernet sometimes i get issues between wifi and the ethernet so this just turns off wifi completely) |
| password |  Calls [password.sh](./env/.local/scripts/password.sh) simply outputs a random password, sort of like password generator |
| kp |  Kill Process, Calls [kill-process.sh](./env/.local/scripts/kill-process.sh) kills processes on macos pre self explanatory |
| ht |  So, so, so useful (not at all!) Calls [world-hour.sh](./env/.local/scripts/world-hour.sh) basically outputs the hour in different timezones. Really just use this for very specific cases when I need to know the hour in some specific reacurent timezones and I'm too lazy to google it |

## Random Stupid Scripts

There are a couple of scripts in the [scripts dir](./env/.local/scripts), that are absolutly worthless. 

One of those scripts is mapped with an [alias](./env/.zsh_alias) as `nr` this script basically just lists out the next upcoming F1 Race by pulling the data from a [f1 schedule txt file](./env/.local/scripts/f1_schedule.txt);

## Repo Structure

```tree
.
├── env/ # Dev Env Configuations
│   ├── .config/
│   ├── scripts/
│   ├── .zsh_profile
│   ├── .zshrc
├── scripts/
├── resrouces/
│   ├── mac/ # Various mac-os default overwrites
├── bootstrap.sh
├── dev-env.sh # Setup env/
└── run.zsh # Runs all scripts/
```