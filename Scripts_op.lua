local Players = game:GetService("Players")
local player = Players.LocalPlayer

_G.logsDeLogin = _G.logsDeLogin or {}

-- TELA DE LOGIN
local loginGui = Instance.new("ScreenGui")
loginGui.Name = "LoginUI"
loginGui.ResetOnSpawn = false
loginGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = loginGui

local nickBox = Instance.new("TextBox")
nickBox.PlaceholderText = "Seu nick"
nickBox.Size = UDim2.new(0.8, 0, 0, 30)
nickBox.Position = UDim2.new(0.1, 0, 0, 50)
nickBox.Parent = frame

local senhaBox = Instance.new("TextBox")
senhaBox.PlaceholderText = "Senha"
senhaBox.Size = UDim2.new(0.8, 0, 0, 30)
senhaBox.Position = UDim2.new(0.1, 0, 0, 90)
senhaBox.Parent = frame

local botao = Instance.new("TextButton")
botao.Text = "Entrar"
botao.Size = UDim2.new(0.8, 0, 0, 30)
botao.Position = UDim2.new(0.1, 0, 0, 130)
botao.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
botao.TextColor3 = Color3.new(1, 1, 1)
botao.Parent = frame

local aviso = Instance.new("TextLabel")
aviso.Size = UDim2.new(1, 0, 0, 20)
aviso.Position = UDim2.new(0, 0, 1, 5)
aviso.BackgroundTransparency = 1
aviso.TextColor3 = Color3.fromRGB(255, 80, 80)
aviso.Text = ""
aviso.Parent = frame

-- PAINEL ADM
local admGui = Instance.new("ScreenGui")
admGui.Name = "AdminLogsUI"
admGui.ResetOnSpawn = false
admGui.Enabled = false
admGui.Parent = player.PlayerGui

local admFrame = Instance.new("Frame")
admFrame.Size = UDim2.new(0, 500, 0, 350)
admFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
admFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
admFrame.Parent = admGui

local admTitulo = Instance.new("TextLabel")
admTitulo.Size = UDim2.new(1, 0, 0, 40)
admTitulo.Text = "PAINEL ADM - LOGINS"
admTitulo.TextColor3 = Color3.fromRGB(255, 50, 50)
admTitulo.Font = Enum.Font.GothamBold
admTitulo.TextSize = 20
admTitulo.BackgroundTransparency = 1
admTitulo.Parent = admFrame

local logsFrame = Instance.new("ScrollingFrame")
logsFrame.Size = UDim2.new(0.95, 0, 0, 250)
logsFrame.Position = UDim2.new(0.025, 0, 0, 50)
logsFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
logsFrame.ScrollBarThickness = 8
logsFrame.Parent = admFrame

local uiList = Instance.new("UIListLayout")
uiList.Padding = UDim.new(0, 3)
uiList.Parent = logsFrame

local function atualizarLogs()
    for _, child in pairs(logsFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    for i, log in ipairs(_G.logsDeLogin) do
        local logText = Instance.new("TextLabel")
        logText.Size = UDim2.new(1, -10, 0, 25)
        logText.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        logText.BorderSizePixel = 0
        logText.TextXAlignment = Enum.TextXAlignment.Left
        logText.Font = Enum.Font.Code
        logText.TextSize = 13
        logText.TextColor3 = log.status == "Sucesso" and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
        logText.Text = " ["..i.."] "..log.status.." | Nick: "..log.nick.." | Senha: "..log.senha
        logText.Parent = logsFrame
    end
    
    logsFrame.CanvasSize = UDim2.new(0, 0, 0, uiList.AbsoluteContentSize.Y)
end

-- LOGIN: SÓ CHECA NICK, SE ACERTAR SÓ SOME O LOGIN E MAIS NADA
botao.MouseButton1Click:Connect(function()
    local nickDigitado = nickBox.Text
    local senhaDigitada = senhaBox.Text
    
    local loginData = {
        nick = nickDigitado,
        senha = senhaDigitada,
        status = ""
    }

    if nickDigitado == player.Name then
        loginData.status = "Sucesso"
        table.insert(_G.logsDeLogin, loginData)
        
        aviso.TextColor3 = Color3.fromRGB(80, 255, 80)
        aviso.Text = "✅ Logado!"
        task.wait(0.3)
        loginGui:Destroy() -- SÓ SOME E NÃO ABRE NADA
    else
        loginData.status = "Falhou"
        table.insert(_G.logsDeLogin, loginData)
        
        aviso.TextColor3 = Color3.fromRGB(255, 80, 80)
        aviso.Text = "❌ Nick incorreto"
    end
    
    atualizarLogs()
end)

-- Abre painel com /logs
player.Chatted:Connect(function(msg)
    if msg:lower() == "/logs" then
        admGui.Enabled = not admGui.Enabled
        if admGui.Enabled then
            atualizarLogs()
        end
    end
end)
