--[[
    Script: Neozx Graphics Menu
    Funções: Controle total de gráficos para Roblox incluindo
    modos de desempenho, qualidade, shaders e resolução.
]]

-- Referências dos serviços
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- GUI
local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "NeozxGraphicsMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 420)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌟 Menu de Gráficos - Neozx"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- Funções de Gráficos
local function aplicarGraficoBatata()
    Lighting.Brightness = 1
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 500
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
    Lighting.EnvironmentDiffuseScale = 0.2
    Lighting.EnvironmentSpecularScale = 0.1
end

local function aplicarGraficoSuperBatata()
    aplicarGraficoBatata()
    Lighting.Brightness = 0.5
    Lighting.FogEnd = 200
end

local function aplicarGraficoAlto()
    Lighting.Brightness = 2
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 1000
    Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
    Lighting.EnvironmentDiffuseScale = 0.5
    Lighting.EnvironmentSpecularScale = 0.5
end

local function aplicarGraficoRealista()
    Lighting.Brightness = 1.2
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 999999
    Lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    local bloom = Instance.new("BloomEffect", Lighting)
    bloom.Intensity = 0.3
    bloom.Size = 32
    local color = Instance.new("ColorCorrectionEffect", Lighting)
    color.Brightness = 0.05
    color.Contrast = 0.15
    color.Saturation = 0.15
end

local function aplicarRayTracing()
    Lighting.Brightness = 1.0
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 999999
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 2
    local cc = Instance.new("ColorCorrectionEffect", Lighting)
    cc.Brightness = 0.03
    cc.Contrast = 0.2
    cc.Saturation = 0.1
    local blur = Instance.new("BlurEffect", Lighting)
    blur.Size = 2
end

local function ajustarResolucao(escala)
    if UserSettings then
        local settings = UserSettings():GetService("UserGameSettings")
        settings.SavedQualityLevel = escala
    end
end

-- Cria botões (exemplo: Batata)
local function criarBotao(nome, funcao, ordem)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, 50 + (ordem * 40))
    btn.Text = nome
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(funcao)
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)
end

-- Adicionar os botões de opções de gráfico
criarBotao("Gráficos Super Batata", aplicarGraficoSuperBatata, 0)
criarBotao("Gráficos Batata", aplicarGraficoBatata, 1)
criarBotao("Gráficos Alto", aplicarGraficoAlto, 2)
criarBotao("Gráficos Realista", aplicarGraficoRealista, 3)
criarBotao("Raytracing Simulado", aplicarRayTracing, 4)
criarBotao("Resolução Alta", function() ajustarResolucao(10) end, 5)
criarBotao("Resolução Baixa", function() ajustarResolucao(1) end, 6)

-- Final
print("[NeozxGraphicsMenu] Menu de gráficos carregado com sucesso!")
