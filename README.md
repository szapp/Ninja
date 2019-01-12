![Ninja](https://user-images.githubusercontent.com/20203034/42415261-92bed2ae-8248-11e8-875c-5f7408588af8.png)

The purpose of this repository is to provide insight into the inner workings of Ninja.

For more information on the Ninja patching framework visit the [documentation](https://tiny.cc/GothicNinja).  
If you are interested in developing Ninja patches, please visit the Ninja Patch repository:
[szapp/NinjaPatchTemplate](https://github.com/szapp/NinjaPatchTemplate).

# Important Note

:warning: **Please understand that maintaining compatibility of Ninja patches is demanding enough as is. For that
reason, please do not modify and redistribute your own versions of Ninja. Please contribute here instead by suggesting
changes via the issue tracker or create pull requests to keep the Ninja patch landscape clean with this here being the
only version and main repository.**
                            <!-- Let's see what idiot doesn't read this paragraph -->

# Requirements

Assembling this project is possible under \*nix and Windows. To do so, the following software is required.

- [NASM (The Netwide Assembler)](https://nasm.us)

On Windows, additionally install the following *GNU Win32* packages and add their binaries to your `PATH` (same for
NASM).

- [Make](http://gnuwin32.sourceforge.net/packages/make.htm)
- [Grep](http://gnuwin32.sourceforge.net/packages/grep.htm)
- [BinUtils](https://sourceforge.net/projects/mingw/files/MinGW/Base/binutils/) for `objdump`
- [Util-Linux](http://gnuwin32.sourceforge.net/packages/util-linux-ng.htm) for `hexdump`
- [CoreUtils](http://gnuwin32.sourceforge.net/packages/coreutils.htm) for `head`

# Assembling

I trust that you build Ninja only out of personal interest or to contribute, but not with the goal of distributing
modified versions.  
Please read the note at the top of this readme and respect this request.

```bash
make
```

This will assemble and bundle the project into SystemPack patch files in the `./build/` directory. The respective files
can also be created separately for Gothic and Gothic 2 NotR.

```bash
make gothic1
```

```bash
make gothic2
```

# Legal

Ninja is free software and released under The MIT License (MIT).

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
