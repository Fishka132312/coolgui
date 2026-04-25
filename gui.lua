local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "CoolGui", HidePremium = false, SaveConfig = true, ConfigFolder = "CoolGui"})

local scripts = {
    'CustomCharacter/CustomCharacter.lua',
}

local baseUrl = 'https://raw.githubusercontent.com/Fishka132312/coolgui/refs/heads/main/Things/'

task.spawn(function()
    -- Использовал правильное имя таблицы: scripts вместо uniqueScripts
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

local selectedSkin = "None" -- Изначально ничего не выбрано

local SkinSelector = Tab:AddDropdown({
    Name = "Выберите скин",
    Default = "None",
    Options = {"Загрузка..."},
    Callback = function(Value)
        selectedSkin = Value
        -- ИСПРАВЛЕНО: Проверяем _G.IsSkinActive
        if _G.ApplySkin and _G.IsSkinActive and selectedSkin ~= "None" then
            _G.ApplySkin(selectedSkin)
        end
    end     
})

-- Функция ожидания базы данных
task.spawn(function()
    local timeout = 0
    while not _G.SkinNames and timeout < 15 do
        task.wait(0.5)
        timeout = timeout + 0.5
    end

    if _G.SkinNames and #_G.SkinNames > 0 then
        -- Просто обновляем список доступных скинов, НО НЕ выбираем их автоматически
        SkinSelector:Refresh(_G.SkinNames, true)
        print("Список скинов загружен.")
    else
        SkinSelector:Refresh({"Ошибка: База пуста"}, true)
    end
end)

-- Переключатель (Toggle)
Tab:AddToggle({
    Name = "Активировать скин",
    Default = false,
    Callback = function(Value)
        -- Используем ту же переменную, что и в базе данных
        _G.IsSkinActive = Value 
        
        if Value then
            -- Проверяем, выбран ли скин и загружена ли функция
            if selectedSkin and selectedSkin ~= "None" and selectedSkin ~= "Загрузка..." and selectedSkin ~= "" then
                if _G.ApplySkin then
                    _G.ApplySkin(selectedSkin)
                end
            else
                -- Если скин не выбран, выключаем Toggle обратно, чтобы не забагалось
                warn("Скин не выбран! Выберите скин из списка.")
                -- Если твоя библиотека поддерживает программное выключение, можно добавить его тут
                _G.IsSkinActive = false 
            end
        else
            -- Если выключили - возвращаем оригинал
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
