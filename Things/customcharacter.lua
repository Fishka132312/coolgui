local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local originalAppearance = nil

local skins = {
    ["Skin1test"] = {
        Headless = true,
        Korblox = true,
        BodyColors = {
            HeadColor3 = Color3.fromRGB(253, 255, 218),
            LeftArmColor3 = Color3.fromRGB(253, 255, 218),
            RightArmColor3 = Color3.fromRGB(253, 255, 218),
            LeftLegColor3 = Color3.fromRGB(253, 255, 218),
            RightLegColor3 = Color3.fromRGB(253, 255, 218),
            TorsoColor3 = Color3.fromRGB(253, 255, 218),
        },
        Shirt = "http://www.roblox.com/asset/?id=130279969081496",
        Pants = "http://www.roblox.com/asset/?id=101378827790861",
        Accessories = {
            {
                Name = "CoolHat",
                MeshId = "rbxassetid://79222906659871",
                TextureId = "rbxassetid://140448396622170",
                C0 = CFrame.new(-0.286330223, 0.0514807701, 0.175481796, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        }
    }
}

local function saveOriginal()
    if originalAppearance then return end
    originalAppearance = {}
    
    for _, obj in ipairs(character:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            table.insert(originalAppearance, obj:Clone())
        end
    end
    if character:FindFirstChild("Head") and character.Head:FindFirstChild("Mesh") then
        originalAppearance.HeadMesh = character.Head.Mesh:Clone()
    end
end

local function clearCharacter()
    for _, obj in ipairs(character:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            obj:Destroy()
        end
    end
end

local function applySkin(skinName)
    local data = skins[skinName]
    if not data then return end
    
    saveOriginal()
    clearCharacter()

    local bc = Instance.new("BodyColors", character)
    if data.BodyColors then
        for prop, color in pairs(data.BodyColors) do
            bc[prop] = color
        end
    end

    if data.Shirt then
        local s = Instance.new("Shirt", character)
        s.ShirtTemplate = data.Shirt
    end
    if data.Pants then
        local p = Instance.new("Pants", character)
        p.PantsTemplate = data.Pants
    end

    if character:FindFirstChild("Head") and character.Head:FindFirstChild("Mesh") then
        if data.Headless then
            character.Head.Mesh.MeshId = "http://www.roblox.com/asset/?id=134079402"
            character.Head.Mesh.TextureId = "http://www.roblox.com/asset/?id=133940918"
        end
    end

    if data.Korblox then
        local mesh = Instance.new("CharacterMesh", character)
        mesh.BaseTextureId = 0
        mesh.BodyPart = Enum.BodyPart.RightLeg
        mesh.MeshId = 101851696
        mesh.OverlayTemplate = 101851254
    end

    if data.Accessories then
        for _, accData in ipairs(data.Accessories) do
            local acc = Instance.new("Accessory")
            acc.Name = accData.Name
            
            local handle = Instance.new("Part", acc)
            handle.Name = "Handle"
            
            local mesh = Instance.new("SpecialMesh", handle)
            mesh.MeshId = accData.MeshId
            mesh.TextureId = accData.TextureId
            
            local origSize = Instance.new("Vector3Value", handle)
            origSize.Name = "OriginalSize"
            origSize.Value = Vector3.new(1, 1, 1)
            
            local partScale = Instance.new("StringValue", handle)
            partScale.Name = "AvatarPartScaleType"
            partScale.Value = "Classic"
            
            local weld = Instance.new("Weld", handle)
            weld.Name = "AccessoryWeld"
            weld.Part0 = handle
            weld.Part1 = character:FindFirstChild("Head")
            weld.C0 = accData.C0
            weld.C1 = accData.C1
            
            acc.Parent = character
        end
    end
end

local function restoreOriginal()
    clearCharacter()
    if originalAppearance then
        for _, obj in ipairs(originalAppearance) do
            if not obj:IsA("SpecialMesh") then
                obj:Clone().Parent = character
            end
        end
        if originalAppearance.HeadMesh and character:FindFirstChild("Head") then
            character.Head.Mesh:Destroy()
            originalAppearance.HeadMesh:Clone().Parent = character.Head
        end
    end
end
