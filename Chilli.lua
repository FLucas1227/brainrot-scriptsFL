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

local plr = game.Players.LocalPlayer
local hum = plr.Character and plr.Character:WaitForChild("Humanoid")
local hrp = plr.Character and plr.Character:WaitForChild("HumanoidRootPart")

-- Auto Steal com teleport
local function FLBOLADO()
    local stealing = true
    local noclipConn

    noclipConn = game:GetService("RunService").Stepped:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid:ChangeState(11)
        end
    end)

    while stealing do
        task.wait(1)
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name == "Brainrot" then
                local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local old = hrp.CFrame
                    hrp.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                    task.wait(0.2)
                    for _, c in ipairs(obj:GetChildren()) do
                        if c:IsA("TouchTransmitter") then
                            firetouchinterest(hrp, obj, 0)
                            task.wait(0.1)
                            firetouchinterest(hrp, obj, 1)
                        end
                    end
                    task.wait(0.1)
                    hrp.CFrame = old

                    -- Teleport para base
                    local base = workspace:FindFirstChild("Base_" .. plr.Name)
                    if base then
                        hrp.CFrame = base.CFrame + Vector3.new(0, 3, 0)
                    end
                end
            end
        end
    end

    noclipConn:Disconnect()
end

-- Auto Buy com filtro de raridade
local function autoBuy(raridade)
    while true do
        task.wait(2)
        for _, btn in ipairs(workspace:GetDescendants()) do
            if btn:IsA("ClickDetector") and btn.Parent and btn.Parent.Name:lower():find(raridade:lower()) then
                fireclickdetector(btn)
            end
        end
    end
end

-- Anti Stun
local function antiStun()
    plr.Character.Humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Physics or newState == Enum.HumanoidStateType.Ragdoll then
            plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end

-- Ajuste de velocidade e pulo
local function ajustarMovimento(speed, jump)
    plr.Character.Humanoid.WalkSpeed = speed
    plr.Character.Humanoid.JumpPower = jump
end

-- Roubo massivo (sem delay)
local function rouboInstantaneo()
    local old = hookmetamethod(game, "__namecall", function(...)
        local args = {...}
        if getnamecallmethod() == "FireServer" and tostring(args[1]) == "Steal" then
            return true
        end
        return old(...)
    end)
end

-- Aimbot simples
local function enableAimbot()
    local RunService = game:GetService("RunService")
    RunService.Stepped:Connect(function()
        local closest = nil
        local shortest = math.huge
        for _, player in ipairs(game.Players:GetP_
