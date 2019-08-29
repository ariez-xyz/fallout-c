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

function printTable(t)
    s = ""
    prefix = ""
    for k, v in pairs(t) do
        s = s .. prefix .. v
        prefix = ","
    end
    print(s)
end