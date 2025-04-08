# Personal Dev Environment

This repo contains all my personal configurations for setting up a new Mac as well as my current development environment. 

## Fresh new Mac Setup

To get started with a new Mac, just open the default MacOS Terminal and copy and paste the command shown below. This will kick off a series of script files that will both change a lot of System default configurations on your Mac, install a bunch of crap, and nuke a bunch of default Apps and stuff that comes installed by default on MacOS. 

For a full explanation and guide of what this bootstrap script does and what sub-scripts it runs, please check the [documentation here](./docs/fresh-mac/getting-started.md);


```bash
curl -fsSL https://raw.githubusercontent.com/luismmadeirac/dev-env/main/bootstrap.sh | bash
```

**[IMPORTANT]:**

If you currently have your Mac already set up and running like you want it, make sure not to run the script above. That script not only changes a LOT of MacOS System defaults, it also nukes a lot of applications and configurations that most likely you do not intend to have completely nuked from your system.


## Dev Env

There is a script called [dev-env](./dev-env.sh) that's mostly responsible for the development setup. If you are only interested in the development environment part of this repository, maybe start from there. You can get more detailed information of how it all works in the [Dev Enviroment - Getting Starter](./docs/dev-enviroment/getting-started.md).

## ZSH Alias References

Below is a table of some of the aliases configured in the [zsh alias file](./env/.zsh_alias) just for reference. You can very well just delete this... they're very specific to some annoying personal things with myself.

| Alias | What the hell it does | 
| --- | --- | 
| nr | Calls [next-race.sh](./env/.local/scripts/next-race.sh) script which basically returns the next upcoming F1 Race | 
| bo | Calls [blackout.sh](./env/.local/scripts/backout.sh) script which basically makes macOS background the color black |
| bg | Calls [background.sh](./env/.local/scripts/background.sh) script which basically returns a list of background wallpaper options located in [backgrounds dir](./backgrounds/). <br /> <br /> (Like I said, useless sometimes. 90% of the time I'm in blackout bo but occasionally put something on the wallpaper. You can just add wallpaper images to the [backgrounds dir](./backgrounds/) and when you run `bg` they will be listed based on the file name) | 
| wifi | Calls [wifi.sh](./env/.local/scripts/wifi.sh) script which basically kills the wifi on macOS (useful for me for some reasons when I'm connected through ethernet, sometimes I get issues between wifi and the ethernet so this just turns off wifi completely) |
| password |  Calls [password.sh](./env/.local/scripts/password.sh) which simply outputs a random password, sort of like a password generator |
| kp | Kill Process, Calls [kill-process.sh](./env/.local/scripts/kill-process.sh) which kills processes on macOS, pretty self-explanatory |
| ht | So, so, so useful (not at all!) Calls [world-hour.sh](./env/.local/scripts/world-hour.sh) which basically outputs the hour in different timezones. Really just use this for very specific cases when I need to know the hour in some specific recurrent timezones and I'm too lazy to google it |
| dev-env | Be careful with this one... or at least run it first with --dry-run |
| toggle-theme | Well this is a hard one to explain, hmmm. Well, it toggles between light and dark on Mac |
| dark | Why do I even have this... am I really that lazy to type `toggle-theme`... well this just sets the theme to dark on macOS |
| light | Guess what, genius, this toggles it back to white theme |
| afk | [All explanation you need](https://www.youtube.com/shorts/PHjAzY_VPtE) |


## Random Stupid Scripts

There are a couple of scripts in the [scripts dir](./env/.local/scripts) that are absolutely worthless.

One of those scripts is mapped with an [alias](./env/.zsh_alias) as `nr`. This script basically just lists out the next upcoming F1 Race by pulling the data from an [f1 schedule txt file](./env/.local/scripts/f1_schedule.txt)

## Repository Structure

```
.
├── backgrounds/
├── bootstrap.sh
├── dev-env.sh
├── docs/
├── env/
│   ├── .config/
│   ├── .local/scriptss
│   ├── .zsh_alias
│   ├── .zsh_profile
│   └── .zshrc
├── README.md
├── resources/
│   └── mac/
├── run.sh
└── [scripts](./scripts/)
```