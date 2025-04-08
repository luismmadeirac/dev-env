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
