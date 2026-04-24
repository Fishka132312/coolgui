local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Настройки
local FOCUS_UPDATE_RATE = 0.05 

local function ApplyUltraShaders()
    -- --- ШАГ 1: ПОЛНАЯ ЗАЧИСТКА ---
    -- Удаляем всё, что может конфликтовать с новыми шейдерами
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("PostEffect") or child:IsA("Atmosphere") or child:IsA("Clouds") then
            child:Destroy()
        end
    end

    -- --- ШАГ 2: НАСТРОЙКА ОСВЕЩЕНИЯ ---
    Lighting.Technology = Enum.Technology.Future 
    Lighting.GlobalShadows = true
    Lighting.ShadowSoftness = 0.2
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 85)

    -- Цветокоррекция
    local cc = Instance.new("ColorCorrectionEffect", Lighting)
    cc.Name = "UltraCC"
    cc.Brightness = 0.02
    cc.Contrast = 0.15
    cc.Saturation = 0.15
    cc.TintColor = Color3.fromRGB(255, 252, 245)

    -- Блум (свечение)
    local bloom = Instance.new("BloomEffect", Lighting)
    bloom.Name = "UltraBloom"
    bloom.Intensity = 0.4
    bloom.Size = 24
    bloom.Threshold = 0.9

    -- Солнечные лучи
    local sunRays = Instance.new("SunRaysEffect", Lighting)
    sunRays.Name = "UltraSunRays"
    sunRays.Intensity = 0.08
    sunRays.Spread = 0.7

    -- Атмосфера
    local atmo = Instance.new("Atmosphere", Lighting)
    atmo.Density = 0.35
    atmo.Offset = 0.25
    atmo.Color = Color3.fromRGB(190, 190, 190)
    atmo.Decay = Color3.fromRGB(100, 115, 125)
    atmo.Glare = 0.5
    atmo.Haze = 0
    
    -- Глубина резкости (создаем заново после очистки)
    local dof = Instance.new("DepthOfFieldEffect", Lighting)
    dof.Name = "SmartDOF"
    dof.FarIntensity = 0.35
    dof.NearIntensity = 0      
    dof.InFocusRadius = 60    
    dof.FocusDistance = 50
    
    return dof
end

-- Запускаем настройку и получаем ссылку на DOF
local dof = ApplyUltraShaders()

-- --- ШАГ 3: ДИНАМИЧЕСКИЙ ФОКУС ---
local lastUpdate = 0
RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - lastUpdate < FOCUS_UPDATE_RATE then return end
    lastUpdate = now

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local char = game.Players.LocalPlayer.Character
    if char then
        raycastParams.FilterDescendantsInstances = {char, Camera}
    else
        raycastParams.FilterDescendantsInstances = {Camera}
    end

    local result = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 500, raycastParams)
    local targetDist = result and (Camera.CFrame.Position - result.Position).Magnitude or 500
    
    if dof and dof.Parent then
        dof.FocusDistance = math.lerp(dof.FocusDistance, targetDist, 0.15)
        
        if targetDist > 150 then
            dof.FarIntensity = math.lerp(dof.FarIntensity, 0, 0.1)
        else
            dof.FarIntensity = math.lerp(dof.FarIntensity, 0.35, 0.1)
        end
    end
end)
