# WPA2-Handshake-Toolkit-


# WPA2 Handshake Analysis Lab

<p align="center">
  <img src="screenshots/banner.png" alt="Project Banner" width="900">
</p>

<p align="center">
  Educational project for studying WPA2 authentication mechanisms and wireless network security concepts in controlled environments.
</p>

---

## Overview

This repository contains scripts, notes, and examples designed to help students and security researchers understand how WPA2 authentication works and how wireless traffic can be analyzed in authorized laboratory environments.

The project focuses on:

* WPA2 authentication concepts
* The 4-Way Handshake process
* Wireless packet capture fundamentals
* Monitor mode configuration
* Capture file analysis
* Security best practices for wireless networks

This repository is intended for educational use, research, and authorized security assessments only.

---

## Objectives

The purpose of this project is to provide a practical environment for learning:

* How WPA2 authentication operates
* The role of the Pairwise Master Key (PMK)
* The role of the Pairwise Transient Key (PTK)
* EAPOL frame exchanges
* Wireless packet inspection techniques
* Secure Wi-Fi configuration practices

---

## Architecture

```text
Wireless Client
       │
       │ Authentication Request
       ▼
 Access Point
       │
       │ 4-Way Handshake
       ▼
 Secure Session Established
```

---

## Screenshots

### Monitor Mode Configuration

> Insert a screenshot showing monitor mode successfully enabled.

<p align="center">
  <img src="screenshots/monitor-mode.png" width="850">
</p>

---

### Wireless Network Discovery

> Insert a screenshot showing nearby wireless networks detected in a lab environment.

<p align="center">
  <img src="screenshots/network-discovery.png" width="850">
</p>

---

### Packet Capture Analysis

> Insert a screenshot showing packet analysis performed using Wireshark.

<p align="center">
  <img src="screenshots/packet-analysis.png" width="850">
</p>

---

### WPA2 Authentication Frames

> Insert a screenshot highlighting EAPOL frames in a controlled test environment.

<p align="center">
  <img src="screenshots/eapol-analysis.png" width="850">
</p>

---

## Project Structure

```text
.
├── scripts/
├── screenshots/
├── docs/
├── examples/
└── README.md
```

---

## Requirements

* Linux
* Aircrack-ng Suite
* Wireshark
* iw
* macchanger

---

## Educational Topics

### WPA2 Security

This project explores:

* WPA2-Personal
* WPA2-Enterprise
* EAPOL communication
* Key derivation concepts
* Wireless authentication workflows

### Packet Analysis

Topics include:

* Beacon Frames
* Probe Requests
* Probe Responses
* Association Frames
* Authentication Frames
* EAPOL Frames

---

## References

**WPA2 Specification**

https://www.ieee.org

**Wireshark Documentation**

https://www.wireshark.org/docs

**Aircrack-ng Documentation**

https://www.aircrack-ng.org/documentation.html

**Linux Wireless Documentation**

https://wireless.docs.kernel.org

---

## Disclaimer

This repository is intended exclusively for educational purposes, research, and authorized security testing.

Do not use any material contained in this repository against networks, systems, or devices without explicit authorization from the owner.

The author assumes no responsibility for misuse of the information provided.

---

## License

MIT License
