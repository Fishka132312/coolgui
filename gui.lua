local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "CoolGui", HidePremium = false, SaveConfig = true, ConfigFolder = "CoolGui"})

local scripts = {
    'things/CustomCharacter.lua',
}

local baseUrl = 'https://raw.githubusercontent.com/Fishka132312/coolgui/refs/heads/main/Things/'

task.spawn(function()
    for i, scriptName in ipairs(uniqueScripts) do
        local fullUrl = baseUrl .. scriptName
        
        local success, err = pcall(function()
            local code = game:HttpGet(fullUrl)
            loadstring(code)()
        end)
        
        if not success then
            warn("Ошибка в " .. scriptName .. ": " .. tostring(err))
        end
        
        task.wait(0.7) 
    end
end)

-------------------------Shader---------------------------

local Tab = Window:MakeTab({
	Name = "Shaders",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Shaders"
})

Tab:AddButton({
	Name = "Shaders",
	Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Fishka132312/coolgui/refs/heads/main/Things/shaders.lua'))()  
  	end    
})

Tab:AddButton({
	Name = "Cool Thing",
	Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Fishka132312/coolgui/refs/heads/main/Things/coolthing.lua'))()  
  	end    
})

-------------------------My Script---------------------------

local Tab = Window:MakeTab({
	Name = "My Script",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Supported Games: Petsim99, Evade, BENPCORDIE "
})

Tab:AddButton({
	Name = "MeowlSploit",
	Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Fishka132312/MeowlSploit/refs/heads/main/xJ9v2PzL.lua'))()
  	end    
})

-------------------------Custom Skin---------------------------

local Tab = Window:MakeTab({
	Name = "Custom Skin",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Free Skins"
})

-- Создаем Dropdown с заглушкой, чтобы скрипт не падал
local SkinSelector = Tab:AddDropdown({
    Name = "Выберите скин",
    Default = "None",
    Options = {"Загрузка..."},
    Callback = function(Value)
        selectedSkin = Value
    end    
})

-- Функция, которая будет ждать появления данных и обновит список
task.spawn(function()
    local timeout = 0
    while not _G.SkinNames and timeout < 15 do -- Ждем до 15 секунд
        task.wait(0.5)
        timeout = timeout + 0.5
    end

    if _G.SkinNames then
        -- Обновляем Dropdown списком из базы данных
        SkinSelector:Refresh(_G.SkinNames, true)
        selectedSkin = _G.SkinNames[1]
    else
        SkinSelector:Refresh({"Ошибка загрузки"}, true)
    end
end)

Tab:AddToggle({
    Name = "Активировать скин",
    Default = false,
    Callback = function(Value)
        if Value then
            if _G.ApplySkin and selectedSkin and selectedSkin ~= "None" then
                _G.ApplySkin(selectedSkin)
            end
        else
            if _G.RestoreOriginal then
                _G.RestoreOriginal()
            end
        end
    end    
})
-------------------------Download Any Game---------------------------

local Tab = Window:MakeTab({
	Name = "Download",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "yo"
})

Tab:AddButton({
	Name = "Download current game",
	Callback = function()
    local Params = {
 RepoURL = "https://raw.githubusercontent.com/luau/UniversalSynSaveInstance/main/",
 SSI = "saveinstance",
}
local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
local Options = {}
synsaveinstance(Options)
  	end    
})

--------------------------------MISC-----------------------------

local Tab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Tools"
})

Tab:AddButton({
	Name = "Infinite Yield",
	Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Fishka132312/ignore-it/refs/heads/main/infiniteyield'))()
  	end    
})

Tab:AddButton({
	Name = "Destroy Gui",
	Callback = function()
    OrionLib:Destroy()
    end    
})

OrionLib:Init()
