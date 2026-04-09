-- ToolWiper_191.lua
-- Script by 191
-- วางใน StarterPlayerScripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

local re1 = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Playe1rTrigge1rEven1t")
local re2 = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s")

-- ================================================
-- ScreenGui
-- ================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ToolWiper_191"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = pGui

-- ================================================
-- Drag Helper
-- ================================================
local function makeDraggable(frame, handle)
	local dragging, dragStart, startPos = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

-- ================================================
-- Toggle Button
-- ================================================
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 46, 0, 46)
toggleBtn.Position = UDim2.new(0, 16, 0.5, -23)
toggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Text = "⚡"
toggleBtn.TextSize = 22
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 10
toggleBtn.Visible = false
toggleBtn.Parent = screenGui
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 9)
local tgStroke = Instance.new("UIStroke", toggleBtn)
tgStroke.Color = Color3.fromRGB(120, 0, 0)
tgStroke.Thickness = 1.5
makeDraggable(toggleBtn, toggleBtn)

-- ================================================
-- Main Frame  (480 x 340)
-- ================================================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 480, 0, 340)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)
local mfStroke = Instance.new("UIStroke", mainFrame)
mfStroke.Color = Color3.fromRGB(26, 26, 26)
mfStroke.Thickness = 1.5

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -46, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ TOOL WIPER — 191"
titleLabel.TextColor3 = Color3.fromRGB(180, 22, 22)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 12
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -31, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(110, 14, 14)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Text = "✕"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 11
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

makeDraggable(mainFrame, titleBar)

-- ================================================
-- LEFT PANEL  (188px wide)
-- ================================================
local leftPanel = Instance.new("Frame")
leftPanel.Size = UDim2.new(0, 188, 1, -36)
leftPanel.Position = UDim2.new(0, 0, 0, 36)
leftPanel.BackgroundTransparency = 1
leftPanel.Parent = mainFrame

-- divider
local div = Instance.new("Frame")
div.Size = UDim2.new(0, 1, 1, -36)
div.Position = UDim2.new(0, 188, 0, 36)
div.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
div.BorderSizePixel = 0
div.Parent = mainFrame

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -16, 0, 20)
statusLabel.Position = UDim2.new(0, 8, 0, 4)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "STATUS: ACTIVE ●"
statusLabel.TextColor3 = Color3.fromRGB(200, 30, 30)
statusLabel.Font = Enum.Font.Code
statusLabel.TextSize = 9
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = leftPanel

-- Main btn
local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(1, -14, 0, 32)
mainBtn.Position = UDim2.new(0, 7, 0, 27)
mainBtn.BackgroundColor3 = Color3.fromRGB(14, 0, 0)
mainBtn.TextColor3 = Color3.fromRGB(200, 44, 44)
mainBtn.Text = "⏹ หยุดทำงาน"
mainBtn.Font = Enum.Font.GothamBold
mainBtn.TextSize = 12
mainBtn.BorderSizePixel = 0
mainBtn.Parent = leftPanel
Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 6)
local mbStroke = Instance.new("UIStroke", mainBtn)
mbStroke.Color = Color3.fromRGB(80, 0, 0)
mbStroke.Thickness = 1.5

-- Counter
local counterLabel = Instance.new("TextLabel")
counterLabel.Size = UDim2.new(1, -14, 0, 16)
counterLabel.Position = UDim2.new(0, 7, 0, 64)
counterLabel.BackgroundTransparency = 1
counterLabel.Text = "WIPED: 0 TIMES"
counterLabel.TextColor3 = Color3.fromRGB(55, 18, 18)
counterLabel.Font = Enum.Font.Code
counterLabel.TextSize = 9
counterLabel.TextXAlignment = Enum.TextXAlignment.Left
counterLabel.Parent = leftPanel

-- Speed label
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -14, 0, 16)
speedLabel.Position = UDim2.new(0, 7, 0, 84)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "SPEED: 10 รอบ/วิ"
speedLabel.TextColor3 = Color3.fromRGB(80, 60, 20)
speedLabel.Font = Enum.Font.Code
speedLabel.TextSize = 9
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = leftPanel

-- Speed row
local speedRow = Instance.new("Frame")
speedRow.Size = UDim2.new(1, -14, 0, 26)
speedRow.Position = UDim2.new(0, 7, 0, 103)
speedRow.BackgroundTransparency = 1
speedRow.Parent = leftPanel

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 26, 1, 0)
speedMinus.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
speedMinus.TextColor3 = Color3.fromRGB(160, 120, 40)
speedMinus.Text = "−"
speedMinus.Font = Enum.Font.GothamBold
speedMinus.TextSize = 16
speedMinus.BorderSizePixel = 0
speedMinus.Parent = speedRow
Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 5)

local speedVal = Instance.new("TextLabel")
speedVal.Size = UDim2.new(1, -56, 1, 0)
speedVal.Position = UDim2.new(0, 30, 0, 0)
speedVal.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
speedVal.TextColor3 = Color3.fromRGB(200, 160, 50)
speedVal.Text = "10"
speedVal.Font = Enum.Font.GothamBold
speedVal.TextSize = 12
speedVal.BorderSizePixel = 0
speedVal.Parent = speedRow
Instance.new("UICorner", speedVal).CornerRadius = UDim.new(0, 5)

local speedPlus = Instance.new("TextButton")
speedPlus.Size = UDim2.new(0, 26, 1, 0)
speedPlus.Position = UDim2.new(1, -26, 0, 0)
speedPlus.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
speedPlus.TextColor3 = Color3.fromRGB(160, 120, 40)
speedPlus.Text = "+"
speedPlus.Font = Enum.Font.GothamBold
speedPlus.TextSize = 16
speedPlus.BorderSizePixel = 0
speedPlus.Parent = speedRow
Instance.new("UICorner", speedPlus).CornerRadius = UDim.new(0, 5)

-- sep
local sep = Instance.new("Frame")
sep.Size = UDim2.new(1, -14, 0, 1)
sep.Position = UDim2.new(0, 7, 0, 134)
sep.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
sep.BorderSizePixel = 0
sep.Parent = leftPanel

-- List header
local listLabel = Instance.new("TextLabel")
listLabel.Size = UDim2.new(1, -14, 0, 14)
listLabel.Position = UDim2.new(0, 7, 0, 139)
listLabel.BackgroundTransparency = 1
listLabel.Text = "PLAYERS  (กดเพื่อ whitelist)"
listLabel.TextColor3 = Color3.fromRGB(44, 44, 44)
listLabel.Font = Enum.Font.Code
listLabel.TextSize = 8
listLabel.TextXAlignment = Enum.TextXAlignment.Left
listLabel.Parent = leftPanel

-- Scroll
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -182)
scrollFrame.Position = UDim2.new(0, 5, 0, 156)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 2
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(50, 0, 0)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = leftPanel
local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.Padding = UDim.new(0, 3)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
Instance.new("UIPadding", scrollFrame).PaddingTop = UDim.new(0, 3)

-- Credits left
local creditsLeft = Instance.new("TextLabel")
creditsLeft.Size = UDim2.new(1, -14, 0, 18)
creditsLeft.Position = UDim2.new(0, 7, 1, -20)
creditsLeft.BackgroundTransparency = 1
creditsLeft.Text = "SCRIPT BY  191"
creditsLeft.TextColor3 = Color3.fromRGB(44, 14, 14)
creditsLeft.Font = Enum.Font.Code
creditsLeft.TextSize = 8
creditsLeft.TextXAlignment = Enum.TextXAlignment.Left
creditsLeft.Parent = leftPanel

-- ================================================
-- RIGHT PANEL (Preview)
-- ================================================
local rightPanel = Instance.new("Frame")
rightPanel.Size = UDim2.new(1, -190, 1, -36)
rightPanel.Position = UDim2.new(0, 190, 0, 36)
rightPanel.BackgroundTransparency = 1
rightPanel.Parent = mainFrame

local previewBar = Instance.new("Frame")
previewBar.Size = UDim2.new(1, 0, 0, 30)
previewBar.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
previewBar.BorderSizePixel = 0
previewBar.Parent = rightPanel

local previewTitle = Instance.new("TextLabel")
previewTitle.Size = UDim2.new(1, -12, 1, 0)
previewTitle.Position = UDim2.new(0, 10, 0, 0)
previewTitle.BackgroundTransparency = 1
previewTitle.Text = "PREVIEW / —"
previewTitle.TextColor3 = Color3.fromRGB(160, 22, 22)
previewTitle.Font = Enum.Font.Code
previewTitle.TextSize = 10
previewTitle.TextXAlignment = Enum.TextXAlignment.Left
previewTitle.Parent = previewBar

-- Viewport
local viewportFrame = Instance.new("ViewportFrame")
viewportFrame.Size = UDim2.new(0, 80, 0, 80)
viewportFrame.Position = UDim2.new(0.5, -40, 0, 36)
viewportFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
viewportFrame.BorderSizePixel = 0
viewportFrame.LightColor = Color3.fromRGB(255, 200, 180)
viewportFrame.LightDirection = Vector3.new(-1, -2, -1)
viewportFrame.Parent = rightPanel
Instance.new("UICorner", viewportFrame).CornerRadius = UDim.new(0, 8)
local vpStroke = Instance.new("UIStroke", viewportFrame)
vpStroke.Color = Color3.fromRGB(22, 22, 22)
vpStroke.Thickness = 1

local vpLabel = Instance.new("TextLabel")
vpLabel.Size = UDim2.new(1, 0, 0, 12)
vpLabel.Position = UDim2.new(0, 0, 1, -13)
vpLabel.BackgroundTransparency = 1
vpLabel.Text = "3D PREVIEW"
vpLabel.TextColor3 = Color3.fromRGB(24, 24, 24)
vpLabel.Font = Enum.Font.Code
vpLabel.TextSize = 7
vpLabel.Parent = viewportFrame

-- Info rows
local function makeInfoRow(parent, key, yOff)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -14, 0, 22)
	row.Position = UDim2.new(0, 7, 0, yOff)
	row.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
	row.BorderSizePixel = 0
	row.Parent = parent
	Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)
	local k = Instance.new("TextLabel")
	k.Size = UDim2.new(0.44, 0, 1, 0)
	k.Position = UDim2.new(0, 7, 0, 0)
	k.BackgroundTransparency = 1
	k.Text = key
	k.TextColor3 = Color3.fromRGB(40, 40, 40)
	k.Font = Enum.Font.Code
	k.TextSize = 8
	k.TextXAlignment = Enum.TextXAlignment.Left
	k.Parent = row
	local v = Instance.new("TextLabel")
	v.Size = UDim2.new(0.56, -7, 1, 0)
	v.Position = UDim2.new(0.44, 0, 0, 0)
	v.BackgroundTransparency = 1
	v.Text = "—"
	v.TextColor3 = Color3.fromRGB(130, 130, 130)
	v.Font = Enum.Font.GothamBold
	v.TextSize = 9
	v.TextXAlignment = Enum.TextXAlignment.Right
	v.Parent = row
	return v
end

local iName   = makeInfoRow(rightPanel, "USERNAME", 124)
local iTool   = makeInfoRow(rightPanel, "TOOL",     150)
local iStatus = makeInfoRow(rightPanel, "STATUS",   176)
local iList   = makeInfoRow(rightPanel, "LIST",     202)

-- Wipe btn
local wipeBtn = Instance.new("TextButton")
wipeBtn.Size = UDim2.new(1, -14, 0, 34)
wipeBtn.Position = UDim2.new(0, 7, 0, 232)
wipeBtn.BackgroundColor3 = Color3.fromRGB(12, 0, 0)
wipeBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
wipeBtn.Text = "⚡ WIPE TOOL"
wipeBtn.Font = Enum.Font.GothamBold
wipeBtn.TextSize = 13
wipeBtn.BorderSizePixel = 0
wipeBtn.Parent = rightPanel
Instance.new("UICorner", wipeBtn).CornerRadius = UDim.new(0, 7)
local wbStroke = Instance.new("UIStroke", wipeBtn)
wbStroke.Color = Color3.fromRGB(80, 0, 0)
wbStroke.Thickness = 1.5

-- Notif
local notifLabel = Instance.new("TextLabel")
notifLabel.Size = UDim2.new(1, -14, 0, 20)
notifLabel.Position = UDim2.new(0, 7, 0, 272)
notifLabel.BackgroundColor3 = Color3.fromRGB(8, 26, 14)
notifLabel.BackgroundTransparency = 0.3
notifLabel.TextColor3 = Color3.fromRGB(44, 180, 88)
notifLabel.Text = ""
notifLabel.Font = Enum.Font.Code
notifLabel.TextSize = 9
notifLabel.BorderSizePixel = 0
notifLabel.Visible = false
notifLabel.Parent = rightPanel
Instance.new("UICorner", notifLabel).CornerRadius = UDim.new(0, 4)

local creditsRight = Instance.new("TextLabel")
creditsRight.Size = UDim2.new(1, -14, 0, 18)
creditsRight.Position = UDim2.new(0, 7, 1, -20)
creditsRight.BackgroundTransparency = 1
creditsRight.Text = "MADE BY 191"
creditsRight.TextColor3 = Color3.fromRGB(36, 12, 12)
creditsRight.Font = Enum.Font.Code
creditsRight.TextSize = 8
creditsRight.TextXAlignment = Enum.TextXAlignment.Right
creditsRight.Parent = rightPanel

-- ================================================
-- State
-- ================================================
local active = true
local wipeCount = 0
local speedRPS = 10
local whitelist = {}
local selectedPlayer = nil
local selectedTool = nil

-- ================================================
-- Helpers
-- ================================================
local function showNotif(msg)
	notifLabel.Text = "  ✅  " .. msg
	notifLabel.Visible = true
	task.delay(3.5, function() notifLabel.Visible = false end)
end

local function updatePreview(p, toolName)
	selectedPlayer = p
	selectedTool = toolName
	previewTitle.Text = "PREVIEW / " .. p.Name
	iName.Text = p.Name
	iName.TextColor3 = Color3.fromRGB(200, 40, 40)
	iTool.Text = toolName ~= "" and toolName or "ไม่มี"
	iTool.TextColor3 = Color3.fromRGB(180, 120, 20)
	iStatus.Text = toolName ~= "" and "ถืออยู่" or "ไม่ได้ถือ"
	iStatus.TextColor3 = toolName ~= "" and Color3.fromRGB(30, 130, 60) or Color3.fromRGB(80, 80, 80)
	local wl = whitelist[p.UserId]
	iList.Text = wl and "WHITELIST" or "BLACKLIST"
	iList.TextColor3 = wl and Color3.fromRGB(40, 180, 80) or Color3.fromRGB(200, 40, 40)

	viewportFrame:ClearAllChildren()
	Instance.new("UICorner", viewportFrame).CornerRadius = UDim.new(0, 8)
	vpLabel.Parent = viewportFrame
	pcall(function()
		local char = p.Character
		if not char then return end
		local clone = char:Clone()
		clone.Parent = viewportFrame
		local cam = Instance.new("Camera")
		cam.Parent = viewportFrame
		viewportFrame.CurrentCamera = cam
		local hrp = clone:FindFirstChild("HumanoidRootPart")
		if hrp then
			cam.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 1, 4), hrp.Position + Vector3.new(0, 1, 0))
		end
	end)
end

-- ================================================
-- Refresh player list
-- ================================================
local function refreshList()
	for _, c in ipairs(scrollFrame:GetChildren()) do
		if c:IsA("GuiObject") then c:Destroy() end
	end

	local i = 0
	for _, p in ipairs(Players:GetPlayers()) do
		if p == player then continue end
		i += 1
		local wl = whitelist[p.UserId] == true
		local tool = p.Character and p.Character:FindFirstChildOfClass("Tool")
		local toolName = tool and tool.Name or ""

		local card = Instance.new("TextButton")
		card.Size = UDim2.new(1, -4, 0, 36)
		card.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
		card.Text = ""
		card.BorderSizePixel = 0
		card.LayoutOrder = i
		card.Parent = scrollFrame
		Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
		local cs = Instance.new("UIStroke", card)
		cs.Color = wl and Color3.fromRGB(0, 50, 20) or Color3.fromRGB(50, 0, 0)
		cs.Thickness = 1

		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(0, 2, 0.5, 0)
		bar.Position = UDim2.new(0, 0, 0.25, 0)
		bar.BackgroundColor3 = wl and Color3.fromRGB(40, 180, 80) or Color3.fromRGB(180, 30, 30)
		bar.BorderSizePixel = 0
		bar.Parent = card
		Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 2)

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1, -68, 0, 18)
		nameLabel.Position = UDim2.new(0, 10, 0, 4)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = p.Name
		nameLabel.TextColor3 = wl and Color3.fromRGB(44, 200, 88) or Color3.fromRGB(200, 44, 44)
		nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextSize = 10
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = card

		local tag = Instance.new("TextLabel")
		tag.Size = UDim2.new(0, 56, 0, 14)
		tag.Position = UDim2.new(1, -60, 0.5, -7)
		tag.BackgroundColor3 = wl and Color3.fromRGB(0, 22, 10) or Color3.fromRGB(20, 0, 0)
		tag.TextColor3 = wl and Color3.fromRGB(30, 150, 60) or Color3.fromRGB(150, 30, 30)
		tag.Text = wl and "✓ WHITE" or "✗ BLACK"
		tag.Font = Enum.Font.Code
		tag.TextSize = 8
		tag.BorderSizePixel = 0
		tag.Parent = card
		Instance.new("UICorner", tag).CornerRadius = UDim.new(0, 3)

		local subLabel = Instance.new("TextLabel")
		subLabel.Size = UDim2.new(1, -68, 0, 12)
		subLabel.Position = UDim2.new(0, 10, 0, 20)
		subLabel.BackgroundTransparency = 1
		subLabel.Text = toolName ~= "" and ("🔧 " .. toolName) or "ไม่มี tool"
		subLabel.TextColor3 = Color3.fromRGB(40, 40, 40)
		subLabel.Font = Enum.Font.Code
		subLabel.TextSize = 8
		subLabel.TextXAlignment = Enum.TextXAlignment.Left
		subLabel.Parent = card

		local captured = p
		local capturedTool = toolName
		card.MouseButton1Click:Connect(function()
			whitelist[captured.UserId] = not whitelist[captured.UserId]
			updatePreview(captured, capturedTool)
			task.defer(refreshList)
		end)
	end
end

-- ================================================
-- Speed control
-- ================================================
speedMinus.MouseButton1Click:Connect(function()
	speedRPS = math.max(1, speedRPS - 1)
	speedVal.Text = tostring(speedRPS)
	speedLabel.Text = "SPEED: " .. speedRPS .. " รอบ/วิ"
end)

speedPlus.MouseButton1Click:Connect(function()
	speedRPS = math.min(100, speedRPS + 1)
	speedVal.Text = tostring(speedRPS)
	speedLabel.Text = "SPEED: " .. speedRPS .. " รอบ/วิ"
end)

-- ================================================
-- Auto loop
-- ================================================
local function doWipe(p, toolName)
	pcall(function()
		re1:FireServer("AcceptedToolToServer", toolName, p)
		task.wait(0.05)
		re2:FireServer("ClearAllTools")
	end)
	wipeCount += 1
	counterLabel.Text = "WIPED: " .. wipeCount .. " TIMES"
	showNotif("WIPED " .. toolName .. " FROM " .. p.Name)
end

task.spawn(function()
	while true do
		local interval = 1 / math.max(1, speedRPS)
		if active then
			for _, p
