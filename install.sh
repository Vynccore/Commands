#!/data/data/com.termux/files/usr/bin/bash

# ==========================================================
#  GAMING BRIDGE: One-Command Installation
# ==========================================================

echo -e "\033[1;32m[*] Installing Gaming Bridge for iQOO Z9x...\033[0m"

# 1. Update & Dependencies
pkg update -y && pkg upgrade -y
pkg install -y termux-x11-nightly pcmanfm box64 wine mesa-vulkan-icd-freedreno vulkan-loader

# 2. Setup Gaming Environment
mkdir -p ~/gaming_data
cd ~/gaming_data

# 3. Create the PC Launcher (pc.sh)
cat << 'EOF' > ~/pc.sh
#!/data/data/com.termux/files/usr/bin/bash
export GALLIUM_DRIVER=zink
export MESA_NO_ERROR=1
export TU_DEBUG=noconform
termux-x11 :0 &
sleep 2
export DISPLAY=:0
pcmanfm
EOF
chmod +x ~/pc.sh

# 4. Create Desktop Entry for Wine
mkdir -p ~/.local/share/applications
cat << 'EOF' > ~/.local/share/applications/wine.desktop
[Desktop Entry]
Type=Application
Name=Wine Run
Exec=box64 wine "%f"
MimeType=application/x-ms-dos-executable;
EOF

# 5. Add Alias to bashrc
if ! grep -q "alias pc=" ~/.bashrc; then
    echo "alias pc='bash ~/pc.sh'" >> ~/.bashrc
fi

echo -e "\033[1;32m[+] Installation Complete! Type 'pc' to start.\033[0m"
