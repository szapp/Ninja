![Ninja](https://user-images.githubusercontent.com/20203034/42415261-92bed2ae-8248-11e8-875c-5f7408588af8.png)

The purpose of this repository is to provide insight into the inner workings of Ninja.

For more information on the Ninja patching framework visit the [documentation](https://tiny.cc/GothicNinja).  
If you are interested in developing patches with Ninja, please visit the patch template repository:
[szapp/NinjaPatchTemplate](https://github.com/szapp/NinjaPatchTemplate).

# Requirements

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
- [Util-Linux](http://gnuwin32.sourceforge.net/packages/util-linux-ng.htm) for `hexdump`
- [CoreUtils](http://gnuwin32.sourceforge.net/packages/coreutils.htm) for `head`

All binaries of the listed software must be added to your `PATH`.

# Assembling

**This is purely for people who want to contribute to this project. There is otherwise *no need to assemble Ninja
yourself* as the latest build is always available for download.**

Building Ninja consists of a cascade of assembling the core and assembling the DLL wrapper.  
First, the core is assembled into binary files. These are then read and included as hexadecimal 'strings' when
assembling the wrapper which is finally linked into a DLL.

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
