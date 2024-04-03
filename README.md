# nix-config

My nix system configuration

## How to use

1. Add the following to `/etc/nixos/configuration.nix` to enable `nix-command` and `flakes` features:

```nix
nix.extraOptions = "experimental-features = nix-command flakes";
```

2. Update you system to reflect the changes:

```bash
sudo nixos-rebuild test
sudo nixos-rebuild switch
```

3. Create a new directory for your `flake.nix` configuration:

```bash
mkdir -p ~/kickstart.nix
cd ~/kickstart.nix
```

4. Using `nix flake init` generate the `kickstart.nix` template of your choice locally:

```bash
nix flake init -t github:ALT-F4-LLC/kickstart.nix#nixos-desktop
nix flake init -t github:ALT-F4-LLC/kickstart.nix#nixos-minimal
```

5. Update the following value(s) in `flake.nix` configuration:

- For `desktop` flake template:

> [!IMPORTANT]
> Both `username` and `password` must be updated with your user username. Once updated, remove `throw` before each value to remove errors while switching. If you'd rather use a [hashed password](https://nixpkgs-manual-sphinx-markedown-example.netlify.app/generated/options-db.xml.html?highlight=hashedpassword#users-users-name-hashedpassword) replace `password` with `hashedPassword` with your password hash.

```nix
let
    nixos-system = import ./system/nixos.nix {
        inherit inputs;
        username = throw "<username>"; # REQUIRED: replace with user name and remove throw
        password = throw "<password>"; # REQUIRED: replace with password and remove throw
        desktop = "gnome"; # optional: "gnome" by default, or "plasma5" for KDE Plasma
    };
in
```

- For `minimal` flake template:

```nix
let
    nixos-system = import ./system/nixos.nix {
        inherit inputs;
        username = throw "<username>"; # REQUIRED: replace with user name and remove throw
        password = throw "<password>"; # REQUIRED: replace with password and remove throw
    };
in
```

6. Switch to `kickstart.nix` environment for your system with flake configuration:

> [!IMPORTANT]
> We use `--impure` due to how `/etc/nixos/hardware-configuration.nix` is generated and stored on the system after installation. To avoid using this flag, copy `hardware-configuration.nix` file locally and replace import in the template [see example](https://github.com/ALT-F4-LLC/dotfiles-nixos/blob/main/lib/default.nix#L54).

- For `aarch64` platforms:

```bash
sudo nixos-rebuild test --flake ".#aarch64" --impure # M Series Chipsets
sudo nixos-rebuild switch --flake ".#aarch64" --impure # M Series Chipsets
```

- For `x86_64` platforms:

```bash
sudo nixos-rebuild test --flake ".#x86_64"  --impure # Intel Chipsets
sudo nixos-rebuild switch --flake ".#x86_64" --impure # Intel Chipsets
```

Congrats! You've setup NixOS with Home Manager!

Be sure to explore the files below to get started customizing:

- `module/configuration.nix` for more `NixOS` system related settings
- `module/home-manager.nix` for `Home Manager` related settings
- `system/nixos.nix` for `NixOS` system related settings
- `flake.nix` for flake related settings
