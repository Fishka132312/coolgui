local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Используем глобальную таблицу _G, чтобы данные были видны в других скриптах
_G.OriginalAppearance = nil
_G.Skins = {
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
    },
    ["GigaChad"] = {
        Headless = false,
        Korblox = false,
        BodyColors = {
            HeadColor3 = Color3.fromRGB(163, 162, 165),
            TorsoColor3 = Color3.fromRGB(163, 162, 165),
        }
    }
}

-- Автоматический список имен для Dropdown
_G.SkinNames = {}
for name, _ in pairs(_G.Skins) do
    table.insert(_G.SkinNames, name)
end

-- Функция сохранения оригинала
_G.SaveOriginal = function()
    if _G.OriginalAppearance then return end
    _G.OriginalAppearance = {}
    
    for _, obj in ipairs(character:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            table.insert(_G.OriginalAppearance, obj:Clone())
        end
    end
    if character:FindFirstChild("Head") and character.Head:FindFirstChild("Mesh") then
        _G.OriginalAppearance.HeadMesh = character.Head.Mesh:Clone()
    end
end

-- Функция очистки
local function clearCharacter()
    for _, obj in ipairs(character:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            obj:Destroy()
        end
    end
end

-- Глобальная функция применения скина
_G.ApplySkin = function(skinName)
    local data = _G.Skins[skinName]
    if not data then return end
    
    _G.SaveOriginal()
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
            
            Instance.new("Vector3Value", handle).Name = "OriginalSize"
            handle.OriginalSize.Value = Vector3.new(1, 1, 1)
            
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

-- Глобальная функция возврата оригинала
_G.RestoreOriginal = function()
    clearCharacter()
    if _G.OriginalAppearance then
        for _, obj in pairs(_G.OriginalAppearance) do
            if typeof(obj) == "Instance" and not obj:IsA("SpecialMesh") then
                obj:Clone().Parent = character
            end
        end
        if _G.OriginalAppearance.HeadMesh and character:FindFirstChild("Head") then
            if character.Head:FindFirstChild("Mesh") then character.Head.Mesh:Destroy() end
            _G.OriginalAppearance.HeadMesh:Clone().Parent = character.Head
        end
    end
end

print("Skin Database Loaded!")
