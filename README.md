# Personal Dev Env (MacOS) v2

This repository contains all my personal configurations for setting up a new Mac as well as my current development environment.

## Fresh New Mac Setup

To get started with a new Mac, just open the default macOS Terminal and copy and paste the command shown below.

This will kick off a series of script files that will both change a lot of system default configurations on your Mac, install a bunch of applications, and remove a bunch of default apps and settings that come installed by default on macOS.

For a full explanation and guide of what this bootstrap script does and what sub-scripts it runs, please check the [documentation here](./).

```bash
curl -fsSL https://raw.githubusercontent.com/luismmadeirac/dev-env-v2/main/setup/bootstrap.sh | bash
```

**[IMPORTANT]:**

If you currently have your Mac already set up and running the way you want it, make sure not to run the script above. That script not only changes a LOT of macOS system defaults, it also removes a lot of applications and configurations that you most likely do not intend to have completely removed from your system.

## Dev Env

There is a script called [dev-env](./) that's mostly responsible for the development setup. If you are only interested in the development environment part of this repository, maybe start from there. You can get more detailed information about how it all works in the [Dev Environment - Getting Started](./).

## Random Stupid Scripts

There are a couple of scripts in the [scripts dir](./env/.local/scripts) that are absolutely worthless and get mapped in the [.zsh_alias_scripts]().
