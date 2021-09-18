-- <3 for fate for Locals
_G.prefix = "/"
--SCRIPT HERE
--Locals
local GetService = game.GetService
local Players = GetService(game, "Players")
local LocalPlayer = Players.LocalPlayer
local IsA = game.IsA
local Connection = game.Loaded
local CWait = Connection.Wait
local InstanceNew = Instance.new
local Destroy, Clone = game.Destroy, game.Clone
local GetPlayers = Players.GetPlayers
local Args = {...}

--Service Locals
local Services = {
    Workspace = GetService(game, "Workspace");
    UserInputService = GetService(game, "UserInputService");
    ReplicatedStorage = GetService(game, "ReplicatedStorage");
    StarterPlayer = GetService(game, "StarterPlayer");
    StarterPack = GetService(game, "StarterPack");
    StarterGui = GetService(game, "StarterGui");
    TeleportService = GetService(game, "TeleportService");
    CoreGui = GetService(game, "CoreGui");
    TweenService = GetService(game, "TweenService");
    HttpService = GetService(game, "HttpService");
    TextService = GetService(game, "TextService");
    MarketplaceService = GetService(game, "MarketplaceService");
    Chat = GetService(game, "Chat");
    Teams = GetService(game, "Teams");
    SoundService = GetService(game, "SoundService");
    Lighting = GetService(game, "Lighting");
    ScriptContext = GetService(game, "ScriptContext");
    Stats = GetService(game, "Stats");
    Players = GetService(game, "Players");
}
local JSONEncode, JSONDecode, GenerateGUID = 
    Services.HttpService.JSONEncode, 
    Services.HttpService.JSONDecode,
    Services.HttpService.GenerateGUID

    local filter = function(tbl, ret)
        if (type(tbl) == 'table') then
            local new = {}
            for i, v in next, tbl do
                if (ret(i, v)) then
                    new[#new + 1] = v
                end
            end
            return new
        end
    end

    local random, floor, round, abs, atan, cos, sin, rad;
    do
        local math = math
        random, floor, round, abs, atan, cos, sin, rad = 
            math.random,
            math.floor,
            math.round,
            math.abs,
            math.atan,
            math.cos,
            math.sin,
            math.rad
    end

        local lower, Sfind, split, sub, format, len, match, gmatch, gsub, byte;
        do
            local string = string
            lower, Sfind, split, sub, format, len, match, gmatch, gsub, byte = 
                string.lower,
                string.find,
                string.split, 
                string.sub,
                string.format,
                string.len,
                string.match,
                string.gmatch,
                string.gsub,
                string.byte
        end

local Tfind, sort, concat, pack, unpack = 
    table.find, 
    table.sort,
    table.concat,
    table.pack,
    table.unpack
    local Hooks = {
        AntiKick = false,
        AntiTeleport = false,
        NoJumpCooldown = false,
        UndetectedMessageOut = true
    }
    local map = function(tbl, ret)
        if (type(tbl) == 'table') then
            local new = {}
            for i, v in next, tbl do
                local Value, Key = ret(i, v);
                new[Key or #new + 1] = Value
            end
            return new
        end
    end
    
local ProtectInstance, SpoofInstance, SpoofProperty;
local UnSpoofInstance;
local ProtectedInstances = setmetatable({}, {
    mode = "v"
});
do
    local SpoofedInstances = setmetatable({}, {
        mode = "v"
    });
    local SpoofedProperties = setmetatable({}, {
        mode = "v"
    });
    Hooks.SpoofedProperties = SpoofedProperties

    ProtectInstance = function(Instance_, disallow)
        if (not Tfind(ProtectedInstances, Instance_)) then
            ProtectedInstances[#ProtectedInstances + 1] = Instance_
            if (syn and syn.protect_gui and not disallow) then
                syn.protect_gui(Instance_);
            end
        end
    end
    
    SpoofInstance = function(Instance_, Instance2)
        if (not SpoofedInstances[Instance_]) then
            SpoofedInstances[Instance_] = Instance2 and Instance2 or Clone(Instance_);
        end
    end

    UnSpoofInstance = function(Instance_)
        if (SpoofedInstances[Instance_]) then
            SpoofedInstances[Instance_] = nil
        end
    end
    
    SpoofProperty = function(Instance_, Property, NoClone)
        if (SpoofedProperties[Instance_]) then
            local SpoofedPropertiesForInstance = SpoofedProperties[Instance_]
            local Properties = map(SpoofedPropertiesForInstance, function(i, v)
                return v.Property
            end)
            if (not Tfind(Properties, Property)) then
                SpoofedProperties[Instance_][#SpoofedPropertiesForInstance + 1] = {
                    SpoofedProperty = SpoofedPropertiesForInstance.SpoofedProperty,
                    Property = Property,
                };
            end
        else
            local Cloned;
            if (not NoClone and IsA(Instance_, "Instance") and not Services[tostring(Instance_)] and Instance_.Archivable) then
                local Success, Ret = pcall(Clone, Instance_);
                if (Success) then
                    Cloned = Ret
                end
            end
            SpoofedProperties[Instance_] = {{
                SpoofedProperty = Cloned and Cloned or {[Property]=Instance_[Property]},
                Property = Property,
            }}
        end
    end

    local Methods = {
        "FindFirstChild",
        "FindFirstChildWhichIsA",
        "FindFirstChildOfClass",
        "IsA"
    }
end

local GetCharacter = GetCharacter or function(Plr)
    return Plr and Plr.Character or LocalPlayer.Character
end

local FindFirstChild, FindFirstChildOfClass, FindFirstChildWhichIsA, WaitForChild = 
    game.FindFirstChild,
    game.FindFirstChildOfClass,
    game.FindFirstChildWhichIsA,
    game.WaitForChild

    local GetHumanoid = function(Plr, Char)
        local LCharacter = GetCharacter();
        local Character = Char or GetCharacter(Plr);
        return Plr and Character and FindFirstChildWhichIsA(Character, "Humanoid") or LCharacter and FindFirstChildWhichIsA(LCharacter, "Humanoid");
    end

    

local GetRoot = function(Plr, Char)
    local LCharacter = GetCharacter();
    local Character = Char or GetCharacter(Plr);
    return Plr and Character and (FindFirstChild(Character, "HumanoidRootPart") or FindFirstChild(Character, "Torso") or FindFirstChild(Character, "UpperTorso")) or LCharacter and (FindFirstChild(LCharacter, "HumanoidRootPart") or FindFirstChild(LCharacter, "Torso") or FindFirstChild(LCharacter, "UpperTorso"));
end



--OldPos Local--
local OldPos = GetRoot().CFrame

local ReplaceHumanoid = function(Hum, R)
    local Humanoid = Hum or GetHumanoid();
    local NewHumanoid = Clone(Humanoid);
    if (R) then
        NewHumanoid.Name = "1"
    end
    NewHumanoid.Parent = Humanoid.Parent
    NewHumanoid.Name = Humanoid.Name
    Services.Workspace.Camera.CameraSubject = NewHumanoid
    Destroy(Humanoid);
    SpoofInstance(NewHumanoid);
    return NewHumanoid
end

local ReplaceCharacter = function()
    local Char = LocalPlayer.Character
    local Model = InstanceNew("Model");
    LocalPlayer.Character = Model
    LocalPlayer.Character = Char
    Destroy(Model);
    return Char
end


--[Commands Start Here]--

LocalPlayer.Chatted:connect(function(cmd) 
    if cmd:match(_G.prefix.."reset") then
local OldPos = GetRoot().CFrame
local Char = GetCharacter();
Char.BreakJoints(Char);
CWait(LocalPlayer.CharacterAdded);
WaitForChild(LocalPlayer.Character, "HumanoidRootPart").CFrame = OldPos
    end
end)

LocalPlayer.Chatted:connect(function(cmd) 
if cmd:match(_G.prefix.."refresh") then
ReplaceCharacter();
wait(Players.RespawnTime - 0.03);
local OldPos = GetRoot().CFrame
ReplaceHumanoid()
CWait(LocalPlayer.CharacterAdded)
WaitForChild(LocalPlayer.Character, "HumanoidRootPart").CFrame = OldPos
    end
end)

LocalPlayer.Chatted:connect(function(cmd) 
    if cmd:match(_G.prefix.."rejoin") then
    local TeleportService = Services.TeleportService
    if (#GetPlayers(Players) == 1) then
        TeleportService.Teleport(TeleportService, game.PlaceId);
    else
        TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, game.JobId)
    end
end
end)

LocalPlayer.Chatted:connect(function(cmd) 
    if cmd:match(_G.prefix.."serverhop") then
local TeleportService = Services.TeleportService
local Servers = JSONDecode(Services.HttpService, game.HttpGetAsync(game, format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100", game.PlaceId))).data
if (#Servers > 1) then
    Servers = filter(Servers, function(i,v)
        return v.playing ~= v.maxPlayers and v.id ~= game.JobId
    end)
    local Server
    local Option = Args[1] or ""
    if (lower(Option) == "min") then
        Server = Servers[#Servers]
    elseif (lower(Option) == "max") then
        Server = Servers[1]
    else
        Server = Servers[random(1, #Servers)]
    end
    local queue_on_teleport = syn and syn.queue_on_teleport or queue_on_teleport
    if (queue_on_teleport) then
        queue_on_teleport("loadstring(game.HttpGet(game, \"https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua\"))()");
    end
    TeleportService.TeleportToPlaceInstance(TeleportService, game.PlaceId, Server.id);
    return format("joining server (%d/%d players)", Server.playing, Server.maxPlayers);
else
end
end
end)
