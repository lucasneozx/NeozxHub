-- NeozxHub - Menu Expandido com Aimbot, ESP e Gráficos
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "NeozxGraphicsMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 600)
frame.Position = UDim2.new(0.5, -200, 0.5, -300)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = true

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "🌟 NeozxHub - Menu Premium"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

-- Botão de Fechar
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextSize = 16
local closeCorner = Instance.new("UICorner", close)
closeCorner.CornerRadius = UDim.new(0, 6)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Helper Button
local function createButton(text, yPos, callback)
    local button = Instance.new("TextButton", frame)
    button.Position = UDim2.new(0, 25, 0, yPos)
    button.Size = UDim2.new(0, 350, 0, 40)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.MouseButton1Click:Connect(callback)
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)
end

-- Opções de Gráficos
createButton("Gráficos: Maquininha (texturas off)", 60, function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Color = Color3.new(0.2, 0.2, 0.2)
        end
    end
    Lighting.GlobalShadows = false
end)

createButton("Gráficos: Alto (com sombra)", 110, function()
    Lighting.GlobalShadows = true
    Lighting.Brightness = 1.5
    Lighting.Ambient = Color3.fromRGB(100, 100, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
end)

createButton("Gráficos: Realista (iluminação leve)", 160, function()
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(140, 140, 140)
    Lighting.OutdoorAmbient = Color3.fromRGB(60, 60, 60)
    Lighting.EnvironmentDiffuseScale = 0.7
    Lighting.EnvironmentSpecularScale = 1
end)

-- FOV
createButton("FOV 60", 210, function()
    workspace.CurrentCamera.FieldOfView = 60
end)
createButton("FOV 90", 260, function()
    workspace.CurrentCamera.FieldOfView = 90
end)
createButton("FOV 120", 310, function()
    workspace.CurrentCamera.FieldOfView = 120
end)

-- FPS
createButton("Ativar Contador de FPS", 360, function()
    if not gui:FindFirstChild("fps") then
        local fps = Instance.new("TextLabel", gui)
        fps.Name = "fps"
        fps.Position = UDim2.new(0, 10, 0, 10)
        fps.Size = UDim2.new(0, 150, 0, 20)
        fps.BackgroundTransparency = 1
        fps.TextColor3 = Color3.fromRGB(255, 255, 0)
        fps.TextSize = 14
        fps.Font = Enum.Font.Code
        RunService.RenderStepped:Connect(function()
            fps.Text = "FPS: " .. math.floor(1 / RunService.RenderStepped:Wait())
        end)
    end
end)

createButton("Desativar FPS", 410, function()
    if gui:FindFirstChild("fps") then gui.fps:Destroy() end
end)

-- Ativar/Desativar Aimbot e ESP
local aimbotEnabled = true
local espEnabled = true
createButton("Alternar Aimbot", 460, function()
    aimbotEnabled = not aimbotEnabled
end)
createButton("Alternar ESP", 510, function()
    espEnabled = not espEnabled
end)

-- Aimbot Head
local aimPart = "Head"
local aimKey = Enum.UserInputType.MouseButton2

local function getClosestEnemy()
    local closestEnemy, shortestDistance = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local char = player.Character
            if char and char:FindFirstChild(aimPart) then
                local pos, visible = Camera:WorldToViewportPoint(char[aimPart].Position)
                if visible then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                    if dist < shortestDistance then
                        shortestDistance = dist
                        closestEnemy = char[aimPart].Position
                    end
                end
            end
        end
    end
    return closestEnemy
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled and UserInputService:IsMouseButtonPressed(aimKey) then
        local target = getClosestEnemy()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target)
        end
    end
end)

-- ESP
local espLines = {}
local function clearESP()
    for _, line in ipairs(espLines) do
        if line then line:Remove() end
    end
    espLines = {}
end

local function drawESP(player)
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(0, 255, 0)
    line.Thickness = 1.5
    line.Transparency = 1
    table.insert(espLines, line)
    return line
end

RunService.RenderStepped:Connect(function()
    if espEnabled then
        clearESP()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Team ~= LocalPlayer.Team and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, visible = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if visible then
                    local line = drawESP(p)
                    line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                    line.To = Vector2.new(pos.X, pos.Y)
                    line.Visible = true
                end
            end
        end
    else
        clearESP()
    end
end)
