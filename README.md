![Ninja](https://user-images.githubusercontent.com/20203034/42415261-92bed2ae-8248-11e8-875c-5f7408588af8.png)

This repository contains the source code of the Ninja patching framework for Gothic 1 and Gothic 2 NotR.

If you are interested in developing patches with Ninja, please follow the instructions in the relevant chapters of the
[documentation](https://tiny.cc/GothicNinja).

# About

Modifications of the video games *Gothic* and *Gothic 2 Night of the Raven* have succeeded to impress for well over a
decade. Graphical changes may be deployed as modular patches running independently side-by-side. However, other aspects
of the games, such as the story, may only be replaced as a whole. This has limited such modifications of the game to be
exclusive, resulting in the term "modification" (in short "mod") to refer to a self-contained set of changes, that
constitutes a new playable game (as opposed to a modular "patch"). To the frustration of many players, this does not
allow combining their favorite mods and even the smallest improvement or bug fix to the original games demands an
entirely independent mod incompatible with any other mods.

Ninja lifts this constraint by extending the scope of the aforementioned, familiar modular patches to include *any*
aspect of the game, instead of only mere graphical enhancements. This empowers them to the extent of mods, while
retaining their modular behavior. Different from mods, they may to be stacked and combined at will, enriching the
modding landscape for players and raising it to a new level. Nevertheless, they are not to be understood to replace
mods, but to complement them with small, independent features and enhancements.

For more information on the Ninja patching framework, visit the [documentation](https://tiny.cc/GothicNinja).

# Usage

To use Ninja, download and install the [latest release](../../releases/latest). If you run into issues or need further
instructions, please consult the [documentation](https://tiny.cc/GothicNinja).

# Building from Source

There is **absolutely no need to assemble Ninja yourself** as the latest build is always available for download.

Nevertheless, if you wish to do so anyway, not all resources necessary for building are supplied in this repository and
you'll not be able to successfully build it. The purpose of this repository is merely to provide *insight* into the
source code. The additional resources may be provided upon request.

## Requirements

Because of linking a Windows DLL, assembling this project is no longer possible under \*nix but is exclusive to Windows.
(All \*nix shell scripts have been stripped from this project, but may still be found in the git history.) For linking
the final DLL the following libraries are required on your system.

- User32.dll
- Kernel32.dll
- NtDll.dll

For assembling and building, the following software is required.

- [NASM (The Netwide Assembler)](https://nasm.us)
- [GoLink (Go Tools for Windows)](http://godevtool.com)
- [GoRC (Go Tools for Windows)](http://godevtool.com)

Additionally, you'll need various *GNU Win32* packages:

- [Make](http://gnuwin32.sourceforge.net/packages/make.htm)
- [Grep](http://gnuwin32.sourceforge.net/packages/grep.htm)
- [BinUtils](https://sourceforge.net/projects/mingw/files/MinGW/Base/binutils/) for `objdump`

All binaries of the listed software must be added to your `PATH` environment variable.

## Assembling

Building Ninja consists of a cascade of assembling the core and assembling the DLL wrapper.  
First, the core is assembled into binary files. These are then included when assembling the wrapper which is then
finally linked into a DLL.

The reason for this compartmentalization is to separate core and wrapper and to avoid slow absolute (eax) jumps within
the executed code by injecting it into the executable at fixed addresses to make use of relative jumps to addresses
known at time of assembling.

All the steps above are performed simply with

```bash
make
```

# Legal

Ninja is free software and released under the MIT License (MIT).

# Changelog

### v2.0: TBA
- ...

### v1.2: Mar 23, 2018
- Fix rare bug in animation ninja

### v1.1: Mar 14, 2018
- Ninja for Gothic 1
- Re-implementation of finding files: old VDFS no longer used = more stability and faster loading times
- Minor fixes

### v1.0: Mar 7, 2018
- Initial release
