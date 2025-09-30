# Git Cheat Sheet  ![Status: Updated](https://img.shields.io/badge/Status-Updated-green)

Last updated: Sep, 15th 2025

## Table of Contents

- [Basic Commands](#basic-commands)
- [Staging & Committing](#staging--committing)
- [Branching & Merging](#branching--merging)
- [Remote Operations](#remote-operations)
- [Viewing History](#viewing-history)
- [Undoing Changes](#undoing-changes)
- [Advanced Workflows](#advanced-workflows)
- [Amending Commits](#amending-commits)
- [Working with Large Projects](#working-with-large-projects)
- [Neovim Integration](#neovim-integration)
- [Useful Aliases](#useful-aliases)

---

## Basic Commands

### Repository Setup

| Command | Description |
| :------ | :---------- |
| `git init` | Initialize a new Git repository |
| `git clone <url>` | Clone a remote repository |
| `git clone <url> <directory>` | Clone into specific directory |
| `git remote -v` | Show remote repositories |
| `git remote add origin <url>` | Add remote repository |

### Configuration

| Command | Description |
| :------ | :---------- |
| `git config --global user.name "Name"` | Set global username |
| `git config --global user.email "email"` | Set global email |
| `git config --list` | Show all configuration |
| `git config --global core.editor nvim` | Set Neovim as default editor |

---

## Staging & Committing

### Basic Staging

| Command | Description |
| :------ | :---------- |
| `git add <file>` | Stage specific file |
| `git add .` | Stage all changes |
| `git add -A` | Stage all changes (including deletions) |
| `git add -p` | Interactive staging (patch mode) |
| `git reset <file>` | Unstage file |
| `git reset` | Unstage all files |

### Committing

| Command | Description |
| :------ | :---------- |
| `git commit -m "message"` | Commit with message |
| `git commit -am "message"` | Stage and commit all tracked files |
| `git commit --amend` | Amend last commit |
| `git commit --amend --no-edit` | Amend without changing message |
| `git commit --allow-empty -m "message"` | Create empty commit |

---

## Branching & Merging

### Branch Management

| Command | Description |
| :------ | :---------- |
| `git branch` | List local branches |
| `git branch -a` | List all branches (local + remote) |
| `git branch <name>` | Create new branch |
| `git checkout <branch>` | Switch to branch |
| `git checkout -b <branch>` | Create and switch to new branch |
| `git switch <branch>` | Switch to branch (newer syntax) |
| `git switch -c <branch>` | Create and switch to new branch |
| `git branch -d <branch>` | Delete branch (safe) |
| `git branch -D <branch>` | Force delete branch |
| `git branch -m <old> <new>` | Rename branch |

### Merging

| Command | Description |
| :------ | :---------- |
| `git merge <branch>` | Merge branch into current |
| `git merge --no-ff <branch>` | Merge without fast-forward |
| `git merge --squash <branch>` | Squash merge |
| `git merge --abort` | Abort merge conflict |
| `git mergetool` | Open merge tool for conflicts |

---

## Remote Operations

### Fetching & Pulling

| Command | Description |
| :------ | :---------- |
| `git fetch` | Fetch changes from remote |
| `git fetch origin` | Fetch from specific remote |
| `git pull` | Fetch and merge from remote |
| `git pull --rebase` | Fetch and rebase on top of remote |
| `git pull origin <branch>` | Pull specific branch |

### Pushing

| Command | Description |
| :------ | :---------- |
| `git push` | Push to tracked remote branch |
| `git push origin <branch>` | Push to specific branch |
| `git push -u origin <branch>` | Push and set upstream |
| `git push --force-with-lease` | Safe force push |
| `git push --delete origin <branch>` | Delete remote branch |
| `git push --tags` | Push all tags |

---

## Viewing History

### Log Commands

| Command | Description |
| :------ | :---------- |
| `git log` | Show commit history |
| `git log --oneline` | Compact log format |
| `git log --graph` | Show branch graph |
| `git log --all --graph --oneline` | Complete visual history |
| `git log -p` | Show patches (diffs) |
| `git log --author="name"` | Filter by author |
| `git log --since="2 weeks ago"` | Filter by date |
| `git log --grep="pattern"` | Filter by commit message |
| `git log <file>` | Show history for specific file |

### Diff Commands

| Command | Description |
| :------ | :---------- |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |
| `git diff HEAD` | Show all changes since last commit |
| `git diff <branch1> <branch2>` | Compare branches |
| `git diff <commit1> <commit2>` | Compare commits |
| `git show <commit>` | Show specific commit details |

### Status & Information

| Command | Description |
| :------ | :---------- |
| `git status` | Show working tree status |
| `git status -s` | Short status format |
| `git blame <file>` | Show file annotations |
| `git show-branch` | Show branch relationships |

---

## Undoing Changes

### Working Directory

| Command | Description |
| :------ | :---------- |
| `git checkout -- <file>` | Discard changes to file |
| `git restore <file>` | Restore file (newer syntax) |
| `git clean -f` | Remove untracked files |
| `git clean -fd` | Remove untracked files and directories |
| `git clean -n` | Dry run of clean |

### Commits

| Command | Description |
| :------ | :---------- |
| `git reset --soft HEAD~1` | Undo commit, keep changes staged |
| `git reset --mixed HEAD~1` | Undo commit, keep changes unstaged |
| `git reset --hard HEAD~1` | Undo commit, discard changes |
| `git revert <commit>` | Create new commit that undoes changes |
| `git revert HEAD` | Revert last commit |

---

## Advanced Workflows

### Stashing

| Command | Description |
| :------ | :---------- |
| `git stash` | Stash current changes |
| `git stash push -m "message"` | Stash with message |
| `git stash list` | List all stashes |
| `git stash pop` | Apply and remove latest stash |
| `git stash apply` | Apply stash without removing |
| `git stash drop` | Delete latest stash |
| `git stash clear` | Delete all stashes |
| `git stash show -p` | Show stash diff |

### Cherry-picking

| Command | Description |
| :------ | :---------- |
| `git cherry-pick <commit>` | Apply commit to current branch |
| `git cherry-pick <commit1> <commit2>` | Apply multiple commits |
| `git cherry-pick --abort` | Abort cherry-pick |
| `git cherry-pick --continue` | Continue after resolving conflicts |

### Tags

| Command | Description |
| :------ | :---------- |
| `git tag` | List all tags |
| `git tag <tagname>` | Create lightweight tag |
| `git tag -a <tagname> -m "message"` | Create annotated tag |
| `git tag -d <tagname>` | Delete local tag |
| `git push --tags` | Push all tags to remote |
| `git checkout <tagname>` | Checkout specific tag |

---

## Rebasing Guide

### Basic Rebasing

| Command | Description |
| :------ | :---------- |
| `git rebase <branch>` | Rebase current branch onto another |
| `git rebase main` | Rebase current branch onto main |
| `git rebase --continue` | Continue rebase after resolving conflicts |
| `git rebase --abort` | Abort rebase operation |
| `git rebase --skip` | Skip current commit during rebase |

### Interactive Rebasing
| Command | Description |
| :------ | :---------- |
| `git rebase -i HEAD~3` | Interactive rebase last 3 commits |
| `git rebase -i <commit>` | Interactive rebase from specific commit |

#### Interactive Rebase Commands
| Command | Description |
| :------ | :---------- |
| `pick` | Use commit as-is |
| `reword` | Use commit but edit message |
| `edit` | Use commit but stop for amending |
| `squash` | Combine with previous commit |
| `fixup` | Like squash but discard commit message |
| `drop` | Remove commit entirely |

### Rebase Best Practices

1. **Never rebase shared branches** - Only rebase feature branches
2. **Use `--force-with-lease`** instead of `--force` when pushing
3. **Rebase before merging** to maintain clean history
4. **Use interactive rebase** to clean up commit history

**Example Workflow:**

```bash
# Work on feature branch
git checkout -b feature-branch
# Make commits...
git commit -m "WIP: initial work"
git commit -m "WIP: more work"
git commit -m "Add final feature"

# Clean up history before merging
git rebase -i HEAD~3  # Squash WIP commits
git checkout main
git pull
git checkout feature-branch
git rebase main  # Rebase onto latest main
git checkout main
git merge --no-ff feature-branch
```

---

## Amending Commits

### Basic Amending

| Command | Description |
| :------ | :---------- |
| `git commit --amend` | Amend last commit (opens editor) |
| `git commit --amend --no-edit` | Amend without changing message |
| `git commit --amend -m "new message"` | Amend with new message |
| `git add <file> && git commit --amend --no-edit` | Add file to last commit |

### Advanced Amending

```bash
# Change author of last commit
git commit --amend --author="New Author <email@example.com>"

# Amend commit date
git commit --amend --date="2023-01-01 12:00:00"

# Split last commit into multiple commits
git reset --soft HEAD~1
git add <file1>
git commit -m "First part"
git add <file2>
git commit -m "Second part"
```

### When to Amend

- **Do amend:** Local commits not yet pushed
- **Don't amend:** Commits already pushed to shared branches
- **Alternative:** Use `git revert` for pushed commits

---

## Working with Large Projects

### Efficient Commands for Large Repos

| Command | Description |
| :------ | :---------- |
| `git log --oneline -10` | Show last 10 commits only |
| `git log --since="1 week ago"` | Limit by time |
| `git log --author="username"` | Filter by author |
| `git blame -L 10,20 <file>` | Blame specific lines |
| `git diff --name-only` | Show only changed file names |
| `git status -s` | Short status format |

### Large File Handling

| Command | Description |
| :------ | :---------- |
| `git lfs track "*.psd"` | Track large files with LFS |
| `git lfs ls-files` | List LFS tracked files |
| `git lfs pull` | Download LFS files |

### Performance Optimization

```bash
# Configure for large repositories
git config core.preloadindex true
git config core.fscache true
git config gc.auto 256

# Partial clone (Git 2.19+)
git clone --filter=blob:none <url>

# Shallow clone with limited history
git clone --depth 1 <url>
```

### Working with Submodules

| Command | Description |
| :------ | :---------- |
| `git submodule add <url> <path>` | Add submodule |
| `git submodule init` | Initialize submodules |
| `git submodule update` | Update submodules |
| `git submodule update --remote` | Update to latest remote |
| `git clone --recurse-submodules <url>` | Clone with submodules |

---

## Neovim Integration

### Git Commands in Neovim

Based on your Neovim configuration, you have access to these Git-related features:

#### LSP Integration

| Neovim Command | Description |
| :------------- | :---------- |
| `:Gitsigns toggle_signs` | Toggle git signs in gutter |
| `:Gitsigns blame_line` | Show blame for current line |
| `:Gitsigns preview_hunk` | Preview hunk under cursor |

#### Terminal Integration

| Neovim Shortcut | Description |
| :-------------- | :---------- |
| `<leader>tt` | Open floating terminal for git commands |
| `<leader>th` | Open horizontal terminal |
| `<C-f>` | Use tmux-sessionizer to switch git projects |

### Recommended Git Workflow in Neovim

1. **Project switching:** `<C-f>` → Select git project
2. **File navigation:** `<C-p>` → Find git tracked files
3. **Text search:** `<leader>ps` → Search across project
4. **Terminal work:** `<leader>tt` → Open terminal for git commands
5. **Commit messages:** Neovim opens automatically for commit editing

---

## Quick Reference Cards

### Conflict Resolution

```bash
# When you encounter merge conflicts:
1. git status                    # See conflicted files
2. <editor> conflicted_file     # Edit and resolve conflicts
3. git add conflicted_file      # Stage resolved files
4. git commit                   # Complete the merge
# OR
   git merge --abort            # Abort the merge
```

### Emergency Commands

```bash
# OH NO! I committed to the wrong branch
git reset --soft HEAD~1        # Undo commit, keep changes
git stash                      # Stash changes
git checkout correct-branch    # Switch to correct branch
git stash pop                  # Apply changes
git commit                     # Commit to correct branch

# OH NO! I need to undo a pushed commit
git revert <commit-hash>       # Create reverting commit
git push                       # Push the revert

# OH NO! I accidentally deleted a branch
git reflog                     # Find the commit hash
git checkout -b branch-name <commit-hash>  # Recreate branch
```

### Daily Workflow

```bash
# Start of day
git checkout main
git pull

# Start feature
git checkout -b feature/new-feature

# During development
git add .
git commit -m "feat: add new feature"

# Before pushing (clean up)
git rebase -i HEAD~3  # Interactive rebase to squash/clean

# Push feature
git push -u origin feature/new-feature

# After review/merge
git checkout main
git pull
git branch -d feature/new-feature
```

---

## Tips & Best Practices

### Commit Message Convention

Follow conventional commits:
- `feat:` new feature
- `fix:` bug fix
- `docs:` documentation
- `style:` formatting
- `refactor:` code restructuring
- `test:` adding tests
- `chore:` maintenance

### Repository Hygiene

1. **Regular cleanup:** `git branch --merged | xargs -n 1 git branch -d`
2. **Garbage collection:** `git gc --prune=now`
3. **Check repo size:** `git count-objects -vH`
4. **Compress repo:** `git repack -ad`

### Security

- **Never commit secrets:** Use `.gitignore` for sensitive files
- **Use SSH keys:** `git remote set-url origin git@github.com:user/repo.git`
- **Sign commits:** `git config --global commit.gpgsign true`

---

### Further Resources

- [Pro Git Book](https://git-scm.com/book)
- [Git Documentation](https://git-scm.com/docs)
- [Interactive Git Tutorial](https://learngitbranching.js.org/)
- [Git Cheat Sheet PDF](https://training.github.com/downloads/github-git-cheat-sheet.pdf)
