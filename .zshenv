# Personal
export HOME_WIN=/mnt/c/Users/Fernando
export PATH=$HOME/.local/bin:$PATH
# 1Password comunication with wsl
export OP_INTEGRATION_SCRIPT=${ZDOTDIR:-$HOME}/1password/.agent-bridge.sh

# Since my ip is static, declare it here
# This config helps metro and wslhostpatcher find expo server when using Expo Go
export REACT_NATIVE_PACKAGER_HOSTNAME='192.168.68.100'

# Something uses XDG_CONFIG_HOME to load something
export XDG_CONFIG_HOME=$HOME

# Cargo
export PATH=$PATH:$HOME/.cargo/bin

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
