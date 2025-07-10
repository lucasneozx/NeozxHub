local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

-- GUI
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "NeozxGraphicsMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 420)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌟 Menu de Gráficos - Neozx"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

-- FPS counter
local fpsLabel = Instance.new("TextLabel", frame)
fpsLabel.Size = UDim2.new(1, -20, 0, 20)
fpsLabel.Position = UDim2.new(0, 10, 1, -25)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 14
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsLabel.Text = "FPS: ..."

local frames = 0
local last = tick()
RunService.RenderStepped:Connect(function()
	frames += 1
	if tick() - last >= 1 then
		fpsLabel.Text = "FPS: " .. frames
		frames = 0
		last = tick()
	end
end)

-- Configurações gráficas
local function setGraphics(mode)
	if Terrain then
		Terrain.WaterWaveSize = 0.1
		Terrain.WaterWaveSpeed = 10
		Terrain.WaterReflectance = 0.5
		Terrain.WaterTransparency = 0.5
	end

	if mode == "superRealista" then
		Lighting.Brightness = 2.5
		Lighting.FogEnd = 400
		Lighting.ClockTime = 17
		Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
		Lighting.Ambient = Color3.fromRGB(160, 160, 160)
		Lighting.ExposureCompensation = 0.4
		Lighting.ShadowSoftness = 0.25
	elseif mode == "alto" then
		Lighting.Brightness = 2.2
		Lighting.FogEnd = 5000
	elseif mode == "medio" then
		Lighting.Brightness = 1.5
		Lighting.FogEnd = 15000
	elseif mode == "batata" then
		Lighting.GlobalShadows = false
		Lighting.Brightness = 0.9
		Lighting.FogEnd = 100000
		Lighting.OutdoorAmbient = Color3.fromRGB(90, 90, 90)
		Lighting.Ambient = Color3.fromRGB(85, 85, 85)
	elseif mode == "superBatata" then
		Lighting.GlobalShadows = false
		Lighting.Brightness = 0.4
		Lighting.FogEnd = 150000
		Lighting.OutdoorAmbient = Color3.fromRGB(40, 40, 40)
		Lighting.Ambient = Color3.fromRGB(35, 35, 35)
	elseif mode == "semSombras" then
		Lighting.GlobalShadows = false
		Lighting.Brightness = 1
		Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
		Lighting.Ambient = Color3.fromRGB(100, 100, 100)
	elseif mode == "raytracing" then
		Lighting.Brightness = 3
		Lighting.GlobalShadows = true
		Lighting.FogEnd = 400
		Lighting.FogColor = Color3.fromRGB(180, 200, 255)
		Lighting.ClockTime = 17
		Lighting.GeographicLatitude = 41
		Lighting.ExposureCompensation = 0.5
		Lighting.ShadowSoftness = 0.2
	end
end

-- Criar botão
local function createButton(text, y, mode)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.TextColor3 = Color3.fromRGB(0, 255, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.MouseButton1Click:Connect(function()
		setGraphics(mode)
	end)
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)
end

-- Botões
createButton("🔆 Super Realista", 50, "superRealista")
createButton("🔅 Alto", 100, "alto")
createButton("💡 Médio", 150, "medio")
createButton("🥔 Batata", 200, "batata")
createButton("🧨 Super Batata", 250, "superBatata")
createButton("🚫 Sem Sombras", 300, "semSombras")
createButton("⚡ Raytracing", 350, "raytracing")
