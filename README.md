# Payday 2 Damage Hook
A Payday 2 mod that allows for detecting incoming enemy damage and outputting a request to an external server
# Contents
- [Dependencies](#dependencies)
- [Usage and Modification](#usage-and-modification)
- [Standard Installation](#standard-installation)
- [Installation from source](#installation-from-source)
- [Damage Types](#damage-types--documentation)
# Dependencies
## Client
- [SuperBLT](https://superblt.znix.xyz/#installation)
## Server
- [Python v3.x.x](https://www.python.org/downloads/)
    - `http.server` (pre-bundled with python 3)
    - Ensure python is added to your `PATH`
# Usage and Modification
- Follow the Installation steps below before doing modifications
- All this mod does is listens for the following and runs a script accordingly
    - `PlayerDamage.damage_bullet` (Player getting shot)
    - `PlayerDamage.damage_melee` (Player getting meleed)
- It calls the function `DamagePingMod:RunHttpRequest()` when these actions occur (with 0.5 seconds debounce)
- If you want to change the server the ping goes to or change what happens when you get shot, the `DamagePingMod:RunHttpRequest()` is what you need to modify
    - To change the location of the ping, you need to modify the url called by `dohttpreq("urlGoesHere")`, this by default is set to `"http://localhost:1327"`
# Standard Installation
## Client
- Ensure you have [SuperBLT](https://superblt.znix.xyz/#installation) installed
- Download the client.zip release of the mod from the releases area on the side
- After downloading the mod, use a program such as [7zip](https://www.7-zip.org/download.html) or [WinRAR](https://www.win-rar.com/download.html?&L=0) to extract the whole mod folder to your `mods` folder in your payday 2 directory
## Server
NOTE: THIS IS NOT REQUIRED IF YOU ARE USING AN EXTERNAL SERVER, THIS IS ONLY FOR THE SERVER EXAMPLE
- Ensure you have Python version 3.x.x
- Download the server.zip release of the mod from the releases area on the side
- Extract that to a secure folder (not in Payday 2)
- Run the python script by either opening it in python or through the command line
```bash
python server.py
```
- Please note that this is just a demonstration using a local server, this has not been tested on external servers yet
# Installation from source
## Client
- Ensure you have [SuperBLT](https://superblt.znix.xyz/#installation) installed
- After downloading the source code, take the `DamageHook` folder and add it to your Payday 2 `mods` folder
## Server
- Ensure you have Python version 3.x.x
- After downloading the source code, take the `Server` folder and extract it somewhere safe separate from the `mods` folder
- Run the python script by either opening it in python or through the command line
```bash
python server.py
```
# Damage Types / Documentation
- Please see the [documentation / wiki](https://github.com/Antipoison7/PD2-Damage-Hook/wiki/Damage-Types)
