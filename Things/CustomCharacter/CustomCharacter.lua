local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Функция для безопасного получения персонажа в любой момент
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

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

-- Создаем список имен СРАЗУ
_G.SkinNames = {}
for name, _ in pairs(_G.Skins) do
    table.insert(_G.SkinNames, name)
end

_G.SaveOriginal = function()
    if _G.OriginalAppearance then return end
    local char = getChar()
    _G.OriginalAppearance = {}
    
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            table.insert(_G.OriginalAppearance, obj:Clone())
        end
    end
    if char:FindFirstChild("Head") and char.Head:FindFirstChild("Mesh") then
        _G.OriginalAppearance.HeadMesh = char.Head.Mesh:Clone()
    end
end

local function clearCharacter()
    local char = getChar()
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            obj:Destroy()
        end
    end
end

_G.ApplySkin = function(skinName)
    local data = _G.Skins[skinName]
    if not data then return end
    local char = getChar()
    
    _G.SaveOriginal()
    clearCharacter()

    local bc = Instance.new("BodyColors", char)
    if data.BodyColors then
        for prop, color in pairs(data.BodyColors) do
            pcall(function() bc[prop] = color end)
        end
    end

    if data.Shirt then
        local s = Instance.new("Shirt", char)
        s.ShirtTemplate = data.Shirt
    end
    if data.Pants then
        local p = Instance.new("Pants", char)
        p.PantsTemplate = data.Pants
    end

    if char:FindFirstChild("Head") and char.Head:FindFirstChild("Mesh") then
        if data.Headless then
            char.Head.Mesh.MeshId = "http://www.roblox.com/asset/?id=134079402"
            char.Head.Mesh.TextureId = "http://www.roblox.com/asset/?id=133940918"
        end
    end

    if data.Korblox then
        local mesh = Instance.new("CharacterMesh", char)
        mesh.BodyPart = Enum.BodyPart.RightLeg
        mesh.MeshId = 101851696
    end

    if data.Accessories then
        for _, accData in ipairs(data.Accessories) do
            local acc = Instance.new("Accessory")
            acc.Name = accData.Name
            local handle = Instance.new("Part", acc)
            handle.Name = "Handle"
            handle.Size = Vector3.new(1,1,1)
            handle.CanCollide = false
            
            local mesh = Instance.new("SpecialMesh", handle)
            mesh.MeshId = accData.MeshId
            mesh.TextureId = accData.TextureId
            
            local weld = Instance.new("Weld", handle)
            weld.Name = "AccessoryWeld"
            weld.Part0 = handle
            weld.Part1 = char:FindFirstChild("Head")
            weld.C0 = accData.C0
            weld.C1 = accData.C1
            
            acc.Parent = char
        end
    end
end

_G.RestoreOriginal = function()
    local char = getChar()
    clearCharacter()
    if _G.OriginalAppearance then
        for _, obj in pairs(_G.OriginalAppearance) do
            if typeof(obj) == "Instance" then
                obj:Clone().Parent = char
            end
        end
        if _G.OriginalAppearance.HeadMesh and char:FindFirstChild("Head") then
            if char.Head:FindFirstChild("Mesh") then char.Head.Mesh:Destroy() end
            _G.OriginalAppearance.HeadMesh:Clone().Parent = char.Head
        end
    end
end

print("Skin Database Loaded Successfully!")
