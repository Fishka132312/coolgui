local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Функция для безопасного получения персонажа в любой момент
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

_G.OriginalAppearance = nil
_G.Skins = {
    ["Skin1test"] = {
        Headless = false, -- false, так как мы ставим свою голову
        CustomHead = {
            MeshId = "rbxassetid://129985527653392",
            TextureId = "rbxassetid://140448396622170", -- если текстуры нет, оставь ""
        },
        Korblox = true,
        BodyColors = {
            HeadColor3 = Color3.fromRGB(253, 255, 218),
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
    -- Сохраняем меш головы (SpecialMesh или Mesh)
    if char:FindFirstChild("Head") then
        local m = char.Head:FindFirstChildOfClass("SpecialMesh") or char.Head:FindFirstChild("Mesh")
        if m then _G.OriginalAppearance.HeadMesh = m:Clone() end
    end
end

local function clearCharacter()
    local char = getChar()
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            obj:Destroy()
        end
    end
    -- Чистим голову от старых мешей и лица
    if char:FindFirstChild("Head") then
        for _, hObj in ipairs(char.Head:GetChildren()) do
            if hObj:IsA("SpecialMesh") or hObj:IsA("CharacterMesh") or hObj.Name == "Mesh" then
                hObj:Destroy()
            end
        end
        local face = char.Head:FindFirstChild("face")
        if face then face.Transparency = 1 end -- Прячем стандартное лицо
    end
end

_G.ApplySkin = function(skinName)
    if not skinName or skinName == "None" or skinName == "Загрузка..." or skinName == "" then 
        return 
    end
    
    local data = _G.Skins[skinName]
    if not data then 
        warn("Скин '" .. tostring(skinName) .. "' не найден!")
        return 
    end
    
    local char = getChar()
    _G.SaveOriginal()
    clearCharacter()

    -- Тело
    local bc = Instance.new("BodyColors", char)
    if data.BodyColors then
        for prop, color in pairs(data.BodyColors) do
            pcall(function() bc[prop] = color end)
        end
    end

    -- Одежда
    if data.Shirt then Instance.new("Shirt", char).ShirtTemplate = data.Shirt end
    if data.Pants then Instance.new("Pants", char).PantsTemplate = data.Pants end

    -- ЛОГИКА ГОЛОВЫ
    if char:FindFirstChild("Head") then
        local head = char.Head
        
        if data.Headless then
            local m = Instance.new("SpecialMesh", head)
            m.MeshId = "http://www.roblox.com/asset/?id=134079402"
            m.TextureId = "http://www.roblox.com/asset/?id=133940918"
        elseif data.CustomHead then
            -- Создаем новую голову по твоим параметрам
            local m = Instance.new("SpecialMesh", head)
            m.Name = "Mesh"
            m.MeshId = data.CustomHead.MeshId
            m.TextureId = data.CustomHead.TextureId or ""
            m.Scale = Vector3.new(1, 1, 1)
            m.Offset = Vector3.new(0, 0, 0)
        end
    end

    -- Ноги (Korblox)
    if data.Korblox then
        local mesh = Instance.new("CharacterMesh", char)
        mesh.BodyPart = Enum.BodyPart.RightLeg
        mesh.MeshId = 101851696
    end

    -- Аксессуары
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
        -- Возвращаем родную голову и лицо
        if char:FindFirstChild("Head") then
            if _G.OriginalAppearance.HeadMesh then
                _G.OriginalAppearance.HeadMesh:Clone().Parent = char.Head
            end
            local face = char.Head:FindFirstChild("face")
            if face then face.Transparency = 0 end
        end
    end
end

print("Skin Database Loaded Successfully!")
