-- NeozxHub v15.3 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

pcall(function()
    if CoreGui:FindFirstChild("NeozxHubBeta") then CoreGui.NeozxHub:Destroy() end
end)

local settings = {
    aimbotEnabled = false,
    aimbotSmooth = 0.30,
    aimbotPart = "Head",
    espEnabled = false
}

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "NeozxHub"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 320, 0, 480)
main.Position = UDim2.new(0.05, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local top = Instance.new("TextLabel", main)
top.Size = UDim2.new(1, 0, 0, 30)
top.Text = "NeozxHub v15.3 🎯"
top.TextColor3 = Color3.fromRGB(100, 255, 150)
top.Font = Enum.Font.GothamBold
top.TextSize = 16
top.BackgroundTransparency = 1

-- FPS
local fpsLabel = Instance.new("TextLabel", main)
fpsLabel.Position = UDim2.new(1, -90, 0, 5)
fpsLabel.Size = UDim2.new(0, 85, 0, 20)
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 14
fpsLabel.Text = "FPS: 0"
fpsLabel.BackgroundTransparency = 1

local frames, last = 0, tick()
RunService.Heartbeat:Connect(function()
    frames += 1
    if tick() - last >= 1 then
        fpsLabel.Text = "FPS: " .. frames
        frames = 0
        last = tick()
    end
end)

local function createButton(txt, posY, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Text = txt
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createButton("📺 Tela Esticada (FOV 100)", 40, function()
    Camera.FieldOfView = 100
end)

createButton("🔁 Restaurar FOV (70)", 85, function()
    Camera.FieldOfView = 70
end)

createButton("🖥 Gráfico Maquininha", 130, function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 0
    Lighting.FogEnd = 999999
    Lighting.OutdoorAmbient = Color3.fromRGB(40,40,40)
    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Color = Color3.fromRGB(50,50,50)
            v.Reflectance = 0
            if v:FindFirstChildOfClass("Texture") then
                v:FindFirstChildOfClass("Texture"):Destroy()
            end
        end
    end
end)

createButton("🌅 Gráfico Super Realista", 175, function()
    Lighting.GlobalShadows = true
    Lighting.Brightness = 1.5
    Lighting.FogEnd = 600
    Lighting.OutdoorAmbient = Color3.fromRGB(180,180,200)
    Lighting.ClockTime = 18
end)

createButton("🔄 Restaurar Gráficos", 220, function()
    Lighting.GlobalShadows = true
    Lighting.Brightness = 1
    Lighting.FogEnd = 100000
    Lighting.ClockTime = 14
    Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
end)

createButton("🔎 ESP: OFF", 265, function(btn)
    settings.espEnabled = not settings.espEnabled
    btn.Text = "🔎 ESP: " .. (settings.espEnabled and "ON" or "OFF")
end)

createButton("🎯 Aimbot: OFF", 310, function(btn)
    settings.aimbotEnabled = not settings.aimbotEnabled
    btn.Text = "🎯 Aimbot: " .. (settings.aimbotEnabled and "ON" or "OFF")
end)

local smoothBtn = createButton("🎚 Intensidade Aimbot: 0.25", 355, function()
    settings.aimbotSmooth += 0.05
    if settings.aimbotSmooth > 1 then settings.aimbotSmooth = 0.05 end
    smoothBtn.Text = "🎚 Intensidade Aimbot: " .. string.format("%.2f", settings.aimbotSmooth)
end)

-- ESP
local drawings = {}
local function clearESP()
    for _, d in ipairs(drawings) do if d.Remove then d:Remove() end end
    drawings = {}
end

local function drawESP()
    clearESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
            local color = p.Team and p.Team.TeamColor and p.Team.TeamColor.Color or Color3.new(1,1,1)
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local line = Drawing.new("Line")
                    line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    line.To = Vector2.new(pos.X, pos.Y)
                    line.Color = color
                    line.Thickness = 1.5
                    line.Visible = true
                    table.insert(drawings, line)
                end
            end
            for _, partName in ipairs({"Head","Torso","Left Arm","Right Arm","Left Leg","Right Leg"}) do
                local part = p.Character:FindFirstChild(partName)
                if part then
                    local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local dot = Drawing.new("Circle")
                        dot.Position = Vector2.new(pos.X, pos.Y)
                        dot.Radius = 3
                        dot.Color = color
                        dot.Visible = true
                        table.insert(drawings, dot)
                    end
                end
            end
        end
    end
end

-- Aimbot Head (só gruda se olhar pro alvo)
local function getTarget()
    local closest, minDist = nil, 60
    local mouse = UserInputService:GetMouseLocation()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(settings.aimbotPart) then
            local part = plr.Character[settings.aimbotPart]
            local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
            if onScreen and dist < minDist then
                closest = part
                minDist = dist
            end
        end
    end
    return closest
end

-- LOOP
RunService.Heartbeat:Connect(function()
    if settings.espEnabled then drawESP() else clearESP() end
    if settings.aimbotEnabled then
        local target = getTarget()
        if target then
            local velocity = target.Velocity or target.AssemblyLinearVelocity or Vector3.zero
            local predicted = target.Position + velocity * 0.05
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, predicted), settings.aimbotSmooth)
        end
    end
end)
