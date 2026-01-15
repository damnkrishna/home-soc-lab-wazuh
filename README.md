# 🛡️ Cross-Platform SOC Lab: Wazuh EDR Deployment & FIM

## 📖 Overview

This project demonstrates the end-to-end implementation of a **Security Operations Center (SOC)** environment. It features a centralized **Wazuh Manager** (Ubuntu) and a **Windows 11 Endpoint Agent**. The lab is designed to provide hands-on experience in log analysis, real-time file monitoring, and cross-platform security orchestration.

---

## 🏗️ Lab Architecture

The lab utilizes a Manager-Agent model to centralize security data:

| Component | Host System | Role |
| --- | --- | --- |
| **Wazuh Manager** | Ubuntu Server (VirtualBox) | Collects, analyzes, and stores security data from agents. |
| **Wazuh Agent** | Windows 11 (Host Machine) | Sends logs and system events to the manager. |
| **Network** | Bridged Adapter | Connects host and guest on the same network subnet. |

---

## 🛠️ Prerequisites

* **Virtualization**: [VirtualBox](https://www.virtualbox.org/) installed.
* **Ubuntu Server**: 20.04+ ISO installed in VirtualBox with **Bridged Networking**.
* **Administrative Access**: Required on the Windows host machine.
* **Memory**: Minimum 4GB RAM allocated to the Ubuntu VM for stable operation.

---

## 🚀 Detailed Build Commands

### 1. Wazuh Manager Setup (Ubuntu)

Run these commands in your Ubuntu terminal to install the central monitoring server.

**Step 1: Add Security GPG Keys**

```bash
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg

```

**Step 2: Run the Installation Script**

```bash
curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh && sudo bash ./wazuh-install.sh -a -i

```

* `-a`: Installs all components (Manager, Indexer, Dashboard).
* `-i`: Runs the script in interactive mode.
* **Note**: Save the admin credentials provided at the end of the script!

---

### 2. Agent Registration & Troubleshooting

After installing the Windows MSI agent, use these commands to link the endpoint to the manager.

**Step 1: Generate the Agent Key (Ubuntu)**

```bash
sudo /var/ossec/bin/manage_agents

```

* Select **`A`** to add an agent (e.g., Name: `Windows-Host`).
* Select **`E`** to extract the key for the new ID (e.g., `005`).
* Copy the resulting long character string.

**Step 2: Solve "Duplicate Agent" Issues**
If you encounter a `Duplicate agent name` error, force-delete the old record:

```bash
sudo /var/ossec/bin/manage_agents -r <OLD_ID>
sudo rm -f /var/ossec/queue/rids/*
sudo systemctl restart wazuh-manager

```

**Step 3: Apply Key on Windows**

1. Open **Wazuh Agent Manager GUI**.
2. Paste the key and enter the **Ubuntu Manager IP**.
3. Click **Save** and **Restart** the service.

---

### 3. File Integrity Monitoring (FIM)

Configure the agent to watch for unauthorized file changes in real-time.

**Step 1: Edit Configuration**
Open `C:\Program Files (x86)\ossec-agent\ossec.conf` as Administrator and add the monitoring directory:

```xml
<syscheck>
  <directories realtime="yes">C:\Users\YourUser\ImportantFolder</directories>
</syscheck>

```

**Step 2: Restart the Agent (PowerShell Admin)**

```powershell
Restart-Service wazuhsvc

```

---

## 📊 Verification & Results

1. **Dashboard**: Navigate to `https://<ubuntu-ip>`.
2. **Status**: Go to **Agents**; ensure `Windows-Host` shows as **Active**.
3. **Alerting**: Create a file in your monitored folder. Navigate to **Integrity Monitoring** to view the real-time detection alert.

---

## 📂 Repository Structure

```text
soc-lab/
├── docs/                   # PDFs and official lab guides
├── screenshots/            # Screenshots of active dashboards and alerts
├── configuration/          # Custom ossec.conf and rule backups
└── README.md               # Detailed project documentation

```

---

## 📌 Final Takeaway

This project successfully moved from a single-node setup to a functional **Enterprise EDR model**. By resolving registration loops and implementing real-time FIM, this lab demonstrates a robust workflow for SOC incident detection and host monitoring.

while trying to build this project i tried to write about the problem i faced here is the link for the writeup 
** https://github.com/damnkrishna/CyberGaurd-j/blob/main/daily-notes/2026-01-14-soc-lab-attempt.md **
