local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "CoolGui", HidePremium = false, SaveConfig = true, ConfigFolder = "CoolGui"})

local scripts = {
    'CustomCharacter/CustomCharacter.lua',
}

local baseUrl = 'https://raw.githubusercontent.com/Fishka132312/coolgui/refs/heads/main/Things/'

task.spawn(function()
    for i, scriptName in ipairs(scripts) do
        local fullUrl = baseUrl .. scriptName
        
        local success, err = pcall(function()
            local code = game:HttpGet(fullUrl)
            if code then
                loadstring(code)()
            else
                warn("Не удалось получить код для: " .. scriptName)
            end
        end)
        
        if not success then
            warn("Ошибка при загрузке " .. scriptName .. ": " .. tostring(err))
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

-------------------------Custom Skin---------------------------

local Tab = Window:MakeTab({
	Name = "Custom Skin",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Free Skins"
})

local selectedSkin = "None" 

-- 1. Выпадающий список (Dropdown)
local SkinSelector = Tab:AddDropdown({
    Name = "Choose skin",
    Default = "None",
    Options = {"Loading..."},
    Callback = function(Value)
        selectedSkin = Value
        _G.CurrentSkinName = Value
        
        -- Если тумблер уже включен, при смене названия в списке скин сразу меняется
        if _G.IsSkinActive and selectedSkin ~= "None" and selectedSkin ~= "Loading..." and selectedSkin ~= "Ошибка базы" then
            if _G.ApplySkin then
                _G.ApplySkin(selectedSkin)
            end
        end
    end     
})

-- 2. Поток загрузки имен скинов из базы
task.spawn(function()
    local timeout = 0
    -- Ждем, пока основная база (_G.SkinNames) прогрузится
    while (not _G.SkinNames or #_G.SkinNames == 0) and timeout < 10 do
        task.wait(0.5)
        timeout = timeout + 0.5
    end

    if _G.SkinNames and #_G.SkinNames > 0 then
        -- Добавляем "None" в начало списка, чтобы можно было сбросить выбор
        local options = {"None"}
        for _, name in ipairs(_G.SkinNames) do
            table.insert(options, name)
        end
        SkinSelector:Refresh(options, true)
    else
        SkinSelector:Refresh({"Error: No Skins Found"}, true)
    end
end)

-- 3. Переключатель (Toggle)
Tab:AddToggle({
    Name = "Enable Skin Changer",
    Default = false,
    Callback = function(Value)
        _G.IsSkinActive = Value 
        
        if Value then
            -- Проверка: выбран ли скин и не является ли он системной надписью
            if selectedSkin and selectedSkin ~= "None" and selectedSkin ~= "Loading..." and selectedSkin ~= "Error: No Skins Found" then
                if _G.ApplySkin then
                    _G.ApplySkin(selectedSkin)
                end
            else
                -- Если скин не выбран, выключаем тумблер обратно (опционально)
                warn("Скин не выбран!")
                _G.IsSkinActive = false
                -- Здесь можно добавить уведомление в консоль или UI, что нужно выбрать скин
            end
        else
            -- Если выключили — возвращаем оригинал
            if _G.RestoreOriginal then
                _G.RestoreOriginal()
            end
        end
    end    
})

-------------------------My Script---------------------------

local Tab = Window:MakeTab({
	Name = "Game Script",
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
