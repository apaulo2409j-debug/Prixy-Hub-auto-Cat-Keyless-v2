-- Script para Delta - Fake Gift com Interceptação do Botão REAL "Comprar"
local player = game.Players.LocalPlayer
local guiService = game:GetService("GuiService")
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")

-- ========== VARIAVEIS GLOBAIS ==========
local fruitName = "Dragao"
local priceValue = "4000"
local balanceValue = "493180"
local isHooking = false
local hookConnection = nil
local realButton = nil

-- ========== CRIAR UI DE CONFIGURAÇÃO (FLUTUANTE) ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local configFrame = Instance.new("Frame")
configFrame.Parent = screenGui
configFrame.Size = UDim2.new(0, 280, 0, 240)
configFrame.Position = UDim2.new(0.5, -140, 0.5, -120)
configFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
configFrame.BorderSizePixel = 0
configFrame.Active = true
configFrame.Draggable = true
local corner1 = Instance.new("UICorner", configFrame)
corner1.CornerRadius = UDim.new(0, 10)

-- Título
local title = Instance.new("TextLabel", configFrame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "⚙️ Configurar Fake Gift"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Input Nome
local fruitBox = Instance.new("TextBox", configFrame)
fruitBox.Size = UDim2.new(0.9, 0, 0, 30)
fruitBox.Position = UDim2.new(0.05, 0, 0.2, 0)
fruitBox.BackgroundColor3 = Color3.fromRGB(50,50,55)
fruitBox.TextColor3 = Color3.fromRGB(255,255,255)
fruitBox.PlaceholderText = "Nome (ex: Kitsune)"
fruitBox.Text = "Dragao"
fruitBox.Font = Enum.Font.GothamMedium
local c2 = Instance.new("UICorner", fruitBox); c2.CornerRadius = UDim.new(0,4)

-- Input Preço
local priceBox = Instance.new("TextBox", configFrame)
priceBox.Size = UDim2.new(0.4, 0, 0, 30)
priceBox.Position = UDim2.new(0.05, 0, 0.45, 0)
priceBox.BackgroundColor3 = Color3.fromRGB(50,50,55)
priceBox.TextColor3 = Color3.fromRGB(255,255,255)
priceBox.PlaceholderText = "Preço"
priceBox.Text = "4000"
priceBox.Font = Enum.Font.GothamMedium
local c3 = Instance.new("UICorner", priceBox); c3.CornerRadius = UDim.new(0,4)

-- Input Saldo
local balanceBox = Instance.new("TextBox", configFrame)
balanceBox.Size = UDim2.new(0.4, 0, 0, 30)
balanceBox.Position = UDim2.new(0.55, 0, 0.45, 0)
balanceBox.BackgroundColor3 = Color3.fromRGB(50,50,55)
balanceBox.TextColor3 = Color3.fromRGB(255,255,255)
balanceBox.PlaceholderText = "Saldo"
balanceBox.Text = "493180"
balanceBox.Font = Enum.Font.GothamMedium
local c4 = Instance.new("UICorner", balanceBox); c4.CornerRadius = UDim.new(0,4)

-- Botão Ativar/Desativar Interceptação
local toggleBtn = Instance.new("TextButton", configFrame)
toggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
toggleBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleBtn.Text = "🔵 Ativar Captura"
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
local c5 = Instance.new("UICorner", toggleBtn); c5.CornerRadius = UDim.new(0,6)

-- Status
local statusLabel = Instance.new("TextLabel", configFrame)
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0.9, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "❌ Aguardando..."
statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamMedium

-- Atualizar valores quando digitar
fruitBox:GetPropertyChangedSignal("Text"):Connect(function() fruitName = fruitBox.Text end)
priceBox:GetPropertyChangedSignal("Text"):Connect(function() priceValue = priceBox.Text end)
balanceBox:GetPropertyChangedSignal("Text"):Connect(function() balanceValue = balanceBox.Text end)

-- ========== FUNÇÃO: CRIAR POPUP FALSA (ESTILO ROBLOX AZUL) ==========
local function createFakePopup(fruit, price, balance)
    -- Fecha se já existir uma
    local old = screenGui:FindFirstChild("FakePopup")
    if old then old:Destroy() end

    local popup = Instance.new("Frame")
    popup.Name = "FakePopup"
    popup.Parent = screenGui
    popup.Size = UDim2.new(0, 380, 0, 500)
    popup.Position = UDim2.new(0.5, -190, 0.5, -250)
    popup.BackgroundColor3 = Color3.fromRGB(22, 24, 35) -- Azul escuro Roblox
    popup.BorderSizePixel = 0
    popup.ClipsDescendants = true
    popup.ZIndex = 10
    
    -- Sombra/brilho (gradiente azul)
    local gradient = Instance.new("UIGradient", popup)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 50, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 20, 30))
    })
    gradient.Rotation = 90

    local popupCorner = Instance.new("UICorner", popup)
    popupCorner.CornerRadius = UDim.new(0, 12)

    -- Borda sutil
    local border = Instance.new("UIStroke", popup)
    border.Color = Color3.fromRGB(60, 70, 100)
    border.Thickness = 1

    -- ===== TOPO =====
    local topBar = Instance.new("Frame", popup)
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.BackgroundTransparency = 1

    local topLabel = Instance.new("TextLabel", topBar)
    topLabel.Size = UDim2.new(1, -50, 1, 0)
    topLabel.Position = UDim2.new(0, 20, 0, 0)
    topLabel.BackgroundTransparency = 1
    topLabel.Text = "Buy item"
    topLabel.TextColor3 = Color3.fromRGB(255,255,255)
    topLabel.TextScaled = true
    topLabel.Font = Enum.Font.GothamBold
    topLabel.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0, 45, 1, 0)
    closeBtn.Position = UDim2.new(1, -45, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(200,200,200)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.MouseButton1Click:Connect(function()
        popup:Destroy()
    end)

    -- ===== ÍCONE DA FRUTA (CÍRCULO) =====
    local iconBg = Instance.new("Frame", popup)
    iconBg.Size = UDim2.new(0, 90, 0, 90)
    iconBg.Position = UDim2.new(0.5, -45, 0.18, 0)
    iconBg.BackgroundColor3 = Color3.fromRGB(55, 50, 70) -- Fundo do ícone
    local iconCorner = Instance.new("UICorner", iconBg)
    iconCorner.CornerRadius = UDim.new(1, 0)

    local iconText = Instance.new("TextLabel", iconBg)
    iconText.Size = UDim2.new(1, 0, 1, 0)
    iconText.BackgroundTransparency = 1
    local initials = string.sub(fruit, 1, 2):upper()
    if #fruit < 2 then initials = fruit:upper() .. "?" end
    iconText.Text = initials
    iconText.TextColor3 = Color3.fromRGB(255, 215, 0) -- Dourado
    iconText.TextScaled = true
    iconText.Font = Enum.Font.GothamBold

    -- ===== NOME DA FRUTA =====
    local fruitNameLabel = Instance.new("TextLabel", popup)
    fruitNameLabel.Size = UDim2.new(1, 0, 0, 45)
    fruitNameLabel.Position = UDim2.new(0, 0, 0.38, 0)
    fruitNameLabel.BackgroundTransparency = 1
    fruitNameLabel.Text = fruit
    fruitNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    fruitNameLabel.TextScaled = true
    fruitNameLabel.Font = Enum.Font.GothamBold

    -- ===== PREÇO (DOURADO) =====
    local priceLabel = Instance.new("TextLabel", popup)
    priceLabel.Size = UDim2.new(1, 0, 0, 50)
    priceLabel.Position = UDim2.new(0, 0, 0.48, 0)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = price
    priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    priceLabel.TextScaled = true
    priceLabel.Font = Enum.Font.GothamBold

    -- ===== SALDO =====
    local balanceLabel = Instance.new("TextLabel", popup)
    balanceLabel.Size = UDim2.new(1, 0, 0, 35)
    balanceLabel.Position = UDim2.new(0, 0, 0.60, 0)
    balanceLabel.BackgroundTransparency = 1
    balanceLabel.Text = balance
    balanceLabel.TextColor3 = Color3.fromRGB(200, 210, 230)
    balanceLabel.TextScaled = true
    balanceLabel.Font = Enum.Font.GothamMedium

    -- ===== BOTÃO COMPRAR (VERDE) =====
    local buyBtn = Instance.new("TextButton", popup)
    buyBtn.Size = UDim2.new(0.8, 0, 0, 55)
    buyBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    buyBtn.Text = "Comprar"
    buyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    buyBtn.TextScaled = true
    buyBtn.Font = Enum.Font.GothamBold
    local buyCorner = Instance.new("UICorner", buyBtn); buyCorner.CornerRadius = UDim.new(0,8)
    -- Efeito visual ao clicar
    buyBtn.MouseButton1Click:Connect(function()
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 60)
        task.wait(0.15)
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    end)

    -- ===== RODAPÉ =====
    local footer = Instance.new("Frame", popup)
    footer.Size = UDim2.new(1, 0, 0, 40)
    footer.Position = UDim2.new(0, 0, 1, -40)
    footer.BackgroundTransparency = 1

    local promo = Instance.new("TextLabel", footer)
    promo.Size = UDim2.new(0.7, 0, 1, 0)
    promo.Position = UDim2.new(0.05, 0, 0, 0)
    promo.BackgroundTransparency = 1
    promo.Text = "Get 10% off with Roblox Plus"
    promo.TextColor3 = Color3.fromRGB(180, 180, 200)
    promo.TextScaled = true
    promo.Font = Enum.Font.GothamMedium
    promo.TextXAlignment = Enum.TextXAlignment.Left

    local newTag = Instance.new("Frame", footer)
    newTag.Size = UDim2.new(0, 45, 0, 22)
    newTag.Position = UDim2.new(0.78, 0, 0.1, 0)
    newTag.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    local tagCorner = Instance.new("UICorner", newTag); tagCorner.CornerRadius = UDim.new(0,4)
    local tagText = Instance.new("TextLabel", newTag)
    tagText.Size = UDim2.new(1,0,1,0)
    tagText.BackgroundTransparency = 1
    tagText.Text = "New"
    tagText.TextColor3 = Color3.fromRGB(255,255,255)
    tagText.TextScaled = true
    tagText.Font = Enum.Font.GothamBold
end

-- ========== FUNÇÃO: PROCURAR BOTÃO REAL "COMPRAR" ==========
local function findRealBuyButton()
    for _, gui in pairs(player.PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            -- Procura recursivamente por TextButton com texto "Comprar" ou "Buy"
            local button = gui:FindFirstChild("Comprar", true)
            if button and button:IsA("TextButton") then
                return button
            end
            local button2 = gui:FindFirstChild("Buy", true)
            if button2 and button2:IsA("TextButton") then
                return button2
            end
            -- Em alguns casos, o texto está dentro de um TextLabel filho
            for _, child in pairs(gui:GetDescendants()) do
                if child:IsA("TextButton") and (child.Text == "Comprar" or child.Text == "Buy") then
                    return child
                end
            end
        end
    end
    return nil
end

-- ========== LÓGICA DE ATIVAÇÃO ==========
local function toggleHook(enable)
    if enable then
        if hookConnection then hookConnection:Disconnect() hookConnection = nil end
        
        realButton = findRealBuyButton()
        if not realButton then
            statusLabel.Text = "❌ Abra o menu de presente primeiro!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            toggleBtn.Text = "🔵 Ativar Captura"
            isHooking = false
            return
        end

        -- Intercepta o clique do botão real
        hookConnection = realButton.MouseButton1Click:Connect(function()
            -- Atualiza os dados dos inputs
            fruitName = fruitBox.Text
            priceValue = priceBox.Text
            balanceValue = balanceBox.Text
            if fruitName == "" then fruitName = "Fruta" end
            if priceValue == "" then priceValue = "0" end
            if balanceValue == "" then balanceValue = "0" end
            
            -- Mostra a popup fake
            createFakePopup(fruitName, priceValue, balanceValue)
            
            -- Opcional: dá um feedback visual no botão real
            realButton.BackgroundColor3 = Color3.fromRGB(0, 150, 60)
            task.wait(0.1)
            realButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- ou a cor original
        end)

        isHooking = true
        statusLabel.Text = "✅ CAPTURA ATIVA! Clique em 'Comprar' no jogo."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleBtn.Text = "🔴 Desativar Captura"
        
    else
        if hookConnection then
            hookConnection:Disconnect()
            hookConnection = nil
        end
        isHooking = false
        statusLabel.Text = "❌ Captura desativada"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        toggleBtn.Text = "🔵 Ativar Captura"
    end
end

-- ========== BOTÃO DE ATIVAÇÃO ==========
toggleBtn.MouseButton1Click:Connect(function()
    if isHooking then
        toggleHook(false)
    else
        toggleHook(true)
    end
end)

print("✅ Script Fake Gift com Interceptação carregado! Ative a captura e clique em 'Comprar' no jogo.")
