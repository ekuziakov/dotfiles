# Finder
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowStatusBar" -bool "true"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Mission control
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write com.apple.spaces "spans-displays" -bool "true"

# Dock
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.Dock "size-immutable" -bool yes
defaults write com.apple.dock "autohide-delay" -float 0
defaults write com.apple.dock "orientation" -string "bottom"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "tilesize" -int "46"

# Screenshots
defaults write com.apple.screencapture "target" -string "clipboard"

killall Finder || true
killall Dock || true
killall SystemUIServer || true
