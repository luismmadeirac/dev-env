# Development Environment Configuration - Getting Started Guide


<p style="color: red">
    <strong>Important Disclaimer</strong>
</p>

If you clone this repo and just simply execute the [dev-env.sh](../../dev-env.sh) script that will absolutly Nuke all the configuration files you have in your current `$HOME/.config` directory... so, kinda be careful before actually running that script ?! Make sure that's really what you want to do


## Getting Started

In a nut shell this basically removes all nukes aka (deletes) the current `$HOME/.config/` dir and replaces it with the `.config` that is configured in [env/.config](../../env/.config/).

The [env/.config](../../env/.config/) basically contains all the configuration files for all the apps, tools, etc, basically everything. Currently according to how this repo is configured the current `.config` dir tree looks something like this: 

```
.
├── aerospace/
├── borders/
├── ghostty/
├── nvim/
├── obsidian/
├── personal/
├── sketchybar/
├── tmux/
└── alacritty.toml @deprecated
```

Each of this folder essential contains the configuration for each one of those tools and how I'm using them in my current development enviroment. Below a overview list of what each configuration is about. **Highly recommend that you adapt this configs of each thing to your own use case**

| App / Plugin / Tool       | What it is, does, description, whatever you wanna call it                                                              | 
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------- |  
| aerospace                 | Window Manager for macOS                                                                                               |
| borders                   | Just applies borders to windows, because.... well... why not.. personal taste really to be honest                      |
| ghosty                    | Ghosty Terminal config file                                                                                            |
| nvim                      | Personal NeoVim Configuration                                                                                          |
| obsidian                  | "I decline to answer"                                                                                                  |
| personal                  | "I decline to answer"                                                                                                  |
| sketchybar                | Remember we "Nuke" hide the default macOS top bar, this is a replacement..., the why?, well...                         |
| tmux                      | Tmux.conf                                                                                                              |
| alacritty.toml            | Not using alacritty term anymore now using ghostty but kept the old conf for some reason, that even I can't remember   |


## First Time Running

If you still want to venture yourself in running the script, you can run the script with a `--dry` flag (e.g., `./dev-env.sh --dry`).

By adding the --dry flag it will basically let you run the script and will log you what the script will actually do before it actually does it. Pretty self explenatory I guess...

## Notes

This script is also map to an [alias](../../env/.zsh_alias), so just calling `dev-env` will call the script.

