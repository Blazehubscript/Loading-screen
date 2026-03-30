-- Loading Screen | Arena Terminal
-- Theme: Combat Arena / Battle Station
-- VERY SLOW progress (5-8 minutes to reach 96.2%)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Remove old if exists
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("ArenaTerminal") then
        game:GetService("CoreGui"):FindFirstChild("ArenaTerminal"):Destroy()
    end
end)
if LocalPlayer.PlayerGui:FindFirstChild("ArenaTerminal") then
    LocalPlayer.PlayerGui:FindFirstChild("ArenaTerminal"):Destroy()
end

-- ========== SCREENGUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArenaTerminal"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    ScreenGui.Parent = gethui()
elseif get_hidden_gui then
    ScreenGui.Parent = get_hidden_gui()
else
    ScreenGui.Parent = game:GetService("CoreGui")
end

-- ========== BACKGROUND (Arena / Battle Theme) ==========
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 5, 8) -- Dark blood/arena color
Background.BorderSizePixel = 0
Background.ZIndex = 1
Background.Parent = ScreenGui

-- Blood drip effect (top)
local BloodDrip = Instance.new("Frame")
BloodDrip.Size = UDim2.new(1, 0, 0, 80)
BloodDrip.Position = UDim2.new(0, 0, 0, 0)
BloodDrip.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
BloodDrip.BackgroundTransparency = 0.5
BloodDrip.ZIndex = 2
BloodDrip.Parent = Background

-- Arena lights (scanning beam)
local ArenaLight = Instance.new("Frame")
ArenaLight.Size = UDim2.new(0, 800, 0, 5)
ArenaLight.Position = UDim2.new(0.5, -400, 0.3, 0)
ArenaLight.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ArenaLight.BackgroundTransparency = 0.6
ArenaLight.Rotation = -15
ArenaLight.ZIndex = 2
ArenaLight.Parent = Background

-- Rotating arena light
task.spawn(function()
    local angle = -15
    while ScreenGui.Parent do
        angle = angle + 0.5
        if angle > 15 then angle = -15 end
        ArenaLight.Rotation = angle
        ArenaLight.BackgroundTransparency = 0.5 + math.sin(angle * 10) * 0.2
        task.wait(0.05)
    end
end)

-- Cage mesh effect (hexagonal pattern)
local CageOverlay = Instance.new("Frame")
CageOverlay.Size = UDim2.new(1, 0, 1, 0)
CageOverlay.BackgroundTransparency = 0.9
CageOverlay.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
CageOverlay.ZIndex = 2
CageOverlay.Parent = Background

-- ========== TERMINAL (Different Design - Horizontal Layout) ==========
local TerminalFrame = Instance.new("Frame")
TerminalFrame.Size = UDim2.new(0, 800, 0, 500)
TerminalFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
TerminalFrame.BackgroundColor3 = Color3.fromRGB(8, 6, 12)
TerminalFrame.BackgroundTransparency = 0.15
TerminalFrame.BorderSizePixel = 2
TerminalFrame.BorderColor3 = Color3.fromRGB(200, 50, 50)
TerminalFrame.ZIndex = 3
TerminalFrame.Parent = Background

local TerminalCorner = Instance.new("UICorner", TerminalFrame)
TerminalCorner.CornerRadius = UDim.new(0, 5)

-- ========== TERMINAL HEADER (Arena Style) ==========
local TerminalHeader = Instance.new("Frame")
TerminalHeader.Size = UDim2.new(1, 0, 0, 35)
TerminalHeader.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
TerminalHeader.BorderSizePixel = 0
TerminalHeader.ZIndex = 4
TerminalHeader.Parent = TerminalFrame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, -20, 1, 0)
HeaderText.Position = UDim2.new(0, 10, 0, 0)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "> ARENA_COMBAT_TERMINAL [v3.0] <"
HeaderText.TextColor3 = Color3.fromRGB(255, 80, 80)
HeaderText.TextSize = 14
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextXAlignment = Enum.TextXAlignment.Left
HeaderText.ZIndex = 4
HeaderText.Parent = TerminalHeader

local HeaderStatus = Instance.new("TextLabel")
HeaderStatus.Size = UDim2.new(0, 100, 1, 0)
HeaderStatus.Position = UDim2.new(1, -110, 0, 0)
HeaderStatus.BackgroundTransparency = 1
HeaderStatus.Text = "> ONLINE"
HeaderStatus.TextColor3 = Color3.fromRGB(80, 255, 80)
HeaderStatus.TextSize = 11
HeaderStatus.Font = Enum.Font.Gotham
HeaderStatus.TextXAlignment = Enum.TextXAlignment.Right
HeaderStatus.ZIndex = 4
HeaderStatus.Parent = TerminalHeader

-- Blink ONLINE status
task.spawn(function()
    while ScreenGui.Parent do
        HeaderStatus.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.wait(0.8)
        HeaderStatus.TextColor3 = Color3.fromRGB(30, 100, 30)
        task.wait(0.4)
    end
end)

-- ========== LEFT PANEL (Fighter Info) ==========
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 180, 1, -45)
LeftPanel.Position = UDim2.new(0, 10, 0, 45)
LeftPanel.BackgroundColor3 = Color3.fromRGB(10, 8, 15)
LeftPanel.BackgroundTransparency = 0.4
LeftPanel.BorderSizePixel = 1
LeftPanel.BorderColor3 = Color3.fromRGB(150, 40, 40)
LeftPanel.ZIndex = 3
LeftPanel.Parent = TerminalFrame

local LeftCorner = Instance.new("UICorner", LeftPanel)
LeftCorner.CornerRadius = UDim.new(0, 3)

-- Fighter avatar / icon
local FighterIcon = Instance.new("TextLabel")
FighterIcon.Size = UDim2.new(0, 50, 0, 50)
FighterIcon.Position = UDim2.new(0.5, -25, 0, 15)
FighterIcon.BackgroundTransparency = 1
FighterIcon.Text = "⚔️"
FighterIcon.TextColor3 = Color3.fromRGB(255, 100, 100)
FighterIcon.TextSize = 40
FighterIcon.ZIndex = 4
FighterIcon.Parent = LeftPanel

local FighterName = Instance.new("TextLabel")
FighterName.Size = UDim2.new(1, -20, 0, 20)
FighterName.Position = UDim2.new(0, 10, 0, 75)
FighterName.BackgroundTransparency = 1
FighterName.Text = "> FIGHTER: " .. LocalPlayer.Name
FighterName.TextColor3 = Color3.fromRGB(255, 150, 150)
FighterName.TextSize = 11
FighterName.Font = Enum.Font.GothamBold
FighterName.ZIndex = 4
FighterName.Parent = LeftPanel

local FighterRank = Instance.new("TextLabel")
FighterRank.Size = UDim2.new(1, -20, 0, 16)
FighterRank.Position = UDim2.new(0, 10, 0, 98)
FighterRank.BackgroundTransparency = 1
FighterRank.Text = "> RANK: GLADIATOR"
FighterRank.TextColor3 = Color3.fromRGB(200, 200, 100)
FighterRank.TextSize = 10
FighterRank.Font = Enum.Font.Gotham
FighterRank.ZIndex = 4
FighterRank.Parent = LeftPanel

local FighterStats = Instance.new("TextLabel")
FighterStats.Size = UDim2.new(1, -20, 0, 60)
FighterStats.Position = UDim2.new(0, 10, 0, 125)
FighterStats.BackgroundTransparency = 1
FighterStats.Text = "> HP: ▰▰▰▰▰▰▰▰▰▰\n> MP: ▰▰▰▰▰▰▰▰▰▰\n> STAM: ▰▰▰▰▰▰▰▰▰▰"
FighterStats.TextColor3 = Color3.fromRGB(150, 150, 150)
FighterStats.TextSize = 9
FighterStats.Font = Enum.Font.Code
FighterStats.TextXAlignment = Enum.TextXAlignment.Left
FighterStats.TextYAlignment = Enum.TextYAlignment.Top
FighterStats.ZIndex = 4
FighterStats.Parent = LeftPanel

-- ========== RIGHT PANEL (Arena Info) ==========
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0, 180, 1, -45)
RightPanel.Position = UDim2.new(1, -190, 0, 45)
RightPanel.BackgroundColor3 = Color3.fromRGB(10, 8, 15)
RightPanel.BackgroundTransparency = 0.4
RightPanel.BorderSizePixel = 1
RightPanel.BorderColor3 = Color3.fromRGB(150, 40, 40)
RightPanel.ZIndex = 3
RightPanel.Parent = TerminalFrame

local RightCorner = Instance.new("UICorner", RightPanel)
RightCorner.CornerRadius = UDim.new(0, 3)

local ArenaTitle = Instance.new("TextLabel")
ArenaTitle.Size = UDim2.new(1, -20, 0, 20)
ArenaTitle.Position = UDim2.new(0, 10, 0, 10)
ArenaTitle.BackgroundTransparency = 1
ArenaTitle.Text = "> ARENA STATUS"
ArenaTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
ArenaTitle.TextSize = 11
ArenaTitle.Font = Enum.Font.GothamBold
ArenaTitle.ZIndex = 4
ArenaTitle.Parent = RightPanel

local ArenaMap = Instance.new("TextLabel")
ArenaMap.Size = UDim2.new(1, -20, 0, 50)
ArenaMap.Position = UDim2.new(0, 10, 0, 35)
ArenaMap.BackgroundTransparency = 1
ArenaMap.Text = "> MAP: COLOSSEUM\n> MODE: 1v1 DEATHMATCH\n> SPECTATORS: 0"
ArenaMap.TextColor3 = Color3.fromRGB(150, 150, 150)
ArenaMap.TextSize = 9
ArenaMap.Font = Enum.Font.Code
ArenaMap.TextXAlignment = Enum.TextXAlignment.Left
ArenaMap.ZIndex = 4
ArenaMap.Parent = RightPanel

local MatchmakingText = Instance.new("TextLabel")
MatchmakingText.Size = UDim2.new(1, -20, 0, 30)
MatchmakingText.Position = UDim2.new(0, 10, 0, 95)
MatchmakingText.BackgroundTransparency = 1
MatchmakingText.Text = "> SEARCHING...\n> WAITING FOR SERVER"
MatchmakingText.TextColor3 = Color3.fromRGB(255, 200, 100)
MatchmakingText.TextSize = 9
MatchmakingText.Font = Enum.Font.Code
MatchmakingText.TextXAlignment = Enum.TextXAlignment.Left
MatchmakingText.ZIndex = 4
MatchmakingText.Parent = RightPanel

-- Blinking searching dots
task.spawn(function()
    local dots = 1
    while ScreenGui.Parent do
        dots = dots % 4 + 1
        MatchmakingText.Text = "> SEARCHING" .. string.rep(".", dots) .. "\n> WAITING FOR SERVER"
        task.wait(0.6)
    end
end)

-- ========== CENTER PANEL (TERMINAL LOGS - Different Layout) ==========
local LogPanel = Instance.new("Frame")
LogPanel.Size = UDim2.new(0, 390, 1, -45)
LogPanel.Position = UDim2.new(0.5, -195, 0, 45)
LogPanel.BackgroundColor3 = Color3.fromRGB(5, 3, 10)
LogPanel.BackgroundTransparency = 0.3
LogPanel.BorderSizePixel = 1
LogPanel.BorderColor3 = Color3.fromRGB(200, 50, 50)
LogPanel.ZIndex = 3
LogPanel.Parent = TerminalFrame

local LogCorner = Instance.new("UICorner", LogPanel)
LogCorner.CornerRadius = UDim.new(0, 3)

local LogTitle = Instance.new("TextLabel")
LogTitle.Size = UDim2.new(1, -20, 0, 22)
LogTitle.Position = UDim2.new(0, 10, 0, 5)
LogTitle.BackgroundTransparency = 1
LogTitle.Text = "> TERMINAL_LOG [ARENA_DEBUG]"
LogTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
LogTitle.TextSize = 10
LogTitle.Font = Enum.Font.GothamBold
LogTitle.TextXAlignment = Enum.TextXAlignment.Left
LogTitle.ZIndex = 4
LogTitle.Parent = LogPanel

local LogScrollFrame = Instance.new("ScrollingFrame")
LogScrollFrame.Size = UDim2.new(1, -20, 1, -35)
LogScrollFrame.Position = UDim2.new(0, 10, 0, 30)
LogScrollFrame.BackgroundTransparency = 1
LogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
LogScrollFrame.ScrollBarThickness = 6
LogScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)
LogScrollFrame.ZIndex = 4
LogScrollFrame.Parent = LogPanel

local LogListLayout = Instance.new("UIListLayout", LogScrollFrame)
LogListLayout.SortOrder = Enum.SortOrder.LayoutOrder
LogListLayout.Padding = UDim.new(0, 1)

local logLines = {}
local logIndex = 0

local logMessages = {
    {txt = "> [ARENA] Initializing combat system...",          color = Color3.fromRGB(255, 100, 100)},
    {txt = "> Loading fighter data...",                         color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Syncing with arena server...",                    color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Calibrating hit detection...",                    color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Loading weapon assets...",                        color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [SUCCESS] Combat engine loaded.",                 color = Color3.fromRGB(100, 255, 100)},
    {txt = "> Establishing P2P connection...",                  color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Verifying anti-cheat integrity...",               color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Loading arena map: COLOSSEUM...",                 color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [SUCCESS] Map data received.",                    color = Color3.fromRGB(100, 255, 100)},
    {txt = "> Waiting for opponent...",                         color = Color3.fromRGB(255, 200, 100)},
    {txt = "> Checking fighter rank eligibility...",            color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [WARNING] High latency detected",                 color = Color3.fromRGB(255, 150, 50)},
    {txt = "> Rerouting connection...",                         color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [SUCCESS] Connection stabilized.",                color = Color3.fromRGB(100, 255, 100)},
    {txt = "> Finalizing arena sync...",                        color = Color3.fromRGB(200, 150, 100)},
}

local function addLog(msg, color)
    logIndex = logIndex + 1
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, 0, 0, 14)
    line.BackgroundTransparency = 1
    line.Text = msg
    line.TextColor3 = color or Color3.fromRGB(200, 150, 100)
    line.TextSize = 10
    line.Font = Enum.Font.Code
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.LayoutOrder = logIndex
    line.ZIndex = 5
    line.Parent = LogScrollFrame

    table.insert(logLines, line)

    if #logLines > 18 then
        local old = table.remove(logLines, 1)
        old:Destroy()
    end
    
    -- Auto scroll to bottom
    LogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, logIndex * 15)
    task.wait(0.05)
    LogScrollFrame.CanvasPosition = Vector2.new(0, LogScrollFrame.CanvasSize.Y.Offset)
end

-- ========== PROGRESS BAR (Arena Style) ==========
local ProgressFrame = Instance.new("Frame")
ProgressFrame.Size = UDim2.new(1, -40, 0, 45)
ProgressFrame.Position = UDim2.new(0, 20, 1, -55)
ProgressFrame.BackgroundTransparency = 1
ProgressFrame.ZIndex = 4
ProgressFrame.Parent = TerminalFrame

local ProgressLabel = Instance.new("TextLabel")
ProgressLabel.Size = UDim2.new(0.3, -10, 1, 0)
ProgressLabel.Position = UDim2.new(0, 0, 0, 0)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Text = "> DEPLOYMENT:"
ProgressLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
ProgressLabel.TextSize = 11
ProgressLabel.Font = Enum.Font.GothamBold
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left
ProgressLabel.ZIndex = 4
ProgressLabel.Parent = ProgressFrame

local ProgressTrack = Instance.new("Frame")
ProgressTrack.Size = UDim2.new(0.7, 0, 0, 12)
ProgressTrack.Position = UDim2.new(0.3, 0, 0.3, 0)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
ProgressTrack.BorderSizePixel = 1
ProgressTrack.BorderColor3 = Color3.fromRGB(200, 50, 50)
ProgressTrack.ZIndex = 4
ProgressTrack.Parent = ProgressFrame

local TrackCorner = Instance.new("UICorner", ProgressTrack)
TrackCorner.CornerRadius = UDim.new(1, 0)

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
ProgressFill.BorderSizePixel = 0
ProgressFill.ZIndex = 5
ProgressFill.Parent = ProgressTrack

local FillCorner = Instance.new("UICorner", ProgressFill)
FillCorner.CornerRadius = UDim.new(1, 0)

local ProgressPercent = Instance.new("TextLabel")
ProgressPercent.Size = UDim2.new(0.3, -10, 1, 0)
ProgressPercent.Position = UDim2.new(1, 0, 0, 0)
ProgressPercent.BackgroundTransparency = 1
ProgressPercent.Text = "0%"
ProgressPercent.TextColor3 = Color3.fromRGB(255, 100, 100)
ProgressPercent.TextSize = 11
ProgressPercent.Font = Enum.Font.GothamBold
ProgressPercent.TextXAlignment = Enum.TextXAlignment.Right
ProgressPercent.ZIndex = 4
ProgressPercent.Parent = ProgressFrame

-- ========== BOTTOM STATUS ==========
local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, 0, 0, 22)
StatusBar.Position = UDim2.new(0, 0, 1, -22)
StatusBar.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
StatusBar.BorderSizePixel = 0
StatusBar.ZIndex = 4
StatusBar.Parent = TerminalFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 1, 0)
StatusText.Position = UDim2.new(0, 10, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "> ARENA_SYNC_ACTIVE | READY_TO_DEPLOY: FALSE | PROTOCOL: v3.0"
StatusText.TextColor3 = Color3.fromRGB(150, 100, 100)
StatusText.TextSize = 9
StatusText.Font = Enum.Font.Code
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.ZIndex = 4
StatusText.Parent = StatusBar

-- Update status text
task.spawn(function()
    local statuses = {
        "> ARENA_SYNC_ACTIVE | READY_TO_DEPLOY: FALSE | PROTOCOL: v3.0",
        "> WAITING_FOR_SERVER | PING: " .. math.random(50, 200) .. "ms",
        "> COMBAT_ENGINE: STANDBY | OPPONENT: NULL",
        "> ARENA_SYNC_ACTIVE | LOADING_ASSETS...",
    }
    local idx = 1
    while ScreenGui.Parent do
        StatusText.Text = statuses[idx % #statuses + 1]
        idx = idx + 1
        task.wait(3)
    end
end)

-- ========== INITIAL LOGS ==========
task.spawn(function()
    for _, log in ipairs(logMessages) do
        task.wait(math.random(4, 10) * 0.1) -- Slower log appearance
        addLog(log.txt, log.color)
    end
    -- Infinite loop of logs after initial
    while ScreenGui.Parent do
        for _, log in ipairs(logMessages) do
            task.wait(math.random(6, 14) * 0.1)
            addLog(log.txt, log.color)
        end
    end
end)

-- ========== VERY SLOW PROGRESS (Stops at 96.2%) ==========
local progress = 0

-- Progress steps with VERY SLOW speeds (slower than before)
local steps = {
    {target = 4.2,   speed = 2.5},
    {target = 9.5,   speed = 3.0},
    {target = 15.3,  speed = 3.5},
    {target = 21.8,  speed = 4.0},
    {target = 28.7,  speed = 4.5},
    {target = 36.1,  speed = 5.0},
    {target = 43.9,  speed = 5.5},
    {target = 51.4,  speed = 6.0},
    {target = 58.2,  speed = 6.5},
    {target = 64.8,  speed = 7.0},
    {target = 71.3,  speed = 7.5},
    {target = 77.5,  speed = 8.0},
    {target = 83.2,  speed = 8.5},
    {target = 88.6,  speed = 9.0},
    {target = 92.4,  speed = 9.5},
    {target = 95.1,  speed = 10.0},
    {target = 96.2,  speed = 12.0},
}

for _, step in ipairs(steps) do
    while progress < step.target do
        progress = math.min(progress + 0.08, step.target) -- Very slow increment
        ProgressFill:TweenSize(UDim2.new(progress / 100, 0, 1, 0), "Linear", nil, 0.1)
        ProgressPercent.Text = string.format("%.1f%%", progress)
        task.wait(step.speed * 0.08)
    end
    task.wait(step.speed * 0.5)
end

-- Stuck at 96.2% forever
ProgressPercent.Text = "96.2%"
ProgressPercent.TextColor3 = Color3.fromRGB(255, 200, 100)
StatusText.Text = "> DEPLOYMENT_STALLED | ERROR_CODE: 0x96 | CONTACT_SUPPORT"
addLog("> [ERROR] Deployment stalled at 96.2% - Check connection", Color3.fromRGB(255, 80, 80))

print("[ArenaTerminal] Loading stuck at 96.2%")

-- Blinking warning on stuck
task.spawn(function()
    local blink = false
    while ScreenGui.Parent do
        blink = not blink
        if blink then
            ProgressPercent.TextColor3 = Color3.fromRGB(255, 100, 100)
            StatusText.TextColor3 = Color3.fromRGB(255, 80, 80)
        else
            ProgressPercent.TextColor3 = Color3.fromRGB(255, 200, 100)
            StatusText.TextColor3 = Color3.fromRGB(150, 100, 100)
        end
        task.wait(0.8)
    end
end)        y = math.random() * 100,
        vx = (math.random() - 0.5) * 0.3,
        vy = (math.random() - 0.5) * 0.3,
        rot = math.random() * 360,
        rotSpeed = (math.random() - 0.5) * 2
    })
end

task.spawn(function()
    while ScreenGui.Parent do
        for _, p in ipairs(particles) do
            p.x = p.x + p.vx
            p.y = p.y + p.vy
            
            if p.x < -5 then p.x = 105 end
            if p.x > 105 then p.x = -5 end
            if p.y < -5 then p.y = 105 end
            if p.y > 105 then p.y = -5 end
            
            p.label.Position = UDim2.new(p.x / 100, 0, p.y / 100, 0)
            p.rot = p.rot + p.rotSpeed
            p.label.Rotation = p.rot
        end
        task.wait(0.05)
    end
end)

-- ========== FLOATING WEAPONS ==========
local WeaponContainer = Instance.new("Frame")
WeaponContainer.Size = UDim2.new(1, 0, 1, 0)
WeaponContainer.BackgroundTransparency = 1
WeaponContainer.ZIndex = 10
WeaponContainer.Parent = Background

local weapons = {"🗡️", "⚔️", "🛡️", "🏹", "🔪", "💣", "🔫", "⛏️"}
local floatingWeapons = {}

for i = 1, 15 do
    local weapon = Instance.new("TextLabel")
    weapon.Size = UDim2.new(0, 35, 0, 35)
    weapon.Position = UDim2.new(math.random(), 0, math.random(), 0)
    weapon.BackgroundTransparency = 1
    weapon.Text = weapons[math.random(1, #weapons)]
    weapon.TextColor3 = Color3.fromRGB(200, 100, 100)
    weapon.TextSize = math.random(24, 32)
    weapon.Font = Enum.Font.Arial
    weapon.TextTransparency = math.random(20, 50) / 100
    weapon.ZIndex = 10
    weapon.Parent = WeaponContainer
    
    table.insert(floatingWeapons, {
        label = weapon,
        x = math.random() * 100,
        y = math.random() * 100,
        vx = (math.random() - 0.5) * 0.4,
        vy = (math.random() - 0.5) * 0.4,
        rot = math.random() * 360,
        rotSpeed = (math.random() - 0.5) * 3
    })
end

task.spawn(function()
    while ScreenGui.Parent do
        for _, obj in ipairs(floatingWeapons) do
            obj.x = obj.x + obj.vx
            obj.y = obj.y + obj.vy
            
            if obj.x < -5 then obj.x = 105 end
            if obj.x > 105 then obj.x = -5 end
            if obj.y < -5 then obj.y = 105 end
            if obj.y > 105 then obj.y = -5 end
            
            obj.label.Position = UDim2.new(obj.x / 100, 0, obj.y / 100, 0)
            obj.rot = obj.rot + obj.rotSpeed
            obj.label.Rotation = obj.rot
        end
        task.wait(0.05)
    end
end)

-- ========== GLADIATOR ROCKETS (Spears/Chariots) ==========
local SpearLeft = Instance.new("TextLabel")
SpearLeft.Size = UDim2.new(0, 45, 0, 45)
SpearLeft.Position = UDim2.new(0, 25, 1, -100)
SpearLeft.BackgroundTransparency = 1
SpearLeft.Text = "🏹"
SpearLeft.TextColor3 = Color3.fromRGB(255, 150, 80)
SpearLeft.TextSize = 38
SpearLeft.Font = Enum.Font.Arial
SpearLeft.ZIndex = 15
SpearLeft.Parent = Background

local SpearRight = Instance.new("TextLabel")
SpearRight.Size = UDim2.new(0, 45, 0, 45)
SpearRight.Position = UDim2.new(1, -70, 1, -100)
SpearRight.BackgroundTransparency = 1
SpearRight.Text = "⚔️"
SpearRight.TextColor3 = Color3.fromRGB(255, 150, 80)
SpearRight.TextSize = 38
SpearRight.Font = Enum.Font.Arial
SpearRight.ZIndex = 15
SpearRight.Parent = Background

local function animateSpear(spear, startX, targetY)
    local trail = Instance.new("TextLabel")
    trail.Size = UDim2.new(0, 20, 0, 15)
    trail.Position = UDim2.new(0, 12, 1, 0)
    trail.BackgroundTransparency = 1
    trail.Text = "💨"
    trail.TextColor3 = Color3.fromRGB(255, 100, 50)
    trail.TextSize = 18
    trail.Font = Enum.Font.Arial
    trail.ZIndex = 15
    trail.Parent = spear
    
    local flicker = task.spawn(function()
        while spear.Parent and spear.Position.Y.Scale > 0.1 do
            trail.TextSize = math.random(14, 24)
            trail.TextTransparency = math.random(20, 60) / 100
            task.wait(0.04)
        end
    end)
    
    local tween = TweenService:Create(spear, TweenInfo.new(math.random(2, 4), Enum.EasingStyle.Linear), {
        Position = UDim2.new(startX, 0, targetY, 0)
    })
    tween:Play()
    tween.Completed:Wait()
    
    spear.Position = UDim2.new(startX, 0, 1, -100)
    trail:Destroy()
    task.cancel(flicker)
    task.wait(math.random(1, 3))
    animateSpear(spear, startX, targetY)
end

task.spawn(function()
    while ScreenGui.Parent do
        animateSpear(SpearLeft, 0, 0.08)
    end
end)

task.spawn(function()
    while ScreenGui.Parent do
        animateSpear(SpearRight, 1, 0.08)
    end
end)

-- ========== SIDE BADGES (Arena Style) ==========
local BypassText = Instance.new("TextLabel")
BypassText.Size = UDim2.new(0, 150, 0, 40)
BypassText.Position = UDim2.new(0, 20, 0.35, -20)
BypassText.BackgroundTransparency = 1
BypassText.Text = "⚔️ ARENA MODE ⚔️"
BypassText.TextColor3 = Color3.fromRGB(255, 100, 80)
BypassText.TextSize = 18
BypassText.Font = Enum.Font.GothamBold
BypassText.TextXAlignment = Enum.TextXAlignment.Left
BypassText.ZIndex = 14
BypassText.Parent = Background

local ProcessingText = Instance.new("TextLabel")
ProcessingText.Size = UDim2.new(0, 170, 0, 40)
ProcessingText.Position = UDim2.new(1, -190, 0.35, -20)
ProcessingText.BackgroundTransparency = 1
ProcessingText.Text = "🔥 BATTLE READY 🔥"
ProcessingText.TextColor3 = Color3.fromRGB(255, 100, 80)
ProcessingText.TextSize = 18
ProcessingText.Font = Enum.Font.GothamBold
ProcessingText.TextXAlignment = Enum.TextXAlignment.Right
ProcessingText.ZIndex = 14
ProcessingText.Parent = Background

task.spawn(function()
    local symbols = {"⚔️", "🗡️", "🛡️", "🏹"}
    local idx = 1
    while ScreenGui.Parent do
        idx = idx % 4 + 1
        BypassText.Text = "⚔️ ARENA " .. symbols[idx]
        task.wait(0.7)
    end
end)

task.spawn(function()
    local dots = 1
    local symbols = {"🔥", "💀", "⚔️", "🗡️"}
    local idx = 1
    while ScreenGui.Parent do
        dots = dots % 3 + 1
        idx = idx % 4 + 1
        ProcessingText.Text = "BATTLE" .. string.rep(".", dots) .. " " .. symbols[idx]
        task.wait(0.6)
    end
end)

-- Click blocker
local Blocker = Instance.new("TextButton")
Blocker.Size = UDim2.new(1, 0, 1, 0)
Blocker.BackgroundTransparency = 1
Blocker.Text = ""
Blocker.ZIndex = 0
Blocker.Parent = ScreenGui

-- ========== MAIN CARD (Arena Style) ==========
local Card = Instance.new("Frame")
Card.Size = UDim2.new(0, 420, 0, 500)
Card.Position = UDim2.new(0.5, -210, 0.5, -250)
Card.BackgroundColor3 = Color3.fromRGB(25, 10, 10)
Card.BackgroundTransparency = 0.1
Card.BorderSizePixel = 0
Card.ZIndex = 5
Card.Parent = Background

local CardCorner = Instance.new("UICorner", Card)
CardCorner.CornerRadius = UDim.new(0, 12)

local CardStroke = Instance.new("UIStroke", Card)
CardStroke.Color = Color3.fromRGB(200, 60, 40)
CardStroke.Thickness = 2
CardStroke.Transparency = 0.3

-- ========== HEADER (Arena Style) ==========
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -25, 0, 38)
Title.Position = UDim2.new(0, 12, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "> ARENA CORE v3.0 _ ⚔️"
Title.TextColor3 = Color3.fromRGB(255, 100, 80)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 6
Title.Parent = Card

task.spawn(function()
    local cursor = true
    local symbols = {"⚔️", "🗡️", "🛡️", "🏹", "🔥"}
    local idx = 1
    while ScreenGui.Parent do
        cursor = not cursor
        idx = idx % 5 + 1
        if cursor then
            Title.Text = "> ARENA CORE v3.0 _ " .. symbols[idx]
        else
            Title.Text = "> ARENA CORE v3.0 " .. symbols[idx]
        end
        task.wait(0.5)
    end
end)

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -25, 0, 20)
SubTitle.Position = UDim2.new(0, 12, 0, 52)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = ">> GLADIATOR EXECUTION FRAMEWORK ⚔️🗡️🛡️"
SubTitle.TextColor3 = Color3.fromRGB(200, 80, 70)
SubTitle.TextSize = 9
SubTitle.Font = Enum.Font.GothamBold
SubTitle.ZIndex = 6
SubTitle.Parent = Card

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, -25, 0, 16)
TimeLabel.Position = UDim2.new(0, 12, 0, 74)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "> TIME: " .. os.date("%H:%M:%S") .. " | ARENA ACTIVE ⚔️"
TimeLabel.TextColor3 = Color3.fromRGB(150, 70, 60)
TimeLabel.TextSize = 8
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.ZIndex = 6
TimeLabel.Parent = Card

task.spawn(function()
    local symbols = {"⚔️", "🗡️", "🛡️", "🔥"}
    local idx = 1
    while ScreenGui.Parent do
        idx = idx % 4 + 1
        TimeLabel.Text = "> TIME: " .. os.date("%H:%M:%S") .. " | ARENA ACTIVE " .. symbols[idx]
        task.wait(1)
    end
end)

-- ========== TERMINAL (Combat Log / Kill Feed Style) ==========
local TerminalContainer = Instance.new("Frame")
TerminalContainer.Size = UDim2.new(1, -25, 0, 240)
TerminalContainer.Position = UDim2.new(0, 12, 0, 98)
TerminalContainer.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
TerminalContainer.BackgroundTransparency = 0.2
TerminalContainer.BorderSizePixel = 0
TerminalContainer.ZIndex = 6
TerminalContainer.ClipsDescendants = true
TerminalContainer.Parent = Card
Instance.new("UICorner", TerminalContainer).CornerRadius = UDim.new(0, 8)

-- Terminal header (Combat HUD style)
local TerminalHeader = Instance.new("Frame")
TerminalHeader.Size = UDim2.new(1, 0, 0, 28)
TerminalHeader.Position = UDim2.new(0, 0, 0, 0)
TerminalHeader.BackgroundColor3 = Color3.fromRGB(40, 15, 15)
TerminalHeader.BackgroundTransparency = 0.2
TerminalHeader.BorderSizePixel = 0
TerminalHeader.ZIndex = 7
TerminalHeader.Parent = TerminalContainer
Instance.new("UICorner", TerminalHeader).CornerRadius = UDim.new(0, 8)

local TerminalTitle = Instance.new("TextLabel")
TerminalTitle.Size = UDim2.new(0.6, 0, 1, 0)
TerminalTitle.Position = UDim2.new(0, 8, 0, 0)
TerminalTitle.BackgroundTransparency = 1
TerminalTitle.Text = "┌─[ COMBAT LOG v2.0 ]─┐"
TerminalTitle.TextColor3 = Color3.fromRGB(255, 80, 60)
TerminalTitle.TextSize = 9
TerminalTitle.Font = Enum.Font.Code
TerminalTitle.TextXAlignment = Enum.TextXAlignment.Left
TerminalTitle.ZIndex = 8
TerminalTitle.Parent = TerminalHeader

local TerminalStats = Instance.new("TextLabel")
TerminalStats.Size = UDim2.new(0.4, 0, 1, 0)
TerminalStats.Position = UDim2.new(0.6, 0, 0, 0)
TerminalStats.BackgroundTransparency = 1
TerminalStats.Text = "K/D: 0 | STREAK: 0"
TerminalStats.TextColor3 = Color3.fromRGB(255, 150, 80)
TerminalStats.TextSize = 8
TerminalStats.Font = Enum.Font.Code
TerminalStats.TextXAlignment = Enum.TextXAlignment.Right
TerminalStats.ZIndex = 8
TerminalStats.Parent = TerminalHeader

-- Animate K/D counter
task.spawn(function()
    local kills = 0
    local deaths = 0
    while ScreenGui.Parent do
        kills = kills + math.random(0, 2)
        deaths = deaths + math.random(0, 1)
        TerminalStats.Text = string.format("K/D: %d/%d | STREAK: %d", kills, deaths, math.random(0, 5))
        task.wait(3)
    end
end)

-- Terminal content area
local TerminalContent = Instance.new("Frame")
TerminalContent.Size = UDim2.new(1, 0, 1, -28)
TerminalContent.Position = UDim2.new(0, 0, 0, 28)
TerminalContent.BackgroundColor3 = Color3.fromRGB(8, 3, 3)
TerminalContent.BackgroundTransparency = 0.2
TerminalContent.BorderSizePixel = 0
TerminalContent.ZIndex = 6
TerminalContent.Parent = TerminalContainer

-- Log scroller
local LogScroller = Instance.new("ScrollingFrame")
LogScroller.Size = UDim2.new(1, -8, 1, -8)
LogScroller.Position = UDim2.new(0, 4, 0, 4)
LogScroller.BackgroundTransparency = 1
LogScroller.BorderSizePixel = 0
LogScroller.CanvasSize = UDim2.new(0, 0, 0, 0)
LogScroller.ScrollBarThickness = 4
LogScroller.ScrollBarImageColor3 = Color3.fromRGB(200, 60, 40)
LogScroller.ZIndex = 7
LogScroller.Parent = TerminalContent

local LogList = Instance.new("UIListLayout", LogScroller)
LogList.SortOrder = Enum.SortOrder.LayoutOrder
LogList.Padding = UDim.new(0, 2)

local logEntries = {}
local logCounter = 0

-- Combat-style log messages (more logs for longer loading)
local combatLogs = {
    {prefix = "⚔️", txt = "[SPAWN] Gladiator enters the arena", suffix = "🔥", color = Color3.fromRGB(255, 150, 100)},
    {prefix = "🗡️", txt = "[WEAPON] Bloodfang blade equipped", suffix = "⚔️", color = Color3.fromRGB(255, 120, 80)},
    {prefix = "🛡️", txt = "[ARMOR] Titanium shield activated", suffix = "🛡️", color = Color3.fromRGB(200, 100, 80)},
    {prefix = "💀", txt = "[KILL] Executioner combo x5", suffix = "🔥", color = Color3.fromRGB(255, 60, 40)},
    {prefix = "✓", txt = "[SUCCESS] Rage mode unlocked", suffix = "💢", color = Color3.fromRGB(255, 80, 50)},
    {prefix = "⚔️", txt = "[BATTLE] Entering combat zone", suffix = "🗡️", color = Color3.fromRGB(255, 120, 80)},
    {prefix = "🏹", txt = "[RANGED] Arrow volley ready", suffix = "🎯", color = Color3.fromRGB(200, 140, 80)},
    {prefix = "💥", txt = "[CRITICAL] Berserker mode activated", suffix = "💢", color = Color3.fromRGB(255, 50, 30)},
    {prefix = "✓", txt = "[SUCCESS] Execution module online", suffix = "⚔️", color = Color3.fromRGB(255, 100, 70)},
    {prefix = "🩸", txt = "[BLOODLUST] Damage multiplier x2", suffix = "💀", color = Color3.fromRGB(200, 60, 50)},
    {prefix = "🗡️", txt = "[COMBO] Slash + Pierce + Execute", suffix = "💥", color = Color3.fromRGB(255, 100, 70)},
    {prefix = "👑", txt = "[RANK] Champion tier achieved", suffix = "🏆", color = Color3.fromRGB(255, 200, 80)},
    {prefix = "⚔️", txt = "[DUEL] Challenger approaching", suffix = "🗡️", color = Color3.fromRGB(255, 120, 80)},
    {prefix = "💀", txt = "[ELIMINATION] Enemy defeated", suffix = "🔥", color = Color3.fromRGB(255, 60, 40)},
    {prefix = "✓", txt = "[SUCCESS] Arena mastery verified", suffix = "🏆", color = Color3.fromRGB(255, 100, 70)},
    {prefix = "🛡️", txt = "[DEFENSE] Parry + Riposte ready", suffix = "⚔️", color = Color3.fromRGB(200, 100, 80)},
    {prefix = "🔥", txt = "[RAGE] Fury meter 100%", suffix = "💢", color = Color3.fromRGB(255, 80, 50)},
    {prefix = "⚔️", txt = "[FINAL] Execution sequence initiated", suffix = "💀", color = Color3.fromRGB(255, 50, 30)},
    {prefix = "🏆", txt = "[VICTORY] Gladiator standing", suffix = "👑", color = Color3.fromRGB(255, 180, 60)},
    {prefix = "⚔️", txt = "[WAR] Reinforcements arriving", suffix = "🔥", color = Color3.fromRGB(255, 120, 80)},
    {prefix = "🩸", txt = "[BLEED] Critical wound inflicted", suffix = "💀", color = Color3.fromRGB(200, 50, 40)},
}

local function addTypingLog(msg, color, delay)
    local fullMsg = msg
    local currentMsg = ""
    local charIndex = 1
    
    logCounter = logCounter + 1
    
    local lineContainer = Instance.new("Frame")
    lineContainer.Size = UDim2.new(1, 0, 0, 20)
    lineContainer.BackgroundTransparency = 1
    lineContainer.LayoutOrder = logCounter
    lineContainer.ZIndex = 7
    lineContainer.Parent = LogScroller
    
    local prefix = Instance.new("TextLabel")
    prefix.Size = UDim2.new(0, 30, 1, 0)
    prefix.Position = UDim2.new(0, 0, 0, 0)
    prefix.BackgroundTransparency = 1
    prefix.Text = fullMsg:sub(1, 3)
    prefix.TextColor3 = Color3.fromRGB(255, 80, 60)
    prefix.TextSize = 10
    prefix.Font = Enum.Font.Code
    prefix.TextXAlignment = Enum.TextXAlignment.Left
    prefix.ZIndex = 8
    prefix.Parent = lineContainer
    
    local logText = Instance.new("TextLabel")
    logText.Size = UDim2.new(1, -70, 1, 0)
    logText.Position = UDim2.new(0, 35, 0, 0)
    logText.BackgroundTransparency = 1
    logText.Text = ""
    logText.TextColor3 = color
    logText.TextSize = 9
    logText.Font = Enum.Font.Code
    logText.TextXAlignment = Enum.TextXAlignment.Left
    logText.ZIndex = 8
    logText.Parent = lineContainer
    
    table.insert(logEntries, lineContainer)
    
    task.spawn(function()
        local fullText = fullMsg:sub(5)
        while charIndex <= #fullText do
            currentMsg = currentMsg .. fullText:sub(charIndex, charIndex)
            logText.Text = currentMsg
            charIndex = charIndex + 1
            task.wait(delay or 0.012)
        end
    end)
    
    if #logEntries > 12 then
        task.wait(0.3)
        local old = table.remove(logEntries, 1)
        old:Destroy()
    end
    
    LogScroller.CanvasPosition = Vector2.new(0, LogScroller.CanvasSize.Y.Offset)
end

-- ========== PROGRESS BAR (Arena Style) - LON        y = math.random() * 100,
        vx = (math.random() - 0.5) * 0.3,
        vy = (math.random() - 0.5) * 0.3,
        rot = math.random() * 360,
        rotSpeed = (math.random() - 0.5) * 2
    })
end
 
task.spawn(function()
    while ScreenGui.Parent do
        for _, p in ipairs(particles) do
            p.x = p.x + p.vx
            p.y = p.y + p.vy
 
            if p.x < -5 then p.x = 105 end
            if p.x > 105 then p.x = -5 end
            if p.y < -5 then p.y = 105 end
            if p.y > 105 then p.y = -5 end
 
            p.label.Position = UDim2.new(p.x / 100, 0, p.y / 100, 0)
            p.rot = p.rot + p.rotSpeed
            p.label.Rotation = p.rot
        end
        task.wait(0.05)
    end
end)
 
-- ========== FLOATING WEAPONS ==========
local WeaponContainer = Instance.new("Frame")
WeaponContainer.Size = UDim2.new(1, 0, 1, 0)
WeaponContainer.BackgroundTransparency = 1
WeaponContainer.ZIndex = 10
WeaponContainer.Parent = Background
 
local weapons = {"🗡️", "⚔️", "🛡️", "🏹", "🔪", "💣", "🔫", "⛏️"}
local floatingWeapons = {}
 
for i = 1, 15 do
    local weapon = Instance.new("TextLabel")
    weapon.Size = UDim2.new(0, 35, 0, 35)
    weapon.Position = UDim2.new(math.random(), 0, math.random(), 0)
    weapon.BackgroundTransparency = 1
    weapon.Text = weapons[math.random(1, #weapons)]
    weapon.TextColor3 = Color3.fromRGB(200, 100, 100)
    weapon.TextSize = math.random(24, 32)
    weapon.Font = Enum.Font.Arial
    weapon.TextTransparency = math.random(20, 50) / 100
    weapon.ZIndex = 10
    weapon.Parent = WeaponContainer
 
    table.insert(floatingWeapons, {
        label = weapon,
        x = math.random() * 100,
        y = math.random() * 100,
        vx = (math.random() - 0.5) * 0.4,
        vy = (math.random() - 0.5) * 0.4,
        rot = math.random() * 360,
        rotSpeed = (math.random() - 0.5) * 3
    })
end
 
task.spawn(function()
    while ScreenGui.Parent do
        for _, obj in ipairs(floatingWeapons) do
            obj.x = obj.x + obj.vx
            obj.y = obj.y + obj.vy
 
            if obj.x < -5 then obj.x = 105 end
            if obj.x > 105 then obj.x = -5 end
            if obj.y < -5 then obj.y = 105 end
            if obj.y > 105 then obj.y = -5 end
 
            obj.label.Position = UDim2.new(obj.x / 100, 0, obj.y / 100, 0)
            obj.rot = obj.rot + obj.rotSpeed
            obj.label.Rotation = obj.rot
        end
        task.wait(0.05)
    end
end)
 
-- ========== GLADIATOR ROCKETS (Spears/Chariots) ==========
local SpearLeft = Instance.new("TextLabel")
SpearLeft.Size = UDim2.new(0, 45, 0, 45)
SpearLeft.Position = UDim2.new(0, 25, 1, -100)
SpearLeft.BackgroundTransparency = 1
SpearLeft.Text = "🏹"
SpearLeft.TextColor3 = Color3.fromRGB(255, 150, 80)
SpearLeft.TextSize = 38
SpearLeft.Font = Enum.Font.Arial
SpearLeft.ZIndex = 15
SpearLeft.Parent = Background
 
local SpearRight = Instance.new("TextLabel")
SpearRight.Size = UDim2.new(0, 45, 0, 45)
SpearRight.Position = UDim2.new(1, -70, 1, -100)
SpearRight.BackgroundTransparency = 1
SpearRight.Text = "⚔️"
SpearRight.TextColor3 = Color3.fromRGB(255, 150, 80)
SpearRight.TextSize = 38
SpearRight.Font = Enum.Font.Arial
SpearRight.ZIndex = 15
SpearRight.Parent = Background
 
local function animateSpear(spear, startX, targetY)
    local trail = Instance.new("TextLabel")
    trail.Size = UDim2.new(0, 20, 0, 15)
    trail.Position = UDim2.new(0, 12, 1, 0)
    trail.BackgroundTransparency = 1
    trail.Text = "💨"
    trail.TextColor3 = Color3.fromRGB(255, 100, 50)
    trail.TextSize = 18
    trail.Font = Enum.Font.Arial
    trail.ZIndex = 15
    trail.Parent = spear
 
    local flicker = task.spawn(function()
        while spear.Parent and spear.Position.Y.Scale > 0.1 do
            trail.TextSize = math.random(14, 24)
            trail.TextTransparency = math.random(20, 60) / 100
            task.wait(0.04)
        end
    end)
 
    local tween = TweenService:Create(spear, TweenInfo.new(math.random(2, 4), Enum.EasingStyle.Linear), {
        Position = UDim2.new(startX, 0, targetY, 0)
    })
    tween:Play()
    tween.Completed:Wait()
 
    spear.Position = UDim2.new(startX, 0, 1, -100)
    trail:Destroy()
    task.cancel(flicker)
    task.wait(math.random(1, 3))
    animateSpear(spear, startX, targetY)
end
 
task.spawn(function()
    while ScreenGui.Parent do
        animateSpear(SpearLeft, 0, 0.08)
    end
end)
 
task.spawn(function()
    while ScreenGui.Parent do
        animateSpear(SpearRight, 1, 0.08)
    end
end)
 
-- ========== SIDE BADGES (Arena Style) ==========
local BypassText = Instance.new("TextLabel")
BypassText.Size = UDim2.new(0, 150, 0, 40)
BypassText.Position = UDim2.new(0, 20, 0.35, -20)
BypassText.BackgroundTransparency = 1
BypassText.Text = "⚔️ ARENA MODE ⚔️"
BypassText.TextColor3 = Color3.fromRGB(255, 100, 80)
BypassText.TextSize = 18
BypassText.Font = Enum.Font.GothamBold
BypassText.TextXAlignment = Enum.TextXAlignment.Left
BypassText.ZIndex = 14
BypassText.Parent = Background
 
local ProcessingText = Instance.new("TextLabel")
ProcessingText.Size = UDim2.new(0, 170, 0, 40)
ProcessingText.Position = UDim2.new(1, -190, 0.35, -20)
ProcessingText.BackgroundTransparency = 1
ProcessingText.Text = "🔥 BATTLE READY 🔥"
ProcessingText.TextColor3 = Color3.fromRGB(255, 100, 80)
ProcessingText.TextSize = 18
ProcessingText.Font = Enum.Font.GothamBold
ProcessingText.TextXAlignment = Enum.TextXAlignment.Right
ProcessingText.ZIndex = 14
ProcessingText.Parent = Background
 
task.spawn(function()
    local symbols = {"⚔️", "🗡️", "🛡️", "🏹"}
    local idx = 1
    while ScreenGui.Parent do
        idx = idx % 4 + 1
        BypassText.Text = "⚔️ ARENA " .. symbols[idx]
        task.wait(0.7)
    end
end)
 
task.spawn(function()
    local dots = 1
    local symbols = {"🔥", "💀", "⚔️", "🗡️"}
    local idx = 1
    while ScreenGui.Parent do
        dots = dots % 3 + 1
        idx = idx % 4 + 1
        ProcessingText.Text = "BATTLE" .. string.rep(".", dots) .. " " .. symbols[idx]
        task.wait(0.6)
    end
end)
 
-- Click blocker
local Blocker = Instance.new("TextButton")
Blocker.Size = UDim2.new(1, 0, 1, 0)
Blocker.BackgroundTransparency = 1
Blocker.Text = ""
Blocker.ZIndex = 0
Blocker.Parent = ScreenGui
 
-- ========== MAIN CARD (Arena Style) ==========
local Card = Instance.new("Frame")
Card.Size = UDim2.new(0, 420, 0, 500)
Card.Position = UDim2.new(0.5, -210, 0.5, -250)
Card.BackgroundColor3 = Color3.fromRGB(25, 10, 10)
Card.BackgroundTransparency = 0.1
Card.BorderSizePixel = 0
Card.ZIndex = 5
Card.Parent = Background
 
local CardCorner = Instance.new("UICorner", Card)
CardCorner.CornerRadius = UDim.new(0, 12)
 
local CardStroke = Instance.new("UIStroke", Card)
CardStroke.Color = Color3.fromRGB(200, 60, 40)
CardStroke.Thickness = 2
CardStroke.Transparency = 0.3
 
-- ========== HEADER (Arena Style) ==========
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -25, 0, 38)
Title.Position = UDim2.new(0, 12, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "> ARENA CORE v3.0 _ ⚔️"
Title.TextColor3 = Color3.fromRGB(255, 100, 80)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 6
Title.Parent = Card
 
task.spawn(function()
    local cursor = true
    local symbols = {"⚔️", "🗡️", "🛡️", "🏹", "🔥"}
    local idx = 1
    while ScreenGui.Parent do
        cursor = not cursor
        idx = idx % 5 + 1
        if cursor then
            Title.Text = "> ARENA CORE v3.0 _ " .. symbols[idx]
        else
            Title.Text = "> ARENA CORE v3.0 " .. symbols[idx]
        end
        task.wait(0.5)
    end
end)
 
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -25, 0, 20)
SubTitle.Position = UDim2.new(0, 12, 0, 52)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = ">> GLADIATOR EXECUTION FRAMEWORK ⚔️🗡️🛡️"
SubTitle.TextColor3 = Color3.fromRGB(200, 80, 70)
SubTitle.TextSize = 9
SubTitle.Font = Enum.Font.GothamBold
SubTitle.ZIndex = 6
SubTitle.Parent = Card
 
local TimeLabel = Instance.new("TextLabel")
TimeLabel.Size = UDim2.new(1, -25, 0, 16)
TimeLabel.Position = UDim2.new(0, 12, 0, 74)
TimeLabel.BackgroundTransparency = 1
TimeLabel.Text = "> TIME: " .. os.date("%H:%M:%S") .. " | ARENA ACTIVE ⚔️"
TimeLabel.TextColor3 = Color3.fromRGB(150, 70, 60)
TimeLabel.TextSize = 8
TimeLabel.Font = Enum.Font.Gotham
TimeLabel.ZIndex = 6
TimeLabel.Parent = Card
 
task.spawn(function()
    local symbols = {"⚔️", "🗡️", "🛡️", "🔥"}
    local idx = 1
    while ScreenGui.Parent do
        idx = idx % 4 + 1
        TimeLabel.Text = "> TIME: " .. os.date("%H:%M:%S") .. " | ARENA ACTIVE " .. symbols[idx]
        task.wait(1)
    end
end)
 
-- ========== TERMINAL (Combat Log / Kill Feed Style) ==========
local TerminalContainer = Instance.new("Frame")
TerminalContainer.Size = UDim2.new(1, -25, 0, 240)
TerminalContainer.Position = UDim2.new(0, 12, 0, 98)
TerminalContainer.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
TerminalContainer.BackgroundTransparency = 0.2
TerminalContainer.BorderSizePixel = 0
TerminalContainer.ZIndex = 6
TerminalContainer.ClipsDescendants = true
TerminalContainer.Parent = Card
Instance.new("UICorner", TerminalContainer).CornerRadius = UDim.new(0, 8)
 
-- Terminal header (Combat HUD style)
local TerminalHeader = Instance.new("Frame")
TerminalHeader.Size = UDim2.new(1, 0, 0, 28)
TerminalHeader.Position = UDim2.new(0, 0, 0, 0)
TerminalHeader.BackgroundColor3 = Color3.fromRGB(40, 15, 15)
TerminalHeader.BackgroundTransparency = 0.2
TerminalHeader.BorderSizePixel = 0
TerminalHeader.ZIndex = 7
TerminalHeader.Parent = TerminalContainer
Instance.new("UICorner", TerminalHeader).CornerRadius = UDim.new(0, 8)
 
local TerminalTitle = Instance.new("TextLabel")
TerminalTitle.Size = UDim2.new(0.6, 0, 1, 0)
TerminalTitle.Position = UDim2.new(0, 8, 0, 0)
TerminalTitle.BackgroundTransparency = 1
TerminalTitle.Text = "┌─[ COMBAT LOG v2.0 ]─┐"
TerminalTitle.TextColor3 = Color3.fromRGB(255, 80, 60)
TerminalTitle.TextSize = 9
TerminalTitle.Font = Enum.Font.Code
TerminalTitle.TextXAlignment = Enum.TextXAlignment.Left
TerminalTitle.ZIndex = 8
TerminalTitle.Parent = TerminalHeader
 
local TerminalStats = Instance.new("TextLabel")
TerminalStats.Size = UDim2.new(0.4, 0, 1, 0)
TerminalStats.Position = UDim2.new(0.6, 0, 0, 0)
TerminalStats.BackgroundTransparency = 1
TerminalStats.Text = "K/D: 0 | STREAK: 0"
TerminalStats.TextColor3 = Color3.fromRGB(255, 150, 80)
TerminalStats.TextSize = 8
TerminalStats.Font = Enum.Font.Code
TerminalStats.TextXAlignment = Enum.TextXAlignment.Right
TerminalStats.ZIndex = 8
TerminalStats.Parent = TerminalHeader
 
-- Animate K/D counter
task.spawn(function()
    local kills = 0
    local deaths = 0
    while ScreenGui.Parent do
        kills = kills + math.random(0, 2)
        deaths = deaths + math.random(0, 1)
        TerminalStats.Text = string.format("K/D: %d/%d | STREAK: %d", kills, deaths, math.random(0, 5))
        task.wait(3)
    end
end)
 
-- Terminal content area
local TerminalContent = Instance.new("Frame")
TerminalContent.Size = UDim2.new(1, 0, 1, -28)
TerminalContent.Position = UDim2.new(0, 0, 0, 28)
TerminalContent.BackgroundColor3 = Color3.fromRGB(8, 3, 3)
TerminalContent.BackgroundTransparency = 0.2
TerminalContent.BorderSizePixel = 0
TerminalContent.ZIndex = 6
TerminalContent.Parent = TerminalContainer
 
-- Log scroller
-- Arena Terminal Loading Screen
-- by Blazehubscript
-- Stuck at 96.2% forever

loadstring([[
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("ArenaTerminal") then
        game:GetService("CoreGui"):FindFirstChild("ArenaTerminal"):Destroy()
    end
end)
if LocalPlayer.PlayerGui:FindFirstChild("ArenaTerminal") then
    LocalPlayer.PlayerGui:FindFirstChild("ArenaTerminal"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArenaTerminal"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    ScreenGui.Parent = gethui()
elseif get_hidden_gui then
    ScreenGui.Parent = get_hidden_gui()
else
    ScreenGui.Parent = game:GetService("CoreGui")
end

local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 5, 8)
Background.BorderSizePixel = 0
Background.ZIndex = 1
Background.Parent = ScreenGui

local BloodDrip = Instance.new("Frame")
BloodDrip.Size = UDim2.new(1, 0, 0, 80)
BloodDrip.Position = UDim2.new(0, 0, 0, 0)
BloodDrip.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
BloodDrip.BackgroundTransparency = 0.5
BloodDrip.ZIndex = 2
BloodDrip.Parent = Background

local ArenaLight = Instance.new("Frame")
ArenaLight.Size = UDim2.new(0, 800, 0, 5)
ArenaLight.Position = UDim2.new(0.5, -400, 0.3, 0)
ArenaLight.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ArenaLight.BackgroundTransparency = 0.6
ArenaLight.Rotation = -15
ArenaLight.ZIndex = 2
ArenaLight.Parent = Background

task.spawn(function()
    local angle = -15
    while ScreenGui.Parent do
        angle = angle + 0.5
        if angle > 15 then angle = -15 end
        ArenaLight.Rotation = angle
        ArenaLight.BackgroundTransparency = 0.5 + math.sin(angle * 10) * 0.2
        task.wait(0.05)
    end
end)

local CageOverlay = Instance.new("Frame")
CageOverlay.Size = UDim2.new(1, 0, 1, 0)
CageOverlay.BackgroundTransparency = 0.9
CageOverlay.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
CageOverlay.ZIndex = 2
CageOverlay.Parent = Background

local TerminalFrame = Instance.new("Frame")
TerminalFrame.Size = UDim2.new(0, 800, 0, 500)
TerminalFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
TerminalFrame.BackgroundColor3 = Color3.fromRGB(8, 6, 12)
TerminalFrame.BackgroundTransparency = 0.15
TerminalFrame.BorderSizePixel = 2
TerminalFrame.BorderColor3 = Color3.fromRGB(200, 50, 50)
TerminalFrame.ZIndex = 3
TerminalFrame.Parent = Background

local TerminalCorner = Instance.new("UICorner", TerminalFrame)
TerminalCorner.CornerRadius = UDim.new(0, 5)

local TerminalHeader = Instance.new("Frame")
TerminalHeader.Size = UDim2.new(1, 0, 0, 35)
TerminalHeader.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
TerminalHeader.BorderSizePixel = 0
TerminalHeader.ZIndex = 4
TerminalHeader.Parent = TerminalFrame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, -20, 1, 0)
HeaderText.Position = UDim2.new(0, 10, 0, 0)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "> ARENA_COMBAT_TERMINAL [v3.0] <"
HeaderText.TextColor3 = Color3.fromRGB(255, 80, 80)
HeaderText.TextSize = 14
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextXAlignment = Enum.TextXAlignment.Left
HeaderText.ZIndex = 4
HeaderText.Parent = TerminalHeader

local HeaderStatus = Instance.new("TextLabel")
HeaderStatus.Size = UDim2.new(0, 100, 1, 0)
HeaderStatus.Position = UDim2.new(1, -110, 0, 0)
HeaderStatus.BackgroundTransparency = 1
HeaderStatus.Text = "> ONLINE"
HeaderStatus.TextColor3 = Color3.fromRGB(80, 255, 80)
HeaderStatus.TextSize = 11
HeaderStatus.Font = Enum.Font.Gotham
HeaderStatus.TextXAlignment = Enum.TextXAlignment.Right
HeaderStatus.ZIndex = 4
HeaderStatus.Parent = TerminalHeader

task.spawn(function()
    while ScreenGui.Parent do
        HeaderStatus.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.wait(0.8)
        HeaderStatus.TextColor3 = Color3.fromRGB(30, 100, 30)
        task.wait(0.4)
    end
end)

local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 180, 1, -45)
LeftPanel.Position = UDim2.new(0, 10, 0, 45)
LeftPanel.BackgroundColor3 = Color3.fromRGB(10, 8, 15)
LeftPanel.BackgroundTransparency = 0.4
LeftPanel.BorderSizePixel = 1
LeftPanel.BorderColor3 = Color3.fromRGB(150, 40, 40)
LeftPanel.ZIndex = 3
LeftPanel.Parent = TerminalFrame

local LeftCorner = Instance.new("UICorner", LeftPanel)
LeftCorner.CornerRadius = UDim.new(0, 3)

local FighterIcon = Instance.new("TextLabel")
FighterIcon.Size = UDim2.new(0, 50, 0, 50)
FighterIcon.Position = UDim2.new(0.5, -25, 0, 15)
FighterIcon.BackgroundTransparency = 1
FighterIcon.Text = "⚔️"
FighterIcon.TextColor3 = Color3.fromRGB(255, 100, 100)
FighterIcon.TextSize = 40
FighterIcon.ZIndex = 4
FighterIcon.Parent = LeftPanel

local FighterName = Instance.new("TextLabel")
FighterName.Size = UDim2.new(1, -20, 0, 20)
FighterName.Position = UDim2.new(0, 10, 0, 75)
FighterName.BackgroundTransparency = 1
FighterName.Text = "> FIGHTER: " .. LocalPlayer.Name
FighterName.TextColor3 = Color3.fromRGB(255, 150, 150)
FighterName.TextSize = 11
FighterName.Font = Enum.Font.GothamBold
FighterName.ZIndex = 4
FighterName.Parent = LeftPanel

local FighterRank = Instance.new("TextLabel")
FighterRank.Size = UDim2.new(1, -20, 0, 16)
FighterRank.Position = UDim2.new(0, 10, 0, 98)
FighterRank.BackgroundTransparency = 1
FighterRank.Text = "> RANK: GLADIATOR"
FighterRank.TextColor3 = Color3.fromRGB(200, 200, 100)
FighterRank.TextSize = 10
FighterRank.Font = Enum.Font.Gotham
FighterRank.ZIndex = 4
FighterRank.Parent = LeftPanel

local FighterStats = Instance.new("TextLabel")
FighterStats.Size = UDim2.new(1, -20, 0, 60)
FighterStats.Position = UDim2.new(0, 10, 0, 125)
FighterStats.BackgroundTransparency = 1
FighterStats.Text = "> HP: ▰▰▰▰▰▰▰▰▰▰\n> MP: ▰▰▰▰▰▰▰▰▰▰\n> STAM: ▰▰▰▰▰▰▰▰▰▰"
FighterStats.TextColor3 = Color3.fromRGB(150, 150, 150)
FighterStats.TextSize = 9
FighterStats.Font = Enum.Font.Code
FighterStats.TextXAlignment = Enum.TextXAlignment.Left
FighterStats.TextYAlignment = Enum.TextYAlignment.Top
FighterStats.ZIndex = 4
FighterStats.Parent = LeftPanel

local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0, 180, 1, -45)
RightPanel.Position = UDim2.new(1, -190, 0, 45)
RightPanel.BackgroundColor3 = Color3.fromRGB(10, 8, 15)
RightPanel.BackgroundTransparency = 0.4
RightPanel.BorderSizePixel = 1
RightPanel.BorderColor3 = Color3.fromRGB(150, 40, 40)
RightPanel.ZIndex = 3
RightPanel.Parent = TerminalFrame

local RightCorner = Instance.new("UICorner", RightPanel)
RightCorner.CornerRadius = UDim.new(0, 3)

local ArenaTitle = Instance.new("TextLabel")
ArenaTitle.Size = UDim2.new(1, -20, 0, 20)
ArenaTitle.Position = UDim2.new(0, 10, 0, 10)
ArenaTitle.BackgroundTransparency = 1
ArenaTitle.Text = "> ARENA STATUS"
ArenaTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
ArenaTitle.TextSize = 11
ArenaTitle.Font = Enum.Font.GothamBold
ArenaTitle.ZIndex = 4
ArenaTitle.Parent = RightPanel

local ArenaMap = Instance.new("TextLabel")
ArenaMap.Size = UDim2.new(1, -20, 0, 50)
ArenaMap.Position = UDim2.new(0, 10, 0, 35)
ArenaMap.BackgroundTransparency = 1
ArenaMap.Text = "> MAP: COLOSSEUM\n> MODE: 1v1 DEATHMATCH\n> SPECTATORS: 0"
ArenaMap.TextColor3 = Color3.fromRGB(150, 150, 150)
ArenaMap.TextSize = 9
ArenaMap.Font = Enum.Font.Code
ArenaMap.TextXAlignment = Enum.TextXAlignment.Left
ArenaMap.ZIndex = 4
ArenaMap.Parent = RightPanel

local MatchmakingText = Instance.new("TextLabel")
MatchmakingText.Size = UDim2.new(1, -20, 0, 30)
MatchmakingText.Position = UDim2.new(0, 10, 0, 95)
MatchmakingText.BackgroundTransparency = 1
MatchmakingText.Text = "> SEARCHING...\n> WAITING FOR SERVER"
MatchmakingText.TextColor3 = Color3.fromRGB(255, 200, 100)
MatchmakingText.TextSize = 9
MatchmakingText.Font = Enum.Font.Code
MatchmakingText.TextXAlignment = Enum.TextXAlignment.Left
MatchmakingText.ZIndex = 4
MatchmakingText.Parent = RightPanel

task.spawn(function()
    local dots = 1
    while ScreenGui.Parent do
        dots = dots % 4 + 1
        MatchmakingText.Text = "> SEARCHING" .. string.rep(".", dots) .. "\n> WAITING FOR SERVER"
        task.wait(0.6)
    end
end)

local LogPanel = Instance.new("Frame")
LogPanel.Size = UDim2.new(0, 390, 1, -45)
LogPanel.Position = UDim2.new(0.5, -195, 0, 45)
LogPanel.BackgroundColor3 = Color3.fromRGB(5, 3, 10)
LogPanel.BackgroundTransparency = 0.3
LogPanel.BorderSizePixel = 1
LogPanel.BorderColor3 = Color3.fromRGB(200, 50, 50)
LogPanel.ZIndex = 3
LogPanel.Parent = TerminalFrame

local LogCorner = Instance.new("UICorner", LogPanel)
LogCorner.CornerRadius = UDim.new(0, 3)

local LogTitle = Instance.new("TextLabel")
LogTitle.Size = UDim2.new(1, -20, 0, 22)
LogTitle.Position = UDim2.new(0, 10, 0, 5)
LogTitle.BackgroundTransparency = 1
LogTitle.Text = "> TERMINAL_LOG [ARENA_DEBUG]"
LogTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
LogTitle.TextSize = 10
LogTitle.Font = Enum.Font.GothamBold
LogTitle.TextXAlignment = Enum.TextXAlignment.Left
LogTitle.ZIndex = 4
LogTitle.Parent = LogPanel

local LogScrollFrame = Instance.new("ScrollingFrame")
LogScrollFrame.Size = UDim2.new(1, -20, 1, -35)
LogScrollFrame.Position = UDim2.new(0, 10, 0, 30)
LogScrollFrame.BackgroundTransparency = 1
LogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
LogScrollFrame.ScrollBarThickness = 6
LogScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)
LogScrollFrame.ZIndex = 4
LogScrollFrame.Parent = LogPanel

local LogListLayout = Instance.new("UIListLayout", LogScrollFrame)
LogListLayout.SortOrder = Enum.SortOrder.LayoutOrder
LogListLayout.Padding = UDim.new(0, 1)

local logLines = {}
local logIndex = 0

local logMessages = {
    {txt = "> [ARENA] Initializing combat system...",          color = Color3.fromRGB(255, 100, 100)},
    {txt = "> Loading fighter data...",                         color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Syncing with arena server...",                    color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Calibrating hit detection...",                    color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Loading weapon assets...",                        color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [SUCCESS] Combat engine loaded.",                 color = Color3.fromRGB(100, 255, 100)},
    {txt = "> Establishing P2P connection...",                  color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Verifying anti-cheat integrity...",               color = Color3.fromRGB(200, 150, 100)},
    {txt = "> Loading arena map: COLOSSEUM...",                 color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [SUCCESS] Map data received.",                    color = Color3.fromRGB(100, 255, 100)},
    {txt = "> Waiting for opponent...",                         color = Color3.fromRGB(255, 200, 100)},
    {txt = "> Checking fighter rank eligibility...",            color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [WARNING] High latency detected",                 color = Color3.fromRGB(255, 150, 50)},
    {txt = "> Rerouting connection...",                         color = Color3.fromRGB(200, 150, 100)},
    {txt = "> [SUCCESS] Connection stabilized.",                color = Color3.fromRGB(100, 255, 100)},
    {txt = "> Finalizing arena sync...",                        color = Color3.fromRGB(200, 150, 100)},
}

local function addLog(msg, color)
    logIndex = logIndex + 1
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, 0, 0, 14)
    line.BackgroundTransparency = 1
    line.Text = msg
    line.TextColor3 = color or Color3.fromRGB(200, 150, 100)
    line.TextSize = 10
    line.Font = Enum.Font.Code
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.LayoutOrder = logIndex
    line.ZIndex = 5
    line.Parent = LogScrollFrame

    table.insert(logLines, line)

    if #logLines > 18 then
        local old = table.remove(logLines, 1)
        old:Destroy()
    end
    
    LogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, logIndex * 15)
    task.wait(0.05)
    LogScrollFrame.CanvasPosition = Vector2.new(0, LogScrollFrame.CanvasSize.Y.Offset)
end

local ProgressFrame = Instance.new("Frame")
ProgressFrame.Size = UDim2.new(1, -40, 0, 45)
ProgressFrame.Position = UDim2.new(0, 20, 1, -55)
ProgressFrame.BackgroundTransparency = 1
ProgressFrame.ZIndex = 4
ProgressFrame.Parent = TerminalFrame

local ProgressLabel = Instance.new("TextLabel")
ProgressLabel.Size = UDim2.new(0.3, -10, 1, 0)
ProgressLabel.Position = UDim2.new(0, 0, 0, 0)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.Text = "> DEPLOYMENT:"
ProgressLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
ProgressLabel.TextSize = 11
ProgressLabel.Font = Enum.Font.GothamBold
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left
ProgressLabel.ZIndex = 4
ProgressLabel.Parent = ProgressFrame

local ProgressTrack = Instance.new("Frame")
ProgressTrack.Size = UDim2.new(0.7, 0, 0, 12)
ProgressTrack.Position = UDim2.new(0.3, 0, 0.3, 0)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
ProgressTrack.BorderSizePixel = 1
ProgressTrack.BorderColor3 = Color3.fromRGB(200, 50, 50)
ProgressTrack.ZIndex = 4
ProgressTrack.Parent = ProgressFrame

local TrackCorner = Instance.new("UICorner", ProgressTrack)
TrackCorner.CornerRadius = UDim.new(1, 0)

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
ProgressFill.BorderSizePixel = 0
ProgressFill.ZIndex = 5
ProgressFill.Parent = ProgressTrack

local FillCorner = Instance.new("UICorner", ProgressFill)
FillCorner.CornerRadius = UDim.new(1, 0)

local ProgressPercent = Instance.new("TextLabel")
ProgressPercent.Size = UDim2.new(0.3, -10, 1, 0)
ProgressPercent.Position = UDim2.new(1, 0, 0, 0)
ProgressPercent.BackgroundTransparency = 1
ProgressPercent.Text = "0%"
ProgressPercent.TextColor3 = Color3.fromRGB(255, 100, 100)
ProgressPercent.TextSize = 11
ProgressPercent.Font = Enum.Font.GothamBold
ProgressPercent.TextXAlignment = Enum.TextXAlignment.Right
ProgressPercent.ZIndex = 4
ProgressPercent.Parent = ProgressFrame

local StatusBar = Instance.new("Frame")
StatusBar.Size = UDim2.new(1, 0, 0, 22)
StatusBar.Position = UDim2.new(0, 0, 1, -22)
StatusBar.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
StatusBar.BorderSizePixel = 0
StatusBar.ZIndex = 4
StatusBar.Parent = TerminalFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 1, 0)
StatusText.Position = UDim2.new(0, 10, 0, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "> ARENA_SYNC_ACTIVE | READY_TO_DEPLOY: FALSE | PROTOCOL: v3.0"
StatusText.TextColor3 = Color3.fromRGB(150, 100, 100)
StatusText.TextSize = 9
StatusText.Font = Enum.Font.Code
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.ZIndex = 4
StatusText.Parent = StatusBar

task.spawn(function()
    local statuses = {
        "> ARENA_SYNC_ACTIVE | READY_TO_DEPLOY: FALSE | PROTOCOL: v3.0",
        "> WAITING_FOR_SERVER | PING: " .. math.random(50, 200) .. "ms",
        "> COMBAT_ENGINE: STANDBY | OPPONENT: NULL",
        "> ARENA_SYNC_ACTIVE | LOADING_ASSETS...",
    }
    local idx = 1
    while ScreenGui.Parent do
        StatusText.Text = statuses[idx % #statuses + 1]
        idx = idx + 1
        task.wait(3)
    end
end)

task.spawn(function()
    for _, log in ipairs(logMessages) do
        task.wait(math.random(4, 10) * 0.1)
        addLog(log.txt, log.color)
    end
    while ScreenGui.Parent do
        for _, log in ipairs(logMessages) do
            task.wait(math.random(6, 14) * 0.1)
            addLog(log.txt, log.color)
        end
    end
end)

local progress = 0

local steps = {
    {target = 4.2,   speed = 2.5}, {target = 9.5,   speed = 3.0},
    {target = 15.3,  speed = 3.5}, {target = 21.8,  speed = 4.0},
    {target = 28.7,  speed = 4.5}, {target = 36.1,  speed = 5.0},
    {target = 43.9,  speed = 5.5}, {target = 51.4,  speed = 6.0},
    {target = 58.2,  speed = 6.5}, {target = 64.8,  speed = 7.0},
    {target = 71.3,  speed = 7.5}, {target = 77.5,  speed = 8.0},
    {target = 83.2,  speed = 8.5}, {target = 88.6,  speed = 9.0},
    {target = 92.4,  speed = 9.5}, {target = 95.1,  speed = 10.0},
    {target = 96.2,  speed = 12.0},
}

for _, step in ipairs(steps) do
    while progress < step.target do
        progress = math.min(progress + 0.08, step.target)
        ProgressFill:TweenSize(UDim2.new(progress / 100, 0, 1, 0), "Linear", nil, 0.1)
        ProgressPercent.Text = string.format("%.1f%%", progress)
        task.wait(step.speed * 0.08)
    end
    task.wait(step.speed * 0.5)
end

ProgressPercent.Text = "96.2%"
ProgressPercent.TextColor3 = Color3.fromRGB(255, 200, 100)
StatusText.Text = "> DEPLOYMENT_STALLED | ERROR_CODE: 0x96 | CONTACT_SUPPORT"
addLog("> [ERROR] Deployment stalled at 96.2% - Check connection", Color3.fromRGB(255, 80, 80))

print("[ArenaTerminal] Loading stuck at 96.2%")

task.spawn(function()
    local blink = false
    while ScreenGui.Parent do
        blink = not blink
        if blink then
            ProgressPercent.TextColor3 = Color3.fromRGB(255, 100, 100)
            StatusText.TextColor3 = Color3.fromRGB(255, 80, 80)
        else
            ProgressPercent.TextColor3 = Color3.fromRGB(255, 200, 100)
            StatusText.TextColor3 = Color3.fromRGB(150, 100, 100)
        end
        task.wait(0.8)
    end
end)
]])()
