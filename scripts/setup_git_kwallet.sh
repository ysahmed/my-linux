#!/bin/bash

# Script to set up Git credential storage using KWallet on Arch Linux (KDE)

# Function to display messages in green color
function echo_green {
    echo -e "\e[32m$1\e[0m"
}

# Step 1: Update package database and install necessary packages
echo_green "Updating package database and installing necessary packages..."
sudo pacman -Sy --needed libsecret kwallet kwalletmanager git --needed --noconfirm

# Step 2: Configure Git to use the libsecret credential helper
echo_green "Configuring Git to use 'libsecret' as the credential helper..."
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

# # Step 2.5: Verify the Git credential helper configuration
# echo_green "Verifying Git credential helper configuration..."
# git_credential_helper=$(git config --global credential.helper)
# if [ "$git_credential_helper" == "/usr/lib/git-core/git-credential-libsecret" ]; then
#     echo_green "Git is now configured to use 'libsecret' for storing credentials."
# else
#     echo -e "\e[31mFailed to configure Git to use 'libsecret'. Please check your Git configuration.\e[0m"
#     exit 1
# fi

# Step 3: Configure Git to use the ksshaskpass
echo_green "Configuring Git to use 'ksshaskpass'..."
ssh_askpass_config="SSH_ASKPASS=/usr/bin/ksshaskpass\nSSH_ASKPASS_REQUIRE=prefer"
echo -e $ssh_askpass_config > /home/$(whoami)/.config/environment.d/ssh_askpass.conf

git_askpass_config="GIT_ASKPASS=/usr/bin/ksshaskpass"
echo -e $git_askpass_config > /home/$(whoami)/.config/environment.d/git_askpass.conf

# Step 4: Instructions for managing credentials with KWallet
echo_green "You can manage your stored credentials using KWalletManager, which can be accessed from KDE's system settings."
echo_green "Setup complete. Git will now store credentials securely in KWallet through libsecret."

exit 0
