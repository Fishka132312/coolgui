local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local existingGui = PlayerGui:FindFirstChild("AtmosphereModV2")
if existingGui then existingGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AtmosphereModV2"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 360)
frame.Position = UDim2.new(0.05, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true 
frame.ClipsDescendants = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 8)
closeBtn.Text = "×"
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 25, 0, 25)
toggleBtn.Position = UDim2.new(1, -60, 0, 8)
toggleBtn.Text = "−"
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 20
toggleBtn.Parent = frame
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 5)

closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

local isMinimized = false
local fullSize = frame.Size
toggleBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        frame:TweenSize(UDim2.new(0, 240, 0, 40), "Out", "Quad", 0.3, true)
        toggleBtn.Text = "+"
    else
        frame:TweenSize(fullSize, "Out", "Quad", 0.3, true)
        toggleBtn.Text = "−"
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 0, 40)
title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "ATMOSPHERE"
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -20, 1, -60)
container.Position = UDim2.new(0, 10, 0, 50)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 0)
container.ScrollBarThickness = 2
container.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.Parent = container
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

local function applySky(ids)
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    local newSky = Instance.new("Sky")
    newSky.SkyboxBk = "rbxassetid://" .. (ids.Bk or ids.all)
    newSky.SkyboxDn = "rbxassetid://" .. (ids.Dn or ids.all)
    newSky.SkyboxFt = "rbxassetid://" .. (ids.Ft or ids.all)
    newSky.SkyboxLf = "rbxassetid://" .. (ids.Lf or ids.all)
    newSky.SkyboxRt = "rbxassetid://" .. (ids.Rt or ids.all)
    newSky.SkyboxUp = "rbxassetid://" .. (ids.Up or ids.all)
    newSky.Parent = Lighting
end

local function createButton(text, color, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 15
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(1, 0, 0, 35)
inputFrame.BackgroundTransparency = 1
inputFrame.Parent = container

local skyInput = Instance.new("TextBox")
skyInput.Size = UDim2.new(0.65, -5, 1, 0)
skyInput.PlaceholderText = "ID..."
skyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
skyInput.TextColor3 = Color3.new(1, 1, 1)
skyInput.Font = Enum.Font.SourceSans
skyInput.TextSize = 14
skyInput.Parent = inputFrame
Instance.new("UICorner", skyInput)

local applySkyBtn = createButton("Set", Color3.fromRGB(50, 120, 50), inputFrame)
applySkyBtn.Size = UDim2.new(0.35, 0, 1, 0)
applySkyBtn.Position = UDim2.new(0.65, 0, 0, 0)
applySkyBtn.MouseButton1Click:Connect(function()
    if skyInput.Text ~= "" then applySky({all = skyInput.Text}) end
end)

local line = Instance.new("Frame")
line.Size = UDim2.new(1, 0, 0, 1)
line.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
line.BorderSizePixel = 0
line.Parent = container

local dayBtn = createButton("☀️ Day Time", Color3.fromRGB(170, 130, 40), container)
dayBtn.MouseButton1Click:Connect(function() Lighting.ClockTime = 14 end)

local nightBtn = createButton("🌙 Night Time", Color3.fromRGB(50, 50, 90), container)
nightBtn.MouseButton1Click:Connect(function() Lighting.ClockTime = 0 end)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local templateTitle = Instance.new("TextLabel")
templateTitle.Size = UDim2.new(1, 0, 0, 15)
templateTitle.Text = "PRESETS"
templateTitle.TextColor3 = Color3.fromRGB(100, 100, 100)
templateTitle.BackgroundTransparency = 1
templateTitle.Font = Enum.Font.SourceSansBold
templateTitle.TextSize = 12
templateTitle.LayoutOrder = 10
templateTitle.Parent = container

local sky1Btn = createButton("🌌 Space Sky", Color3.fromRGB(70, 45, 110), container)
sky1Btn.LayoutOrder = 11 -- Больше чем у заголовка, значит будет ниже
sky1Btn.MouseButton1Click:Connect(function()
    applySky({Bk="15983968922", Dn="15983966825", Ft="15983965025", Lf="15983967420", Rt="15983966246", Up="15983964246"})
end)

local sky2Btn = createButton("⭐ Starry Night", Color3.fromRGB(45, 60, 110), container)
sky2Btn.LayoutOrder = 12 -- Еще ниже
sky2Btn.MouseButton1Click:Connect(function()
    applySky({Bk="154184972", Dn="154184960", Ft="154185021", Lf="154184943", Rt="154185004", Up="154185031"})
end)

local sky2Btn = createButton("🟥 Scarry Red", Color3.fromRGB(45, 60, 110), container)
sky2Btn.LayoutOrder = 12
sky2Btn.MouseButton1Click:Connect(function()
    applySky({Bk="108929045660200", Dn="78646480540009", Ft="90546017435179", Lf="109838453114563", Rt="94190734796082", Up="126944775797063"})
end)

local sky2Btn = createButton("🎴 Aesthetic", Color3.fromRGB(45, 60, 110), container)
sky2Btn.LayoutOrder = 12
sky2Btn.MouseButton1Click:Connect(function()
    applySky({Bk="81858382098344", Dn="138472117789684", Ft="95687237979398", Lf="84924000207295", Rt="99961685452126", Up="104038404823203"})
end)

local sky2Btn = createButton("🌌 Galaxy Nebula", Color3.fromRGB(45, 60, 110), container)
sky2Btn.LayoutOrder = 12
sky2Btn.MouseButton1Click:Connect(function()
    applySky({Bk="159454299", Dn="159454296", Ft="159454293", Lf="159454286", Rt="159454300", Up="159454288"})
end)
