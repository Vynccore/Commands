# =======================================================
# UBUNTU ON ANDROID: CLAUDE CODE & OLLAMA SETUP COMMANDS
# =======================================================

# 1. Update Termux Packages
pkg update && pkg upgrade -y

# 2. Install Ubuntu (Jammy XFCE4)
. <(curl -Ls https://bit.ly/udroid-installer)
udroid install jammy:xfce4

# 3. Install Termux-X11 & Start Desktop
pkg install x11-repo -y
pkg install termux-x11-nightly -y
termux-x11 :1  -ac &

# 4. Login to Ubuntu & Run GUI
udroid login jammy:xfce4
export DISPLAY=:1
startxfce4 & 

# 5. Install Ollama & Start Server
curl -fsSL https://ollama.com/install.sh | sh
ollama serve 

# 6. Install & Fix Claude Code
curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 7. Run AI Models in Ollama
# For Local AI Model:
ollama run qwen2.5:0.5b 

# For Cloud AI Model:
ollama run gemma4:31b-cloud
