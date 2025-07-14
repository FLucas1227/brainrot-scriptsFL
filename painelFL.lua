-- // Painel GUI usando OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Brainrot FL | Painel Premium",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BrainrotFL_Config"
})

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- // Tab Principal
local Main = Window:MakeTab({
    Name = "Principal",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- // FLBOLADO: roubo de brainrot mesmo com base trancada
local function FLBOLADO()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and v.Name == "Brainrot" then
            hrp.CFrame = v.Handle.CFrame * CFrame.new(0, 3, 0)
            wait(0.25)
            firetouchinterest(v.Handle, hrp, 0)
            firetouchinterest(v.Handle, hrp, 1)
        end
    end
end

Main:AddButton({
    Name = "⚡ Roubar brainrot (FLBOLADO)",
    Callback = FLBOLADO
})

-- // Auto roubo com teleporte
local AutoSteal = false
Main:AddToggle({
    Name = "Auto roubar brainrot",
    Default = false,
    Callback = function(value)
        AutoSteal = value
        while AutoSteal do
            FLBOLADO()
            wait(2)
        end
    end
})

-- // Velocidade
Main:AddSlider({
    Name = "Velocidade",
    Min = 16,
    Max = 100,
    Default = 16,
    Increment = 1,
    Callback = function(v)
        hum.WalkSpeed = v
    end
})

-- // Pulo
Main:AddSlider({
    Name = "Altura do Pulo",
    Min = 50,
    Max = 200,
    Default = 50,
    Increment = 1,
    Callback = function(v)
        hum.JumpPower = v
    end
})

-- // Anti-Stun
Main:AddToggle({
    Name = "Anti-stun",
    Default = false,
    Callback = function(v)
        if v then
            local conn
            conn = hum.ChildAdded:Connect(function(child)
                if child:IsA("BoolValue") and child.Name == "Stunned" then
                    child:Destroy()
                end
            end)
        end
    end
})

-- // Auto compra por raridade
Main:AddDropdown({
    Name = "Comprar por raridade",
    Options = {"Common", "Uncommon", "Rare", "Epic", "Legendary"},
    Callback = function(selected)
        local args = {[1] = selected}
        game:GetService("ReplicatedStorage").RemoteEvents.BuyCrate:FireServer(unpack(args))
    end
})

-- // Roubo massivo (sem delay)
Main:AddButton({
    Name = "💥 Roubo massivo de brainrot",
    Callback = function()
        for i = 1, 10 do
            FLBOLADO()
            wait(0.1)
        end
    end
})

-- // Aimbot simples
Main:AddToggle({
    Name = "Aimbot (lock mouse)",
    Default = false,
    Callback = function(on)
        if on then
            local RunService = game:GetService("RunService")
            RunService.RenderStepped:Connect(function()
                local closest = nil
                local shortest = math.huge
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= plr and v.Character and v.Character:FindFirstChild("Head") then
                        local dist = (v.Character.Head.Position - hrp.Position).Magnitude
                        if dist < shortest then
                            shortest = dist
                            closest = v
                        end
                    end
                end
                if closest then
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
                end
            end)
        end
    end
})

-- // AllHack (ver invisíveis)
Main:AddToggle({
    Name = "AllHack (ver jogadores invisíveis)",
    Default = false,
    Callback = function(v)
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= plr and p.Character then
                for _, part in pairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        part.Transparency = v and 0 or 1
                    end
                end
            end
        end
    end
})

OrionLib:Init()
Atualizar painelFL.lua com todas as funções completas
