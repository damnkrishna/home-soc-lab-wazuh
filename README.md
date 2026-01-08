# 🛡️ Mini SOC Lab – SIEM-Based Detection & Incident Response

## 📖 Overview

This project demonstrates a **mini Security Operations Center (SOC)** environment built on a single Linux system using **Wazuh SIEM**.
The lab simulates how security teams **detect, analyze, and respond** to suspicious system activity using log-based detection, alerting, and investigation workflows.

The focus of this project is **security operations and decision-making**, not just log collection.

---

## 🎯 Objectives

* Build a lightweight SOC lab under **8 GB RAM constraints**
* Collect and analyze system security logs
* Design and validate custom detection rules
* Generate alerts for suspicious behavior
* Perform SOC-style investigation and incident reporting
* Map detections to **MITRE ATT&CK**

---

## 🏗️ Architecture

**Environment**

* OS: Kali Linux
* SIEM: Wazuh (Single-node: Manager + Dashboard + Agent)
* Monitoring Mode: Localhost (agent-based)

**Data Sources**

* Authentication logs (`/var/log/auth.log`)
* File Integrity Monitoring (critical system directories)
* Privilege escalation attempts

```
[ System Activity ]
        ↓
[ Wazuh Agent ]
        ↓
[ Wazuh Manager ]
        ↓
[ Detection Rules ]
        ↓
[ Alerts & Dashboards ]
        ↓
[ SOC Investigation & Report ]
```

---

## 🔍 Detection Scenarios Implemented

### 1️⃣ SSH Brute-Force Attempt

* **Behavior**: Multiple failed authentication attempts
* **Detection**: Threshold-based alert
* **MITRE ATT&CK**: T1110 – Brute Force
* **Severity**: High

### 2️⃣ Suspicious File Creation

* **Behavior**: Unauthorized file creation in temporary directory
* **Detection**: File Integrity Monitoring
* **Severity**: Medium

### 3️⃣ Privilege Escalation Attempt

* **Behavior**: Repeated sudo authentication attempts
* **Detection**: Privilege-related log analysis
* **Severity**: Medium

---

## 🚨 Alerting & Dashboards

* Custom Wazuh rules for security detection
* Severity-based alert classification
* Dashboards for:

  * Authentication failures
  * Alerts by severity
  * Top affected users

Dashboards are intentionally minimal, reflecting **real SOC environments**.

---

## 🧪 SOC Incident Workflow

Each alert follows a standard SOC process:

1. **Detection** – Alert triggered by rule
2. **Triage** – Initial severity assessment
3. **Investigation** – Log correlation and context analysis
4. **Impact Assessment** – Risk evaluation
5. **Response Recommendation** – Suggested containment actions
6. **Incident Report** – Documentation of findings

---

## 📄 Sample Incident Report

```
Alert: SSH Brute Force Detected
Severity: High
Source: Localhost
Target User: root
Evidence: Multiple failed authentication attempts within a short time window
MITRE ATT&CK: T1110
Impact: Potential credential compromise
Recommended Action: Lock affected account and block source IP
```

---

## 🧠 Key Learnings

* Difference between raw logs and actionable alerts
* Importance of detection logic and thresholds
* SOC alert triage and investigation workflow
* Practical use of MITRE ATT&CK in incident analysis
* How SIEM tools support security decision-making

---

## 🚀 Future Improvements

* Add Windows endpoint with Sysmon
* Monitor remote hosts
* Advanced correlation rules
* Integration with ticketing systems (SOC automation)
* Threat intelligence enrichment

---

## 📌 Disclaimer

This project is for **educational and defensive security purposes only**.
All activities are performed in a controlled lab environment.

---

## 📂 Recommended Repo Structure

```
mini-soc-wazuh-lab/
│
├── README.md
├── architecture/
│   └── soc-lab-diagram.png
├── detections/
│   └── custom-wazuh-rules.xml
├── incident-reports/
│   └── ssh-bruteforce-report.md
└── screenshots/
    ├── dashboard.png
    ├── alert.png
```

📌 **Screenshots matter** — they prove it actually works.

---
