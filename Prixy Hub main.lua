getgenv().JOAO_SCRIPT_LOADED = true
local FILE = "data.txt"
local NAME = "JOAO SCRIPT"
local R = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local K = "H7T2joaokey9VL4MN"
local T = {72, 55, 84, 50, 106, 111, 97, 111, 107, 101, 121, 57, 86, 76, 52, 77, 78}
local D = 60
local currentKey = ""
local Window = nil

local function check(k)
    if #k ~= 17 then return false end
    for i = 1, 17 do
        if string.byte(k, i) ~= T[i] then return false end
    end
    return true
end

local function save(k, e)
    writefile(FILE, k.. "|".. tostring(e))
end

local function load()
    if isfile(FILE) and readfile(FILE) ~= "" then
        local d = readfile(FILE)
        local k, e = d:match("(.+)|(.+)")
        if k and e and tonumber(e) then
            return k, tonumber(e)
        end
    end
    return nil, nil
end

local function formatTime(s)
    if s <= 0 then return "Expirado" end
    local m = math.floor(s / 60)
    local s = s % 60
    return string.format("%dm %ds", m, s)
end

task.spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
                if (v:IsA("TextLabel") or v:IsA("TextButton")) and string.find(v.Text, "3TN") then
                    v.Text = NAME
                    v.TextColor3 = Color3.fromRGB(0, 170, 255)
                end
            end
        end)
    end)
end)

local function createStatusUI(k, e)
    -- DESTRÓI JANELA ANTIGA
    pcall(function()
        for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
            if v.Name == "Rayfield" then v:Destroy() end
        end
    end)
    task.wait(0.3)

    -- CRIA SÓ A ABA STATUS
    Window = R:CreateWindow({Name = NAME, LoadingTitle = NAME, ConfigurationSaving = {Enabled = false}})
    local Tab = Window:CreateTab("Status", 4483362458)

    local TimeLabel = Tab:CreateParagraph({Title = "Validade", Content = formatTime(e - os.time())})
    local StatusLabel = Tab:CreateParagraph({Title = "Status", Content = "Script Ativo"})

    task.spawn(function()
        while task.wait(1) do
            local r = e - os.time()
            if r <= 0 then
                delfile(FILE)
                game.Players.LocalPlayer:Kick("Tempo expirado da key")
                break
            else
                TimeLabel:Set({Title = "Validade", Content = formatTime(r)})
            end
        end
    end)

    Config = {Team = "Pirates", FPS = 15, Configuration = { HopWhenIdle = true, AutoHop = true, AutoHopDelay = 3600, FpsBoost = false, blackscreen = false }, Fruit ={ Sniper = true, Fruit = {"Kitsune-Kitsune"} }, Items = { AutoFullyMelees = true, Saber = true, CursedDualKatana = true, SoulGuitar = true, RaceV2 = true }, Settings = { StayInSea2UntilHaveDarkFragments = false }}
    task.wait(1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sucvatthieunang/djtme/refs/heads/main/module"))()
end

-- CHECA SE JÁ TEM KEY VÁLIDA
local sk, et = load()
if sk and check(sk) and et and et > os.time() then
    createStatusUI(sk, et) -- ENTRA DIRETO NO STATUS COM TEMPO RESTANTE
    return
elseif sk then
    delfile(FILE)
end

-- SE NÃO TIVER KEY, MOSTRA SÓ A TELA DE KEY
Window = R:CreateWindow({
    Name = NAME.. " | Key System",
    LoadingTitle = "Aguardando Key...",
    LoadingSubtitle = "by JOAO SCRIPT",
    ConfigurationSaving = {Enabled = false}
})

local KeyTab = Window:CreateTab("Key", 4483362458)

KeyTab:CreateInput({
   Name = "Digite sua Key",
   PlaceholderText = "Cole a key aqui",
   RemoveTextAfterFocusLost = false,
   Callback = function(Value)
      currentKey = Value
   end,
})

KeyTab:CreateButton({
   Name = "Verificar Key",
   Callback = function()
      local InputKey = currentKey:gsub("%s+", "")
      if check(InputKey) then
         -- CHECA SE JÁ TEM TEMPO SALVO PRA ESSA KEY
         local sk, et = load()
         local expireTime

         if sk == InputKey and et and et > os.time() then
            expireTime = et -- USA O TEMPO QUE SOBROU
         else
            expireTime = os.time() + D -- CRIA NOVO
         end

         save(InputKey, expireTime) -- SALVA ANTES DE TUDO

         R:Notify({
            Title = "Key Correta",
            Content = "Ativando...",
            Duration = 1,
            Image = 4483362458
         })
         task.wait(0.5)
         createStatusUI(InputKey, expireTime) -- ATIVA DIRETO SEM REJOIN
      else
         R:Notify({
            Title = "Key Inválida",
            Content = "Essa key não funciona nesse script.",
            Duration = 3,
            Image = 4483362458
         })
         task.wait(1)
         game.Players.LocalPlayer:Kick("Key inválida")
      end
   end,
})
