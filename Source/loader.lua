-- NeozxHub - Menu de Gráficos Avançado + Aimbot & ESP (Aprimorado)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- GUI Setup
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "NeozxGraphicsMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 550)
frame.Position = UDim2.new(0.5, -200, 0.5, -275)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
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

local function createButton(text, yPos, callback)
    local button = Instance.new("TextButton", frame)
    button.Position = UDim2.new(0, 25, 0, yPos)
    button.Size = UDim2.new(0, 350, 0, 45)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.MouseButton1Click:Connect(callback)
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 10)
end

-- FPS Counter
createButton("Desativar FPS", 60, function()
    if gui:FindFirstChild("fps") then gui.fps:Destroy() end
end)

createButton("Ativar FPS", 115, function()
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
end)

-- Gráficos e FOV
createButton("Gráfico Maquininha (texturas off)", 170, function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Color = Color3.new(0.2, 0.2, 0.2)
        end
    end
    Lighting.GlobalShadows = false
end)

createButton("FOV 60", 225, function()
    workspace.CurrentCamera.FieldOfView = 60
end)

createButton("FOV 90", 280, function()
    workspace.CurrentCamera.FieldOfView = 90
end)

createButton("FOV 120", 335, function()
    workspace.CurrentCamera.FieldOfView = 120
end)

-- Shader aprimorado
Lighting.Brightness = 1.5
Lighting.GlobalShadows = true
Lighting.Ambient = Color3.fromRGB(100, 100, 100)
Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 50)
Lighting.EnvironmentDiffuseScale = 0.6
Lighting.EnvironmentSpecularScale = 1
Lighting.ColorShift_Top = Color3.new(0.05, 0.05, 0.05)

-- Aimbot
local aimEnabled = true
local aimPart = "Head"
local aimKey = Enum.UserInputType.MouseButton2

local function getClosestEnemy()
    local shortestDistance = math.huge
    local closestEnemy = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local char = player.Character
            if char and char:FindFirstChild(aimPart) then
                local pos, visible = Camera:WorldToViewportPoint(char[aimPart].Position)
                if visible then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
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
    if aimEnabled and UserInputService:IsMouseButtonPressed(aimKey) then
        local target = getClosestEnemy()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target)
        end
    end
end)

-- ESP
local espEnabled = true
local espLines = {}

local function clearESP()
    for _, v in pairs(espLines) do
        if v then v:Remove() end
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
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Team ~= LocalPlayer.Team and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local pos, visible = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                if visible then
                    local line = drawESP(p)
                    line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    line.To = Vector2.new(pos.X, pos.Y)
                    line.Visible = true
                end
            end
        end
    end
end)
