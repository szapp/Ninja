![Ninja](https://user-images.githubusercontent.com/20203034/42415261-92bed2ae-8248-11e8-875c-5f7408588af8.png)

There are graphic patches for Gothic, that can be applied to the game and to various of the game modifications (in short "mods") and can be combined with other graphic patches.
It is a well-known fact in Gothic modding, however, that this is not possible with scripts - there is no such thing as real "script patches".  
"Ninja" is an attempt to make that possible for both Gothic 1 and Gothic 2.

This document is aimed at helping to create Ninja patches.

# General Information

A Ninja patch is a VDF that allows to inject any script changes into the game or modifications of it (whether it be content, menu, PFX, VFX, SFX, FightAI, music, or camera scripts), as well as new animations (without breaking existing animations or MDS/MSB files of the loaded mod).

- Ninja patches may be stacked at will to allow playing with all of them at the same time
- [SystemPack __1.7__](https://github.com/GothicFixTeam/GothicFix) is required (no older or newer version is supported)
- Use at your own risk: There is no support
- Ninja patches have no business in mod-kit (developer) installations

The version information (typically in the bottom right of the game main menu, provided it's not turned off) shows whether Ninja is activated ("2.6fx-S1.7-N1.2").

# Advanced Modding

This chapter of Gothic modding is directed towards experienced modders, because there is a lot that can be done wrong and there should be a good understanding of the scripts and how Ninja works. Should Ninja catch on and you want to create a Ninja patch, this here document is compulsory reading material.

# The Name "Ninja"

This name fits pretty well for several reasons:
- The nine ninjas, that the patch deploys "infiltrate" the mod scripts and "inject" changes.
- They are quick and agile: They traverse around existing scripts without any collision.
- They are silent but deadly: There is no direct error handling. If a patch is not carefully designed, it ends deadly for the ninjas (game crashes).
- They establish their goal by force: If you are not careful, they break the underlying mod.

# The Patching System

The system consists of nine ninjas that are based on the same principle (except for the animation ninja, more on that later). The ninjas accept missions and execute them at the start of Gothic in the following fashion:
- Gothic loads the `Gothic.dat` ➞ the content ninja injects his changes,
- Gothic loads the `Menu.dat` ➞ the menu ninja injects his changes,
- ...

Now, what do these missions look like? The missions are nothing more that the usual SRC files. The ninjas take their respective SRC file and parse them after the loading of the corresponding DAT file. Yes: *parse*. Since the ninjas infiltrate and inject changes, the scripts have to be provided in uncompiled form (D files). This may sound a bit strange for a VDF and it would theoretically be possible to also do it with DAT files, but that would be way more complicated, for both the ninjas and the creator of the Ninja patch. I have altered the parsing such that symbols may be overwritten (variables, functions, etc.). Further below, I explain how this is regulated.  
In order to not only add new scripts, but to also trigger/call/use them, initialization functions may be provided that will be called from Ninja (also explained below).

# Implementation

How is this even possible? The System Pack offers the possibility to inject machine code into the `GothicMod.exe` or the `Gothic2.exe` at start of Gothic, similar how this can be done with Ikarus, but at the very beginning and without dependencies on any scripts. I have written over 3100 bytes of machine code to circumvent parsing limitations, search and parse Ninja SRC files after one another, find and call initialization functions, and inject animations.

# Modified Parsing

As per usual, you create one SRC file for each parser that you need (in other words: one mission for each ninja that you'd like to deploy). The file path (starting from the Gothic install directory) looks like this: `"Ninja\[Parser]_Ninja_[PatchName].src"`, where `[Parser]` is the respective ninja ("Content", "Menu", "Camera", "PFX", "SFX", "VFX", "Music", "Fight", or "Animation") and `[PatchName]` is the unique identifier of the Ninja patch. In the SRC file all D files or further SRC files are listed. Keep in mind, however, that ninjas do not accept wildcards (`*` and `?`), such that **each file has to be listed explicitly**. The ninjas then persuade Gothic to parse these SRC files on top of the previously loaded DAT files.

In order to use common, reoccurring script packages (like Ikarus and LeGo) for mods that do not use them, as well as for mods that do have them, the ninjas evade parser errors like `"Redefined Identifier"`. Any symbol can be replaced, whether it be variables, constants, or functions. Classes, prototypes and instances, on the other hand, will be merged, that is, they cannot be reduced, but only changed or enlarged. Additional exceptions are empty functions and the Ikarus symbols that implement jumps (`MEM_Label`, `MEM_Goto`, `repeat`, `while`). These will be ignored when being reparsed. This is necessary to not break the Ikarus jumps.  
**It is inevitable that Ninja patches that include LeGo are kept up to date to the newest version of LeGo continuously** in order not to compromise any other loaded patches by overwriting a newer LeGo version with an older one.

Although the ninjas are very agile, they never question their missions. You should be very careful with overwriting symbols! A recklessly created patch with poorly chosen variable names may overwrite the wrong symbols unintentionally. Furthermore, the symbol type will also be overwritten. Usually that is not a problem, but a recklessly created patch might change an integer variable to a string variable which will cause crashes mid game that are not easy to track. Not only does this hold for symbols from the DAT file, but also for symbols from other loaded Ninja patches. Thus, **symbols in Ninja patches must have a unique name** (i.e. to make them patch specific variables or functions); convention: `Ninja_[PatchName]_[SymbolName]`, e.g. `Ninja_GFA_MergeLeGoFlags`. For this reason, mind this guideline:  
**Avoid common symbol names (e.g. `Var1` or `a`, `b`, `c`) and instead choose patch specific names.**

Nevertheless, targeted overwriting of symbols should not be misunderstood and used only sparingly. As an example, overwriting the `Init_Global` (in order to initialize something) would not be very smart, because it throws out any initialization that the underlying mod might have made. Similarly, it would not be very smart to overwrite the main menu just to add one new menu entry - existing, modified menu entries of the mod would get lost. This raises the question: What are the ninjas good for, if they are not allowed to replace anything? The answer to that question are the initialization functions (details below).

Another important thing to keep in mind is that the symbol indices of Ninja patches shift around if the player loads or unloads different patches between saving and loading. Since DAT files are always loaded into the symbol table first, this only affects Ninja patches, but not the underlying game/mods. Usually this is not a problem, but it should be kept in mind for more complex scripts that save the index of symbols (e.g. LeGo's Event-Handler).

# Initialization Functions

What good is an added script function, if it is never called? In order to not only add, but to also change existing things (without replacing them completely), or to trigger/call/use these alterations, there are two initialization functions. These are new patch specific functions that are called from Ninja. The idea is to call your new functions from there.

One of these initialization functions is for the content scripts. It is called every time directly after `Init_Global`<sup>1</sup>. The other one is for the menu scripts and is called every time a menu is created, that is, every time when it's opened. From these functions you can initiate changes (e.g. initialize LeGo or inject a new menu entry into the main menu). Each Ninja patch can (but does not have to) provide either one or both of these functions and they will be called one by one for each patch at the mentioned positions. The functions are detected by their names, that is composed like this: `func void Ninja_[PatchName]_Init()` for the initialization function after `Init_Global`<sup>1</sup> and `func void Ninja_[PatchName]_Menu(var int menuPtr)` for the initialization function when opening any menu, where the function argument `menuPtr` is a zCMenu pointer to the menu that is being opened.

Of course, both functions must be parsed by the content ninja. So if you, for example, want to add a new menu entry, you will not only need an SRC file for the menu ninja, but also one for the content ninja that includes the file that holds the menu initialization function.

How to add a new menu entry neatly is demonstrated in the *Free Aiming Ninja patch*.  
How to initialize LeGo packages without breaking the existing LeGo initialization in a loaded mod or in another Ninja patch is also shown in the *Free Aiming Ninja patch*, as well as in the *Bloodsplats Ninja patch* (for a simple example). **If you use LeGo in your patch, using the demonstrated procedure found in those patches is inevitable!** Likewise it is very important that the corresponding symbols have unique names (`Ninja_[PatchName]_MergeLeGoFlags`)!

<sup>1</sup> Since there is no `Init_Global` in Gothic 1, the content initialization function is called after the respective `Init_[World]` in Gothic 1.

# Special Case: The Animation Ninja

Although animations do not rely on Daedalus scripts, the injection works similarly there. The SRC file is merely needed to determine the patch name (`"Ninja\Animation_Ninja_[PatchName].src"`). The content of the file is ignored. With the name, the MDS files in question will be determined. These have to be named in the following manner: `"_work\Data\Anims\[PatchName]_[Model].mds"`, where `[Model]` corresponds to any `zCModelPrototype`, e.g. `"Humans"` for the `"Humans.mds"`.

The contents of the MDS file is expected in the usual MDS format. However, since the file will be read after the MDS/MSB file has been loaded, it does not need to be complete. This means, if you simply want to add a new animation to the `Humans.mds`, you'll only need the usual block of
```
Model ("Hus")
{
    aniEnum
    {
        [YOUR NEW ANIMATIONS HERE]
    }
}
```
without any registering of meshes or trees or the listing of already existing animations. I want to refer you to the contents of the *Free Aiming Ninja patch* for a good example. Similarly, it is just as easy to register new armors. Please check out the *OreArmor Ninja patch* for a simple demonstration.

New animations should be provided in compiled format at the usual file path inside the VDF (again, use the existing Ninja patches as example).

The animation ninja is initiated, just like the loading of the MDS/MSB files, every time when a corresponding model is loaded in the game for the first time (typically during loading of a game or later when applying MDS overlays). The animation ninja will only search for MDS files whose patch name has been announced with an SRC file.

Keep in mind, that it is possible to overwrite properties of existing animations (reverse flag, event block, etc.), but you cannot overwrite existing animations themselves (if you do, the changes will be ignored silently). In order to effectively overwrite an animation, create an MDS overlay and a apply it to the desired NPCs via the content initialization function (e.g. with [broadcasts](https://forum.worldofplayers.de/forum/threads/?p=17232705)).

Furthermore, it is important to understand that the animation ninja sneaks through the engine while removing the writing of corresponding binary files. Therefore note: **Ninja has no business in a mod-kit installation** of Gothic 2 (Gothic 1 is not affected by this, the advice still holds, however).

# Debugging

You may force the ninjas to talk by setting the level of the zSpy logging to 5 (or above) and filter for information (not only warnings or faults). All Ninja messages are indicated by the author-prefix "J:". You'll get insight into appended MDS files (incl. the number of new animations) and parsed Ninja script files. If you need even more information and don't mind the increased loading time, you can increase the zSpy level to 7 to list each and every symbol that the ninjas overwrite.

# Creating a Ninja Patch VDF

Inside the VDF there is the `Ninja` directory in which the SRC files and the script D files are located. Keep in mind the mechanism behind the VDFS: *Each* and *every* of your files should have a unique name to prevent from overwriting or being overwritten by other Ninja patches. Best practice is to stick to the naming convention: `"Ninja_[PatchName]_[...].d"`. Exceptions may of course be common script packages like Ikarus or LeGo. If further data is required (textures, animations, etc.), place it in the usual file path (`"_work\Data\..."`). Alongside the directories `"Ninja"` and (if necessary) `"_work"` in the root directory, the Ninja machine code is needed (extended SystemPack 1.7. patch file), available for download: [Gothic 1](https://github.com/szapp/Ninja/files/2173152/Ninja_v1.2_Code_Gothic1.zip), [Gothic 2](https://github.com/szapp/Ninja/files/2173153/Ninja_v1.2_Code_Gothic2.zip). The file name, as well as its location in the root directory cannot be changed! Only under these circumstances the patch file will be considered. It is equally important to name the VDF by the following naming convention: `"Ninja_[PatchName].vdf"`.

Finally, it is desirable that the root directory contains a file named `"Readme_Ninja_[PatchName].txt"`, which lists the changes the Ninja patch performs, any compatibility warnings, necessary credits and (very importantly!) a note about with Ninja version is used! (Currently Ninja v1.2) Should there ever be a new version of Ninja, this information is very important even for players to determine the compatibility with other Ninja patches.  
Furthermore, it makes sense to include the link [http://tiny.cc/GothicNinja](http://tiny.cc/GothicNinja), to steer possible interested people in the right direction and to prevent completely wrong and destructive Ninja patches to get into circulation. Ninja version and the mentioned link should also be included in the info text of the VDF in order to make this information accessible for anyone without unpacking the VDF. Again: Take the existing Ninja patches as example.

```
╔═══════════════════════╗
║ Ninja_[PatchName].vdf ║
╚╦══════════════════════╝
 |
 │  ┌────────┐
 ├─>| NINJA/ |
 │  └─┬──────┘
 |    |  ┌──────────┐
 │    ├─>| CONTENT/ |
 │    │  └─┬────────┘
 │    │    ├─> Ninja_[PatchName]_[...].d    // Content/menu initialization functions if necessary.
 │    │    │
 │    │    ├─> Ninja_[PatchName]_[...].d    // Any content script files. Mind the file names.
 │    │    ├─> Ninja_[PatchName]_[...].d
 │    │    └─> ...
 │    │  ┌─────────┐
 │    ├─>| SYSTEM/ |
 │    │  └─┬───────┘
 │    │    ├─> Ninja_[PatchName]_[...].d    // Any system script files. Mind the file names.
 │    │    ├─> Ninja_[PatchName]_[...].d
 │    │    └─> ...
 │    │
 │    ├─> Ninja_[PatchName]_[Parser].src    // Ninja SRC files that list all D files. Mind the file names.
 │    ├─> Ninja_[PatchName]_[Parser].src
 │    └─> ...
 |
 │  ┌────────┐
 ├─>| _WORK/ |
 │  └─┬──────┘
 |    │  ┌───────┐
 │    └─>| DATA/ |
 │       └─┬─────┘
 |         |  ┌──────┐
 │         ├─>| .../ ├─> ...                 // Any new resources. Files like textures, meshes or sounds.
 |         |  └──────┘
 │         │  ┌────────┐
 │         └─>| ANIMS/ |
 │            └─┬──────┘
 |              |  ┌────────────┐
 │              ├─>| _COMPILED/ |
 │              │  └─┬──────────┘
 │              │    └─> ...                // Any new animations referenced in the Ninja MDS files.
 │              │
 │              ├─> [PatchName]_[Model].mds // Ninja MDS files. Corresponding Ninja SRC file necessary.
 │              ├─> [PatchName]_[Model].mds
 │              └─> ...
 │
 ├─> CODE_[XXXXXXXX].patch                  // Ninja machine code file(s) for Gothic 1 or Gothic 2.
 │
 └─> Readme_Ninja_[PatchName].txt           // Information about the Ninja patch.
 
```

# How stable is Ninja?

There are no known issues with the latest version.

# Changelog

### v1.2: Mar 23, 2018
- Fix rare bug in animation ninja

### v1.1: Mar 14, 2018
- Ninja for Gothic 1
- Re-implementation of finding files: old VDFS no longer used = more stability and faster loading times
- Minor fixes

### v1.0: Mar 7, 2018
- Initial release
