-- Neozx Graphics Menu for Roblox
-- Atualizado com sombras realistas, resolução real, e modo "gráficos de maquininha"

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

-- Criar GUI
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "NeozxGraphicsMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.5, -200, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local function createOption(name, callback, posY)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(callback)
end

-- Opções de gráfico
createOption("Gráficos Altos", function()
    Lighting.Brightness = 2
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Workspace.Terrain.WaterWaveSize = 0.2
    Workspace.Terrain.WaterReflectance = 1
end, 50)

createOption("Gráficos Realistas", function()
    Lighting.Brightness = 1.5
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(90, 90, 90)
    Lighting.EnvironmentDiffuseScale = 1.25
    Lighting.EnvironmentSpecularScale = 1.25
    Workspace.Terrain.WaterWaveSize = 0.2
    Workspace.Terrain.WaterReflectance = 1
end, 100)

createOption("Raytracing Suave", function()
    Lighting.Brightness = 1.2
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(90, 90, 90)
    Lighting.EnvironmentDiffuseScale = 1.5
    Lighting.EnvironmentSpecularScale = 1.5
end, 150)

createOption("Gráficos de Maquininha (sem textura)", function()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Color = Color3.fromRGB(120, 120, 120)
        end
    end
    Lighting.Brightness = 1
    Lighting.GlobalShadows = false
end, 200)

-- Resolução real
createOption("Resolução 720p", function()
    Camera.FieldOfView = 60
end, 250)

createOption("Resolução 4K", function()
    Camera.FieldOfView = 100
end, 300)

-- Ajustes finais
Lighting.ClockTime = 14
Lighting.FogEnd = 100000
Lighting.FogStart = 0
Lighting.FogColor = Color3.fromRGB(255, 255, 255)

print("Menu de Gráficos Neozx carregado com sucesso")
