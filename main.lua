local ascii = require("ascii")

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
    local h = io.popen(command)
    local result = h:read("*l")
    h:close()
    return result or "Unknown"
end

local user = os.getenv("USER") or "unknown"
local hostname = read_first_line("/etc/hostname") or "unknown"

local distro_name, distro_id = get_distro()

local info = {
    user .. "@" .. hostname,
    "OS: " .. distro_name,
    "Kernel: " .. cmd("uname -r"),
    "Shell: " .. (os.getenv("SHELL") or "Unknown"),
    "Lua: " .. _VERSION
}

local art = ascii[distro_id] or {}

for i = 1, math.max(#art, #info) do
    local left = art[i] or ""
    local right = info[i] or ""

    print(string.format("%-20s %s", left, right))
end