local bit = require("bit")

-- String.split()
function split(s, sep)
    local fields = {}

    local sep = sep or " "
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)

    return fields
end

-- see if the file exists
function fileExists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end
  
-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function readLines(file)
    if not fileExists(file) then return {} end
    lines = {}
    for line in io.lines(file) do 
        lines[#lines + 1] = line
    end
    return lines
  end

function printArray(t)
    s = ""
    prefix = ""
    for _, v in pairs(t) do
        s = s .. prefix .. v
        prefix = ","
    end
    print(s)
end

function printTable(t)
    for k, v in pairs(t) do
        print(k .. ":\t" .. tostring(v))
    end
end

function checkFlag(index, val)
    -- math.abs is needed because with index=30 and val>=2^31 the call to bit.band
    -- returns -2^31. bit returns *signed* numbers and is limited to 32bit integers
    -- don't ask how long this took to figure out
    return math.abs(bit.band(2 ^ index, val)) == 2 ^ index
end

function clearFlag(index, val)
    return bit.band(bit.bnot(2 ^ index), val)
end

function len(table)
    local len = 0
    for _ in pairs(table) do
        len = len + 1
    end
    return len
end

function math.max(x, y)
    return x > y and x or y
end

function math.sgn(x)
    return
        x > 0 and 1 or
        x == 0 and 0 or
        -1
end

function joinTables(...)
    local s = {}
    for _, t in ipairs{...} do
        for k, v in pairs(t) do
            assert(s[k] == nil, "key collision in joinTables (key: " .. k .. ")")
            s[k] = v
        end
    end
    return s
end