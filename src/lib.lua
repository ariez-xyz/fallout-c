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
    -- math.abs is needed because for index=30, calling bit.band with values > 2^31
    -- returns -2^31. bit returns *signed* numbers and is limited to 32bits of precision.
    return math.abs(bit.band(2 ^ index, val)) == 2 ^ index
end

function clearFlag(index, val)
    return bit.band(bit.bnot(2 ^ index), val)
end