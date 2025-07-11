local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)

-- Função para criar interface móvel personalizada
local function CreateMobileInterface()
    local sg = Instance.new("ScreenGui", game.CoreGui)
    local mainFrame = Instance.new("Frame", sg)
    local titleBar = Instance.new("Frame", mainFrame)
    local title = Instance.new("TextLabel", titleBar)
    local closeBtn = Instance.new("TextButton", titleBar)
    local contentFrame = Instance.new("ScrollingFrame", mainFrame)
    
    -- Configuração da ScreenGui
    sg.Name = "UniversalHubMobile"
    sg.ResetOnSpawn = false
    
    -- Frame principal
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true -- Permite arrastar o menu
    
    -- Barra de título
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleBar.BorderSizePixel = 0
    
    -- Título
    title.Name = "Title"
    title.Size = UDim2.new(1, -30, 1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Universal Hub Mobile"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    
    -- Botão fechar
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.SourceSansBold
    
    -- Frame de conteúdo
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 8
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
    
    -- Função para fechar
    closeBtn.MouseButton1Click:Connect(function()
        sg:Destroy()
    end)
    
    return sg, mainFrame, contentFrame
end

-- Função para criar botões móveis
local function CreateMobileButton(parent, text, position, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.SourceSans
    
    -- Efeito visual
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

-- Função para criar sliders móveis
local function CreateMobileSlider(parent, text, position, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.9, 0, 0, 60)
    frame.Position = position
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 0.5, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.SourceSans
    
    local slider = Instance.new("Frame", frame)
    slider.Size = UDim2.new(0.9, 0, 0, 20)
    slider.Position = UDim2.new(0.05, 0, 0.5, 10)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    slider.BorderSizePixel = 0
    
    local fill = Instance.new("Frame", slider)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.Position = UDim2.new(0, 0, 0, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    fill.BorderSizePixel = 0
    
    local function updateSlider(input)
        local percent = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * percent)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        label.Text = text .. ": " .. value
        callback(value)
    end
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            updateSlider(input)
        end
    end)
    
    slider.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            updateSlider(input)
        end
    end)
    
    return frame
end

if not success or not Library then
    -- Criar interface móvel personalizada
    local sg, mainFrame, contentFrame = CreateMobileInterface()
    
    -- Serviços e player
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local Root = Character:WaitForChild("HumanoidRootPart")
    
    -- Config
    local Config = {
        WalkSpeed = 16,
        JumpPower = 50,
        ESP = false,
        Aimbot = false,
        AimbotFOV = 100,
        OriginalGraphics = {}
    }
    
    -- Notificação
    local function Notify(t, msg)
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = t,
                Text = msg,
                Duration = 3
            })
        end)
    end
    
    -- Salvar gráficos
    local function SaveGraphics()
        Config.OriginalGraphics = {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            FogEnd = Lighting.FogEnd,
            GlobalShadows = Lighting.GlobalShadows,
            Ambient = Lighting.Ambient
        }
    end
    
    -- Aplicar gráficos
    local function SetGraphics(mode)
        local presets = {
            realista = {Brightness = 3, ClockTime = 14, FogEnd = 100000, GlobalShadows = true, Ambient = Color3.fromRGB(128,128,128)},
            alto     = {Brightness = 2, ClockTime = 12, FogEnd = 75000, GlobalShadows = true, Ambient = Color3.fromRGB(100,100,100)},
            medio    = {Brightness = 1.5, ClockTime = 10, FogEnd = 50000, GlobalShadows = true, Ambient = Color3.fromRGB(70,70,70)},
            baixo    = {Brightness = 1, ClockTime = 8, FogEnd = 30000, GlobalShadows = false, Ambient = Color3.fromRGB(50,50,50)},
            potato   = {Brightness = 0.5, ClockTime = 6, FogEnd = 10000, GlobalShadows = false, Ambient = Color3.fromRGB(30,30,30)},
            machinha = {Brightness = 0.3, ClockTime = 5, FogEnd = 5000, GlobalShadows = false, Ambient = Color3.fromRGB(20,20,20)}
        }
        
        local g = presets[mode]
        if g then
            Lighting.Brightness = g.Brightness
            Lighting.ClockTime = g.ClockTime
            Lighting.FogEnd = g.FogEnd
            Lighting.GlobalShadows = g.GlobalShadows
            Lighting.Ambient = g.Ambient
            Notify("Gráficos", "Aplicado: " .. mode)
        end
    end
    
    -- ESP básico
    local function ToggleESP()
        Config.ESP = not Config.ESP
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                if Config.ESP then
                    local tag = Instance.new("BillboardGui", hrp)
                    tag.Name = "ESPTag"
                    tag.Size = UDim2.new(0, 100, 0, 40)
                    tag.AlwaysOnTop = true
                    tag.StudsOffset = Vector3.new(0, 3, 0)
                    
                    local label = Instance.new("TextLabel", tag)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.Text = p.Name
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.TextScaled = true
                    label.BackgroundTransparency = 1
                else
                    local tag = hrp:FindFirstChild("ESPTag")
                    if tag then tag:Destroy() end
                end
            end
        end
        Notify("ESP", Config.ESP and "Ativado" or "Desativado")
    end
    
    -- Aimbot básico
    RunService.RenderStepped:Connect(function()
        if Config.Aimbot then
            local cam = workspace.CurrentCamera
            local mouse = game:GetService("UserInputService"):GetMouseLocation()
            local closest, minDist = nil, math.huge
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head
                    local pos, onScreen = cam:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                        if dist < Config.AimbotFOV and dist < minDist then
                            closest = head.Position
                            minDist = dist
                        end
                    end
                end
            end
            
            if closest then
                cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, closest), 0.1)
            end
        end
    end)
    
    -- Criar elementos da interface
    local yPos = 0
    local spacing = 70
    
    -- Sliders
    CreateMobileSlider(contentFrame, "Velocidade", UDim2.new(0.05, 0, 0, yPos), 16, 500, 16, function(v)
        Config.WalkSpeed = v
        Humanoid.WalkSpeed = v
    end)
    yPos = yPos + spacing
    
    CreateMobileSlider(contentFrame, "Pulo", UDim2.new(0.05, 0, 0, yPos), 50, 500, 50, function(v)
        Config.JumpPower = v
        Humanoid.JumpPower = v
    end)
    yPos = yPos + spacing
    
    CreateMobileSlider(contentFrame, "FOV Aimbot", UDim2.new(0.05, 0, 0, yPos), 50, 300, 100, function(v)
        Config.AimbotFOV = v
    end)
    yPos = yPos + spacing
    
    -- Botões de toggle
    CreateMobileButton(contentFrame, "ESP Jogadores", UDim2.new(0.05, 0, 0, yPos), function()
        ToggleESP()
    end)
    yPos = yPos + 50
    
    CreateMobileButton(contentFrame, "Aimbot Head", UDim2.new(0.05, 0, 0, yPos), function()
        Config.Aimbot = not Config.Aimbot
        Notify("Aimbot", Config.Aimbot and "Ativado" or "Desativado")
    end)
    yPos = yPos + 60
    
    -- Botões de gráficos
    local graphicsButtons = {"Realista", "Alto", "Médio", "Baixo", "Potato", "Machinha", "Restaurar"}
    for _, btnName in ipairs(graphicsButtons) do
        CreateMobileButton(contentFrame, btnName, UDim2.new(0.05, 0, 0, yPos), function()
            if btnName == "Restaurar" then
                RestoreGraphics()
            else
                SetGraphics(btnName:lower())
            end
        end)
        yPos = yPos + 50
    end
    
    SaveGraphics()
    Notify("Universal Hub", "Interface móvel carregada!")
    
    return
end

-- Resto do código original para quando a Kavo UI carrega
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

-- Config
local Config = {
    WalkSpeed = 16,
    JumpPower = 50,
    ESP = false,
    ESPLine = false,
    Aimbot = false,
    AimbotFOV = 100,
    OriginalGraphics = {}
}

-- Notificação
local function Notify(t, msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = t,
            Text = msg,
            Duration = 3
        })
    end)
end

-- Salvar gráficos
local function SaveGraphics()
    Config.OriginalGraphics = {
        Brightness = Lighting.Brightness,
        ClockTime = Lighting.ClockTime,
        FogEnd = Lighting.FogEnd,
        GlobalShadows = Lighting.GlobalShadows,
        Ambient = Lighting.Ambient
    }
end

-- Aplicar gráficos
local function SetGraphics(mode)
    local presets = {
        realista = {Brightness = 3, ClockTime = 14, FogEnd = 100000, GlobalShadows = true, Ambient = Color3.fromRGB(128,128,128)},
        alto     = {Brightness = 2, ClockTime = 12, FogEnd = 75000, GlobalShadows = true, Ambient = Color3.fromRGB(100,100,100)},
        medio    = {Brightness = 1.5, ClockTime = 10, FogEnd = 50000, GlobalShadows = true, Ambient = Color3.fromRGB(70,70,70)},
        baixo    = {Brightness = 1, ClockTime = 8, FogEnd = 30000, GlobalShadows = false, Ambient = Color3.fromRGB(50,50,50)},
        potato   = {Brightness = 0.5, ClockTime = 6, FogEnd = 10000, GlobalShadows = false, Ambient = Color3.fromRGB(30,30,30)},
        machinha = {Brightness = 0.3, ClockTime = 5, FogEnd = 5000, GlobalShadows = false, Ambient = Color3.fromRGB(20,20,20)}
    }

    local g = presets[mode]
    if g then
        Lighting.Brightness = g.Brightness
        Lighting.ClockTime = g.ClockTime
        Lighting.FogEnd = g.FogEnd
        Lighting.GlobalShadows = g.GlobalShadows
        Lighting.Ambient = g.Ambient
        Notify("Gráficos", "Aplicado: " .. mode)
    end
end

-- Restaurar gráficos
local function RestoreGraphics()
    local g = Config.OriginalGraphics
    if g then
        Lighting.Brightness = g.Brightness
        Lighting.ClockTime = g.ClockTime
        Lighting.FogEnd = g.FogEnd
        Lighting.GlobalShadows = g.GlobalShadows
        Lighting.Ambient = g.Ambient
        Notify("Gráficos", "Restaurados!")
    end
end

-- ESP básico com nome e distância
local function ToggleESP()
    Config.ESP = not Config.ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            if Config.ESP then
                local tag = Instance.new("BillboardGui", hrp)
                tag.Name = "ESPTag"
                tag.Size = UDim2.new(0, 100, 0, 40)
                tag.AlwaysOnTop = true
                tag.StudsOffset = Vector3.new(0, 3, 0)

                local label = Instance.new("TextLabel", tag)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = p.Name
                label.TextColor3 = Color3.new(1, 1, 1)
                label.TextScaled = true
                label.BackgroundTransparency = 1
            else
                local tag = hrp:FindFirstChild("ESPTag")
                if tag then tag:Destroy() end
            end
        end
    end
    Notify("ESP", Config.ESP and "Ativado" or "Desativado")
end

-- Aimbot básico
RunService.RenderStepped:Connect(function()
    if Config.Aimbot then
        local cam = workspace.CurrentCamera
        local mouse = game:GetService("UserInputService"):GetMouseLocation()
        local closest, minDist = nil, math.huge

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local pos, onScreen = cam:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                    if dist < Config.AimbotFOV and dist < minDist then
                        closest = head.Position
                        minDist = dist
                    end
                end
            end
        end

        if closest then
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, closest), 0.1)
        end
    end
end)

-- Interface
local Window = Library.CreateLib("Universal Hub", "DarkTheme")
local Tab = Window:NewTab("Funções")
local Section = Tab:NewSection("Movimentação")

Section:NewSlider("Velocidade", "Altera WalkSpeed", 500, 16, function(v)
    Config.WalkSpeed = v
    Humanoid.WalkSpeed = v
end)

Section:NewSlider("Pulo", "Altera JumpPower", 500, 50, function(v)
    Config.JumpPower = v
    Humanoid.JumpPower = v
end)

Section:NewToggle("ESP Jogadores", "Ver nomes no mapa", function()
    ToggleESP()
end)

Section:NewToggle("Aimbot Head", "Gruda no inimigo", function(v)
    Config.Aimbot = v
    Notify("Aimbot", v and "Ativado" or "Desativado")
end)

Section:NewSlider("FOV Aimbot", "Campo de visão", 300, 100, function(v)
    Config.AimbotFOV = v
end)

local GTab = Window:NewTab("Gráficos")
local GSec = GTab:NewSection("Qualidade Visual")

GSec:NewButton("Realista", "", function() SetGraphics("realista") end)
GSec:NewButton("Alto", "", function() SetGraphics("alto") end)
GSec:NewButton("Médio", "", function() SetGraphics("medio") end)
GSec:NewButton("Baixo", "", function() SetGraphics("baixo") end)
GSec:NewButton("Potato", "", function() SetGraphics("potato") end)
GSec:NewButton("Machinha", "", function() SetGraphics("machinha") end)
GSec:NewButton("Restaurar", "", function() RestoreGraphics() end)

SaveGraphics()
Notify("Universal Hub", "Carregado com sucesso!")
