-- Loading Screen | Blazehubscript
-- Infinite loading with terminal logs (Arena Battle Theme)
-- New Terminal: Combat-style HUD with damage numbers and kill feed
-- Progress: Fast at start, slow in middle, EXTREMELY SLOW at end, stuck at 99.8% forever
-- Duration: ~45-60 seconds total before stuck
 
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
 
-- Remove old if exists
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("LoadingScreen") then
        game:GetService("CoreGui"):FindFirstChild("LoadingScreen"):Destroy()
    end
end)
if LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen") then
    LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen"):Destroy()
end
 
-- ========== SCREENGUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoadingScreen"
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
 
-- ========== BACKGROUND (Arena Theme) ==========
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
Background.BorderSizePixel = 0
Background.ZIndex = 1
Background.Parent = ScreenGui
 
-- Blood splatter overlay
local BloodOverlay = Instance.new("Frame")
BloodOverlay.Size = UDim2.new(1, 0, 1, 0)
BloodOverlay.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
BloodOverlay.BackgroundTransparency = 0.85
BloodOverlay.ZIndex = 1
BloodOverlay.Parent = Background
 
-- Arena floor grid effect
local GridContainer = Instance.new("Frame")
GridContainer.Size = UDim2.new(1, 0, 1, 0)
GridContainer.BackgroundTransparency = 1
GridContainer.ZIndex = 2
GridContainer.Parent = Background
 
for i = 0, 20 do
    local lineH = Instance.new("Frame")
    lineH.Size = UDim2.new(1, 0, 0, 1)
    lineH.Position = UDim2.new(0, 0, i / 20, 0)
    lineH.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    lineH.BackgroundTransparency = 0.7
    lineH.BorderSizePixel = 0
    lineH.ZIndex = 2
    lineH.Parent = GridContainer
 
    local lineV = Instance.new("Frame")
    lineV.Size = UDim2.new(0, 1, 1, 0)
    lineV.Position = UDim2.new(i / 20, 0, 0, 0)
    lineV.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    lineV.BackgroundTransparency = 0.7
    lineV.BorderSizePixel = 0
    lineV.ZIndex = 2
    lineV.Parent = GridContainer
end
 
-- Floating particles (dust/blood)
local ParticleContainer = Instance.new("Frame")
ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
ParticleContainer.BackgroundTransparency = 1
ParticleContainer.ZIndex = 10
ParticleContainer.Parent = Background
 
local particles = {}
for i = 1, 50 do
    local particle = Instance.new("TextLabel")
    particle.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundTransparency = 1
    particle.Text = math.random(1, 3) == 1 and "💀" or (math.random(1, 2) == 1 and "⚔️" or "🩸")
    particle.TextColor3 = Color3.fromRGB(180, 50, 50)
    particle.TextSize = math.random(12, 20)
    particle.Font = Enum.Font.Arial
    particle.TextTransparency = math.random(30, 70) / 100
    particle.ZIndex = 10
    particle.Parent = ParticleContainer
 
    table.insert(particles, {
        label = particle,
        x = math.random() * 100,
        y = math.random() * 100,
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
 
-- ========== PROGRESS BAR (Arena Style) - LON
Advertisement

Meet Christian Singles in
