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
                ParentPart = "Head",
                C0 = CFrame.new(-0.286330223, 0.0514807701, 0.175481796, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        }
    },
    ["Skin2test"] = {
        Headless = true, -- false, так как мы ставим свою голову
        Korblox = true,
        BodyColors = {
            HeadColor3 = Color3.fromRGB(253, 255, 218),
            TorsoColor3 = Color3.fromRGB(253, 255, 218),
            LeftArmColor3 = Color3.fromRGB(253, 255, 218),
            LeftLegColor3 = Color3.fromRGB(253, 255, 218),
            RightArmColor3 = Color3.fromRGB(253, 255, 218),
            RightLegColor3 = Color3.fromRGB(253, 255, 218),
            
        },
        Shirt = "http://www.roblox.com/asset/?id=9195449962",
        Pants = "http://www.roblox.com/asset/?id=6930028736",
        Accessories = {
            {
                Name = "1",
                MeshId = "rbxassetid://6544038046",
                TextureId = "http://www.roblox.com/asset/?id=6544029865",
                ParentPart = "Torso",
                C0 = CFrame.new(0.00788385514, 0.215940952, 0.00236511254, 1, 0, 0, 0, 0.999996841, -0.00250333641, 0, 0.00250333641, 0.999996841),
                C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "2",
                MeshId = "rbxassetid://6965173581",
                TextureId = "rbxassetid://6965173394",
                ParentPart = "Head",
                C0 = CFrame.new(5.76972961e-05, -0.446971893, 0.000505998731, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "3",
                MeshId = "rbxassetid://8787409279",
                TextureId = "rbxassetid://8787432743",
                ParentPart = "Head",
                C0 = CFrame.new(0.000167846709, -0.456766367, -0.017478941, -0.999848127, 0.000604231202, -0.017436387, 0.000604231202, 0.999999821, 5.2682044e-06, 0.017436387, -5.2682044e-06, -0.999848366),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "4",
                MeshId = "rbxassetid://7004527040",
                TextureId = "rbxassetid://7004539074",
                ParentPart = "Torso",
                C0 = CFrame.new(-0.00132751465, 0.172905982, -0.0212802887, -0.999999762, 0.000604254019, 0, 0.000604254019, 0.999999821, 0, 0, 0, -1),
                C1 = CFrame.new(0, -1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "5",
                MeshId = "rbxassetid://14282065531",
                TextureId = "rbxassetid://14282028098",
                ParentPart = "Head",
                C0 = CFrame.new(-0.0747375414, 0.165453434, -0.0651750565, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "6",
                MeshId = "rbxassetid://11146163759",
                TextureId = "http://www.roblox.com/asset/?id=11146030162",
                ParentPart = "Torso",
                C0 = CFrame.new(0.170048654, -0.257273197, -0.346508145, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0, 0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "11",
                MeshId = "rbxassetid://13947623093",
                TextureId = "rbxassetid://13947691674",
                ParentPart = "Head",
                C0 = CFrame.new(-2.3648141e-05, 0.25254631, 0.0580291748, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "7",
                MeshId = "rbxassetid://7259065617",
                TextureId = "http://www.roblox.com/asset/?id=7104179851",
                ParentPart = "Head",
                C0 = CFrame.new(-0.0430011787, 0.282998562, -0.0699996948, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "8",
                MeshId = "rbxassetid://11610173780",
                TextureId = "rbxassetid://11610173941",
                ParentPart = "Head",
                C0 = CFrame.new(-0.000413894653, -0.147464991, 0.570066512, 1, 0, 0, 0, 0.996039689, -0.0889098421, 0, 0.0889098421, 0.996039689),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "9",
                MeshId = "rbxassetid://10432172130",
                TextureId = "rbxassetid://10431957786",
                ParentPart = "Torso",
                C0 = CFrame.new(-4.89909798e-05, 0.363111854, 0.0185300764, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "10",
                MeshId = "rbxassetid://7805064587",
                TextureId = "http://www.roblox.com/asset/?id=7900022736",
                ParentPart = "Head",
                C0 = CFrame.new(-0.00323867775, 0.193525791, 0.186584473, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
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

_G.IsSkinActive = false -- По умолчанию выключен

_G.SaveOriginal = function()
    if _G.IsSkinActive or _G.OriginalAppearance ~= nil then return end 

    local char = getChar()
    _G.OriginalAppearance = {
        Items = {}, -- Тут будут ID шмоток
        BodyColors = nil,
        Face = nil,
        HeadMesh = nil
    }
    
    -- Сохраняем цвета тела
    local bc = char:FindFirstChildOfClass("BodyColors")
    if bc then
        _G.OriginalAppearance.BodyColors = bc:Clone()
    end

    -- Сохраняем ID одежды и аксессуары
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Shirt") then
            _G.OriginalAppearance.Shirt = obj.ShirtTemplate
        elseif obj:IsA("Pants") then
            _G.OriginalAppearance.Pants = obj.PantsTemplate
        elseif obj:IsA("Accessory") then
            -- Для аксессуаров всё же сохраним клон, но уберем его в спец. хранилище
            local clone = obj:Clone()
            table.insert(_G.OriginalAppearance.Items, clone)
        end
    end

    -- Голова
    if char:FindFirstChild("Head") then
        local m = char.Head:FindFirstChildOfClass("SpecialMesh") or char.Head:FindFirstChild("Mesh")
        if m then _G.OriginalAppearance.HeadMesh = m:Clone() end
        
        local face = char.Head:FindFirstChild("face")
        if face then _G.OriginalAppearance.Face = face.Texture end
    end
end

_G.RestoreOriginal = function()
    local char = getChar()
    _G.IsSkinActive = false 
    
    clearCharacter() 
    
    if _G.OriginalAppearance then
        -- 1. Возвращаем цвета
        if _G.OriginalAppearance.BodyColors then
            _G.OriginalAppearance.BodyColors.Parent = char
        end
        
        -- 2. Возвращаем одежду
        if _G.OriginalAppearance.Shirt then
            local s = Instance.new("Shirt", char)
            s.ShirtTemplate = _G.OriginalAppearance.Shirt
        end
        if _G.OriginalAppearance.Pants then
            local p = Instance.new("Pants", char)
            p.PantsTemplate = _G.OriginalAppearance.Pants
        end

        -- 3. Возвращаем аксессуары
        for _, acc in ipairs(_G.OriginalAppearance.Items) do
            acc.Parent = char
        end
        
        -- 4. Возвращаем лицо и голову
        if char:FindFirstChild("Head") then
            if _G.OriginalAppearance.HeadMesh then
                _G.OriginalAppearance.HeadMesh.Parent = char.Head
            end
            local face = char.Head:FindFirstChild("face")
            if face then
                face.Transparency = 0
                face.Texture = _G.OriginalAppearance.Face or ""
            end
        end
    end
    
    _G.OriginalAppearance = nil 
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
    
    -- 1. Сначала сохраняем оригинал (пока персонаж еще в своей одежде)
    _G.SaveOriginal()
    
    -- 2. Ставим отметку, что кастомный скин активирован
    _G.IsSkinActive = true

    local char = getChar()
    clearCharacter()

    -- Тело (BodyColors)
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
            local m = Instance.new("SpecialMesh", head)
            m.Name = "Mesh"
            m.MeshId = data.CustomHead.MeshId
            m.TextureId = data.CustomHead.TextureId or ""
            m.Scale = Vector3.new(1, 1, 1)
            m.Offset = Vector3.new(0, 0, 0)
        end
    end

    -- Ноги (Korblox) - ИСПРАВЛЕНО: добавлена поддержка цвета тела
    if data.Korblox then
        local mesh = Instance.new("CharacterMesh", char)
        mesh.BodyPart = Enum.BodyPart.RightLeg
        mesh.MeshId = 101851696
        -- Чтобы нога не была просто серой/пустой, используем BaseTextureId = 0
        mesh.BaseTextureId = 0 
    end

    -- Аксессуары
    if data.Accessories then
        local function toCFrame(cfData)
            if not cfData then return CFrame.new() end
            if typeof(cfData) == "CFrame" then return cfData end
            if typeof(cfData) == "table" then return CFrame.new(unpack(cfData)) end
            return cfData
        end

        for _, accData in ipairs(data.Accessories) do
            local acc = Instance.new("Accessory")
            acc.Name = accData.Name
            
            local handle = Instance.new("Part")
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 1, 1)
            handle.CanCollide = false
            handle.Parent = acc
            
            local mesh = Instance.new("SpecialMesh", handle)
            mesh.MeshId = accData.MeshId
            mesh.TextureId = accData.TextureId
            mesh.Scale = accData.Scale or Vector3.new(1, 1, 1)
            
            local targetName = accData.ParentPart or "Head"
            local targetPart = char:FindFirstChild(targetName)
            
            if targetPart then
                local weld = Instance.new("Weld", handle)
                weld.Name = "AccessoryWeld"
                weld.Part0 = handle
                weld.Part1 = targetPart
                
                weld.C0 = toCFrame(accData.C0)
                weld.C1 = toCFrame(accData.C1)
                
                acc.Parent = char
            else
                warn("Ошибка: Часть тела " .. tostring(targetName) .. " не найдена для " .. accData.Name)
            end
        end
    end
end

_G.RestoreOriginal = function()
    local char = getChar()
    _G.IsSkinActive = false 
    
    clearCharacter() 
    
    if _G.OriginalAppearance then
        -- Возвращаем предметы из списка Items
        if _G.OriginalAppearance.Items then
            for _, obj in ipairs(_G.OriginalAppearance.Items) do
                obj:Clone().Parent = char
            end
        end
        
        -- Возвращаем голову и лицо из Data
        if char:FindFirstChild("Head") then
            if _G.OriginalAppearance.Data.HeadMesh then
                _G.OriginalAppearance.Data.HeadMesh:Clone().Parent = char.Head
            end
            
            local face = char.Head:FindFirstChild("face")
            if face then 
                face.Transparency = 0 
                if _G.OriginalAppearance.Data.FaceTexture then
                    face.Texture = _G.OriginalAppearance.Data.FaceTexture
                end
            end
        end
    end
    
    _G.OriginalAppearance = nil 
end

print("Skin Database Loaded Successfully!")
