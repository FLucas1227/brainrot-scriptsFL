-- Carregar biblioteca Chilli original
loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()

-- Função FLBOLADO: rouba brainrot ignorando base trancada
function FLBOLADO()
    local plr = game.Players.LocalPlayer
    local noclipConn
    local stealing = true

    -- Ativa noclip
    noclipConn = game:GetService("RunService").Stepped:Connect(function()
        if plr.Character and plr.Character:FindFirstChild("Humanoid") then
            plr.Character.Humanoid:ChangeState(11)
        end
    end)

    -- Loop de roubo
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
                end
            end
        end
    end

    noclipConn:Disconnect()
end

-- Exemplo: botão para ativar FLBOLADO se quiser integrar com GUI
-- Você pode também apenas rodar diretamente com: task.spawn(FLBOLADO)
