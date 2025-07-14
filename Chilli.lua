--[[
  Painel: BrainFL Panel
  Jogo: Roube um Brainrot [Roblox]
  Funções: Roubo automático com teleport, auto compra com filtro, anti stun, roubo massivo,
           ajustes de velocidade e pulo, aimbot, ver invisíveis, menu toggle
]]

-- Carregar biblioteca OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Criar Janela
local Window = OrionLib:MakeWindow({
    Name = "BrainFL Panel | Roube um Brainrot",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BrainFL_Config"
})

-- Variáveis principais
local plr = game.Players.LocalPlayer
local hum = plr.Character and plr.Character:WaitForChild("Humanoid")
local hrp = plr.Character and plr.Character:WaitForChild("HumanoidRootPart")
local teleportBaseCFrame = CFrame.new(0, 0, 0) -- Substituir pela sua base se souber

-- Menu toggle
OrionLib:Init()

-- Aba: Jogabilidade
local jogabilidadeTab = Window:MakeTab({
    Name = "🎮 Jogabilidade",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

jogabilidadeTab:AddSlider({
    Name = "Velocidade",
    Min = 16,
    Max = 120,
    Default = 16,
    Increment = 1,
    ValueName = "Vel",
    Callback = function(val)
        if hum then hum.WalkSpeed = val end
    end
})

jogabilidadeTab:AddSlider({
    Name = "Altura do Pulo",
    Min = 50,
    Max = 200,
    Default = 50,
    Increment = 1,
    ValueName = "Pulo",
    Callback = function(val)
        if hum then hum.JumpPower = val end
    end
})

-- Aba: Roubo
local rouboTab = Window:MakeTab({
    Name = "💸 Roubo",
    Icon = "rbxassetid://6031075931",
    PremiumOnly = false
})

local stealing = false

rouboTab:AddToggle({
    Name = "Auto Roubar + Teleport",
    Default = false,
    Callback = function(val)
        stealing = val
        while stealing do
            task.wait()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Part") and obj.Name == "Brainrot" then
                    local target = obj.CFrame
                    hrp.CFrame = target + Vector3.new(0, 2, 0)
                    for _, c in ipairs(obj:GetChildren()) do
                        if c:IsA("TouchTransmitter") then
                            firetouchinterest(hrp, obj, 0)
                            task.wait(0.1)
                            firetouchinterest(hrp, obj, 1)
                        end
                    end
                    task.wait(0.1)
                    hrp.CFrame = teleportBaseCFrame
                end
            end
        end
    end
})

-- Aba: Auto Compra
local compraTab = Window:MakeTab({
    Name = "🛒 Auto Compra",
    Icon = "rbxassetid://6031265976",
    PremiumOnly = false
})

local raridadeEscolhida = "Secreto"

compraTab:AddDropdown({
    Name = "Escolher raridade",
    Default = "Secreto",
    Options = {"Comum", "Raro", "Épico", "Lendário", "Secreto"},
    Callback = function(val)
        raridadeEscolhida = val
    end
})

compraTab:AddToggle({
    Name = "Comprar automaticamente",
    Default = false,
    Callback = function(val)
        while val do
            task.wait(1)
            local evento = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("BuyBrainrot")
            if evento then evento:FireServer(raridadeEscolhida) end
        end
    end
})

-- Aba: Anti-Stun
local defesaTab = Window:MakeTab({
    Name = "🛡 Anti-Stun",
    Icon = "rbxassetid://6035047409",
    PremiumOnly = false
})

defesaTab:AddButton({
    Name = "Ativar Anti-Stun",
    Callback = function()
        plr.Character.Humanoid.BreakJointsOnDeath = false
        plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    end
})

-- Aba: Visual
local visualTab = Window:MakeTab({
    Name = "🕵️ Visual",
    Icon = "rbxassetid://6031763426",
    PremiumOnly = false
})

visualTab:AddButton({
    Name = "Ver jogadores invisíveis",
    Callback = function()
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local esp = Instance.new("Highlight")
                esp.Adornee = p.Character
                esp.FillColor = Color3.new(1, 0, 0)
                esp.FillTransparency = 0.5
                esp.OutlineColor = Color3.new(0, 0, 0)
                esp.OutlineTransparency = 0
                esp.Parent = p.Character
            end
        end
    end
})

-- Aimbot (simples)
rouboTab:AddToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(val)
        if val then
            getgenv().aimbotConnection = game:GetService("RunService").RenderStepped:Connect(function()
                local mouse = plr:GetMouse()
                local target = mouse.Target
                if target and target:IsDescendantOf(workspace) then
                    mouse.Icon = "rbxassetid://6031154879"
                end
            end)
        else
            if getgenv().aimbotConnection then getgenv().aimbotConnection:Disconnect() end
        end
    end
})
