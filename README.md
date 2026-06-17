# luafetch
a simple asf neofetch implementation on lua

```text
    /¯\             unterdev@unterdev-nitro
   /   \            OS: EndeavourOS
 /      \           Kernel: 7.0.12-arch1-1
/_       )          Shell: /bin/bash
 /_______/          Lua: Lua 5.5
```

## requirements

* Lua 5.4+

### arch linux

```bash
sudo pacman -S lua
```

## installation

clone the repository:

```bash
git clone https://github.com/unterdev33/luafetch
cd luafetch
```

run directly:

```bash
lua main.lua
```

## system-wide installation

clone the repository:

```bash
git clone https://github.com/unterdev33/luafetch
cd luafetch
```
install system-wide:

```bash
sudo cp main.lua /usr/local/bin/luafetch
sudo chmod +x /usr/local/bin/luafetch
```

## usage

run:
```bash
luafetch
```

use a different logo:
```bash
luafetch --distro arch
luafetch --distro endeavouros
```

## uninstall
```bash
sudo rm /usr/local/bin/luafetch
```

## adding a distribution Logo

edit `ascii.lua`:

```lua
ascii.arch = {
    "    /\\     ",
    "   /, \\    ",
    "  /    \\   ",
    " /  () ,\\  ",
    "/__/  \\__\\ "
}
```

the table key should match the distribution `ID` from `/etc/os-release`.
