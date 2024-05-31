# Ninja

[![Build status](https://github.com/szapp/Ninja/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/szapp/Ninja/actions/workflows/build.yml)
[![Documentation](https://img.shields.io/badge/docs-wiki-blue)](https://github.com/szapp/Ninja/wiki)
[![GitHub release](https://img.shields.io/github/v/release/szapp/Ninja.svg)](https://github.com/szapp/Ninja/releases/latest)
[![Combined downloads](https://api.szapp.de/downloads/ninja/total/badge)](https://github.com/szapp/Ninja/wiki#user-content-downloads)
[![Steam Gothic 1](https://img.shields.io/badge/steam-Gothic%201-2a3f5a?logo=steam&labelColor=1b2838)](https://steamcommunity.com/sharedfiles/filedetails/?id=2786936496)
[![Steam Gothic 2](https://img.shields.io/badge/steam-Gothic%202-2a3f5a?logo=steam&labelColor=1b2838)](https://steamcommunity.com/sharedfiles/filedetails/?id=2786910489)

This repository contains the source code of the Ninja extension for the Gothic game series.

If you are interested in developing patches with Ninja, please follow the instructions in the relevant chapters of the
[documentation](https://github.com/szapp/Ninja/wiki) and get started with the official [patch template](https://github.com/szapp/patch-template).

# About

Ninja is supported by the games Gothic (1.08k_mod), Gothic Sequel (1.12f), Gothic 2 (1.30 fix report version), and Gothic 2 NotR (2.6 fix report version).

For information on Ninja, please visit the [documentation](https://github.com/szapp/Ninja/wiki).

# Usage

To use Ninja, download and install the [latest release](https://github.com/szapp/Ninja/releases/latest). If you run into
issues or need further instructions, please consult the [documentation](https://github.com/szapp/Ninja/wiki).

---

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

- [NASM (The Netwide Assembler)](https://nasm.us) (2.16.03)
- [GoLink (Go Tools for Windows)](http://godevtool.com) (1.0.4.5)
- [GoRC (Go Tools for Windows)](http://godevtool.com) (1.0.3.0)
- [NSIS (Nullsoft Scriptable Install System)](https://nsis.sourceforge.io) (3.10)

Additionally, you'll need the following binaries:

- [GNU Make](http://gnuwin32.sourceforge.net/packages/make.htm) (3.81)
- [Git for Windows](https://git-scm.com/download/win) (2.45.1) for various included GNU Win32 tools
- [BinUtils](https://sourceforge.net/projects/mingw/files/MinGW/Base/binutils/) (2.28) for `objdump`
- [ducible](https://github.com/jasonwhite/ducible) (1.2.2)

The binaries of the listed software must be added to your `PATH` environment variable or placed in the root directory.

Some binaries are attempted to be automatically detected at build time and added to the `PATH` for the duration of building. These include `nasm`, `makensis`, `grep`, `date`, `dd`, `touch`, `xxd`.

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
