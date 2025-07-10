-- Serviços
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- Jogador local
local LocalPlayer = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NeozxGraphicsMenu"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 480)
frame.Position = UDim2.new(0.5, -180, 0.5, -240)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = frame

-- Botão fechar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Parent = frame
closeButton.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌟 Menu de Gráficos - Neozx"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = frame

-- Funções de gráficos
local function aplicarGraficos(modo)
    if modo == "Super Batata" then
        Lighting.Brightness = 1
        Lighting.FogEnd = 100
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v.Transparency = 0.5
            end
        end
    elseif modo == "Realista" then
        Lighting.Brightness = 1.2
        Lighting.FogEnd = 1000
        Lighting.EnvironmentDiffuseScale = 0.5
        Lighting.EnvironmentSpecularScale = 0.5
        Lighting.GlobalShadows = true
    elseif modo == "Raytracing" then
        Lighting.Brightness = 1.1
        Lighting.FogEnd = 1000
        Lighting.EnvironmentDiffuseScale = 1
        Lighting.EnvironmentSpecularScale = 1
        Lighting.GlobalShadows = true
    end
end

-- Função de resolução
local function aplicarResolucao(res)
    local camera = workspace.CurrentCamera
    if res == "720p" then
        camera.FieldOfView = 70
    elseif res == "4k" then
        camera.FieldOfView = 90
    end
end

-- Botões
local function criarBotao(texto, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, 0, yPos)
    btn.Text = texto
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Parent = frame
    btn.MouseButton1Click:Connect(callback)
end

criarBotao("Gráficos Super Batata", 60, function() aplicarGraficos("Super Batata") end)
criarBotao("Gráficos Realista", 110, function() aplicarGraficos("Realista") end)
criarBotao("Raytracing", 160, function() aplicarGraficos("Raytracing") end)
criarBotao("Resolucao 720p", 210, function() aplicarResolucao("720p") end)
criarBotao("Resolucao 4K", 260, function() aplicarResolucao("4k") end)
