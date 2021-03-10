--[[
    Acidity UI Library
]]

local Lib = {};

local Themes = {
    DarkTheme = {
        Background = Color3.fromRGB(45, 45, 45),
        Navigation = Color3.fromRGB(55, 55, 55)
    }
}

function Lib.InitStartup(Config)
    local Title = Config.Title or "nil";
    local Theme = Themes[Config["Theme"]] or "DarkTheme";

    local UIHolder = Instance.new("ScreenGui");
    if syn.crypt then
        math.randomseed(tick());
        local rand = Random.new();
        UIHolder.Name = syn.crypt.random(rand:NextNumber(15, 35));
    else
        UIHolder.Name = "";
    end;
    if syn.protect_gui then
        syn.protect_gui(UIHolder);
    end;
    if gethui then
        UIHolder.Parent = gethui();
    else
        UIHolder.Parent = game:GetService("CoreGui");
    end;
    local UIBackground = Instance.new("Frame");
    UIBackground.Parent = UIHolder;


    local UITitle = Instance.new("TextLabel");
    return UIHolder;
end;

return Lib;
