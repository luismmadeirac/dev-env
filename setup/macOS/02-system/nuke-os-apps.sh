#!/bin/bash

source "../../utils/logging.sh"
source "../../utils/script-analysis.sh"

log_info "Starting removal of default macOS applications..."

remove_app() {
    local app_name="$1"
    shift
    local paths=("$@")

    log_step "Removing $app_name..."

    local removed_count=0
    local total_count=${#paths[@]}

    for path in "${paths[@]}"; do
        if [[ -e "$path" ]]; then
            if sudo /bin/rm -rf "$path" 2>/dev/null; then
                log_success "Removed: $path"
                ((removed_count++))
            else
                log_warning "Failed to remove: $path"
            fi
        else
            log_info "Not found (already removed?): $path"
            ((removed_count++))
        fi
    done

    if [[ $removed_count -eq $total_count ]]; then
        log_success "$app_name completely removed"
    else
        log_warning "$app_name partially removed ($removed_count/$total_count paths)"
    fi
}

remove_app "GarageBand" \
    "/Applications/GarageBand.app" \
    "/System/Applications/GarageBand.app" \
    "/Library/Application Support/GarageBand/" \
    "/Library/Audio/Apple Loops/" \
    "$HOME/Library/Application Support/GarageBand/" \
    "$HOME/Library/Containers/com.apple.garageband/"

remove_app "iMovie" \
    "/Applications/iMovie.app" \
    "/System/Applications/iMovie.app" \
    "/Library/Application Support/iMovie/" \
    "$HOME/Library/Containers/com.apple.iMovieApp/" \
    "$HOME/Library/Application Support/iMovie/"

remove_app "Pages" \
    "/Applications/Pages.app" \
    "/System/Applications/Pages.app" \
    "$HOME/Library/Containers/com.apple.Pages/"

remove_app "Numbers" \
    "/Applications/Numbers.app" \
    "/System/Applications/Numbers.app" \
    "$HOME/Library/Containers/com.apple.Numbers/"

remove_app "Keynote" \
    "/Applications/Keynote.app" \
    "/System/Applications/Keynote.app" \
    "$HOME/Library/Containers/com.apple.iWork.Keynote/"

remove_app "News" \
    "/Applications/News.app" \
    "/System/Applications/News.app" \
    "$HOME/Library/Containers/com.apple.news/"

remove_app "Stocks" \
    "/Applications/Stocks.app" \
    "/System/Applications/Stocks.app" \
    "$HOME/Library/Containers/com.apple.stocks/"

remove_app "Podcasts" \
    "/Applications/Podcasts.app" \
    "/System/Applications/Podcasts.app" \
    "$HOME/Library/Containers/com.apple.podcasts/"

remove_app "Chess" \
    "/Applications/Chess.app" \
    "/System/Applications/Chess.app"

remove_app "Stickies" \
    "/Applications/Stickies.app" \
    "/System/Applications/Stickies.app" \
    "$HOME/Library/Containers/com.apple.Stickies/"

log_step "Clearing system and user caches..."
cache_paths=(
    "/Library/Caches/*"
    "$HOME/Library/Caches/*"
)

for cache_path in "${cache_paths[@]}"; do
    if sudo /bin/rm -rf $cache_path 2>/dev/null; then
        log_success "Cleared caches: $cache_path"
    else
        log_warning "Failed to clear some caches: $cache_path"
    fi
done

log_step "Emptying trash..."
if sudo rm -rf ~/.Trash/* 2>/dev/null; then
    log_success "Trash emptied successfully"
else
    log_warning "Failed to empty trash (might already be empty)"
fi

log_success "Application removal process completed!"
log_info "Note: Some system apps may reappear after macOS updates"
