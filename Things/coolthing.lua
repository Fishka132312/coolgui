local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AtmosphereMod"
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 250)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- Можно двигать по экрану
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Settings"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

local dayBtn = Instance.new("TextButton")
dayBtn.Size = UDim2.new(0.8, 0, 0, 40)
dayBtn.Position = UDim2.new(0.1, 0, 0.15, 0)
dayBtn.Text = "Set Day"
dayBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 50)
dayBtn.Parent = frame

local nightBtn = Instance.new("TextButton")
nightBtn.Size = UDim2.new(0.8, 0, 0, 40)
nightBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
nightBtn.Text = "Set Night"
nightBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
nightBtn.TextColor3 = Color3.new(1, 1, 1)
nightBtn.Parent = frame

local skyInput = Instance.new("TextBox")
skyInput.Size = UDim2.new(0.8, 0, 0, 40)
skyInput.Position = UDim2.new(0.1, 0, 0.6, 0)
skyInput.PlaceholderText = "Type Sky ID..."
skyInput.Text = ""
skyInput.BackgroundColor3 = Color3.new(1, 1, 1)
skyInput.Parent = frame

local applySkyBtn = Instance.new("TextButton")
applySkyBtn.Size = UDim2.new(0.8, 0, 0, 30)
applySkyBtn.Position = UDim2.new(0.1, 0, 0.8, 0)
applySkyBtn.Text = "Change Sky"
applySkyBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
applySkyBtn.Parent = frame


dayBtn.MouseButton1Click:Connect(function()
	Lighting.ClockTime = 14
end)

nightBtn.MouseButton1Click:Connect(function()
	Lighting.ClockTime = 0
end)

applySkyBtn.MouseButton1Click:Connect(function()
	local assetId = skyInput.Text
	if assetId ~= "" then
		for _, obj in pairs(Lighting:GetChildren()) do
			if obj:IsA("Sky") then
				obj:Destroy()
			end
		end
		
		local newSky = Instance.new("Sky")
		local formattedId = "rbxassetid://" .. assetId
		
		newSky.SkyboxBk = formattedId
		newSky.SkyboxDn = formattedId
		newSky.SkyboxFt = formattedId
		newSky.SkyboxLf = formattedId
		newSky.SkyboxRt = formattedId
		newSky.SkyboxUp = formattedId
		
		newSky.Parent = Lighting
	end
end)