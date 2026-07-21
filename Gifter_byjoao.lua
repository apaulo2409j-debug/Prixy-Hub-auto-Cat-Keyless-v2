-- Fake Gift com Interceptação do Botão "Comprar" e Detecção Automática da Fruta
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Variáveis de controle
local isHooking = false
local hookConnection = nil
local originalBuyButton = nil
local originalScreen = nil

-- Função para encontrar a tela de presente e o botão "Comprar"
local function findBuyButton()
    for _, gui in pairs(player.PlayerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            -- Procura por um botão com texto "Comprar" ou "Buy"
            local button = gui:FindFirstChild("Comprar", true)
            if button and button:IsA("TextButton") then
                originalScreen = gui
                return button
            end
            -- Procura em todos os descendentes
            for _, child in pairs(gui:GetDescendants()) do
                if child:IsA("TextButton") and (child.Text == "Comprar" or child.Text == "Buy") then
                    originalScreen = gui
                    return child
                end
            end
        end
    end
    return nil
end

-- Função para detectar o nome da fruta na tela
local function detectFruitName()
    if not originalScreen then return "Fruta" end
    -- Procura por um TextLabel ou TextButton que contenha um nome de fruta conhecido
    local fruitNames = {
        "Kitsune", "Dragon", "Leopard", "Dough", "Venom", "Spirit", 
        "Control", "Shadow", "Gravity", "Mammoth", "T-Rex", "Sound",
        "Pain", "Love", "Spider", "Rumble", "Magma", "Buddha",
        "Flame", "Ice", "Sand", "Dark", "Light", "Rubber",
        "Ghost", "Phoenix", "Blizzard", "Smoke", "Spring", "Chop",
        "Spin", "Falcon", "Diamond", "String", "Barrier", "Revive",
        "Door", "Paw", "Fruit"
    }
    for _, child in pairs(originalScreen:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            local text = child.Text
            for _, fruit in pairs(fruitNames) do
                if string.find(text, fruit) then
                    return fruit
                end
            end
        end
    end
    -- Se não encontrar, tenta pegar o texto de um título
    for _, child in pairs(originalScreen:GetDescendants()) do
        if child:IsA("TextLabel") and child.TextSize > 20 then
            return child.Text
        end
    end
    return "Fruta"
end

-- Função para criar a tela falsa (idêntica à do print)
local function createFakePopup(fruitName, price, balance)
    -- Fecha popup antiga se existir
    local old = screenGui:FindFirstChild("FakePopup")
    if old then old:Destroy() end

    -- Esconde a tela original (se existir) para não conflitar
    if originalScreen then
        originalScreen.Enabled = false
    end

    local popup = Instance.new("Frame")
    popup.Name = "FakePopup"
    popup.Parent = screenGui
    popup.Size = UDim2.new(0, 400, 0, 520)
    popup.Position = UDim2.new(0.5, -200, 0.5, -260)
    popup.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
    popup.BorderSizePixel = 0
    popup.ClipsDescendants = true
    popup.ZIndex = 20

    -- Gradiente azul escuro
    local gradient = Instance.new("UIGradient", popup)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 50, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 18, 28))
    })
    gradient.Rotation = 90

    local popupCorner = Instance.new("UICorner", popup)
    popupCorner.CornerRadius = UDim.new(0, 12)

    -- Borda sutil
    local border = Instance.new("UIStroke", popup)
    border.Color = Color3.fromRGB(70, 80, 120)
    border.Thickness = 1

    -- ===== TOPO =====
    local topBar = Instance.new("Frame", popup)
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.BackgroundTransparency = 1

    local topLabel = Instance.new("TextLabel", topBar)
    topLabel.Size = UDim2.new(1, -55, 1, 0)
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
        -- Reativa a tela original
        if originalScreen then
            originalScreen.Enabled = true
        end
    end)

    -- ===== ÍCONE DA FRUTA (CÍRCULO) =====
    local iconBg = Instance.new("Frame", popup)
    iconBg.Size = UDim2.new(0, 100, 0, 100)
    iconBg.Position = UDim2.new(0.5, -50, 0.18, 0)
    iconBg.BackgroundColor3 = Color3.fromRGB(60, 55, 80)
    local iconCorner = Instance.new("UICorner", iconBg)
    iconCorner.CornerRadius = UDim.new(1, 0)

    local iconText = Instance.new("TextLabel", iconBg)
    iconText.Size = UDim2.new(1, 0, 1, 0)
    iconText.BackgroundTransparency = 1
    local initials = string.sub(fruitName, 1, 2):upper()
    if #fruitName < 2 then initials = fruitName:upper() .. "?" end
    iconText.Text = initials
    iconText.TextColor3 = Color3.fromRGB(255, 215, 0)
    iconText.TextScaled = true
    iconText.Font = Enum.Font.GothamBold

    -- ===== NOME DA FRUTA =====
    local fruitNameLabel = Instance.new("TextLabel", popup)
    fruitNameLabel.Size = UDim2.new(1, 0, 0, 45)
    fruitNameLabel.Position = UDim2.new(0, 0, 0.38, 0)
    fruitNameLabel.BackgroundTransparency = 1
    fruitNameLabel.Text = fruitName
    fruitNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    fruitNameLabel.TextScaled = true
    fruitNameLabel.Font = Enum.Font.GothamBold

    -- ===== PREÇO =====
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
    buyBtn.MouseButton1Click:Connect(function()
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 60)
        task.wait(0.15)
        buyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
        -- Ao clicar em "Comprar" na tela falsa, pode fechar ou mostrar uma mensagem
        popup:Destroy()
        if originalScreen then
            originalScreen.Enabled = true
        end
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

-- ========== UI DE ATIVAÇÃO (FLUTUANTE) ==========
local configFrame = Instance.new("Frame")
configFrame.Parent = screenGui
configFrame.Size = UDim2.new(0, 280, 0, 150)
configFrame.Position = UDim2.new(0.5, -140, 0.5, -75)
configFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
configFrame.BorderSizePixel = 0
configFrame.Active = true
configFrame.Draggable = true
local corner = Instance.new("UICorner", configFrame)
corner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", configFrame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "🎁 Fake Gift Activator"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local statusLabel = Instance.new("TextLabel", configFrame)
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0.3, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "❌ Aguardando..."
statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamMedium

local toggleBtn = Instance.new("TextButton", configFrame)
toggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
toggleBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleBtn.Text = "🔵 Ativar Interceptação"
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
local c5 = Instance.new("UICorner", toggleBtn); c5.CornerRadius = UDim.new(0,6)

-- ========== LÓGICA DE INTERCEPTAÇÃO ==========
local function toggleIntercept(enable)
    if enable then
        if hookConnection then hookConnection:Disconnect() hookConnection = nil end

        local button = findBuyButton()
        if not button then
            statusLabel.Text = "❌ Abra a tela de presente primeiro!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            toggleBtn.Text = "🔵 Ativar Interceptação"
            isHooking = false
            return
        end

        originalBuyButton = button

        hookConnection = button.MouseButton1Click:Connect(function()
            -- Detecta a fruta e valores
            local fruit = detectFruitName()
            local price = "4,000"  -- fixo, mas você pode tentar detectar
            local balance = "493,180" -- fixo
            createFakePopup(fruit, price, balance)
        end)

        isHooking = true
        statusLabel.Text = "✅ Interceptação ATIVA! Clique em 'Comprar'."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        toggleBtn.Text = "🔴 Desativar Interceptação"
    else
        if hookConnection then
            hookConnection:Disconnect()
            hookConnection = nil
        end
        isHooking = false
        statusLabel.Text = "❌ Interceptação desativada"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        toggleBtn.Text = "🔵 Ativar Interceptação"
        -- Reativa a tela original se estiver escondida
        if originalScreen then
            originalScreen.Enabled = true
        end
    end
end

toggleBtn.MouseButton1Click:Connect(function()
    if isHooking then
        toggleIntercept(false)
    else
        toggleIntercept(true)
    end
end)

print("✅ Fake Gift com Interceptação carregado! Abra a tela de presente, ative e clique em 'Comprar'.")
