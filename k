-- 191 Script
-- วางไว้ใน StarterPlayerScripts

local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════
-- SCREEN GUI
-- ═══════════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "191_Gui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- ═══════════════════════════════════════════════════════════════
-- FUNCTIONS
-- ═══════════════════════════════════════════════════════════════
local function MakeDraggable(handle, target)
    local dragging, dragInput, dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInput.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function NewFrame(props)
    local f = Instance.new("Frame")
    for k, v in pairs(props) do
        f[k] = v
    end
    return f
end

local function NewLabel(props)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Font = Enum.Font.GothamBold
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    for k, v in pairs(props) do
        l[k] = v
    end
    return l
end

local function NewButton(props)
    local b = Instance.new("TextButton")
    b.Font = Enum.Font.GothamBold
    b.AutoButtonColor = false
    for k, v in pairs(props) do
        b[k] = v
    end
    return b
end

local function AddCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 8)
    c.Parent = parent
    return c
end

local function AddStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(40, 40, 40)
    s.Thickness = thickness or 1
    s.Parent = parent
    return s
end

-- ═══════════════════════════════════════════════════════════════
-- TOGGLE BUTTON
-- ═══════════════════════════════════════════════════════════════
local ToggleBtn = NewFrame({
    Name = "ToggleBtn",
    Size = UDim2.new(0, 44, 0, 44),
    Position = UDim2.new(0, 30, 0, 30),
    BackgroundColor3 = Color3.fromRGB(18, 18, 18),
    BorderSizePixel = 0,
    Active = true,
    ZIndex = 10,
    Parent = ScreenGui,
})
AddCorner(ToggleBtn, 10)
AddStroke(ToggleBtn, Color3.fromRGB(50, 50, 50))

for i = 1, 3 do
    local line = NewFrame({
        Size = UDim2.new(0, 16, 0, 2),
        Position = UDim2.new(0.5, -8, 0, 10 + (i - 1) * 10),
        BackgroundColor3 = Color3.fromRGB(100, 100, 100),
        BorderSizePixel = 0,
        Parent = ToggleBtn,
    })
    AddCorner(line, 2)
end

MakeDraggable(ToggleBtn, ToggleBtn)

-- ═══════════════════════════════════════════════════════════════
-- MAIN FRAME
-- ═══════════════════════════════════════════════════════════════
local MainFrame = NewFrame({
    Name = "MainFrame",
    Size = UDim2.new(0, 320, 0, 0),
    Position = UDim2.new(0, 30, 0, 90),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Visible = false,
    ZIndex = 5,
    Parent = ScreenGui,
})
AddCorner(MainFrame, 12)
AddStroke(MainFrame, Color3.fromRGB(35, 35, 35))

-- Title Bar
local TitleBar = NewFrame({
    Name = "TitleBar",
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = Color3.fromRGB(10, 10, 10),
    BorderSizePixel = 0,
    ZIndex = 6,
    Parent = MainFrame,
})

local dotColors = { Color3.fromRGB(60, 20, 20), Color3.fromRGB(60, 50, 10), Color3.fromRGB(20, 55, 20) }
for i, col in ipairs(dotColors) do
    local d = NewFrame({
        Size = UDim2.new(0, 9, 0, 9),
        Position = UDim2.new(0, 10 + (i - 1) * 16, 0.5, -4),
        BackgroundColor3 = col,
        BorderSizePixel = 0,
        ZIndex = 7,
        Parent = TitleBar,
    })
    AddCorner(d, 99)
end

local TitleText = NewLabel({
    Size = UDim2.new(1, 0, 1, 0),
    Text = "191",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    Font = Enum.Font.GothamBlack,
    ZIndex = 7,
    Parent = TitleBar,
})

local TitleDiv = NewFrame({
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    ZIndex = 7,
    Parent = TitleBar,
})

MakeDraggable(TitleBar, MainFrame)

-- Tab Bar
local TabBar = NewFrame({
    Name = "TabBar",
    Size = UDim2.new(1, 0, 0, 38),
    Position = UDim2.new(0, 0, 0, 42),
    BackgroundColor3 = Color3.fromRGB(6, 6, 6),
    BorderSizePixel = 0,
    ZIndex = 6,
    Parent = MainFrame,
})

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabBar

-- Content Area
local ContentArea = NewFrame({
    Name = "ContentArea",
    Size = UDim2.new(1, 0, 1, -80),
    Position = UDim2.new(0, 0, 0, 80),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    ZIndex = 6,
    Parent = MainFrame,
})

-- ═══════════════════════════════════════════════════════════════
-- TAB SYSTEM
-- ═══════════════════════════════════════════════════════════════
local tabs = {}
local tabBtns = {}
local activeTab = nil
local C_WHITE = Color3.fromRGB(255, 255, 255)
local C_DIM = Color3.fromRGB(60, 60, 60)

local function SwitchTab(name)
    for n, page in pairs(tabs) do
        page.Visible = (n == name)
    end
    for n, btn in pairs(tabBtns) do
        if n == name then
            btn.TextColor3 = C_WHITE
            btn.BorderSizePixel = 0
            if btn:FindFirstChild("Underline") then
                btn.Underline.BackgroundColor3 = C_WHITE
            end
        else
            btn.TextColor3 = C_DIM
            if btn:FindFirstChild("Underline") then
                btn.Underline.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            end
        end
    end
    activeTab = name
end

local function AddTab(name, label)
    local btn = NewButton({
        Name = name .. "Btn",
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(6, 6, 6),
        BorderSizePixel = 0,
        Text = label,
        TextColor3 = C_DIM,
        TextSize = 12,
        ZIndex = 7,
        Parent = TabBar,
    })

    local underline = NewFrame({
        Name = "Underline",
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        ZIndex = 8,
        Parent = btn,
    })

    local page = NewFrame({
        Name = name .. "Page",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 6,
        Parent = ContentArea,
    })

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 8)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = page

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 12)
    pad.PaddingBottom = UDim.new(0, 12)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.Parent = page

    tabBtns[name] = btn
    tabs[name] = page

    btn.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)

    return page
end

local function MakeRow(parent, h)
    local row = NewFrame({
        Size = UDim2.new(1, 0, 0, h or 44),
        BackgroundColor3 = Color3.fromRGB(13, 13, 13),
        BorderSizePixel = 0,
        ZIndex = 7,
        Parent = parent,
    })
    AddCorner(row, 8)
    AddStroke(row, Color3.fromRGB(28, 28, 28))
    return row
end

-- ═══════════════════════════════════════════════════════════════
-- CREATE TABS
-- ═══════════════════════════════════════════════════════════════
local Page1 = AddTab("wiper", "ระบบ")
local Page2 = AddTab("credits", "เครดิต")

-- ═══════════════════════════════════════════════════════════════
-- PAGE 1 - WIPER SYSTEM
-- ═══════════════════════════════════════════════════════════════

-- Get Remote Events
local re1, re2
pcall(function()
    local repStorage = ReplicatedStorage:FindFirstChild("RE")
    if repStorage then
        re1 = repStorage:FindFirstChild("1Playe1rTrigge1rEven1t")
        re2 = repStorage:FindFirstChild("1Clea1rTool1s")
    end
end)

-- Row: Rate per second
local rateRow = MakeRow(Page1, 55)

NewLabel({
    Size = UDim2.new(0.6, 0, 0, 18),
    Position = UDim2.new(0, 10, 0, 8),
    Text = "เคลียร์ต่อวินาที",
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8,
    Parent = rateRow,
})

NewLabel({
    Size = UDim2.new(0.6, 0, 0, 14),
    Position = UDim2.new(0, 10, 0, 28),
    Text = "กรอกจำนวนครั้งที่เคลียร์ไอเทมครับไอเหี้ยโง่",
    TextSize = 10,
    TextColor3 = Color3.fromRGB(55, 55, 55),
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8,
    Parent = rateRow,
})

local RateBox = Instance.new("TextBox")
RateBox.Size = UDim2.new(0, 90, 0, 35)
RateBox.Position = UDim2.new(1, -100, 0.5, -17)
RateBox.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
RateBox.BorderSizePixel = 0
RateBox.Text = "10"
RateBox.PlaceholderText = "จำนวนครั้ง"
RateBox.TextColor3 = Color3.fromRGB(255, 255, 255)
RateBox.Font = Enum.Font.GothamBold
RateBox.TextSize = 14
RateBox.ClearTextOnFocus = false
RateBox.ZIndex = 9
RateBox.Parent = rateRow
AddCorner(RateBox, 6)
AddStroke(RateBox, Color3.fromRGB(35, 35, 35))

RateBox.FocusLost:Connect(function()
    local n = tonumber(RateBox.Text)
    if not n or n < 1 then
        n = 1
    end
    if n > 1000000 then
        n = 1000000
    end
    RateBox.Text = tostring(math.floor(n))
end)

-- Row: Status
local statusRow = MakeRow(Page1, 40)

local StatusDot = NewFrame({
    Size = UDim2.new(0, 10, 0, 10),
    Position = UDim2.new(0, 10, 0.5, -5),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BorderSizePixel = 0,
    ZIndex = 9,
    Parent = statusRow,
})
AddCorner(StatusDot, 99)

local StatusLabel = NewLabel({
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.new(0, 28, 0, 0),
    Text = "หยุดทำงาน",
    TextSize = 12,
    TextColor3 = Color3.fromRGB(60, 60, 60),
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9,
    Parent = statusRow,
})

-- Info Label (แสดงจำนวนที่กำลังเคลียร์)
local InfoLabel = NewLabel({
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 12, 1, -18),
    Text = "",
    TextSize = 9,
    TextColor3 = Color3.fromRGB(80, 80, 80),
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8,
    Parent = statusRow,
})

-- Main Action Button
local ActionBtn = NewButton({
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Color3.fromRGB(13, 13, 13),
    BorderSizePixel = 0,
    Text = "▶ เริ่มเคลียร์",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    ZIndex = 8,
    Parent = Page1,
})
AddCorner(ActionBtn, 8)
AddStroke(ActionBtn, Color3.fromRGB(35, 35, 35))

-- Row: Counter (จำนวนที่เคลียร์แล้ว)
local counterRow = MakeRow(Page1, 38)

local CounterLabel = NewLabel({
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    Text = "เคลียร์ไปแล้ว: 0 ครั้ง",
    TextSize = 11,
    TextColor3 = Color3.fromRGB(100, 100, 100),
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 8,
    Parent = counterRow,
})

-- ═══════════════════════════════════════════════════════════════
-- WIPER LOGIC
-- ═══════════════════════════════════════════════════════════════
local active = false
local clearLoop = nil
local clearCount = 0
local RED = Color3.fromRGB(180, 0, 0)
local RED_DIM = Color3.fromRGB(40, 0, 0)

local function ClearItems()
    if not re1 or not re2 then
        return
    end

    local clearedThisRound = 0
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local tool = p.Character:FindFirstChildOfClass("Tool")
            if tool then
                pcall(function()
                    re1:FireServer("AcceptedToolToServer", tool.Name, p)
                    re2:FireServer("ClearAllTools")
                    clearedThisRound = clearedThisRound + 1
                end)
            end
        end
    end
    
    if clearedThisRound > 0 then
        clearCount = clearCount + clearedThisRound
        CounterLabel.Text = "เคลียร์ไปแล้ว: " .. clearCount .. " ครั้ง"
    end
end

local function SetActive(state)
    active = state

    if active then
        ActionBtn.Text = "⏹ หยุดเคลียร์"
        ActionBtn.BackgroundColor3 = RED_DIM
        StatusDot.BackgroundColor3 = RED
        StatusLabel.Text = "กำลังเคลียร์..."
        StatusLabel.TextColor3 = RED
        
        local rate = tonumber(RateBox.Text) or 10
        if rate < 1 then rate = 1 end
        if rate > 1000000 then rate = 1000000 end
        
        InfoLabel.Text = "@ " .. rate .. " ครั้ง/วินาที"
        clearCount = 0
        CounterLabel.Text = "เคลียร์ไปแล้ว: 0 ครั้ง"
        
        local interval = 1 / rate
        
        clearLoop = task.spawn(function()
            while active do
                local startTime = tick()
                ClearItems()
                local elapsed = tick() - startTime
                local waitTime = interval - elapsed
                if waitTime > 0 then
                    task.wait(waitTime)
                else
                    task.wait(0)
                end
            end
        end)
    else
        ActionBtn.Text = "▶ เริ่มเคลียร์"
        ActionBtn.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
        StatusDot.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        StatusLabel.Text = "หยุดทำงาน"
        StatusLabel.TextColor3 = Color3.fromRGB(60, 60, 60)
        InfoLabel.Text = ""
        
        if clearLoop then
            task.cancel(clearLoop)
            clearLoop = nil
        end
    end
end

ActionBtn.MouseButton1Click:Connect(function()
    SetActive(not active)
end)

-- ═══════════════════════════════════════════════════════════════
-- PAGE 2 - CREDITS
-- ═══════════════════════════════════════════════════════════════
local creditBlock = MakeRow(Page2, 200)
creditBlock.Size = UDim2.new(1, 0, 0, 200)

NewLabel({
    Size = UDim2.new(1, 0, 0, 45),
    Position = UDim2.new(0, 0, 0, 15),
    Text = "191",
    TextSize = 32,
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    ZIndex = 8,
    Parent = creditBlock,
})

local cdiv = NewFrame({
    Size = UDim2.new(0.85, 0, 0, 1),
    Position = UDim2.new(0.075, 0, 0, 65),
    BackgroundColor3 = Color3.fromRGB(25, 25, 25),
    BorderSizePixel = 0,
    ZIndex = 8,
    Parent = creditBlock,
})

local creditData = {
    { "ผู้สร้าง", "191" },
    { "เวอร์ชัน", "v1.0.0" },
    { "ไซส์หำ", "ควยมั่ง56นะคับ" },
    { "อัพเดท", "1988" },
}

for i, item in ipairs(creditData) do
    NewLabel({
        Size = UDim2.new(0.5, 0, 0, 20),
        Position = UDim2.new(0, 12, 0, 70 + (i - 1) * 26),
        Text = item[1],
        TextSize = 11,
        TextColor3 = Color3.fromRGB(55, 55, 55),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 8,
        Parent = creditBlock,
    })
    NewLabel({
        Size = UDim2.new(0.5, 0, 0, 20),
        Position = UDim2.new(0.5, -12, 0, 70 + (i - 1) * 26),
        Text = item[2],
        TextSize = 11,
        TextColor3 = Color3.fromRGB(130, 130, 130),
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 8,
        Parent = creditBlock,
    })
end

-- ═══════════════════════════════════════════════════════════════
-- FOOTER
-- ═══════════════════════════════════════════════════════════════
local Footer = NewFrame({
    Name = "Footer",
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = Color3.fromRGB(6, 6, 6),
    BorderSizePixel = 0,
    ZIndex = 6,
    Parent = MainFrame,
})

NewLabel({
    Size = UDim2.new(0.5, 0, 1, 0),
    Position = UDim2.new(0, 12, 0, 0),
    Text = "191 Script",
    TextSize = 10,
    TextColor3 = Color3.fromRGB(35, 35, 35),
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 7,
    Parent = Footer,
})

NewLabel({
    Size = UDim2.new(0.5, 0, 1, 0),
    Position = UDim2.new(0.5, -12, 0, 0),
    Text = "191",
    TextSize = 10,
    TextColor3 = Color3.fromRGB(35, 35, 35),
    TextXAlignment = Enum.TextXAlignment.Right,
    ZIndex = 7,
    Parent = Footer,
})

-- Adjust MainFrame size
MainFrame.Size = UDim2.new(0, 320, 0, 320)
Footer.Position = UDim2.new(0, 0, 1, -32)
ContentArea.Size = UDim2.new(1, 0, 1, -112)

-- ═══════════════════════════════════════════════════════════════
-- TOGGLE UI (Button + Insert Key)
-- ═══════════════════════════════════════════════════════════════
local uiOpen = false

local function ToggleUI()
    uiOpen = not uiOpen
    MainFrame.Visible = uiOpen
    if uiOpen and not activeTab then
        SwitchTab("wiper")
    end
end

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        ToggleUI()
    end
end)

UserInput.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        ToggleUI()
    end
end)

-- Auto-select first tab
SwitchTab("wiper")
