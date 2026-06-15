local player = game.Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

if pGui:FindFirstChild("PrixyHub_Final") then
	pGui.PrixyHub_Final:Destroy()
end

local Hub = Instance.new("ScreenGui")
Hub.Name = "PrixyHub_Final"
Hub.Parent = pGui
Hub.ResetOnSpawn = false

local MainF = Instance.new("Frame", Hub)
MainF.BackgroundColor3 = Color3.fromRGB(18,18,18)
MainF.Position = UDim2.new(0.3, 0, 0.3, 0)
MainF.Size = UDim2.new(0, 360, 0, 200)
MainF.Active = true
MainF.Draggable = true

local cornerMain = Instance.new("UICorner")
cornerMain.CornerRadius = UDim.new(0, 10)
cornerMain.Parent = MainF

local Sidebar = Instance.new("Frame", MainF)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Sidebar.Size = UDim2.new(0, 90, 1, 0)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local TMain = Instance.new("TextButton", Sidebar)
TMain.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TMain.Position = UDim2.new(0.05, 0, 0.1, 0)
TMain.Size = UDim2.new(0, 80, 0, 35)
TMain.Font = Enum.Font.GothamBold
TMain.Text = "Auto Click"
TMain.TextColor3 = Color3.fromRGB(0, 170, 255)
TMain.TextSize = 11
Instance.new("UICorner", TMain).CornerRadius = UDim.new(0, 6)

local TConf = Instance.new("TextButton", Sidebar)
TConf.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TConf.Position = UDim2.new(0.05, 0, 0.32, 0)
TConf.Size = UDim2.new(0, 80, 0, 35)
TConf.Font = Enum.Font.GothamBold
TConf.Text = "Config"
TConf.TextColor3 = Color3.fromRGB(200, 200, 200)
TConf.TextSize = 11
Instance.new("UICorner", TConf).CornerRadius = UDim.new(0, 6)

local Cont = Instance.new("Frame", MainF)
Cont.BackgroundTransparency = 1
Cont.Position = UDim2.new(0.27, 0, 0, 0)
Cont.Size = UDim2.new(0.73, 0, 1, 0)

-- Elementos da Aba Auto Click
local Tog = Instance.new("TextButton", Cont)
Tog.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Tog.Position = UDim2.new(0.05, 0, 0.2, 0)
Tog.Size = UDim2.new(0, 240, 0, 45)
Tog.Font = Enum.Font.GothamBold
Tog.Text = "AUTO CLIQUE: DESLIGADO"
Tog.TextColor3 = Color3.fromRGB(255, 255, 255)
Tog.TextSize = 13
Instance.new("UICorner", Tog).CornerRadius = UDim.new(0, 8)

local Lb = Instance.new("TextLabel", Cont)
Lb.BackgroundTransparency = 1
Lb.Position = UDim2.new(0, 0, 0.55, 0)
Lb.Size = UDim2.new(1, 0, 0, 30)
Lb.Font = Enum.Font.Gotham
Lb.Text = "Status: Parado"
Lb.TextColor3 = Color3.fromRGB(150, 150, 150)
Lb.TextSize = 13

-- Elementos da Aba Config (Inputs de Texto Compactos)
local SpeedIn = Instance.new("TextBox", Cont)
SpeedIn.BackgroundColor3 = Color3.fromRGB(30,30,30)
SpeedIn.Position = UDim2.new(0.05, 0, 0.1, 0)
SpeedIn.Size = UDim2.new(0, 240, 0, 30)
SpeedIn.Font = Enum.Font.Gotham
SpeedIn.PlaceholderText = "Velocidade de Andar (Padrão: 16)"
SpeedIn.Text = ""
SpeedIn.TextColor3 = Color3.fromRGB(255,255,255)
SpeedIn.TextSize = 11
SpeedIn.Visible = false
Instance.new("UICorner", SpeedIn).CornerRadius = UDim.new(0, 6)

local JumpIn = Instance.new("TextBox", Cont)
JumpIn.BackgroundColor3 = Color3.fromRGB(30,30,30)
JumpIn.Position = UDim2.new(0.05, 0, 0.35, 0)
JumpIn.Size = UDim2.new(0, 240, 0, 30)
JumpIn.Font = Enum.Font.Gotham
JumpIn.PlaceholderText = "Altura do Pulo (Padrão: 50)"
JumpIn.Text = ""
JumpIn.TextColor3 = Color3.fromRGB(255,255,255)
JumpIn.TextSize = 11
JumpIn.Visible = false
Instance.new("UICorner", JumpIn).CornerRadius = UDim.new(0, 6)

local ClickDelayIn = Instance.new("TextBox", Cont)
ClickDelayIn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ClickDelayIn.Position = UDim2.new(0.05, 0, 0.6, 0)
ClickDelayIn.Size = UDim2.new(0, 240, 0, 30)
ClickDelayIn.Font = Enum.Font.Gotham
ClickDelayIn.PlaceholderText = "Delay do Clique em Segundos (Ex: 0.01)"
ClickDelayIn.Text = ""
ClickDelayIn.TextColor3 = Color3.fromRGB(255,255,255)
ClickDelayIn.TextSize = 11
ClickDelayIn.Visible = false
Instance.new("UICorner", ClickDelayIn).CornerRadius = UDim.new(0, 6)
local Mini = Instance.new("TextButton", Hub)
Mini.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Mini.Position = UDim2.new(0.05, 0, 0.1, 0)
Mini.Size = UDim2.new(0, 55, 0, 55)
Mini.Font = Enum.Font.GothamBold
Mini.Text = "Prixy"
Mini.TextColor3 = Color3.fromRGB(0, 170, 255)
Mini.TextSize = 13
Mini.Visible = false
Mini.Active = true
Mini.Draggable = true
Instance.new("UICorner", Mini).CornerRadius = UDim.new(0, 50)

-- Botões de Controle no Topo Direito (Igual aos Hacks Famosos)
local XB = Instance.new("TextButton", MainF)
XB.Size = UDim2.new(0, 20, 0, 20)
XB.Position = UDim2.new(0.93, 0, 0.03, 0)
XB.BackgroundTransparency = 1
XB.Text = "X"
XB.TextColor3 = Color3.fromRGB(255, 50, 50)
XB.Font = Enum.Font.GothamBold
XB.TextSize = 14

local MinusB = Instance.new("TextButton", MainF)
MinusB.Size = UDim2.new(0, 20, 0, 20)
MinusB.Position = UDim2.new(0.86, 0, 0.03, 0)
MinusB.BackgroundTransparency = 1
MinusB.Text = "—"
MinusB.TextColor3 = Color3.fromRGB(255, 200, 0)
MinusB.Font = Enum.Font.GothamBold
MinusB.TextSize = 14

-- Sistema de Fechar e Minimizar Superior
XB.MouseButton1Click:Connect(function()
	Hub:Destroy()
end)

MinusB.MouseButton1Click:Connect(function()
	MainF.Visible = false
	Mini.Visible = true
end)

Mini.MouseButton1Click:Connect(function()
	MainF.Visible = true
	Mini.Visible = false
end)

-- Alternador de Abas
TMain.MouseButton1Click:Connect(function()
	TMain.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TMain.TextColor3 = Color3.fromRGB(0, 170, 255)
	TConf.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	TConf.TextColor3 = Color3.fromRGB(200, 200, 200)
	Tog.Visible, Lb.Visible = true, true
	SpeedIn.Visible, JumpIn.Visible, ClickDelayIn.Visible = false, false, false
end)

TConf.MouseButton1Click:Connect(function()
	TConf.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TConf.TextColor3 = Color3.fromRGB(0, 170, 255)
	TMain.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	TMain.TextColor3 = Color3.fromRGB(200, 200, 200)
	Tog.Visible, Lb.Visible = false, false
	SpeedIn.Visible, JumpIn.Visible, ClickDelayIn.Visible = true, true, true
end)

-- Lógica de Configurações de Atributos do Jogador
SpeedIn.FocusLost:Connect(function()
	local val = tonumber(SpeedIn.Text)
	if val and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = val
	end
end)

JumpIn.FocusLost:Connect(function()
	local val = tonumber(JumpIn.Text)
	if val and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.JumpPower = val
		player.Character.Humanoid.UseJumpPower = true
	end
end)

-- Lógica Interna de Automação do Auto Clicker Gato
local auto = false
local gato = nil
local delayClique = 0.01

ClickDelayIn.FocusLost:Connect(function()
	local val = tonumber(ClickDelayIn.Text)
	if val then delayClique = val end
end)

local function acharGato()
	if gato and gato.Parent then return gato end
	for _, o in pairs(workspace:GetDescendants()) do
		if o:IsA("ClickDetector") then
			local n = string.lower(o.Parent.Name)
			if string.find(n,"cat") or string.find(n,"gato") or string.find(n,"leader") or string.find(n,"clic") then
				gato = o
				return o
			end
		end
	end
	return nil
end

local function loop(alvo)
	local cx = (getconnections and getconnections(alvo.MouseClick)) or {}
	while auto and alvo and alvo.Parent do
		if #cx > 0 then
			for _, c in pairs(cx) do c:Fire() end
		else
			fireclickdetector(alvo)
		end
		task.wait(delayClique)
	end
end

Tog.MouseButton1Click:Connect(function()
	auto = not auto
	if auto then
		Tog.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
		Tog.Text = "AUTO CLIQUE: LIGADO"
		Lb.Text = "Status: Procurando Alvo..."
		local tgt = acharGato()
		if tgt then
			Lb.Text = "Status: Metralhando com sucesso! 🔥"
			Lb.TextColor3 = Color3.fromRGB(0, 255, 120)
			task.spawn(loop, tgt)
			task.spawn(loop, tgt)
		else
			Lb.Text = "Status: Gato não encontrado."
			Lb.TextColor3 = Color3.fromRGB(255, 80, 80)
			auto = false
			Tog.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
			Tog.Text = "AUTO CLIQUE: DESLIGADO"
		end
	else
		Tog.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
		Tog.Text = "AUTO CLIQUE: DESLIGADO"
		Lb.Text = "Status: Parado"
		Lb.TextColor3 = Color3.fromRGB(150, 150, 150)
	end
end)
