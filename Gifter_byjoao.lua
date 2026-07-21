-- Script para Delta Executor - Fake Gift UI (Apenas Visual / Prank)
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

-- ========== UI DE CONFIGURAÇÃO (Flutuante) ==========
local configFrame = Instance.new("Frame")
configFrame.Parent = screenGui
configFrame.Size = UDim2.new(0, 300, 0, 200)
configFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
configFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
configFrame.BorderSizePixel = 0
configFrame.Active = true
configFrame.Draggable = true
-- Arredondar
local corner1 = Instance.new("UICorner", configFrame)
corner1.CornerRadius = UDim.new(0, 8)

-- Título
local title = Instance.new("TextLabel", configFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "🛠️ Configurar Fake Gift"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Input Nome da Fruta
local fruitBox = Instance.new("TextBox", configFrame)
fruitBox.Size = UDim2.new(0.9, 0, 0, 30)
fruitBox.Position = UDim2.new(0.05, 0, 0.2, 0)
fruitBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
fruitBox.TextColor3 = Color3.fromRGB(255, 255, 255)
fruitBox.PlaceholderText = "Nome da Fruta (ex: Kitsune)"
fruitBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
fruitBox.Text = "Dragão"
fruitBox.Font = Enum.Font.GothamMedium
local corner2 = Instance.new("UICorner", fruitBox)
corner2.CornerRadius = UDim.new(0, 4)

-- Input Preço
local priceBox = Instance.new("TextBox", configFrame)
priceBox.Size = UDim2.new(0.4, 0, 0, 30)
priceBox.Position = UDim2.new(0.05, 0, 0.45, 0)
priceBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
priceBox.TextColor3 = Color3.fromRGB(255, 255, 255)
priceBox.PlaceholderText = "Preço"
priceBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
priceBox.Text = "4000"
priceBox.Font = Enum.Font.GothamMedium
local corner3 = Instance.new("UICorner", priceBox)
corner3.CornerRadius = UDim.new(0, 4)

-- Input Saldo (Robux)
local balanceBox = Instance.new("TextBox", configFrame)
balanceBox.Size = UDim2.new(0.4, 0, 0, 30)
balanceBox.Position = UDim2.new(0.55, 0, 0.45, 0)
balanceBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
balanceBox.TextColor3 = Color3.fromRGB(255, 255, 255)
balanceBox.PlaceholderText = "Saldo"
balanceBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
balanceBox.Text = "493180"
balanceBox.Font = Enum.Font.GothamMedium
local corner4 = Instance.new("UICorner", balanceBox)
corner4.CornerRadius = UDim.new(0, 4)

-- Botão Gerar Fake
local generateBtn = Instance.new("TextButton", configFrame)
generateBtn.Size = UDim2.new(0.8, 0, 0, 40)
generateBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
generateBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
generateBtn.Text = "🚀 Mostrar Fake Gift"
generateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
generateBtn.TextScaled = true
generateBtn.Font = Enum.Font.GothamBold
local corner5 = Instance.new("UICorner", generateBtn)
corner5.CornerRadius = UDim.new(0, 6)

-- ========== FUNÇÃO PARA CRIAR A POPUP FALSA ==========
local function createFakePopup(fruit, price, balance)
    -- Fecha a UI de configuração
    configFrame.Visible = false

    -- Frame principal (igual ao print)
    local popup = Instance.new("Frame")
    popup.Parent = screenGui
    popup.Size = UDim2.new(0, 400, 0, 520)
    popup.Position = UDim2.new(0.5, -200, 0.5, -260)
    popup.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    popup.BorderSizePixel = 0
    popup.ClipsDescendants = true
    local popupCorner = Instance.new("UICorner", popup)
    popupCorner.CornerRadius = UDim.new(0, 12)

    -- Gradiente de fundo (simulando o estilo Roblox)
    local gradient = Instance.new("UIGradient", popup)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
    })
    gradient.Rotation = 45

    -- ===== TOPO =====
    local topBar = Instance.new("Frame", popup)
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundTransparency = 1

    local topLabel = Instance.new("TextLabel", topBar)
    topLabel.Size = UDim2.new(1, -40, 1, 0)
    topLabel.Position = UDim2.new(0, 20, 0, 0)
    topLabel.BackgroundTransparency = 1
    topLabel.Text = "Buy item"
    topLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    topLabel.TextScaled = true
    topLabel.Font = Enum.Font.GothamBold
    topLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Botão Fechar (X)
    local closeBtn = Instance.new("TextButton", topBar)
    closeBtn.Size = UDim2.new(0, 40, 1, 0)
    closeBtn.Position = UDim2.new(1, -40, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.MouseButton1Click:Connect(function()
        popup:Destroy()
        configFrame.Visible = true
    end)

    -- ===== ÁREA DA FRUTA =====
    local fruitIconBg = Instance.new("Frame", popup)
    fruitIconBg.Size = UDim2.new(0, 100, 0, 100)
    fruitIconBg.Position = UDim2.new(0.5, -50, 0.15, 0)
    fruitIconBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    local fruitCorner = Instance.new("UICorner", fruitIconBg)
    fruitCorner.CornerRadius = UDim.new(1, 0) -- Círculo

    local fruitLabel = Instance.new("TextLabel", fruitIconBg)
    fruitLabel.Size = UDim2.new(1, 0, 1, 0)
    fruitLabel.BackgroundTransparency = 1
    fruitLabel.Text = string.sub(fruit, 1, 2):upper() -- Emoji/ícone genérico
    fruitLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    fruitLabel.TextScaled = true
    fruitLabel.Font = Enum.Font.GothamBold

    local fruitNameLabel = Instance.new("TextLabel", popup)
    fruitNameLabel.Size = UDim2.new(1, 0, 0, 40)
    fruitNameLabel.Position = UDim2.new(0, 0, 0.35, 0)
    fruitNameLabel.BackgroundTransparency = 1
    fruitNameLabel.Text = fruit
    fruitNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fruitNameLabel.TextScaled = true
    fruitNameLabel.Font = Enum.Font.GothamBold

    -- ===== PREÇO =====
    local priceLabel = Instance.new("TextLabel", popup)
    priceLabel.Size = UDim2.new(1, 0, 0, 50)
    priceLabel.Position = UDim2.new(0, 0, 0.47, 0)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = price
    priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    priceLabel.TextScaled = true
    priceLabel.Font = Enum.Font.GothamBold

    -- ===== SALDO =====
    local balanceLabel = Instance.new("TextLabel", popup)
    balanceLabel.Size = UDim2.new(1, 0, 0, 30)
    balanceLabel.Position = UDim2.new(0, 0, 0.60, 0)
    balanceLabel.BackgroundTransparency = 1
    balanceLabel.Text = balance
    balanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    balanceLabel.TextScaled = true
    balanceLabel.Font = Enum.Font.GothamMedium

    -- ===== BOTÃO BUY (falso) =====
    local buyBtn = Instance.new("TextButton", popup)
    buyBtn.Size = UDim2.new(0.8, 0, 0, 55)
    buyBtn.Position = UDim2.new(0.1, 0, 0.70, 0)
    buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    buyBtn.Text = "Buy"
    buyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    buyBtn.TextScaled = true
    buyBtn.Font = Enum.Font.GothamBold
    local buyCorner = Instance.new("UICorner", buyBtn)
    buyCorner.CornerRadius = UDim.new(0, 8)
    -- Simula efeito de hover/click visual
    buyBtn.MouseButton1Click:Connect(function()
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 60)
        task.wait(0.1)
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    end)

    -- ===== RODAPÉ (Get 10% off + NEW) =====
    local footer = Instance.new("Frame", popup)
    footer.Size = UDim2.new(1, 0, 0, 40)
    footer.Position = UDim2.new(0, 0, 1, -40)
    footer.BackgroundTransparency = 1

    local promoText = Instance.new("TextLabel", footer)
    promoText.Size = UDim2.new(0.7, 0, 1, 0)
    promoText.Position = UDim2.new(0.05, 0, 0, 0)
    promoText.BackgroundTransparency = 1
    promoText.Text = "Get 10% off with Roblox Plus"
    promoText.TextColor3 = Color3.fromRGB(180, 180, 180)
    promoText.TextScaled = true
    promoText.Font = Enum.Font.GothamMedium
    promoText.TextXAlignment = Enum.TextXAlignment.Left

    local newTag = Instance.new("TextLabel", footer)
    newTag.Size = UDim2.new(0, 50, 0, 20)
    newTag.Position = UDim2.new(0.8, 0, 0.1, 0)
    newTag.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    newTag.Text = "New"
    newTag.TextColor3 = Color3.fromRGB(255, 255, 255)
    newTag.TextScaled = true
    newTag.Font = Enum.Font.GothamBold
    local newCorner = Instance.new("UICorner", newTag)
    newCorner.CornerRadius = UDim.new(0, 4)

    -- Adiciona o "X" para fechar no canto inferior (opcional, mas o principal já tem)
end

-- ========== CONFIGURAR BOTÃO GERAR ==========
generateBtn.MouseButton1Click:Connect(function()
    local fruit = fruitBox.Text
    local price = priceBox.Text
    local balance = balanceBox.Text
    
    if fruit == "" then fruit = "Kitsune" end
    if price == "" then price = "4000" end
    if balance == "" then balance = "493180" end
    
    createFakePopup(fruit, price, balance)
end)

-- Mensagem no console
print("✅ Script Fake Gift carregado! Configure os valores e clique em 'Mostrar Fake Gift'.")
