local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

_G.OriginalAppearance = nil
_G.Skins = {
    ["Cool Black Eboy"] = {
        Headless = true,
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
            }
        }
    },
    ["Rich Black/White eboy"] = {
        Headless = false,
        Korblox = false,
        CustomHead = {
            MeshId = "rbxassetid://94343742178760",
            TextureId = "rbxassetid://119330915745370",
        },
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
                MeshId = "rbxassetid://14540578692",
                TextureId = "rbxassetid://14540576906",
                ParentPart = "Head",
                C0 = CFrame.new(0.0174255371, 0.216400146, -0.0615539551, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "2",
                MeshId = "rbxassetid://139340584178768",
                TextureId = "rbxassetid://129480931135684",
                ParentPart = "Torso",
                C0 = CFrame.new(0.018773092, -0.200564086, 0.500219405, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                C1 = CFrame.new(0, 0, -0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "3",
                MeshId = "rbxassetid://118959861022187",
                TextureId = "rbxassetid://83546633555844",
                ParentPart = "Torso",
                C0 = CFrame.new(0.061958313, 0.0527453423, 0.71781826, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "4",
                MeshId = "rbxassetid://14390081008",
                TextureId = "rbxassetid://14389890877",
                ParentPart = "Head",
                C0 = CFrame.new(-2.47077111e-07, 0.319997787, 0.0249103606, -1, 0, 0, 0, 1, 0, 0, 0, -1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "5",
                MeshId = "rbxassetid://13812255514",
                TextureId = "rbxassetid://13812064017",
                ParentPart = "Head",
                C0 = CFrame.new(0.0282440186, 0.48028326, -0.13414669, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            {
                Name = "6",
                MeshId = "http://www.roblox.com/asset/?id=1365696",
                TextureId = "http://www.roblox.com/asset/?id=124896442",
                ParentPart = "Head",
                C0 = CFrame.new(8.65838956e-09, -0.243375838, -0.265762806, 1, -0, 0, 0, 0.966936111, 0.2550188, -0, -0.2550188, 0.966936111),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            }
        }
    },
    ["Cool Rich Girl"] = {
        Headless = false,
        Korblox = false,
        CustomHead = {
            MeshId = "rbxassetid://115355460861394",
            TextureId = "rbxassetid://76689256681394",
        },
        R6BodyMeshes = {
            ["LeftArm"] = { MeshId = 83001137 },
            ["RightArm"] = { MeshId = 83001181 },
            ["LeftLeg"] = { MeshId = 81487640 },
            ["RightLeg"] = { MeshId = 81487710 },
            ["Torso"] = { MeshId = 82987757 },
        },
        R15BodyMeshes = {
        ["UpperTorso"]     = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997174058" },
        ["LowerTorso"]     = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997174057" },
        ["LeftUpperArm"]   = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997174089" },
        ["LeftLowerArm"]   = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997174056" },
        ["LeftHand"]       = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997173998" },
        ["RightUpperArm"]  = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997173999" },
        ["RightLowerArm"]  = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997173930" },
        ["RightHand"]      = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997173932" },
        ["LeftUpperLeg"]   = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997173925" },
        ["LeftLowerLeg"]   = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997173927" },
        ["LeftFoot"]       = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997173950" },
        ["RightUpperLeg"]  = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997174087" },
        ["RightLowerLeg"]  = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997174053" },
        ["RightFoot"]      = { MeshId = "https://assetdelivery.roblox.com/v1/asset/?id=8997174055" },
    },
        BodyColors = {
            HeadColor3 = Color3.fromRGB(204, 142, 105),
            TorsoColor3 = Color3.fromRGB(204, 142, 105),
            LeftArmColor3 = Color3.fromRGB(204, 142, 105),
            LeftLegColor3 = Color3.fromRGB(204, 142, 105),
            RightArmColor3 = Color3.fromRGB(204, 142, 105),
            RightLegColor3 = Color3.fromRGB(204, 142, 105),
        },
        Shirt = "http://www.roblox.com/asset/?id=6472288557",
        Pants = "http://www.roblox.com/asset/?id=6066432764",
        Accessories = {
            {
                Name = "chicBowPursePink",
                MeshId = "rbxassetid://6843422307",
                TextureId = "rbxassetid://6843422345",
                ParentPart = "Torso",
                C0 = CFrame.new(0.387207031, 0.0957374573, -0.765258789, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                C1 = CFrame.new(0, 0, -0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            },
            {
                Name = "NewSideBangsCaramelAccessory",
                MeshId = "rbxassetid://5945976587",
                TextureId = "rbxassetid://6322812499",
                ParentPart = "Head",
                C0 = CFrame.new(-0.00221633911, -0.166851044, -0.286561489, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0, -0.600000024, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            },
            {
                Name = "BandageAccessory",
                MeshId = "rbxassetid://5699721463",
                TextureId = "http://www.roblox.com/asset/?id=5699711147",
                ParentPart = "Head",
                C0 = CFrame.new(-0.000275611877, -0.0262117386, 0.597229004, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            },
            {
                Name = "BubblyPigtails",
                MeshId = "rbxassetid://6633403700",
                TextureId = "rbxassetid://6632272463",
                ParentPart = "Head",
                C0 = CFrame.new(-4.4408921e-16, 1.22000003, -0.130999997, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            },
            {
                Name = "FluffyEarringsAccessory",
                MeshId = "rbxassetid://4632062805",
                TextureId = "rbxassetid://4632070627",
                ParentPart = "Head",
                C0 = CFrame.new(0, 0.900715947, -0.00371140987, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            },
            {
                Name = "PinkBaddieSunniesAccessory",
                MeshId = "rbxassetid://5582632117",
                TextureId = "http://www.roblox.com/asset/?id=5582639653",
                ParentPart = "Head",
                C0 = CFrame.new(0.00819158554, -0.0284600258, 0.298658371, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 0.600000024, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            },
            {
                Name = "PearlArmbandAccessory",
                MeshId = "rbxassetid://6714866689",
                TextureId = "http://www.roblox.com/asset/?id=6714855730",
                ParentPart = "Left Arm",
                C0 = CFrame.new(0.0630722046, 0.448396206, -0.0439186096, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            },
            {
                Name = "WomansPearl",
                MeshId = "rbxassetid://6471990108",
                TextureId = "http://www.roblox.com/asset/?id=6471995247",
                ParentPart = "Torso",
                C0 = CFrame.new(0.000244140625, 0.252067804, 0.156005859, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                C1 = CFrame.new(0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            }
        }
    }
}

_G.SkinNames = {}
for name, _ in pairs(_G.Skins) do
    table.insert(_G.SkinNames, name)
end

_G.IsSkinActive = false

_G.SaveOriginal = function()
    if _G.OriginalAppearance ~= nil then return end 

    local char = getChar()
    
    if not char:FindFirstChild("AppearanceRoot") and not char:FindFirstChildOfClass("Accessory") then
        task.wait(1) 
    end

    _G.OriginalAppearance = {
        Items = {}, 
        BodyColors = nil,
        Face = nil,
        HeadMesh = nil,
        Shirt = nil,
        Pants = nil
    }
    
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") then
            local clone = obj:Clone()
            if clone then
                clone.Parent = nil 
                table.insert(_G.OriginalAppearance.Items, clone)
            end
        elseif obj:IsA("Shirt") then
            _G.OriginalAppearance.Shirt = obj.ShirtTemplate
        elseif obj:IsA("Pants") then
            _G.OriginalAppearance.Pants = obj.PantsTemplate
        elseif obj:IsA("BodyColors") then
            _G.OriginalAppearance.BodyColors = obj:Clone()
        end
    end

    local head = char:FindFirstChild("Head")
    if head then
        local face = head:FindFirstChild("face")
        if face then _G.OriginalAppearance.Face = face.Texture end
        
        local mesh = head:FindFirstChildOfClass("SpecialMesh") or head:FindFirstChild("Mesh")
        if mesh then
            local mClone = mesh:Clone()
            mClone.Parent = nil
            _G.OriginalAppearance.HeadMesh = mClone
        end
    end
    
    print("--- СКИН СОХРАНЕН: " .. #_G.OriginalAppearance.Items .. " аксессуаров ---")
end

local function clearCharacter()
    local char = getChar()
    for _, obj in ipairs(char:GetChildren()) do
        if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
            obj:Destroy()
        end
    end
    
    if char:FindFirstChild("Head") then
        for _, hObj in ipairs(char.Head:GetChildren()) do
            if hObj:IsA("SpecialMesh") or hObj.Name == "Mesh" then
                hObj:Destroy()
            end
        end
        local face = char.Head:FindFirstChild("face")
        if face then face.Transparency = 1 end 
    end
end

local function onCharacterAdded(newCharacter)
    task.wait(1) 
    
    if _G.IsSkinActive and _G.ApplySkin then
        if _G.CurrentSkinName and _G.CurrentSkinName ~= "None" then
            print("Персонаж обновлен, переприменяю скин: " .. _G.CurrentSkinName)
            _G.ApplySkin(_G.CurrentSkinName)
        end
    end
end

player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
    task.spawn(onCharacterAdded, player.Character)
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
    
    _G.SaveOriginal()
    _G.IsSkinActive = true

    local char = getChar()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local isR15 = humanoid and humanoid.RigType == Enum.HumanoidRigType.R15
    
    clearCharacter()

    -- 1. Настройка цветов тела
    local bc = Instance.new("BodyColors", char)
    if data.BodyColors then
        for prop, color in pairs(data.BodyColors) do
            pcall(function() bc[prop] = color end)
        end
    end

    -- 2. Настройка одежды
    if data.Shirt then Instance.new("Shirt", char).ShirtTemplate = data.Shirt end
    if data.Pants then Instance.new("Pants", char).PantsTemplate = data.Pants end

    -- 3. Настройка головы (Headless или Custom)
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

    -- 4. ПРИМЕНЕНИЕ МЕШЕЙ ТЕЛА (R6 vs R15)
    if isR15 then
        -- Логика для R15: ищем части тела и меняем ID в MeshPart
        if data.R15BodyMeshes then
            for partName, meshInfo in pairs(data.R15BodyMeshes) do
                local part = char:FindFirstChild(partName)
                if part and part:IsA("MeshPart") then
                    pcall(function()
                        part.MeshId = tostring(meshInfo.MeshId)
                        if meshInfo.TextureId then
                            part.TextureID = tostring(meshInfo.TextureId)
                        end
                    end)
                end
            end
        end
    else
        -- Логика для R6: используем CharacterMesh
        -- Проверяем R6BodyMeshes, если пусто — берем старый BodyMeshes для совместимости
        local r6Data = data.R6BodyMeshes or data.BodyMeshes 
        if r6Data then
            local partMapping = {
                ["Torso"] = Enum.BodyPart.Torso,
                ["LeftArm"] = Enum.BodyPart.LeftArm,
                ["RightArm"] = Enum.BodyPart.RightArm,
                ["LeftLeg"] = Enum.BodyPart.LeftLeg,
                ["RightLeg"] = Enum.BodyPart.RightLeg,
                ["Head"] = Enum.BodyPart.Head
            }

            for partName, meshInfo in pairs(r6Data) do
                local bodyPartEnum = partMapping[partName]
                if bodyPartEnum and meshInfo.MeshId then
                    local cm = Instance.new("CharacterMesh")
                    cm.BodyPart = bodyPartEnum
                    cm.MeshId = tostring(meshInfo.MeshId):gsub("%D", "") 
                    cm.BaseTextureId = meshInfo.TextureId or 0
                    cm.Parent = char
                end
            end
        end
        
        -- Спец. проверка Korblox для R6
        if data.Korblox and not (r6Data and r6Data.RightLeg) then
            local mesh = Instance.new("CharacterMesh", char)
            mesh.BodyPart = Enum.BodyPart.RightLeg
            mesh.MeshId = 101851696
            mesh.BaseTextureId = 0 
            mesh.OverlayTextureId = 101851254
        end
    end

    -- 5. Настройка аксессуаров
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
        if _G.OriginalAppearance.BodyColors then
            _G.OriginalAppearance.BodyColors:Clone().Parent = char
        end
        
        if _G.OriginalAppearance.Shirt then
            local s = Instance.new("Shirt", char)
            s.ShirtTemplate = _G.OriginalAppearance.Shirt
        end
        if _G.OriginalAppearance.Pants then
            local p = Instance.new("Pants", char)
            p.PantsTemplate = _G.OriginalAppearance.Pants
        end

        for _, acc in ipairs(_G.OriginalAppearance.Items) do
            if acc and acc:IsA("Accessory") then
                acc:Clone().Parent = char
            end
        end
        
        if char:FindFirstChild("Head") then
            if _G.OriginalAppearance.HeadMesh then
                _G.OriginalAppearance.HeadMesh:Clone().Parent = char.Head
            end
            local face = char.Head:FindFirstChild("face")
            if face then
                face.Transparency = 0
                face.Texture = _G.OriginalAppearance.Face or ""
            end
        end
        
        _G.OriginalAppearance = nil 
    end
    print("--- ПЕРСОНАЖ ВОССТАНОВЛЕН И ПАМЯТЬ ОЧИЩЕНА ---")
end
print("Skin Database Loaded Successfully!")
