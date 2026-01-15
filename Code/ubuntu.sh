
### 📜 Wazuh Manager Auto-Install Script 

```bash
#!/bin/bash

# --- Colors for Output ---
GREEN='\033[0:32m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting Wazuh Manager Installation Lab Setup...${NC}"

# 1. Add Wazuh GPG Key
echo -e "${GREEN}🔑 Adding Wazuh GPG Key...${NC}"
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg

# 2. Download and Execute Wazuh Installation Script
echo -e "${GREEN}📦 Downloading and Installing Wazuh All-in-One...${NC}"
curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh 
sudo bash ./wazuh-install.sh -a -i

# 3. Display Connection Info
IP_ADDR=$(hostname -I | awk '{print $1}')
echo -e "${GREEN}✅ Installation Complete!${NC}"
echo -e "${GREEN}🌐 Access your dashboard at: https://$IP_ADDR${NC}"
echo -e "${GREEN}📄 Check the terminal output above for your 'admin' password.${NC}"

# 4. Prompt for Agent Creation
read -p "Do you want to create a new agent now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo /var/ossec/bin/manage_agents
fi

```

---

### 📂 How to use this for your GitHub:

1. **Create the file:** `nano install_wazuh.sh`
2. **Paste the code** above and save (Ctrl+O, Enter, Ctrl+X).
3. **Make it executable:**
```bash
chmod +x install_wazuh.sh

```


4. **Run it:**
```bash
./install_wazuh.sh

```



