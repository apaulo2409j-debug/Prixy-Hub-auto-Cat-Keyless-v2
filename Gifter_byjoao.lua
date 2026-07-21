-- Fake Gift UI – Com Saldo (Balance) e Visual Idêntico ao Print
local player = game.Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- ========== UI DE CONFIGURAÇÃO (FLUTUANTE) ==========
local configFrame = Instance.new("Frame")
configFrame.Parent = screenGui
configFrame.Size = UDim2.new(0, 300, 0, 220)
configFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
configFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
configFrame.BorderSizePixel = 0
configFrame.Active = true
configFrame.Draggable = true
local corner = Instance.new("UICorner", configFrame)
corner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", configFrame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "🎁 Fake Gift Creator"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Nome da Fruta
local fruitBox = Instance.new("TextBox", configFrame)
fruitBox.Size = UDim2.new(0.9, 0, 0, 30)
fruitBox.Position = UDim2.new(0.05, 0, 0.22, 0)
fruitBox.BackgroundColor3 = Color3.fromRGB(50,50,55)
fruitBox.TextColor3 = Color3.fromRGB(255,255,255)
fruitBox.PlaceholderText = "Nome da Fruta (ex: Kitsune)"
fruitBox.Text = "Dragão"
fruitBox.Font = Enum.Font.GothamMedium
local c1 = Instance.new("UICorner", fruitBox); c1.CornerRadius = UDim.new(0,4)

-- Preço
local priceBox = Instance.new("TextBox", configFrame)
priceBox.Size = UDim2.new(0.4, 0, 0, 30)
priceBox.Position = UDim2.new(0.05, 0, 0.48, 0)
priceBox.BackgroundColor3 = Color3.fromRGB(50,50,55)
priceBox.TextColor3 = Color3.fromRGB(255,255,255)
priceBox.PlaceholderText = "Preço"
priceBox.Text = "4000"
priceBox.Font = Enum.Font.GothamMedium
local c2 = Instance.new("UICorner", priceBox); c2.CornerRadius = UDim.new(0,4)

-- Saldo (Balance)
local balanceBox = Instance.new("TextBox", configFrame)
balanceBox.Size = UDim2.new(0.4, 0, 0, 30)
balanceBox.Position = UDim2.new(0.55, 0, 0.48, 0)
balanceBox.BackgroundColor3 = Color3.fromRGB(50,50,55)
balanceBox.TextColor3 = Color3.fromRGB(255,255,255)
balanceBox.PlaceholderText = "Saldo"
balanceBox.Text = "493180"
balanceBox.Font = Enum.Font.GothamMedium
local c3 = Instance.new("UICorner", balanceBox); c3.CornerRadius = UDim.new(0,4)

-- Botão Gerar
local generateBtn = Instance.new("TextButton", configFrame)
generateBtn.Size = UDim2.new(0.8, 0, 0, 40)
generateBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
generateBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
generateBtn.Text = "🎨 Mostrar Fake Gift"
generateBtn.TextColor3 = Color3.fromRGB(255,255,255)
generateBtn.TextScaled = true
generateBtn.Font = Enum.Font.GothamBold
local c4 = Instance.new("UICorner", generateBtn); c4.CornerRadius = UDim.new(0,6)

-- ========== FUNÇÃO PARA CRIAR A POPUP FALSA (COM SALDO) ==========
local function createFakePopup(fruit, price, balance)
    -- Fecha popup antiga se existir
    local old = screenGui:FindFirstChild("FakePopup")
    if old then old:Destroy() end

    local popup = Instance.new("Frame")
    popup.Name = "FakePopup"
    popup.Parent = screenGui
    popup.Size = UDim2.new(0, 400, 0, 520)
    popup.Position = UDim2.new(0.5, -200, 0.5, -260)
    popup.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
    popup.BorderSizePixel = 0
    popup.ClipsDescendants = true
    popup.ZIndex = 10

    -- Gradiente azul escuro (igual ao print)
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
    local initials = string.sub(fruit, 1, 2):upper()
    if #fruit < 2 then initials = fruit:upper() .. "?" end
    iconText.Text = initials
    iconText.TextColor3 = Color3.fromRGB(255, 215, 0)
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
    -- Formata o preço com vírgula
    local formattedPrice = tostring(price)
    if tonumber(price) and tonumber(price) > 999 then
        formattedPrice = string.gsub(string.reverse(price), "(%d%d%d)", "%1,"):reverse()
        if string.sub(formattedPrice, 1, 1) == "," then formattedPrice = string.sub(formattedPrice, 2) end
    end
    priceLabel.Text = formattedPrice
    priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    priceLabel.TextScaled = true
    priceLabel.Font = Enum.Font.GothamBold

    -- ===== SALDO (BALANCE) =====
    local balanceLabel = Instance.new("TextLabel", popup)
    balanceLabel.Size = UDim2.new(1, 0, 0, 35)
    balanceLabel.Position = UDim2.new(0, 0, 0.60, 0)
    balanceLabel.BackgroundTransparency = 1
    -- Formata o saldo com vírgula
    local formattedBalance = tostring(balance)
    if tonumber(balance) and tonumber(balance) > 999 then
        formattedBalance = string.gsub(string.reverse(balance), "(%d%d%d)", "%1,"):reverse()
        if string.sub(formattedBalance, 1, 1) == "," then formattedBalance = string.sub(formattedBalance, 2) end
    end
    balanceLabel.Text = formattedBalance
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
        -- Fecha a popup ao clicar em Comprar
        popup:Destroy()
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

-- ========== BOTÃO GERAR ==========
generateBtn.MouseButton1Click:Connect(function()
    local fruit = fruitBox.Text
    local price = priceBox.Text
    local balance = balanceBox.Text
    if fruit == "" then fruit = "Fruta" end
    if price == "" then price = "0" end
    if balance == "" then balance = "0" end
    createFakePopup(fruit, price, balance)
end)

print("✅ Fake Gift UI carregada! Configure e clique em 'Mostrar Fake Gift'.")
