print("cUNC Test - Surplus Softworks")

local cunc_score,cunc_tests = 0,0
local stopcode,stopsuc = nil,nil
local logs = {nil}
local rprint = print
local print = function(...)
    logs[#logs+1]=...
end

local function printstopcode(name)
    if stopsuc then
        print("✅ "..name..": "..stopcode)
    else
        print("⛔ "..name..": "..stopcode)
    end
end
local function checkvar(var, name)
    if var then
        stopcode,stopsuc = (name.." is in the enviorment"),true
        cunc_score += 1
    else
        stopcode,stopsuc = (name.." is not in the enviorment!"),false
    end
    printstopcode(name)
    cunc_tests += 1
end

if request then
    local suc,err = pcall(function()
        local response = request{Method="GET", Url="https://raw.githubusercontent.com/ThisAintComputin/CoreUnifiedNamingConvension/refs/heads/main/tests/urltester"}
        if response.body then
            if response.body == "true\n" then
                return true
            else
                error("Unexpected response, could be a dummy request to spoof UNC")
            end
        else
            error("Request returned invalid response: No response body")
        end
    end)
    if suc then
        stopcode,stopsuc = ("request passed the test"),true
        cunc_score += 1
    else
        stopcode,stopsuc = err,false
    end
    printstopcode("request")
else
    checkvar(request, "request")
end
cunc_tests += 1

if http_request then
    local suc,err = pcall(function()
        local response = http_request{Method="GET", Url="https://raw.githubusercontent.com/ThisAintComputin/CoreUnifiedNamingConvension/refs/heads/main/tests/urltester"}
        if response.body then
            if response.body == "true\n" then
                return true
            else
                error("Unexpected response, could be a dummy request to spoof UNC")
            end
        else
            error("Request returned invalid response: No response body")
        end
    end)
    if suc then
        stopcode,stopsuc = ("http_request passed the test"),true
        cunc_score += 1
    else
        stopcode,stopsuc = err,false
    end
    printstopcode("http_request")
else
    checkvar(http_request, "http_request")
end
cunc_tests += 1

if http.request then
    local suc,err = pcall(function()
        local response = http.request{Method="GET", Url="https://raw.githubusercontent.com/ThisAintComputin/CoreUnifiedNamingConvension/refs/heads/main/tests/urltester"}
        if response.body then
            if response.body == "true\n" then
                return true
            else
                error("Unexpected response, could be a dummy request to spoof UNC")
            end
        else
            error("Request returned invalid response: No response body")
        end
    end)
    if suc then
        stopcode,stopsuc = ("http.request passed the test"),true
        cunc_score += 1
    else
        stopcode,stopsuc = err,false
    end
    printstopcode("http.request")
else
    checkvar(http.request, "http.request")
end
cunc_tests += 1

if syn then
    if syn.request then
        local suc,err = pcall(function()
            local response = syn.request{Method="GET", Url="https://raw.githubusercontent.com/ThisAintComputin/CoreUnifiedNamingConvension/refs/heads/main/tests/urltester"}
            if response.body then
                if response.body == "true\n" then
                    return true
                else
                    error("Unexpected response, could be a dummy request to spoof UNC")
                end
            else
                error("Request returned invalid response: No response body")
            end
        end)
        if suc then
            stopcode,stopsuc = ("syn.request passed the test"),true
            cunc_score += 1
        else
            stopcode,stopsuc = err,false
        end
        printstopcode("syn.request")
    else
        checkvar(syn.request, "syn.request")
    end
else
    checkvar(syn, "syn.request")
end
cunc_tests += 1

local httpget_compatible = false
if game.HttpGet then
    local suc,err = pcall(function()
        local response = game:HttpGet("https://raw.githubusercontent.com/ThisAintComputin/CoreUnifiedNamingConvension/refs/heads/main/tests/urltester")
        if response then
            if response == "true\n" then
                httpget_compatible = true
                return true
            else
                error("Unexpected response, could be a dummy request to spoof UNC")
            end
        else
            error("game.HttpGet returned invalid response: No response body")
        end
    end)
    if suc then
        stopcode,stopsuc = ("game.HttpGet passed the test"),true
        cunc_score += 1
    else
        stopcode,stopsuc = err,false
    end
    printstopcode("game.HttpGet")
else
    checkvar(game.HttpGet, "game.HttpGet")
end
cunc_tests += 1

if hookfunction then
    local funca,funcb = function() return false end, function() return true end;
    hookfunction(funca, funcb)
    if funca() then
        stopcode,stopsuc = ("hookfunction passed the test"),true
        cunc_score += 1
    else
        stopcode,stopsuc = "'Hooked' function return false when should return true after hooked",false
    end
    printstopcode("hookfunction")
else
    checkvar(hookfunction, "hookfunction")
end
cunc_tests += 1

local loadstring_compatible = false
if loadstring then
    if loadstring("return print")() == print then
        stopcode,stopsuc = ("loadstring passed the test"),true
        loadstring_compatible = true
        cunc_score += 1
    else
        stopcode,stopsuc = ("Interesting"),false
    end
    printstopcode("loadstring")
else
    checkvar(loadstring, "loadstring")
end
cunc_tests += 1

if loadstring_compatible and httpget_compatible then
    local suc,err = pcall(function()
        if loadstring(game:HttpGet("https://raw.githubusercontent.com/ThisAintComputin/CoreUnifiedNamingConvension/refs/heads/main/tests/simpleloadstring"))() then
            stopcode,stopsuc = ("passed basic loadstring test"),true
            cunc_score += 1
        else
            stopcode,stopsuc = ("failed basic loadstring test"),false
        end
    end)
    if not suc then
        stopcode,stopsuc = err,false
    end
    printstopcode("loadstring basic")
else
    checkvar(loadstring,"loadstring basic")
end
cunc_tests += 1

if loadstring_compatible and httpget_compatible then
    local suc,err = pcall(function()
        if loadstring(game:HttpGet("https://raw.githubusercontent.com/ThisAintComputin/CoreUnifiedNamingConvension/refs/heads/main/tests/mediumloadstring"))() then
            stopcode,stopsuc = ("passed medium loadstring test"),true
            cunc_score += 1
        else
            stopcode,stopsuc = ("failed medium loadstring test"),false
        end
    end)
    if not suc then
        stopcode,stopsuc = err,false
    end
    printstopcode("loadstring medium")
else
    checkvar(loadstring,"loadstring medium")
end
cunc_tests += 1

local newcclosure_compatible = false
if newcclosure then
    local suc,err = pcall(function()
        if newcclosure(function() return true end)() then
            stopcode,stopsuc = ("passed newcclosure test"),true
            newcclosure_compatible = true
            cunc_score += 1
        else
            stopcode,stopsuc = ("failed newcclosure test"),false
        end
    end)
    if not suc then
        stopcode,stopsuc = err,false
    end
    printstopcode("newcclosure")
else
    checkvar(newcclosure,"newcclosure")
end
cunc_tests += 1

for i=1,#logs do
    rprint(logs[i])
    task.wait(0.05)
end
local cunc_percent = (cunc_score/cunc_tests)*100
if cunc_percent<50 then
    rprint("Interesting")
end
rprint((function() if cunc_percent > 50 then return "✅" else return "⛔" end end)(), identifyexecutor(), "passed with a",tostring(math.floor(cunc_percent)).."%","cUNC score. ("..tostring(cunc_score).."/"..tostring(cunc_tests),"tests)")
