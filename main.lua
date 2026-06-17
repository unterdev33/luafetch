#!/usr/bin/env lua

local ascii = {}

ascii.endeavouros = {
    color = "\27[35m",
    art = {
        "    /^\\    ",
        "   /   \\   ",
        " /      \\  ",
        "/_       ) ",
        " /_______/ "
    }
}

ascii.arch = {
    color = "\27[36m",
    art = {
        "    /\\     ",
        "   /, \\    ",
        "  /    \\   ",
        " /  () ,\\  ",
        "/__/  \\__\\"
    }

}

ascii.ubuntu = {
    color = "\27[31m",
    art = {
        " /¯¯¯¯¯¯\\  ",
        "|  /¯¯\\0 | ",
        "| 0    | | ",
        "|  \\___0 | ",
        " \\______/  "
    }
}

ascii.debian = {
    color = "\27[31m",
    art = {
        "  /¯¯¯¯\\   ",
        " | /¯¯  |  ",
        " \\ \\___/ ",
        "  \\_      ",
        "    \\,    "
    }
}

ascii.cachyos = {
    color = "\27[32m",
    art = {
       " //:::::: .   ",
       "//            ",
       "<<     o      ",
       "\\\\........ 0  ",
       " \\\\:::::::    "
    }
}

ascii.mint = {
    color = "\27[32m",
    art = {
        "|| /^^\\__^^\\   ",
        "|| || | || ||  ",
        "|| || | || ||  ",
        "|| || | || ||  ",
        "\\\\_________//  ",
    }
}




local RESET = "\27[0m"
local CYAN = "\27[36m"

local distro_override = nil

for i = 1, #arg do
    if arg[i] == "--distro" and arg[i + 1] then
        distro_override = arg[i + 1]
    end
end

local function read_first_line(path)
    local file = io.open(path, "r")
    if not file then
        return nil
    end

    local line = file:read("*l")
    file:close()

    return line
end

local function get_distro()
    local pretty_name = "Unknown"
    local distro_id = "unknown"

    for line in io.lines("/etc/os-release") do
        local pretty = line:match('^PRETTY_NAME="(.*)"$')
        local id = line:match("^ID=(.+)$")

        if pretty then
            pretty_name = pretty
        end

        if id then
            distro_id = id:gsub('"', "")
        end
    end

    return pretty_name, distro_id
end

local function cmd(command)
    local handle = io.popen(command)

    if not handle then
        return "Unknown"
    end

    local result = handle:read("*l")
    handle:close()

    return result or "Unknown"
end

local user = os.getenv("USER") or "unknown"
local hostname = read_first_line("/etc/hostname") or "unknown"

local distro_name, distro_id = get_distro()

if distro_override and ascii[distro_override] then
    distro_id = distro_override
end

local logo = ascii[distro_id]

local art = {}
local color = ""

if logo then
    art = logo.art
    color = logo.color or ""
    
    if distro_override and logo.name then
        distro_name = logo.name
    end
end

local info = {
    CYAN .. user .. "@" .. hostname .. RESET,
    CYAN .. "OS:" .. RESET .. " " .. distro_name,
    CYAN .. "Kernel:" .. RESET .. " " .. cmd("uname -r"),
    CYAN .. "Shell:" .. RESET .. " " .. (os.getenv("SHELL") or "Unknown"),
    CYAN .. "Lua:" .. RESET .. " " .. _VERSION
}

for i = 1, math.max(#art, #info) do
    local left = art[i] and (color .. art[i] .. RESET) or ""
    local right = info[i] or ""

    print(string.format("%-20s %s", left, right))
end