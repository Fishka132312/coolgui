local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

getgenv().ShaderThreads = getgenv().ShaderThreads or {}

for name, connection in pairs(getgenv().ShaderThreads) do
    if connection then connection:Disconnect() end
end
getgenv().ShaderThreads = {}

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera
local FILE_NAME = "MeowlShaders_Config.json"

local oldGui = PlayerGui:FindFirstChild("MeowlShaders_GUI")
if oldGui then oldGui:Destroy() end

local effectsToRemove = {"UltraCC", "UltraBloom", "UltraSunRays", "UltraAtmo", "SmartDOF"}
for _, name in pairs(effectsToRemove) do
    local oldEffect = Lighting:FindFirstChild(name)
    if oldEffect then oldEffect:Destroy() end
end

local function GetOrCreate(className, name)
    local obj = Lighting:FindFirstChild(name)
    if not obj then
        obj = Instance.new(className)
        obj.Name = name
        obj.Parent = Lighting
    end
    return obj
end

local cc = GetOrCreate("ColorCorrectionEffect", "UltraCC")
local bloom = GetOrCreate("BloomEffect", "UltraBloom")
local sunRays = GetOrCreate("SunRaysEffect", "UltraSunRays")
local atmo = GetOrCreate("Atmosphere", "UltraAtmo")
local dof = GetOrCreate("DepthOfFieldEffect", "SmartDOF")

local function EnsureEffects()
    local needsUpdate = false
    
    if not cc or cc.Parent ~= Lighting then 
        cc = GetOrCreate("ColorCorrectionEffect", "UltraCC") 
        needsUpdate = true 
    end
    if not bloom or bloom.Parent ~= Lighting then 
        bloom = GetOrCreate("BloomEffect", "UltraBloom") 
        needsUpdate = true 
    end
    if not sunRays or sunRays.Parent ~= Lighting then 
        sunRays = GetOrCreate("SunRaysEffect", "UltraSunRays") 
        needsUpdate = true 
    end
    if not atmo or atmo.Parent ~= Lighting then 
        atmo = GetOrCreate("Atmosphere", "UltraAtmo") 
        needsUpdate = true 
    end
    if not dof or dof.Parent ~= Lighting then 
        dof = GetOrCreate("DepthOfFieldEffect", "SmartDOF") 
        needsUpdate = true 
    end

    if needsUpdate then UpdateWorld() end
end

local Config = {
    smartDof = true,
    exposure = 0,
    shadowSoftness = 0.2,
    bloomIntensity = 0.4,
    bloomSize = 24,
    brightness = 0.01,
    contrast = 0.15,
    saturation = 0.15,
    sunRaysIntensity = 0.5,
    atmoDensity = 0.3,
    atmoHaze = 0,
    outdoorAmbient = 70,
    techFuture = true,
    guiMinimized = false,
    UserPresets = {}
}

local Presets = {
    ["Default"] = {smartDof=true, exposure=0, bloomIntensity=0.4, bloomSize=24, brightness=0.01, contrast=0.15, saturation=0.15, sunRaysIntensity=0.5, atmoDensity=0.3, atmoHaze=0, outdoorAmbient=70},
    ["RTX Ultra"] = {smartDof=true, exposure=0.1, bloomIntensity=1.2, bloomSize=48, brightness=0.02, contrast=0.4, saturation=0.3, sunRaysIntensity=0.8, atmoDensity=0.2, atmoHaze=0.5, outdoorAmbient=40},
    ["Cinematic"] = {smartDof=true, exposure=-0.2, bloomIntensity=0.5, bloomSize=12, brightness=-0.05, contrast=0.5, saturation=-0.1, sunRaysIntensity=0.3, atmoDensity=0.4, atmoHaze=1.5, outdoorAmbient=30}
}

local function ApplyPreset(presetData)
    for k, v in pairs(presetData) do
        Config[k] = v
    end
    UpdateWorld()
    SaveConfig()
end

local function SaveConfig()
    if pcall(function() return writefile end) then
        writefile(FILE_NAME, HttpService:JSONEncode(Config))
    end
end

local function LoadConfig()
    if pcall(function() return isfile(FILE_NAME) end) and isfile(FILE_NAME) then
        local success, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(FILE_NAME))
        if success then
            for k, v in pairs(decoded) do Config[k] = v end
        end
    end
end

LoadConfig()

local function UpdateWorld()
    EnsureEffects()
    
    Lighting.ExposureCompensation = Config.exposure
    local amb = math.clamp(Config.outdoorAmbient, 0, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(amb, amb, math.min(amb + 10, 255))
    
    bloom.Intensity = Config.bloomIntensity
    bloom.Size = Config.bloomSize
    cc.Brightness = Config.brightness
    cc.Contrast = Config.contrast
    cc.Saturation = Config.saturation
    sunRays.Intensity = Config.sunRaysIntensity
    atmo.Density = Config.atmoDensity
    atmo.Haze = Config.atmoHaze * 0.5 
    
    dof.Enabled = Config.smartDof
    if dof.Enabled then
        dof.InFocusRadius = 20
        dof.NearIntensity = 0
    end
end

local lastForceUpdate = 0

getgenv().ShaderThreads["UpdateLoop"] = RunService.Heartbeat:Connect(function()
    local now = os.clock()
    
    if now - lastForceUpdate > 0.1 then
        lastForceUpdate = now
        EnsureEffects() 
        UpdateWorld()
    end

    if Config.smartDof then
        local char = Player.Character
        if char and Camera then
            local rayParams = RaycastParams.new()
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            rayParams.FilterDescendantsInstances = {char, Camera}

            local result = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 500, rayParams)
            local dist = result and (Camera.CFrame.Position - result.Position).Magnitude or 500
            
            dof.FocusDistance = dof.FocusDistance + (dist - dof.FocusDistance) * 0.05
            
            local targetFar = (dist > 100) and 0.1 or 0.35
            dof.FarIntensity = dof.FarIntensity + (targetFar - dof.FarIntensity) * 0.05
        end
    else
        dof.Enabled = false
    end
end)

local oldGui = PlayerGui:FindFirstChild("UltraShaders_Ultimate")
if oldGui then
    oldGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MeowlShaders_GUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = Config.guiMinimized and UDim2.new(0, 300, 0, 50) or UDim2.new(0, 300, 0, 520)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)

-- Кнопки управления
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.Text = "×"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -75, 0, 10)
minBtn.Text = Config.guiMinimized and "+" or "−"
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minBtn.TextColor3 = Color3.new(1, 1, 1)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 20
minBtn.Parent = frame
Instance.new("UICorner", minBtn)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 0, 50)
title.Position = UDim2.new(0, 20, 0, 0)
title.Text = "MEOWL SHADERS"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -20, 1, -70)
container.Position = UDim2.new(0, 10, 0, 60)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 1100)
container.ScrollBarThickness = 4
container.Visible = not Config.guiMinimized
container.Parent = frame
Instance.new("UIListLayout", container).Padding = UDim.new(0, 15)

closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
minBtn.MouseButton1Click:Connect(function()
    Config.guiMinimized = not Config.guiMinimized
    SaveConfig()
    if Config.guiMinimized then
        frame:TweenSize(UDim2.new(0, 300, 0, 50), "Out", "Quad", 0.3, true)
        container.Visible = false
        minBtn.Text = "+"
    else
        frame:TweenSize(UDim2.new(0, 300, 0, 520), "Out", "Quad", 0.3, true)
        container.Visible = true
        minBtn.Text = "−"
    end
end)

local function createSlider(name, configKey, min, max)
    local base = Instance.new("Frame")
    base.Size = UDim2.new(1, -10, 0, 60)
    base.BackgroundTransparency = 1
    base.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Text = name .. ": " .. Config[configKey]
    label.TextColor3 = Color3.fromRGB(240, 240, 240)
    label.BackgroundTransparency = 1
    label.TextSize = 16
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = base

    local sliderBack = Instance.new("Frame")
    sliderBack.Size = UDim2.new(1, 0, 0, 10)
    sliderBack.Position = UDim2.new(0, 0, 0, 35)
    sliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    sliderBack.Parent = base
    Instance.new("UICorner", sliderBack)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((Config[configKey] - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    fill.Parent = sliderBack
    Instance.new("UICorner", fill)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = sliderBack

    local function update(input)
        local pos = math.clamp((input.Position.X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
        
        local rawValue = min + (max - min) * pos
        
        local step = (max - min) > 10 and 1 or 0.05
        
        local value = math.floor(rawValue / step + 0.5) * step
        
        value = math.floor(value * 100) / 100

        Config[configKey] = value
        
        local visualPos = (value - min) / (max - min)
        fill.Size = UDim2.new(visualPos, 0, 1, 0)
        
        label.Text = name .. ": " .. value
        UpdateWorld()
        SaveConfig()
    end

    local dragging = false
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true update(input) end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then update(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

local function createToggle(name, configKey)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(40, 180, 100) or Color3.fromRGB(50, 50, 55)
    btn.Text = name .. ": " .. (Config[configKey] and "ON" or "OFF")
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = container
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(40, 180, 100) or Color3.fromRGB(50, 50, 55)
        btn.Text = name .. ": " .. (Config[configKey] and "ВКЛ" or "ВЫКЛ")
        UpdateWorld()
        SaveConfig()
    end)
end

local allMenus = {}

local function createDropdown(name, options, callback, isUserType)
    local base = Instance.new("Frame")
    base.Size = UDim2.new(1, -10, 0, 45)
    base.BackgroundTransparency = 1
    base.Parent = container

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.Text = name .. " >"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = base
    Instance.new("UICorner", btn)

    local menu = Instance.new("ScrollingFrame")
    menu.Visible = false
    menu.ZIndex = 110
    menu.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    menu.BorderSizePixel = 0
    menu.AnchorPoint = Vector2.new(0, 0)
    menu.Position = UDim2.new(0, 0, 1, 5)
    menu.Parent = btn
    menu.ScrollBarThickness = 3
    Instance.new("UICorner", menu)
    
    table.insert(allMenus, menu)

    local layout = Instance.new("UIListLayout", menu)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    local currentOptions = options

    local function refreshOptions(newOptions)
        currentOptions = newOptions
        for _, child in pairs(menu:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        for i, optName in ipairs(newOptions) do
            local itemFrame = Instance.new("Frame")
            itemFrame.Size = UDim2.new(1, 0, 0, 40)
            itemFrame.BackgroundTransparency = 1
            itemFrame.BorderSizePixel = 0
            itemFrame.LayoutOrder = i
            itemFrame.Parent = menu
            
            local optBtn = Instance.new("TextButton")
            optBtn.Size = isUserType and UDim2.new(1, -85, 1, 0) or UDim2.new(1, 0, 1, 0)
            optBtn.BackgroundTransparency = 0.9
            optBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
            optBtn.Text = "  " .. optName
            optBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
            optBtn.Font = Enum.Font.GothamMedium
            optBtn.TextSize = 16
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.ZIndex = 112
            optBtn.Parent = itemFrame
            Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)

            local editBox = Instance.new("TextBox")
            editBox.Size = optBtn.Size
            editBox.Visible = false
            editBox.Text = optName
            editBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            editBox.TextColor3 = Color3.new(1, 1, 1)
            editBox.Font = Enum.Font.GothamMedium
            editBox.TextSize = 16
            editBox.ZIndex = 115
            editBox.Parent = itemFrame
            Instance.new("UICorner", editBox)

            if isUserType then
                local delBtn = Instance.new("TextButton")
                delBtn.Size = UDim2.new(0, 26, 0, 26)
                delBtn.Position = UDim2.new(1, -32, 0.5, -13)
                delBtn.BackgroundTransparency = 1
                delBtn.Text = "🗑️" 
                delBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
                delBtn.TextSize = 14
                delBtn.ZIndex = 113
                delBtn.Parent = itemFrame

                local editBtn = Instance.new("TextButton")
                editBtn.Size = UDim2.new(0, 26, 0, 26)
                editBtn.Position = UDim2.new(1, -62, 0.5, -13)
                editBtn.BackgroundTransparency = 1
                editBtn.Text = "✏️" 
                editBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
                editBtn.TextSize = 14
                editBtn.ZIndex = 113
                editBtn.Parent = itemFrame

                local function addHover(btn, color)
                    btn.MouseEnter:Connect(function()
                        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
                            TextColor3 = color,
                            TextSize = 17
                        }):Play()
                    end)
                    btn.MouseLeave:Connect(function()
                        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
                            TextColor3 = Color3.fromRGB(150, 150, 150),
                            TextSize = 14
                        }):Play()
                    end)
                end

                addHover(delBtn, Color3.fromRGB(255, 80, 80))
                addHover(editBtn, Color3.fromRGB(80, 180, 255))
        
                delBtn.MouseButton1Click:Connect(function()
                    Config.UserPresets[optName] = nil
                    SaveConfig()
                    refreshOptions(getUserPresetNames())
                    menu.Size = UDim2.new(1, 0, 0, math.min(#getUserPresetNames() * 40, 200))
                end)

                editBtn.MouseButton1Click:Connect(function()
                    optBtn.Visible = false
                    editBox.Visible = true
                    editBox:CaptureFocus()
                end)
            

                editBox.FocusLost:Connect(function(enter)
                    if enter and editBox.Text ~= "" and editBox.Text ~= optName then
                        local oldData = Config.UserPresets[optName]
                        Config.UserPresets[editBox.Text] = oldData
                        Config.UserPresets[optName] = nil
                        SaveConfig()
                        refreshOptions(getUserPresetNames())
                    end
                    optBtn.Visible = true
                    editBox.Visible = false
                end)
            end

            optBtn.MouseButton1Click:Connect(function()
                callback(optName)
                menu.Visible = false
                btn.Text = name .. ": " .. optName
            end)
        end
        menu.CanvasSize = UDim2.new(0, 0, 0, #newOptions * 40)
    end

    refreshOptions(options)

    btn.MouseButton1Click:Connect(function()
        local isOpening = not menu.Visible
        
        if isOpening then
            for _, otherMenu in pairs(allMenus) do
                otherMenu.Visible = false
            end
        end
        
        menu.Visible = isOpening
        if menu.Visible then
            menu.Size = UDim2.new(1, 0, 0, math.min(#currentOptions * 40, 200))
        end
    end)

    return refreshOptions 
end


local systemNames = {}
for name, _ in pairs(Presets) do table.insert(systemNames, name) end
createDropdown("Default Presets", systemNames, function(selected)
    ApplyPreset(Presets[selected])
end)

function getUserPresetNames()
    local names = {}
    if Config.UserPresets then
        for name, _ in pairs(Config.UserPresets) do table.insert(names, name) end
    end
    table.sort(names)
    return names
end

local refreshUserDropdown
refreshUserDropdown = createDropdown("User Presets", getUserPresetNames(), function(selected)
    local data = Config.UserPresets[selected]
    if data then
        for k, v in pairs(data) do Config[k] = v end
        UpdateWorld()
    end
end, true)

createToggle("Dynamic Focus", "smartDof")
createToggle("Future Lighting (RTX)", "techFuture")
createSlider("Exposure", "exposure", -2, 2)
createSlider("ShadowSoftness", "shadowSoftness", 0, 1)
createSlider("OutdoorAmbient", "outdoorAmbient", 0, 255)
createSlider("BloomIntensity", "bloomIntensity", 0, 10)
createSlider("BloomSize", "bloomSize", 0, 56)
createSlider("Brightness", "brightness", -0.5, 0.5)
createSlider("Contrast", "contrast", -1, 2)
createSlider("Saturation", "saturation", -1, 2)
createSlider("SunRaysIntensity", "sunRaysIntensity", 0, 1)
createSlider("AtmoDensity", "atmoDensity", 0, 1)
createSlider("AtmoHaze", "atmoHaze", 0, 3)

local saveUserBtn = Instance.new("TextButton")
saveUserBtn.Size = UDim2.new(1, -10, 0, 45)
saveUserBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
saveUserBtn.Text = "SAVE TO USER PRESETS"
saveUserBtn.TextColor3 = Color3.new(1, 1, 1)
saveUserBtn.Font = Enum.Font.GothamBold
saveUserBtn.TextSize = 14
saveUserBtn.Parent = container
Instance.new("UICorner", saveUserBtn)

saveUserBtn.MouseButton1Click:Connect(function()
    local names = getUserPresetNames()
    local newName = "Preset " .. (#names + 1)

    local currentSettings = {}
    for k, v in pairs(Config) do
        if type(v) ~= "table" and type(v) ~= "function" then
            currentSettings[k] = v
        end
    end

    Config.UserPresets[newName] = currentSettings
    SaveConfig()
    
    if refreshUserDropdown then
        refreshUserDropdown(getUserPresetNames())
    end

    saveUserBtn.Text = "✅ " .. newName .. " SAVED!"
    task.wait(1.5)
    saveUserBtn.Text = "СОХРАНИТЬ МОЙ ПРЕСЕТ"
end)

local lastUpdate = 0
UpdateWorld()

getgenv().ShaderThreads["DofLoop"] = RunService.Heartbeat:Connect(function()
    local now = os.clock()
    if now - lastUpdate < 0.05 then return end
    lastUpdate = now

    EnsureEffects()

    if Config.smartDof and dof then
        local char = Player.Character
        if char and Camera then
            local rayParams = RaycastParams.new()
            rayParams.FilterType = Enum.RaycastFilterType.Exclude
            rayParams.FilterDescendantsInstances = {char, Camera}

            local result = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 500, rayParams)
            local dist = result and (Camera.CFrame.Position - result.Position).Magnitude or 500
            
            dof.FocusDistance = dof.FocusDistance + (dist - dof.FocusDistance) * 0.1
            local targetFar = (dist > 100) and 0.15 or 0.4
            dof.FarIntensity = dof.FarIntensity + (targetFar - dof.FarIntensity) * 0.05
            dof.Enabled = true
        end
    else
        if dof then dof.Enabled = false end
    end
end)
