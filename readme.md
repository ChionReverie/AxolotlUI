# AxolotlUI - v0.2.3-sample
![WoW Client](https://img.shields.io/badge/wow_client-1.12.1_%22vanilla%22-blue)
[![Release](https://img.shields.io/github/v/release/ChionReverie/AxolotlUI)](https://github.com/ChionReverie/AxolotlUI/tags) 
[![Prerelease](https://img.shields.io/github/v/release/ChionReverie/AxolotlUI?include_prereleases&label=prerelease)](https://github.com/ChionReverie/AxolotlUI/tags)

Axolotl is my custom UI addon for the World of Warcraft Vanilla 1.12 client. It was originally designed for use on the TurtleWoW server, but is intented to function on any vanilla realm.

I created this addon because I've never been happy with other UI mods and their simplified shape language and clashing themes. With Axolotl, I intend to reimagine common addon features under a unified design theme. In the future, I intend to support other addons by replacing their visuals. 

## Installation
1. Download the [Latest Release](https://github.com/ChionReverie/AxolotlUI/releases/latest) of AxolotlUI. The correct download will be the first link under "Assets". (There may also be a [prerelease version](https://github.com/ChionReverie/AxolotlUI/releases) available.)
2. Unpack the archive to `<WoWDir>\Interface\Addons\`
3. Relaunch World of Warcraft. (Addons and files will only be read after launch.)

## Contributing
This addon is written in Lua with Lua Language Server's type-checking in mind. Some helpful tools include...
* [Vanilla WoW Lua Definitions](https://github.com/refaim/Vanilla-WoW-Lua-Definitions) (which is missing some important definitions. )
* [Blizzard Interface Data for 1.12.2](https://github.com/MOUZU/Blizzard-WoW-Interface/tree/master/1.12.1)

In order to get useful diagnostic warnings in VSCode, I use the following settings in the [Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) addon:
* `Lua.workspace.library`: Paths to WoW API lua definitions and WoW Interface Data
* `Lua.diagnostics.libraryFiles`: "Disable"