local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Настройки
local FOCUS_UPDATE_RATE = 0.05 
local RAY_DISTANCE = 500

-- Функция плавного перехода (Lerp)
local function lerp(a, b, t)
    return a + (b - a) * t
end

local function ApplyUltraShaders()
    -- --- ШАГ 1: УМНАЯ ОЧИСТКА ---
    -- Удаляем только те эффекты, которые мы сами создали ранее (по имени)
    local namesToClear = {"UltraCC", "UltraBloom", "UltraSunRays", "UltraAtmo", "SmartDOF"}
    for _, name in ipairs(namesToClear) do
        local old = Lighting:FindFirstChild(name)
        if old then old:Destroy() end
    end

    -- --- ШАГ 2: НАСТРОЙКА ОСВЕЩЕНИЯ ---
    Lighting.Technology = Enum.Technology.Future 
    Lighting.GlobalShadows = true
    Lighting.ShadowSoftness = 0.2
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 85)

    -- Цветокоррекция
    local cc = Instance.new("ColorCorrectionEffect")
    cc.Name = "UltraCC"
    cc.Brightness = 0.02
    cc.Contrast = 0.15
    cc.Saturation = 0.15
    cc.TintColor = Color3.fromRGB(255, 252, 245)
    cc.Parent = Lighting

    -- Блум
    local bloom = Instance.new("BloomEffect")
    bloom.Name = "UltraBloom"
    bloom.Intensity = 0.4
    bloom.Size = 24
    bloom.Threshold = 0.9
    bloom.Parent = Lighting

    -- Солнечные лучи
    local sunRays = Instance.new("SunRaysEffect")
    sunRays.Name = "UltraSunRays"
    sunRays.Intensity = 0.08
    sunRays.Spread = 0.7
    sunRays.Parent = Lighting

    -- Атмосфера
    local atmo = Instance.new("Atmosphere")
    atmo.Name = "UltraAtmo"
    atmo.Density = 0.35
    atmo.Offset = 0.25
    atmo.Color = Color3.fromRGB(190, 190, 190)
    atmo.Decay = Color3.fromRGB(100, 115, 125)
    atmo.Glare = 0.5
    atmo.Haze = 0
    atmo.Parent = Lighting
    
    -- Глубина резкости
    local dof = Instance.new("DepthOfFieldEffect")
    dof.Name = "SmartDOF"
    dof.FarIntensity = 0.35
    dof.NearIntensity = 0      
    dof.InFocusRadius = 60    
    dof.FocusDistance = 50
    dof.Parent = Lighting
    
    return dof
end

-- Инициализация
local dof = ApplyUltraShaders()
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude

-- --- ШАГ 3: ДИНАМИЧЕСКИЙ ФОКУС ---
local lastUpdate = 0

RunService.Heartbeat:Connect(function()
    local now = os.clock()
    if now - lastUpdate < FOCUS_UPDATE_RATE then return end
    lastUpdate = now

    -- Проверяем камеру и персонажа
    if not Camera then Camera = workspace.CurrentCamera end
    local char = player.Character
    if not char then return end

    -- Обновляем фильтр луча
    raycastParams.FilterDescendantsInstances = {char, Camera}

    -- Рейкаст
    local rayOrigin = Camera.CFrame.Position
    local rayDirection = Camera.CFrame.LookVector * RAY_DISTANCE
    local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    local targetDist = result and (rayOrigin - result.Position).Magnitude or RAY_DISTANCE
    
    if dof and dof.Parent then
        -- Используем нашу функцию lerp для плавности
        dof.FocusDistance = lerp(dof.FocusDistance, targetDist, 0.15)
        
        if targetDist > 150 then
            dof.FarIntensity = lerp(dof.FarIntensity, 0, 0.1)
        else
            dof.FarIntensity = lerp(dof.FarIntensity, 0.35, 0.1)
        end
    end
end)
