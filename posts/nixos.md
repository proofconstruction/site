---
title: NixOS
date: 2020-08-05
---

A few years ago I discovered the [NixOS project](https://nixos.org) and fell in love with the idea.

While I'm not a professional developer and the Nix tool's utility is comparatively limited for me, I am a long-time Linux user and frequent-sysadmin at work and for friends' projects, so the promise of declaratively configuring the entire operating system was too good to pass up. I used it casually on a few machines but didn't go all-in until about two summers ago.

Though I've slowed down recently, I tend to move between devices pretty quickly. Usually this was a function of working in IT: we have new hires coming in today that HR didn't warn us about **(!)**, and laptops should've been provisioned yesterday **(!!)**, so I give up mine **(!!!)**. Other times, a family member or friend just needs a new machine, so I give up one of mine and move to something else. In any case, this creates a decent amount of friction for me, and opens the door for inconsistencies between the old and new setups.

NixOS largely solves this and other problems, in an elegant way. Most notably at the outset, it allows you to avoid having a million different config files written in as many different languages, just to have basic services running, or a user provisioned, or whatever else.

My current configuration is available on [GitHub](https://github.com/proofconstruction/system) and I'll explain a bit of how I use it here.

---


### Configuration

The `configuration.nix` file located at (or symlinked to) `/etc/nixos/` is the top level of your OS configuration.

Mine looks like this:
``` nix
    { config, pkgs, lib, options, ... }:
    {
     imports = [

        # special channel stuff goes here
        <nixos-hardware/lenovo/thinkpad/x1/6th-gen/QHD>
        <home-manager/nixos>

        # general configs go here
        ./boot.nix
        ./config.nix
        ./console.nix
        ./desktop.nix
        ./devices.nix
        ./environment.nix
        ./fonts.nix
        ./hardware-configuration.nix
        ./i18n.nix
        ./network.nix
        ./system.nix
        ./users.nix
      ];

      nixpkgs.config.allowUnfree = true;

      powerManagement.enable = true;

      system.stateVersion = "20.03";
    }
```

Here, I've broken my configuration into many more files, each of which handles different functionality. The `desktop.nix` file contains settings for X11 and my window manager, `hardware-configuration.nix` has stuff for specifying filesystems and kernel modules, and so on. It's a nice touch that `imports` takes a _list_ of paths.

Nix has a notion of "channels", which are locations containing Nix expressions that evaluate to the software you want. These are unfortunately stateful, and will be replaced by an upcoming feature called [flakes](https://nixos.wiki/wiki/Flakes), but more on that soon once I refactor my configuration. I have a channel for [nixos-hardware](https://github.com/nixos/nixos-hardware) which imports device-specific configs, and another for [home-manager](https://github.com/rycee/home-manager) which allows me to declaratively manage my `/home` configuration. Previously I was using bespoke bash scripts and tools like `stow` for the latter, which just adds complexity and things to lose..

Below this I have settings to allow installing proprietary/unfree software, to enable CPU frequency scaling, and to set the version of the NixOS configuration.

The `{ config, pkgs, lib, options, ... }:` bit at the top is necessary because the Nix expression language is written as pure functions, and all of the things in those curly braces are inputs to the function that produces this configuration.


#### Users

Of particular interest to sysadmins is my `users.nix`, which defines my non-root desktop user (this is a single-human machine), its group memberships, its home directory and default shell:

```nix
    { config, pkgs, lib, ...}:

    {
      # enable user account
      users.users.alex = {
        isNormalUser = true;
        uid = 1000;
        createHome = true;
        name = "alex";
        group = "users";
        extraGroups = [
          "wheel" "disk" "audio" "video"
          "networkmanager" "systemd-journal"
          "adbusers" "docker" "lxd"
        ];
        home = "/home/alex";
        shell = pkgs.zsh;
      };

      # declare the user's home-manager config here
      home-manager.users.alex = import ./home.nix;
    }
```
Compare this to having fragments of the user and group configurations strewn all over `/etc`.

### Home Manager

At the end of `users.nix`, I import `home.nix`, which is essentially another `configuration.nix` but for my user's `$HOME`, and which makes heavy use of the home-manager mentioned earlier:

#### Home

This file in turn uses a `let` expression to define some paths and default environment variables, enables user-level systemd services, and enables the FreeDesktop `xdg` utilities. It then imports all of my home-manager module files.

In here, I have configurations for my user interface under `# UI`, the `stow` replacement with `files.nix`, and definitions and configurations for the _user-level_ packages, programs, and services I want. Nix lets you avoid installing things system-wide, a feature we'll come back to in a later post.

At time of writing, I'm using a standalone `.emacs` file and not importing the configuration in `emacs.nix`, but I have a full configuration for Emacs built from the development branch, thanks to the [Emacs overlay](https://github.com/nix-community/emacs-overlay).

```nix
    { config, pkgs, lib, ... }:

    let

      # paths
      dotFiles = "/home/alex/dotfiles";
      homeFiles = "${dotFiles}/home-manager";
      appFiles = "${dotFiles}/applications";

      # preferences
      home = {
        keyboard.layout = "us";
        stateVersion = "20.03";
        home.sessionVariables = {
          EDITOR = "emacs";
          BROWSER = "firefox";
          LC_CTYPE = "en_US.UTF-8";
          PAGER = "less -R";
        };
      };

      systemd.user.startServices = true;

      xdg.enable = true;

    in {
      imports = map builtins.toPath [
        # enable nonfree packages
        "${homeFiles}/config.nix"

        # UI
        "${homeFiles}/interface.nix"
        "${homeFiles}/xresources.nix"
        "${homeFiles}/xsession.nix"
    
        # general config
        "${homeFiles}/files.nix"
        "${homeFiles}/packages.nix"
        "${homeFiles}/programs.nix"
        "${homeFiles}/services.nix"
    
        # applications
        #"${appFiles}/emacs.nix"
      ];
    
    
    }
```

#### Programs

home-manager has modules for many of the commonly used pieces of software, and I have these specified in `programs.nix`. Here's an excerpt of that file containing my very basic zsh configuration:
```nix
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      history = {
        extended = true;
        share = true;
      };
      oh-my-zsh = {
        enable = true;
        theme = "clean";
      };
    };
```

I love not needing to manually clone repositories or change individual files to set up things like [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/).

The major utility of home-manager is not having to remember where all your configurations were made, or the different configuration syntaxes used by other tools. Just as with the system-wide configuration, much of your user-level software can be configured through the Nix expression language, and new options and supported programs are being added all the time.


### Nix

In a future post I'll talk about how I use Nix to build this blog, and to manage my development environments for other projects.


### Resources

Here are some useful links for getting into Nix and NixOS.

-   [Nix Pills](https://nixos.org/nixos/nix-pills/index.html)
-   [Nix.dev](https://nix.dev/)
-   [The NixOS Wiki (Unofficial)](https://nixos.wiki/)
-   [The NixOS Manual (Official)](https://nixos.org/nixos/manual)

Admittedly, the documentation still needs a lot of help and has a long way to go to reach the quality of the [Arch Wiki](https://wiki.archlinux.org/index.php/) or [Gentoo Wiki](https://wiki.gentoo.org/wiki/Main_Page), but big strides have been made recently.

