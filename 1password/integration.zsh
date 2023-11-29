export OP_INTEGRATION_SCRIPT=${ZDOTDIR:-$HOME}/1password/agent-bridge.sh

reset-1password-integration() {
  export OP_SOCAT_PID=$(pgrep -f openssh-ssh-agent)
  kill -9 $OP_SOCAT_PID >/dev/null 2>&1
  source $OP_INTEGRATION_SCRIPT
}
alias reset1p="reset-1password-integration"