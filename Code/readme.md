# 🚀 Quick Start: Wazuh SOC Lab Commands

This guide contains **only** the necessary download links and terminal commands to set up your Wazuh Manager and Agent.

## 1. Wazuh Manager (Ubuntu)

Run these commands in your Ubuntu terminal.

### **Add GPG Key**

```bash
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg

```

### **Install All-in-One Manager**

```bash
curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh && sudo bash ./wazuh-install.sh -a -i

```

> **Note:** Copy the **admin password** displayed at the end of this script!

---

## 2. Wazuh Agent (Windows)

### **Download Link**

* **MSI Installer:** [Wazuh Agent for Windows](https://documentation.wazuh.com/current/installation-guide/wazuh-agent/wazuh-agent-package-windows.html)

### **Register Agent (Ubuntu Side)**

Run the management utility on your Ubuntu server to generate an authentication key:

```bash
sudo /var/ossec/bin/manage_agents

```

1. Press **`A`** to add an agent.
2. Enter a name (e.g., `WindowsHost`).
3. Press **`E`** to extract the key.
4. **Copy the resulting key string.**

---

## 3. Real-Time Monitoring (FIM)

To enable real-time file monitoring, edit the agent config file on your Windows machine.

### **Configuration Path**

`C:\Program Files (x86)\ossec-agent\ossec.conf`

### **Command to Insert**

Add this inside the `<syscheck>` block:

```xml
<directories realtime="yes">C:\Users\abc\Test</directories>

```

### **Restart Service (PowerShell Admin)**

```powershell
Restart-Service wazuhsvc

```

---

## 📊 Summary of Access

* **Dashboard URL:** `https://<ubuntu-ip-address>`
* **Username:** `admin`
* **Password:** (Generated during installation)

