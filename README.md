
<p align="center">
  <img src="screenshots/banner.png" alt="Project Banner" width="900">
</p>

# WPA/WPA2-PSK Handshake Capture & Analysis (Educational)

<p align="center">
  <b>⚠️ This attack works only on WPA/WPA2-Personal (PSK). WPA3 is NOT vulnerable to this method.</b>
</p>

---

## 📌 Overview

This project provides a complete, hands-on laboratory for understanding how Wi-Fi authentication works and how to securely capture the **4-Way Handshake** for educational analysis. It includes:

- ✅ Automated scripts to enable/disable **monitor mode**
- ✅ Wireless interface detection and MAC address randomization
- ✅ Step-by-step capture of WPA/WPA2 handshake using `airodump-ng` and `aireplay-ng`
- ✅ Conversion of captured traffic to **hashcat format (`hc22000`)**
- ✅ Cracking the handshake using hashcat with wordlist attacks

---

## 🔐 Supported Protocols

| Protocol | Vulnerable to Deauth Attack | Can capture Handshake? | Crackable with hashcat? |
|----------|----------------------------|------------------------|-------------------------|
| **WPA/WPA2-PSK** | ✅ Yes | ✅ Yes | ✅ Yes (with wordlist) |
| **WPA3-Personal (SAE)** | ❌ No | ❌ No | ❌ No |
| **WPA3-Enterprise** | ❌ No | ❌ No | ❌ No |
| **WPA2-Enterprise (802.1X)** | ❌ No | ❌ No | ❌ No |

> **Why doesn't this work on WPA3?**  
> WPA3 uses **SAE (Simultaneous Authentication of Equals)** which replaces the 4-Way Handshake with a more secure Dragonfly Key Exchange. Deauthentication attacks cannot force a client to re-authenticate in a way that reveals crackable material.

---

## ✅ What This Project Does

1. Enables monitor mode on your wireless interface (with MAC randomization)
2. Discovers nearby networks and identifies WPA/WPA2-PSK targets
3. Captures the **4-Way Handshake** using `airodump-ng` + `aireplay-ng` deauth attack
4. Converts the capture to `hc22000` format (hashcat compatible)
5. Cracks the handshake using a wordlist (rockyou.txt or custom)

---

## 🚫 What This Project Does NOT Do

- ❌ Does NOT work against WPA3 networks
- ❌ Does NOT work against WPA2-Enterprise
- ❌ Does NOT break strong passwords (depends entirely on wordlist quality)
- ❌ Does NOT work on 5GHz-only adapters without proper configuration

---

## 📁 Project Structure
.
├── scripts/
│ ├── Enable_Monitor_Mode.sh # Auto-detects interface, kills services, enables monitor mode
│ └── Disable_Monitor_Mode.sh # Stops monitor mode, restores NetworkManager
├── screenshots/ # Your actual screenshots go here
├── StepToFollow.txt # Your command notes
└── README.md

text

---

## 🛠️ Requirements

- **OS:** Linux (Kali Linux recommended)
- **Wireless Adapter:** Must support monitor mode & packet injection
  - Common chipsets: Atheros, Ralink, Realtek (some models)
- **Tools:**
  ```bash
  sudo apt update
  sudo apt install aircrack-ng hcxtools hashcat macchanger iw
📸 Step-by-Step Guide (with screenshot instructions)
Step 0: Verify Your Wireless Interface
bash
iw dev
Look for an interface like wlan0 or wlp2s0.

📷 Screenshot to take: Output of iw dev showing your wireless interface.

<p align="center"> <img src="screenshots/0-iw-dev.png" alt="Wireless interface verification" width="800"> </p>
Step 1: Enable Monitor Mode
Run the provided script:

bash
chmod +x scripts/Enable_Monitor_Mode.sh
sudo ./scripts/Enable_Monitor_Mode.sh
What the script does:

Detects your wireless interface automatically

Runs airmon-ng check kill to stop interfering services

Enables monitor mode

Assigns a random MAC address via macchanger

Brings the monitor interface up

📷 Screenshot to take: Terminal output showing monitor mode enabled (e.g., wlan0mon created with random MAC).

<p align="center"> <img src="screenshots/1-monitor-mode-enabled.png" alt="Monitor mode enabled" width="800"> </p>
Step 2: Scan for WPA/WPA2-PSK Networks
bash
sudo airodump-ng wlan0mon
What to look for:

ENC: WPA2 or WPA (NOT WPA3)

AUTH: PSK (NOT SAE, NOT 802.1X)

CH: Channel number (note this down)

BSSID: MAC address of access point (note this down)

ESSID: Network name

How to identify WPA2-PSK vs WPA3:

text
WPA2-PSK example:  ENC: WPA2   CIPHER: CCMP   AUTH: PSK
WPA3 example:      ENC: WPA3   CIPHER: CCMP   AUTH: SAE   ← NOT VULNERABLE
📷 Screenshot to take: airodump-ng output showing nearby networks, highlighting a WPA2-PSK target.

<p align="center"> <img src="screenshots/2-scan-networks.png" alt="Network discovery scan" width="800"> </p>
Step 3: Targeted Capture on Specific Channel
Press Ctrl+C to stop the scan. Now start a targeted capture, saving to a file:

bash
sudo airodump-ng --bssid XX:XX:XX:XX:XX:XX --channel X -w capture wlan0mon
Parameters explained:

--bssid : Target access point MAC address (replace XX:XX:XX:XX:XX:XX)

--channel : Channel the AP is operating on (replace X)

-w capture : Write capture to files named capture-01.cap, etc.

📷 Screenshot to take: The airodump-ng window showing 0 handshake captured (waiting state). Include the BSSID and channel in the shot.

<p align="center"> <img src="screenshots/3-waiting-for-handshake.png" alt="Waiting for handshake capture" width="800"> </p>
Step 4: Send Deauthentication Frames
Open a new terminal (keep the airodump running). Force connected clients to reconnect:

bash
sudo aireplay-ng --deauth 10 -a XX:XX:XX:XX:XX:XX wlan0mon
Parameters explained:

--deauth 10 : Send 10 deauthentication packets

-a : Target access point BSSID (replace XX:XX:XX:XX:XX:XX)

wlan0mon : Monitor interface

How it works: When a client is deauthenticated, it automatically re-authenticates, performing the 4-Way Handshake. The handshake frames are captured by airodump-ng.

📷 Screenshot to take: The aireplay-ng terminal sending deauth packets.

<p align="center"> <img src="screenshots/4-sending-deauth.png" alt="Sending deauthentication packets" width="800"> </p>
Step 5: Handshake Captured ✅
Watch the airodump-ng terminal. When you see:

text
WPA handshake: XX:XX:XX:XX:XX:XX
…the handshake has been successfully captured.

📷 Screenshot to take: The airodump-ng output showing "WPA handshake:" in the top-right corner.

<p align="center"> <img src="screenshots/5-handshake-captured.png" alt="Handshake successfully captured" width="800"> </p>
Step 6: Stop the Capture
Press Ctrl+C in the airodump-ng terminal to stop the capture. The capture file will be saved as capture-01.cap (or similar).

📷 Screenshot to take: Terminal showing the capture file information (number of packets captured, file size, etc.).

<p align="center"> <img src="screenshots/6-capture-complete.png" alt="Capture complete" width="800"> </p>
Step 7: Convert Capture to Hashcat Format
Method A: Using hcxpcapngtool (recommended for hashcat)

bash
hcxpcapngtool -o handshake.hc22000 capture-01.cap
What this does: Converts the .cap file to .hc22000 format, which is the modern hashcat format for WPA/WPA2 handshakes.

Method B: Using aircrack-ng (quick verification)

bash
aircrack-ng capture-01.cap
This will show if a valid handshake was captured and list any found ESSIDs.

📷 Screenshot to take: Output of hcxpcapngtool showing "EAPOL pairs written to 22000 hash file: 1".

<p align="center"> <img src="screenshots/7-conversion-success.png" alt="Conversion to hc22000 successful" width="800"> </p>
Step 8: Crack the Handshake with Hashcat
First, prepare your wordlist (if using compressed rockyou.txt):

bash
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
Then run hashcat:

bash
hashcat -m 22000 handshake.hc22000 /usr/share/wordlists/rockyou.txt
Parameters explained:

-m 22000 : Hash mode for WPA-PBKDF2-PMKID+EAPOL

handshake.hc22000 : The hash file from step 7

/usr/share/wordlists/rockyou.txt : The wordlist to use

To show the result if already cracked:

bash
hashcat -m 22000 handshake.hc22000 --show
📷 Screenshot to take: Hashcat showing Cracked: password_example (or status).

<p align="center"> <img src="screenshots/8-cracked.png" alt="Hashcat successfully cracked the handshake" width="800"> </p>
📚 Recommended Wordlists
Wordlist	Size	Description	Download
rockyou.txt	14M	Classic, included in Kali Linux	Pre-installed in Kali
SecLists/Passwords	Large (~1GB+)	Huge collection from SecLists	apt install seclists
Weakpass	Varies	Multiple wordlists available	https://weakpass.com/
crackstation.txt	15GB	Massive, password reuse focused	https://crackstation.net/crackstation-wordlist-password-cracking-dictionary.htm
⚠️ Success depends 100% on the password being in your wordlist. Strong passwords (>12 characters, random) are NOT crackable with this method.

🔄 Disable Monitor Mode & Restore Network
After completing your analysis, disable monitor mode and restore normal networking:

bash
chmod +x scripts/Disable_Monitor_Mode.sh
sudo ./scripts/Disable_Monitor_Mode.sh
What the script does:

Detects the active monitor interface

Stops monitor mode using airmon-ng stop

Automatically detects and restarts your network manager (NetworkManager, systemd-networkd, or networking)

📷 Screenshot to take: Terminal showing "Monitor mode disabled" and "Network service restarted".

<p align="center"> <img src="screenshots/9-cleanup.png" alt="Cleanup and restore network" width="800"> </p>
📜 Scripts Explanation
Enable_Monitor_Mode.sh
bash
#!/bin/bash
# Detects first wireless interface
# Runs airmon-ng check kill (stops interfering services)
# Enables monitor mode with airmon-ng start
# Assigns random MAC address using macchanger
# Brings monitor interface up
Disable_Monitor_Mode.sh
bash
#!/bin/bash
# Detects active monitor interface (ends with 'mon')
# Stops monitor mode with airmon-ng stop
# Detects active network management service (NetworkManager, systemd-networkd, or networking)
# Restarts the detected service to restore normal connectivity
🧠 Educational Concepts Covered
Concept	Description
Monitor Mode	Special mode allowing wireless interface to capture all 802.11 frames
Managed Mode	Normal client mode where interface connects to access points
4-Way Handshake	M1 (ANonce), M2 (SNonce + MIC), M3 (GTK + MIC), M4 (ACK)
PMK	Pairwise Master Key - derived from password + SSID
PTK	Pairwise Transient Key - derived from PMK + ANonce + SNonce + MACs
MIC	Message Integrity Code - verifies handshake messages
Deauth Attack	Exploits unauthenticated management frames to disconnect clients
PBKDF2	Key derivation function used by WPA/WPA2 (4096 iterations)
Hashcat Mode 22000	Modern format for WPA-PBKDF2-PMKID+EAPOL
🐛 Troubleshooting
Problem	Solution
No wireless interface detected	Check adapter is connected: lsusb or iw dev
Monitor interface not found	Wait a few seconds, retry, or check airmon-ng compatibility
No handshake captured	Try more deauth packets: --deauth 0 (infinite), or target a specific client with -c CLIENT_MAC
Radio tap header missing warning	Normal for basic captures; upgrade to pcapng for full data
Hashcat says No hash loaded	Verify file format: cat handshake.hc22000 should show hash lines
Hashcat too slow	Use GPU: -D 2 flag, or use --force on CPU (slower)
Network doesn't work after disable script	Manually restart network: sudo systemctl restart NetworkManager
⚠️ Legal Disclaimer
This repository is for EDUCATIONAL PURPOSES ONLY.

You may only test against:

Networks you own

Networks you have explicit written permission to test

Your own laboratory environment

Unauthorized access to wireless networks is illegal in most jurisdictions and constitutes a violation of:

Computer Fraud and Abuse Act (CFAA) in the US

Computer Misuse Act in the UK

Similar laws worldwide

The author assumes no responsibility for misuse of the information provided. By using this repository, you agree that you are solely responsible for complying with all applicable laws.

📖 References
Aircrack-ng Documentation

Hashcat Example Hashes

Understanding the 4-Way Handshake

Why WPA3 breaks this attack

hcxdumptool / hcxpcapngtool

IEEE 802.11 Standard

📄 License
MIT License – for educational tooling only. See LICENSE file for details.

⭐ Acknowledgments
Aircrack-ng team for the amazing wireless tools

Hashcat team for the world's fastest password cracker

ZeroBeat for hcxtools

The open source security community

<p align="center"> <b>Use this knowledge responsibly and only on networks you own or have permission to test.</b><br> <i>Security research helps make all networks safer when done ethically.</i> </p> ```
