# Update, install, and search
alias psync='sudo dnf install'
alias update='sudo dnf upgrade --refresh -y'
alias install='sudo dnf install -y'
alias search='dnf search'
alias remove='sudo dnf remove -y'
alias rmcache='sudo dnf autoremove -y'

# Cleanup orphaned packages
alias cleanup='sudo dnf autoremove -y'
