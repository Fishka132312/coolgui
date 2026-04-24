local Lighting = game:GetService("Lighting")

local function ApplyAdvancedShaders()
    Lighting.Technology = Enum.Technology.Future 
    Lighting.GlobalShadows = true
    Lighting.ShadowSoftness = 0.2
    
    local colorCorrection = Instance.new("ColorCorrectionEffect", Lighting)
    colorCorrection.Brightness = 0.02
    colorCorrection.Contrast = 0.15
    colorCorrection.Saturation = 0.15
    colorCorrection.TintColor = Color3.fromRGB(255, 252, 245)

    local bloom = Instance.new("BloomEffect", Lighting)
    bloom.Intensity = 0.4
    bloom.Size = 24
    bloom.Threshold = 0.9

    local sunRays = Instance.new("SunRaysEffect", Lighting)
    sunRays.Intensity = 0.08
    sunRays.Spread = 0.7

    local dof = Instance.new("DepthOfFieldEffect", Lighting)
    dof.FarIntensity = 0.35
    dof.FocusDistance = 50
    dof.InFocusRadius = 60
    dof.NearIntensity = 0

    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere", Lighting)
    atmosphere.Density = 0.35
    atmosphere.Offset = 0.25
    atmosphere.Color = Color3.fromRGB(190, 190, 190)
    atmosphere.Decay = Color3.fromRGB(100, 115, 125)
    atmosphere.Glare = 0.5
    atmosphere.Haze = 1.5

    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 85)
end

ApplyAdvancedShaders()