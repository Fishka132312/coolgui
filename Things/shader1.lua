local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local USE_FUTURE_LIGHTING = false 
local FOCUS_UPDATE_RATE = 0.05 

local function ApplyOptimizedShaders()
    Lighting.Technology = USE_FUTURE_LIGHTING and Enum.Technology.Future or Enum.Technology.ShadowMap
    Lighting.GlobalShadows = true
    Lighting.EnvironmentDiffuseScale = 0.5
    Lighting.EnvironmentSpecularScale = 0.5
    
    local bloom = Lighting:FindFirstChild("OptimizedBloom") or Instance.new("BloomEffect", Lighting)
    bloom.Name = "OptimizedBloom"
    bloom.Intensity = 0.3
    bloom.Threshold = 0.9
    
    local cc = Lighting:FindFirstChild("OptimizedCC") or Instance.new("ColorCorrectionEffect", Lighting)
    cc.Name = "OptimizedCC"
    cc.Saturation = 0.15
    cc.Contrast = 0.1
    
    local atmo = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
    atmo.Density = 0.2
end

local dof = Lighting:FindFirstChild("SmartDOF") or Instance.new("DepthOfFieldEffect", Lighting)
dof.Name = "SmartDOF"
dof.FarIntensity = 0.15 
dof.NearIntensity = 0      
dof.InFocusRadius = 50    
dof.FocusDistance = 50

local lastUpdate = 0
RunService.Heartbeat:Connect(function()
    local now = tick()
    if now - lastUpdate < FOCUS_UPDATE_RATE then return end
    lastUpdate = now

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, Camera}

    local result = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 250, raycastParams)
    
    local targetDist = result and (Camera.CFrame.Position - result.Position).Magnitude or 250
    
    dof.FocusDistance = math.lerp(dof.FocusDistance, targetDist, 0.15)
    
    if targetDist > 150 then
        dof.FarIntensity = math.lerp(dof.FarIntensity, 0, 0.1)
    else
        dof.FarIntensity = math.lerp(dof.FarIntensity, 0.15, 0.1)
    end
end)

ApplyOptimizedShaders()