-- Script para Delta - Fake Gift com Detecção Automática e Imagem
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local isHooking = false
local hookConnection = nil

-- ========== UI DE CONFIGURAÇÃO ==========
local configFrame = Instance.new("Frame")
configFrame.Parent = screenGui
configFrame.Size = UDim2.new(0, 280, 0, 150)
configFrame.Position = UDim2.new(0.5, -140, 0.5, -75)
configFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
configFrame.BorderSizePixel = 0
configFrame.Active = true
configFrame.Draggable = true
local corner1 = Instance.new("UICorner", configFrame)
corner1.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", configFrame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "⚙️ Fake Gift - Auto Detect"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local statusLabel = Instance.new("TextLabel", configFrame)
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0.3, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "❌ Aguardando ativação..."
statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamMedium

local toggleBtn = Instance.new("TextButton", configFrame)
toggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
toggleBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
toggleBtn.Text = "🔵 Ativar Captura"
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.GothamBold
local c5 = Instance.new("UICorner", toggleBtn); c5.CornerRadius = UDim.new(0,6)

-- ========== FUNÇÃO PARA DETECTAR A FRUTA ==========
local function detectFruit()
    -- Tenta encontrar o nome da fruta na tela de compra
    local playerGui = player.PlayerGui
    for _, gui in pairs(playerGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, child in pairs(gui:GetDescendants()) do
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    local text = child.Text
                    -- Lista de frutas conhecidas (adicione mais se necessário)
                    local fruits = {"Kitsune", "Dragon", "Leopard", "Dough", "Venom", "Spirit", "Control", "Shadow", "Gravity", "Mammoth", "T-Rex", "Sound", "Pain", "Love", "Spider", "Rumble", "Magma", "Buddha", "Flame", "Ice", "Sand", "Dark", "Light", "Rubber", "Ghost", "Phoenix", "Blizzard", "Smoke", "Spring", "Chop", "Spin", "Falcon", "Diamond", "String", "Barrier", "Revive", "Door", "Paw", "Fruit"}
                    for _, fruit in pairs(fruits) do
                        if string.find(text, fruit) then
                            return fruit
                        end
                    end
                end
            end
        end
    end
    return nil
end

-- ========== FUNÇÃO: CRIAR POPUP FALSA COM IMAGEM ==========
local function createFakePopup(fruit)
    if not fruit then fruit = "Fruta" end
    
    -- Fecha popup antiga se existir
    local old = screenGui:FindFirstChild("FakePopup")
    if old then old:Destroy() end

    local popup = Instance.new("Frame")
    popup.Name = "FakePopup"
    popup.Parent = screenGui
    popup.Size = UDim2.new(0, 380, 0, 500)
    popup.Position = UDim2.new(0.5, -190, 0.5, -250)
    popup.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
    popup.BorderSizePixel = 0
    popup.ClipsDescendants = true
    popup.ZIndex = 10
    
    local gradient = Instance.new("UIGradient", popup)
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 50, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 20, 30))
    })
    gradient.Rotation = 90

    local popupCorner = Instance.new("UICorner", popup)
    popupCorner.CornerRadius = UDim.new(0, 12)

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

    -- ===== ÍCONE DA FRUTA (IMAGEM) =====
    local iconBg = Instance.new("Frame", popup)
    iconBg.Size = UDim2.new(0, 90, 0, 90)
    iconBg.Position = UDim2.new(0.5, -45, 0.18, 0)
    iconBg.BackgroundColor3 = Color3.fromRGB(55, 50, 70)
    local iconCorner = Instance.new("UICorner", iconBg)
    iconCorner.CornerRadius = UDim.new(1, 0)

    -- Tenta carregar a imagem da fruta (você pode substituir a URL)
    local imageLabel = Instance.new("ImageLabel", iconBg)
    imageLabel.Size = UDim2.new(0.8, 0, 0.8, 0)
    imageLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
    imageLabel.BackgroundTransparency = 1
    -- URL genérica para ícone de fruta (substitua por uma melhor se encontrar)
    imageLabel.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=123456789&width=90&height=90"
    -- Caso a imagem não carregue, mostra as iniciais
    local iconText = Instance.new("TextLabel", iconBg)
    iconText.Size = UDim2.new(1, 0, 1, 0)
    iconText.BackgroundTransparency = 1
    iconText.Text = string.sub(fruit, 1, 2):upper()
    iconText.TextColor3 = Color3.fromRGB(255, 215, 0)
    iconText.TextScaled = true
    iconText.Font = Enum.Font.GothamBold
    iconText.Visible = false -- Escondido por padrão, aparece se a imagem falhar

    imageLabel:GetPropertyChangedSignal("Image"):Connect(function()
        if imageLabel.Image == "" then
            iconText.Visible = true
        end
    end)

    -- ===== NOME DA FRUTA =====
    local fruitNameLabel = Instance.new("TextLabel", popup)
    fruitNameLabel.Size = UDim2.new(1, 0, 0, 45)
    fruitNameLabel.Position = UDim2.new(0, 0, 0.38, 0)
    fruitNameLabel.BackgroundTransparency = 1
    fruitNameLabel.Text = fruit
    fruitNameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    fruitNameLabel.TextScaled = true
    fruitNameLabel.Font = Enum.Font.GothamBold

    -- ===== PREÇO (fixo em 4000 para exemplo) =====
    local priceLabel = Instance.new("TextLabel", popup)
    priceLabel.Size = UDim2.new(1, 0, 0, 50)
    priceLabel.Position = UDim2.new(0, 0, 0.48, 0)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = "4,000"
    priceLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    priceLabel.TextScaled = true
    priceLabel.Font = Enum.Font.GothamBold

    -- ===== SALDO (fixo em 493180 para exemplo) =====
    local balanceLabel = Instance.new("TextLabel", popup)
    balanceLabel.Size = UDim2.new(1, 0, 0, 35)
    balanceLabel.Position = UDim2.new(0, 0, 0.60, 0)
    balanceLabel.BackgroundTransparency = 1
    balanceLabel.Text = "493,180"
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
        
        local realButton = findRealBuyButton()
        if not realButton then
            statusLabel.Text = "❌ Abra o menu de presente primeiro!"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            toggleBtn.Text = "🔵 Ativar Captura"
            isHooking = false
            return
        end

        hookConnection = realButton.MouseButton1Click:Connect(function()
            local fruit = detectFruit()
            if fruit then
                createFakePopup(fruit)
            else
                -- Se não detectar, mostra uma mensagem
                statusLabel.Text = "⚠️ Fruta não detectada! Tente novamente."
                statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                -- Mostra popup genérica
                createFakePopup("Fruta")
            end
        end)

        isHooking = true
        statusLabel.Text = "✅ CAPTURA ATIVA! Clique em 'Comprar'."
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

toggleBtn.MouseButton1Click:Connect(function()
    if isHooking then
        toggleHook(false)
    else
        toggleHook(true)
    end
end)

print("✅ Script Fake Gift com Detecção Automática carregado!")
