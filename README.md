# Ninja

[![Build status](https://github.com/szapp/Ninja/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/szapp/Ninja/actions/workflows/build.yml)
[![Documentation](https://img.shields.io/badge/docs-wiki-blue)](https://github.com/szapp/Ninja/wiki)
[![GitHub release](https://img.shields.io/github/v/release/szapp/Ninja.svg)](https://github.com/szapp/Ninja/releases/latest)
[![Combined downloads](https://api.szapp.de/downloads/ninja/total/badge)](https://github.com/szapp/Ninja/wiki#user-content-downloads)

This repository contains the source code of the Ninja extension for Gothic 1 and Gothic 2 NotR.

If you are interested in developing patches with Ninja, please follow the instructions in the relevant chapters of the
[documentation](https://github.com/szapp/Ninja/wiki).

# About

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

- [NASM (The Netwide Assembler)](https://nasm.us)
- [GoLink (Go Tools for Windows)](http://godevtool.com)
- [GoRC (Go Tools for Windows)](http://godevtool.com)
- [NSIS (Nullsoft Scriptable Install System)](https://nsis.sourceforge.io)

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
