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
    OrionLib:MakeNotification({
        Name = "FLBOLADO Ativado!",
        Content = "Teleportando para o brainrot mais próximo...",
        Image = "rbxassetid://4483345998",
        Time = 5
    })

    task.spawn(function()
        while task.wait() do
            local closest, dist = nil, math.huge
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "brainrot" and v:IsA("BasePart") then
                    local d = (v.Position - hrp.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = v
                    end
                end
            end
            if closest then
                hrp.CFrame = CFrame.new(hrp.Position, closest.Character.HumanoidRootPart.Position)
            end
        end
    end)
end

Main:AddButton({
    Name = "FLBOLADO (rouba até trancado)",
    Callback = FLBOLADO
})

-- // AllHack (ver jogadores invisíveis)
Main:AddButton({
    Name = "AllHack (ver invisíveis)",
    Callback = function()
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Character then
                for _, part in pairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Transparency == 1 then
                        part.Transparency = 0
                        part.Material = Enum.Material.Neon
                        part.Color = Color3.fromRGB(255, 0, 0)
                    end
                end
            end
        end
    end
})

OrionLib:Init()
Add painel autoexecutável
