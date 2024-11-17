[EmulatorJS](https://emulatorjs.org/) is a web-based emulator for various system; that is, it allows you to run old games in your web browser. It's based on [Emscripten](https://emscripten.org/), which is a toolchain for compiling C and C++ code to WebAssembly.

### Loading saves and states

Our integration with EmulatorJS automates the process of loading and saving save files and save states. Before starting the game, select a save and/or state file to load (if one is available). Anytime you save the game (or create a save state), the save and state files stored with RomM will be updated, so there's no need to manually download or upload them.

### Supported systems

Note that only the following systems are currently supported:

* 3DO
* Amiga
* Arcade/MAME
* Atari 2600
* Atari 5200
* Atari 7800
* Atari Jaguar
* Atari Lynx
* Commodore 64
* ColecoVision
* Neo Geo Pocket
* Neo Geo Pocket Color
* Nintendo 64
* Nintendo Entertainment System (NES)
* Nintendo Family Computer (Famicom)
* Nintendo DS
* Game Boy
* Game Boy Color
* Game Boy Advance
* PC-FX
* PlayStation (PS)
* Sega 32X [currently disabled - broken](https://github.com/EmulatorJS/EmulatorJS/issues/579) 
* Sega CD
* Sega Game Gear
* Sega Master System
* Sega Genesis/Megadrive
* Sega Saturn
* Super Nintendo Entertainment System (SNES)
* Super Famicom
* TurboGraphx-16/PC Engine
* Virtual Boy
* WonderSwan
* WonderSwan Color
