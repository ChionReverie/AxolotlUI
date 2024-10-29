# AxolotlUI
Axolotl is my custom UI addon for the World of Warcraft Vanilla 1.12 client. It was originally designed for use on the TurtleWoW server, but is intented to function on any vanilla realm.

I created this addon because I've never been happy with other UI mods and their simplified shape language and clashing themes. With Axolotl, I intend to reimagine common addon features under a unified design theme. In the future, I intend to support other addons by replacing their visuals. 

## Installation
1. Download the [Master branch](https://github.com/ChionReverie/AxolotlUI/archive/refs/heads/main.zip). This is where the current release version of Axolotl lives. 
2. Unpack the zip file to `<WoWDir>\Interface\Addons\`
3. Rename the `AxolotlUI-main` folder to `AxolotlUI`
4. Relaunch World of Warcraft. (Addons and files will only be read after launch.)

## Contributing
This addon is written in Lua with Lua Language Server's type-checking in mind. Some helpful tools include...
* [Vanilla WoW Lua Definitions](https://github.com/refaim/Vanilla-WoW-Lua-Definitions) (which is missing some important definitions. )
* [Blizzard Interface Data for 1.12.2](https://github.com/MOUZU/Blizzard-WoW-Interface/tree/master/1.12.1)

In order to get useful diagnostic warnings in VSCode, I use the following settings in the [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) addon:
* `Lua.workspace.library`: Paths to WoW API lua definitions and WoW Interface Data
* `Lua.diagnostics.libraryFiles`: "Disable"