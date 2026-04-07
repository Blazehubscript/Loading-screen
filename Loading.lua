-- Loading Screen | Modern Theme
-- Infinite loading with glassmorphism & animated orbs
-- Credit: MADE BY SUMMER SCRIPT

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
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

-- ========== MODERN BACKGROUND (Animated Gradient) ==========
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
Background.BorderSizePixel = 0
Background.ZIndex = 1
Background.Parent = ScreenGui

-- Gradient overlay 1 (top)
local GradientTop = Instance.new("Frame")
GradientTop.Size = UDim2.new(1, 0, 0.5, 0)
GradientTop.Position = UDim2.new(0, 0, 0, 0)
GradientTop.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
GradientTop.BackgroundTransparency = 0.4
GradientTop.BorderSizePixel = 0
GradientTop.ZIndex = 1
GradientTop.Parent = Background

-- Gradient overlay 2 (bottom)
local GradientBottom = Instance.new("Frame")
GradientBottom.Size = UDim2.new(1, 0, 0.5, 0)
GradientBottom.Position = UDim2.new(0, 0, 0.5, 0)
GradientBottom.BackgroundColor3 = Color3.fromRGB(15, 12, 30)
GradientBottom.BackgroundTransparency = 0.3
GradientBottom.BorderSizePixel = 0
GradientBottom.ZIndex = 1
GradientBottom.Parent = Background

-- Animated gradient shift
task.spawn(function()
    local hue = 0
    while ScreenGui.Parent do
        hue = (hue + 0.0015) % 1
        local r = math.sin(hue * math.pi * 2) * 12 + 20
        local g = math.sin((hue + 0.33) * math.pi * 2) * 8 + 15
        local b = math.sin((hue + 0.67) * math.pi * 2) * 18 + 35
        GradientTop.BackgroundColor3 = Color3.fromRGB(r, g, b)
        GradientBottom.BackgroundColor3 = Color3.fromRGB(r * 0.7, g * 0.7, b * 0.7)
        task.wait(0.05)
    end
end)

-- Modern particle system
local ParticleLayer = Instance.new("Frame")
ParticleLayer.Size = UDim2.new(1, 0, 1, 0)
ParticleLayer.BackgroundTransparency = 1
ParticleLayer.ZIndex = 2
ParticleLayer.Parent = Background

local particles = {}
for i = 1, 50 do
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    particle.BackgroundColor3 = Color3.fromRGB(180, 160, 250)
    particle.BackgroundTransparency = math.random(50, 85) / 100
    particle.BorderSizePixel = 0
    particle.ZIndex = 2
    particle.Parent = ParticleLayer
    
    table.insert(particles, {
        frame = particle,
        speedY = math.random(15, 60) / 100,
        speedX = (math.random(-30, 30) / 100)
    })
end

task.spawn(function()
    while ScreenGui.Parent do
        for _, p in ipairs(particles) do
            local newY = p.frame.Position.Y.Scale + (p.speedY / 600)
            local newX = p.frame.Position.X.Scale + (p.speedX / 600)
            if newY > 1 then newY = 0 end
            if newX > 1 then newX = 0 end
            if newX < 0 then newX = 1 end
            p.frame.Position = UDim2.new(newX, 0, newY, 0)
        end
        task.wait(0.05)
    end
end)

-- ========== LEFT PANEL - MADE BY SUMMER SCRIPT ==========
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 220, 0, 280)
LeftPanel.Position = UDim2.new(0, 20, 0.5, -140)
LeftPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LeftPanel.BackgroundTransparency = 0.88
LeftPanel.BorderSizePixel = 0
LeftPanel.ZIndex = 5
LeftPanel.Parent = Background
local LeftCorner = Instance.new("UICorner", LeftPanel)
LeftCorner.CornerRadius = UDim.new(0, 20)

local LeftStroke = Instance.new("UIStroke", LeftPanel)
LeftStroke.Color = Color3.fromRGB(200, 180, 255)
LeftStroke.Thickness = 1
LeftStroke.Transparency = 0.5

-- Creator avatar icon (stylized)
local CreatorIcon = Instance.new("Frame")
CreatorIcon.Size = UDim2.new(0, 60, 0, 60)
CreatorIcon.Position = UDim2.new(0.5, -30, 0, 20)
CreatorIcon.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
CreatorIcon.BackgroundTransparency = 0.85
CreatorIcon.BorderSizePixel = 0
CreatorIcon.ZIndex = 5
CreatorIcon.Parent = LeftPanel
local IconCorner = Instance.new("UICorner", CreatorIcon)
IconCorner.CornerRadius = UDim.new(1, 0)

local IconText = Instance.new("TextLabel")
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "✨"
IconText.TextColor3 = Color3.fromRGB(200, 180, 255)
IconText.TextSize = 32
IconText.Font = Enum.Font.GothamBold
IconText.TextXAlignment = Enum.TextXAlignment.Center
IconText.ZIndex = 5
IconText.Parent = CreatorIcon

-- Credit title
local CreditTitle = Instance.new("TextLabel")
CreditTitle.Size = UDim2.new(1, -20, 0, 20)
CreditTitle.Position = UDim2.new(0, 10, 0, 90)
CreditTitle.BackgroundTransparency = 1
CreditTitle.Text = "CREATOR"
CreditTitle.TextColor3 = Color3.fromRGB(160, 140, 210)
CreditTitle.TextSize = 10
CreditTitle.Font = Enum.Font.Gotham
CreditTitle.TextXAlignment = Enum.TextXAlignment.Center
CreditTitle.ZIndex = 5
CreditTitle.Parent = LeftPanel

-- Credit name (main)
local CreditName = Instance.new("TextLabel")
CreditName.Size = UDim2.new(1, -20, 0, 35)
CreditName.Position = UDim2.new(0, 10, 0, 112)
CreditName.BackgroundTransparency = 1
CreditName.Text = "SUMMER SCRIPT"
CreditName.TextColor3 = Color3.fromRGB(200, 180, 255)
CreditName.TextSize = 18
CreditName.Font = Enum.Font.GothamBold
CreditName.TextXAlignment = Enum.TextXAlignment.Center
CreditName.ZIndex = 5
CreditName.Parent = LeftPanel

-- Animated glow on credit name
task.spawn(function()
    local glow = 0
    local increasing = true
    while ScreenGui.Parent do
        if increasing then
            glow = glow + 0.02
            if glow >= 1 then increasing = false end
        else
            glow = glow - 0.02
            if glow <= 0.3 then increasing = true end
        end
        CreditName.TextColor3 = Color3.fromRGB(
            200 - glow * 20,
            180 - glow * 30,
            255 - glow * 30
        )
        task.wait(0.05)
    end
end)

-- Divider line
local LeftDivider = Instance.new("Frame")
LeftDivider.Size = UDim2.new(0.8, 0, 0, 1)
LeftDivider.Position = UDim2.new(0.1, 0, 0, 158)
LeftDivider.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
LeftDivider.BackgroundTransparency = 0.7
LeftDivider.BorderSizePixel = 0
LeftDivider.ZIndex = 5
LeftDivider.Parent = LeftPanel

-- Made by text
local MadeByText = Instance.new("TextLabel")
MadeByText.Size = UDim2.new(1, -20, 0, 50)
MadeByText.Position = UDim2.new(0, 10, 0, 170)
MadeByText.BackgroundTransparency = 1
MadeByText.Text = "MADE BY"
MadeByText.TextColor3 = Color3.fromRGB(140, 120, 190)
MadeByText.TextSize = 11
MadeByText.Font = Enum.Font.Gotham
MadeByText.TextXAlignment = Enum.TextXAlignment.Center
MadeByText.ZIndex = 5
MadeByText.Parent = LeftPanel

local SummerText = Instance.new("TextLabel")
SummerText.Size = UDim2.new(1, -20, 0, 35)
SummerText.Position = UDim2.new(0, 10, 0, 210)
SummerText.BackgroundTransparency = 1
SummerText.Text = "SUMMER SCRIPT"
SummerText.TextColor3 = Color3.fromRGB(200, 180, 255)
SummerText.TextSize = 16
SummerText.Font = Enum.Font.GothamBold
SummerText.TextXAlignment = Enum.TextXAlignment.Center
SummerText.ZIndex = 5
SummerText.Parent = LeftPanel

-- Version text
local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, -20, 0, 20)
VersionText.Position = UDim2.new(0, 10, 0, 250)
VersionText.BackgroundTransparency = 1
VersionText.Text = "v2.0.0 | MODERN"
VersionText.TextColor3 = Color3.fromRGB(120, 100, 170)
VersionText.TextSize = 9
VersionText.Font = Enum.Font.Gotham
VersionText.TextXAlignment = Enum.TextXAlignment.Center
VersionText.ZIndex = 5
VersionText.Parent = LeftPanel

-- ========== RIGHT PANEL - FEATURES ==========
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0, 250, 0, 320)
RightPanel.Position = UDim2.new(1, -270, 0.5, -160)
RightPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RightPanel.BackgroundTransparency = 0.88
RightPanel.BorderSizePixel = 0
RightPanel.ZIndex = 5
RightPanel.Parent = Background
local RightCorner = Instance.new("UICorner", RightPanel)
RightCorner.CornerRadius = UDim.new(0, 20)

local RightStroke = Instance.new("UIStroke", RightPanel)
RightStroke.Color = Color3.fromRGB(200, 180, 255)
RightStroke.Thickness = 1
RightStroke.Transparency = 0.5

-- Features header
local FeaturesHeader = Instance.new("TextLabel")
FeaturesHeader.Size = UDim2.new(1, -20, 0, 35)
FeaturesHeader.Position = UDim2.new(0, 10, 0, 15)
FeaturesHeader.BackgroundTransparency = 1
FeaturesHeader.Text = "⚡ FEATURES"
FeaturesHeader.TextColor3 = Color3.fromRGB(200, 180, 255)
FeaturesHeader.TextSize = 18
FeaturesHeader.Font = Enum.Font.GothamBold
FeaturesHeader.TextXAlignment = Enum.TextXAlignment.Center
FeaturesHeader.ZIndex = 5
FeaturesHeader.Parent = RightPanel

-- Features subtitle
local FeaturesSub = Instance.new("TextLabel")
FeaturesSub.Size = UDim2.new(1, -20, 0, 20)
FeaturesSub.Position = UDim2.new(0, 10, 0, 52)
FeaturesSub.BackgroundTransparency = 1
FeaturesSub.Text = "ACTIVE MODULES"
FeaturesSub.TextColor3 = Color3.fromRGB(140, 120, 190)
FeaturesSub.TextSize = 9
FeaturesSub.Font = Enum.Font.Gotham
FeaturesSub.TextXAlignment = Enum.TextXAlignment.Center
FeaturesSub.ZIndex = 5
FeaturesSub.Parent = RightPanel

-- Divider
local RightDivider = Instance.new("Frame")
RightDivider.Size = UDim2.new(0.8, 0, 0, 1)
RightDivider.Position = UDim2.new(0.1, 0, 0, 80)
RightDivider.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
RightDivider.BackgroundTransparency = 0.7
RightDivider.BorderSizePixel = 0
RightDivider.ZIndex = 5
RightDivider.Parent = RightPanel

-- Feature list container
local FeatureContainer = Instance.new("Frame")
FeatureContainer.Size = UDim2.new(1, -20, 0, 200)
FeatureContainer.Position = UDim2.new(0, 10, 0, 95)
FeatureContainer.BackgroundTransparency = 1
FeatureContainer.ZIndex = 5
FeatureContainer.Parent = RightPanel

local features = {
    {name = "ESP CANDY", icon = "🍬", desc = "Player ESP & Item highlight"},
    {name = "AUTO POPCORN", icon = "🍿", desc = "Auto collect popcorn"},
    {name = "AUTO FARM", icon = "🌾", desc = "Auto farming system"},
    {name = "DUPE", icon = "🔄", desc = "Item duplication exploit"}
}

for i, feature in ipairs(features) do
    local yPos = (i - 1) * 48
    
    local featureFrame = Instance.new("Frame")
    featureFrame.Size = UDim2.new(1, 0, 0, 42)
    featureFrame.Position = UDim2.new(0, 0, 0, yPos)
    featureFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
    featureFrame.BackgroundTransparency = 0.5
    featureFrame.BorderSizePixel = 0
    featureFrame.ZIndex = 5
    featureFrame.Parent = FeatureContainer
    local featureFrameCorner = Instance.new("UICorner", featureFrame)
    featureFrameCorner.CornerRadius = UDim.new(0, 10)
    
    -- Feature icon
    local featureIcon = Instance.new("TextLabel")
    featureIcon.Size = UDim2.new(0, 35, 1, 0)
    featureIcon.Position = UDim2.new(0, 8, 0, 0)
    featureIcon.BackgroundTransparency = 1
    featureIcon.Text = feature.icon
    featureIcon.TextColor3 = Color3.fromRGB(200, 180, 255)
    featureIcon.TextSize = 20
    featureIcon.Font = Enum.Font.Gotham
    featureIcon.TextXAlignment = Enum.TextXAlignment.Center
    featureIcon.ZIndex = 5
    featureIcon.Parent = featureFrame
    
    -- Feature name
    local featureName = Instance.new("TextLabel")
    featureName.Size = UDim2.new(1, -55, 0, 18)
    featureName.Position = UDim2.new(0, 48, 0, 6)
    featureName.BackgroundTransparency = 1
    featureName.Text = feature.name
    featureName.TextColor3 = Color3.fromRGB(200, 180, 255)
    featureName.TextSize = 12
    featureName.Font = Enum.Font.GothamBold
    featureName.TextXAlignment = Enum.TextXAlignment.Left
    featureName.ZIndex = 5
    featureName.Parent = featureFrame
    
    -- Feature description
    local featureDesc = Instance.new("TextLabel")
    featureDesc.Size = UDim2.new(1, -55, 0, 14)
    featureDesc.Position = UDim2.new(0, 48, 0, 24)
    featureDesc.BackgroundTransparency = 1
    featureDesc.Text = feature.desc
    featureDesc.TextColor3 = Color3.fromRGB(130, 110, 180)
    featureDesc.TextSize = 9
    featureDesc.Font = Enum.Font.Gotham
    featureDesc.TextXAlignment = Enum.TextXAlignment.Left
    featureDesc.ZIndex = 5
    featureDesc.Parent = featureFrame
    
    -- Status indicator
    local statusDot = Instance.new("Frame")
    statusDot.Size = UDim2.new(0, 6, 0, 6)
    statusDot.Position = UDim2.new(1, -14, 0.5, -3)
    statusDot.BackgroundColor3 = Color3.fromRGB(80, 200, 100)
    statusDot.BorderSizePixel = 0
    statusDot.ZIndex = 5
    statusDot.Parent = featureFrame
    local dotCorner = Instance.new("UICorner", statusDot)
    dotCorner.CornerRadius = UDim.new(1, 0)
    
    -- Blinking status
    task.spawn(function()
        local blink = false
        while ScreenGui.Parent do
            blink = not blink
            statusDot.BackgroundColor3 = blink and Color3.fromRGB(100, 220, 120) or Color3.fromRGB(50, 150, 70)
            task.wait(0.8)
        end
    end)
end

-- Bottom text on right panel
local RightFooter = Instance.new("TextLabel")
RightFooter.Size = UDim2.new(1, -20, 0, 20)
RightFooter.Position = UDim2.new(0, 10, 1, -28)
RightFooter.BackgroundTransparency = 1
RightFooter.Text = "● ALL SYSTEMS ONLINE"
RightFooter.TextColor3 = Color3.fromRGB(100, 200, 120)
RightFooter.TextSize = 9
RightFooter.Font = Enum.Font.Gotham
RightFooter.TextXAlignment = Enum.TextXAlignment.Center
RightFooter.ZIndex = 5
RightFooter.Parent = RightPanel

-- ========== MODERN ANIMATING ORBS ==========
local OrbContainer = Instance.new("Frame")
OrbContainer.Size = UDim2.new(1, 0, 1, 0)
OrbContainer.BackgroundTransparency = 1
OrbContainer.ZIndex = 3
OrbContainer.Parent = Background

-- Orb 1 (Large - Glassmorphism)
local Orb1 = Instance.new("Frame")
Orb1.Size = UDim2.new(0, 220, 0, 220)
Orb1.Position = UDim2.new(0.5, -110, 0.5, -110)
Orb1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orb1.BackgroundTransparency = 0.94
Orb1.BorderSizePixel = 0
Orb1.ZIndex = 3
Orb1.Parent = OrbContainer
local Orb1Corner = Instance.new("UICorner", Orb1)
Orb1Corner.CornerRadius = UDim.new(1, 0)

local Orb1Border = Instance.new("UIStroke", Orb1)
Orb1Border.Color = Color3.fromRGB(200, 180, 255)
Orb1Border.Thickness = 1.5
Orb1Border.Transparency = 0.5

local Orb1Glow = Instance.new("Frame")
Orb1Glow.Size = UDim2.new(0.85, 0, 0.85, 0)
Orb1Glow.Position = UDim2.new(0.075, 0, 0.075, 0)
Orb1Glow.BackgroundColor3 = Color3.fromRGB(150, 120, 250)
Orb1Glow.BackgroundTransparency = 0.92
Orb1Glow.BorderSizePixel = 0
Orb1Glow.ZIndex = 2
Orb1Glow.Parent = Orb1
local GlowCorner = Instance.new("UICorner", Orb1Glow)
GlowCorner.CornerRadius = UDim.new(1, 0)

-- Orb 2 (Medium)
local Orb2 = Instance.new("Frame")
Orb2.Size = UDim2.new(0, 130, 0, 130)
Orb2.Position = UDim2.new(0.22, -65, 0.18, -65)
Orb2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orb2.BackgroundTransparency = 0.95
Orb2.BorderSizePixel = 0
Orb2.ZIndex = 3
Orb2.Parent = OrbContainer
local Orb2Corner = Instance.new("UICorner", Orb2)
Orb2Corner.CornerRadius = UDim.new(1, 0)

local Orb2Border = Instance.new("UIStroke", Orb2)
Orb2Border.Color = Color3.fromRGB(180, 160, 230)
Orb2Border.Thickness = 1
Orb2Border.Transparency = 0.65

-- Orb 3 (Small)
local Orb3 = Instance.new("Frame")
Orb3.Size = UDim2.new(0, 85, 0, 85)
Orb3.Position = UDim2.new(0.78, -42.5, 0.78, -42.5)
Orb3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orb3.BackgroundTransparency = 0.96
Orb3.BorderSizePixel = 0
Orb3.ZIndex = 3
Orb3.Parent = OrbContainer
local Orb3Corner = Instance.new("UICorner", Orb3)
Orb3Corner.CornerRadius = UDim.new(1, 0)

local Orb3Border = Instance.new("UIStroke", Orb3)
Orb3Border.Color = Color3.fromRGB(160, 140, 210)
Orb3Border.Thickness = 1
Orb3Border.Transparency = 0.7

-- Orb pulsing animation
local function animateOrb(orb, orbGlow, baseSize, pulseAmount)
    local growing = true
    
    while ScreenGui.Parent do
        local targetSize = baseSize
        local targetGlowSize = baseSize * 0.85
        
        if growing then
            targetSize = baseSize + pulseAmount
            targetGlowSize = (baseSize + pulseAmount) * 0.85
        else
            targetSize = baseSize - (pulseAmount * 0.6)
            targetGlowSize = (baseSize - (pulseAmount * 0.6)) * 0.85
        end
        
        local sizeUDim = UDim2.new(0, targetSize, 0, targetSize)
        local posOffset = -targetSize / 2
        local posUDim = UDim2.new(orb.Position.X.Scale, posOffset, orb.Position.Y.Scale, posOffset)
        
        local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        TweenService:Create(orb, tweenInfo, {Size = sizeUDim, Position = posUDim}):Play()
        
        if orbGlow then
            local glowSize = targetSize * 0.85
            local glowOffset = -(glowSize - targetSize) / 2
            TweenService:Create(orbGlow, tweenInfo, {
                Size = UDim2.new(0, glowSize, 0, glowSize),
                Position = UDim2.new(glowOffset / targetSize, 0, glowOffset / targetSize, 0)
            }):Play()
        end
        
        growing = not growing
        task.wait(2.8)
    end
end

task.spawn(function() animateOrb(Orb1, Orb1Glow, 220, 25) end)
task.spawn(function() animateOrb(Orb2, nil, 130, 18) end)
task.spawn(function() animateOrb(Orb3, nil, 85, 12) end)

-- Orb rotation
local function rotateOrbs()
    local angle = 0
    while ScreenGui.Parent do
        angle = angle + 0.0025
        local offsetX = math.sin(angle) * 35
        local offsetY = math.cos(angle * 0.85) * 22
        local offsetX2 = math.cos(angle) * 30
        local offsetY2 = math.sin(angle * 0.7) * 18
        
        Orb2.Position = UDim2.new(0.22, -65 + offsetX, 0.18, -65 + offsetY)
        Orb3.Position = UDim2.new(0.78, -42.5 + offsetX2, 0.78, -42.5 + offsetY2)
        
        task.wait(0.05)
    end
end

task.spawn(rotateOrbs)

-- ========== LOADING SCREEN INSIDE ORBS ==========
local InnerLoadingFrame = Instance.new("Frame")
InnerLoadingFrame.Size = UDim2.new(0, 180, 0, 140)
InnerLoadingFrame.Position = UDim2.new(0.5, -90, 0.5, -70)
InnerLoadingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InnerLoadingFrame.BackgroundTransparency = 0.9
InnerLoadingFrame.BorderSizePixel = 0
InnerLoadingFrame.ZIndex = 10
InnerLoadingFrame.Parent = OrbContainer
local InnerCorner = Instance.new("UICorner", InnerLoadingFrame)
InnerCorner.CornerRadius = UDim.new(0, 22)

local InnerStroke = Instance.new("UIStroke", InnerLoadingFrame)
InnerStroke.Color = Color3.fromRGB(200, 180, 255)
InnerStroke.Thickness = 1.2
InnerStroke.Transparency = 0.5

local BrandText = Instance.new("TextLabel")
BrandText.Size = UDim2.new(1, 0, 0, 30)
BrandText.Position = UDim2.new(0, 0, 0, 12)
BrandText.BackgroundTransparency = 1
BrandText.Text = "MODERN"
BrandText.TextColor3 = Color3.fromRGB(200, 180, 255)
BrandText.TextSize = 22
BrandText.Font = Enum.Font.GothamBold
BrandText.TextXAlignment = Enum.Text    while ScreenGui.Parent do
        for _, p in ipairs(particles) do
            local newY = p.frame.Position.Y.Scale + (p.speedY / 600)
            local newX = p.frame.Position.X.Scale + (p.speedX / 600)
            if newY > 1 then newY = 0 end
            if newX > 1 then newX = 0 end
            if newX < 0 then newX = 1 end
            p.frame.Position = UDim2.new(newX, 0, newY, 0)
        end
        task.wait(0.05)
    end
end)

-- ========== LEFT PANEL - MADE BY SUMMER SCRIPT ==========
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 220, 0, 280)
LeftPanel.Position = UDim2.new(0, 20, 0.5, -140)
LeftPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LeftPanel.BackgroundTransparency = 0.88
LeftPanel.BorderSizePixel = 0
LeftPanel.ZIndex = 5
LeftPanel.Parent = Background
local LeftCorner = Instance.new("UICorner", LeftPanel)
LeftCorner.CornerRadius = UDim.new(0, 20)

local LeftStroke = Instance.new("UIStroke", LeftPanel)
LeftStroke.Color = Color3.fromRGB(200, 180, 255)
LeftStroke.Thickness = 1
LeftStroke.Transparency = 0.5

-- Creator avatar icon (stylized)
local CreatorIcon = Instance.new("Frame")
CreatorIcon.Size = UDim2.new(0, 60, 0, 60)
CreatorIcon.Position = UDim2.new(0.5, -30, 0, 20)
CreatorIcon.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
CreatorIcon.BackgroundTransparency = 0.85
CreatorIcon.BorderSizePixel = 0
CreatorIcon.ZIndex = 5
CreatorIcon.Parent = LeftPanel
local IconCorner = Instance.new("UICorner", CreatorIcon)
IconCorner.CornerRadius = UDim.new(1, 0)

local IconText = Instance.new("TextLabel")
IconText.Size = UDim2.new(1, 0, 1, 0)
IconText.BackgroundTransparency = 1
IconText.Text = "✨"
IconText.TextColor3 = Color3.fromRGB(200, 180, 255)
IconText.TextSize = 32
IconText.Font = Enum.Font.GothamBold
IconText.TextXAlignment = Enum.TextXAlignment.Center
IconText.ZIndex = 5
IconText.Parent = CreatorIcon

-- Credit title
local CreditTitle = Instance.new("TextLabel")
CreditTitle.Size = UDim2.new(1, -20, 0, 20)
CreditTitle.Position = UDim2.new(0, 10, 0, 90)
CreditTitle.BackgroundTransparency = 1
CreditTitle.Text = "CREATOR"
CreditTitle.TextColor3 = Color3.fromRGB(160, 140, 210)
CreditTitle.TextSize = 10
CreditTitle.Font = Enum.Font.Gotham
CreditTitle.TextXAlignment = Enum.TextXAlignment.Center
CreditTitle.ZIndex = 5
CreditTitle.Parent = LeftPanel

-- Credit name (main)
local CreditName = Instance.new("TextLabel")
CreditName.Size = UDim2.new(1, -20, 0, 35)
CreditName.Position = UDim2.new(0, 10, 0, 112)
CreditName.BackgroundTransparency = 1
CreditName.Text = "SUMMER SCRIPT"
CreditName.TextColor3 = Color3.fromRGB(200, 180, 255)
CreditName.TextSize = 18
CreditName.Font = Enum.Font.GothamBold
CreditName.TextXAlignment = Enum.TextXAlignment.Center
CreditName.ZIndex = 5
CreditName.Parent = LeftPanel

-- Animated glow on credit name
task.spawn(function()
    local glow = 0
    local increasing = true
    while ScreenGui.Parent do
        if increasing then
            glow = glow + 0.02
            if glow >= 1 then increasing = false end
        else
            glow = glow - 0.02
            if glow <= 0.3 then increasing = true end
        end
        CreditName.TextColor3 = Color3.fromRGB(
            200 - glow * 20,
            180 - glow * 30,
            255 - glow * 30
        )
        task.wait(0.05)
    end
end)

-- Divider line
local LeftDivider = Instance.new("Frame")
LeftDivider.Size = UDim2.new(0.8, 0, 0, 1)
LeftDivider.Position = UDim2.new(0.1, 0, 0, 158)
LeftDivider.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
LeftDivider.BackgroundTransparency = 0.7
LeftDivider.BorderSizePixel = 0
LeftDivider.ZIndex = 5
LeftDivider.Parent = LeftPanel

-- Made by text
local MadeByText = Instance.new("TextLabel")
MadeByText.Size = UDim2.new(1, -20, 0, 50)
MadeByText.Position = UDim2.new(0, 10, 0, 170)
MadeByText.BackgroundTransparency = 1
MadeByText.Text = "MADE BY"
MadeByText.TextColor3 = Color3.fromRGB(140, 120, 190)
MadeByText.TextSize = 11
MadeByText.Font = Enum.Font.Gotham
MadeByText.TextXAlignment = Enum.TextXAlignment.Center
MadeByText.ZIndex = 5
MadeByText.Parent = LeftPanel

local SummerText = Instance.new("TextLabel")
SummerText.Size = UDim2.new(1, -20, 0, 35)
SummerText.Position = UDim2.new(0, 10, 0, 210)
SummerText.BackgroundTransparency = 1
SummerText.Text = "SUMMER SCRIPT"
SummerText.TextColor3 = Color3.fromRGB(200, 180, 255)
SummerText.TextSize = 16
SummerText.Font = Enum.Font.GothamBold
SummerText.TextXAlignment = Enum.TextXAlignment.Center
SummerText.ZIndex = 5
SummerText.Parent = LeftPanel

-- Version text
local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, -20, 0, 20)
VersionText.Position = UDim2.new(0, 10, 0, 250)
VersionText.BackgroundTransparency = 1
VersionText.Text = "v2.0.0 | MODERN"
VersionText.TextColor3 = Color3.fromRGB(120, 100, 170)
VersionText.TextSize = 9
VersionText.Font = Enum.Font.Gotham
VersionText.TextXAlignment = Enum.TextXAlignment.Center
VersionText.ZIndex = 5
VersionText.Parent = LeftPanel

-- ========== RIGHT PANEL - FEATURES ==========
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0, 250, 0, 320)
RightPanel.Position = UDim2.new(1, -270, 0.5, -160)
RightPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RightPanel.BackgroundTransparency = 0.88
RightPanel.BorderSizePixel = 0
RightPanel.ZIndex = 5
RightPanel.Parent = Background
local RightCorner = Instance.new("UICorner", RightPanel)
RightCorner.CornerRadius = UDim.new(0, 20)

local RightStroke = Instance.new("UIStroke", RightPanel)
RightStroke.Color = Color3.fromRGB(200, 180, 255)
RightStroke.Thickness = 1
RightStroke.Transparency = 0.5

-- Features header
local FeaturesHeader = Instance.new("TextLabel")
FeaturesHeader.Size = UDim2.new(1, -20, 0, 35)
FeaturesHeader.Position = UDim2.new(0, 10, 0, 15)
FeaturesHeader.BackgroundTransparency = 1
FeaturesHeader.Text = "⚡ FEATURES"
FeaturesHeader.TextColor3 = Color3.fromRGB(200, 180, 255)
FeaturesHeader.TextSize = 18
FeaturesHeader.Font = Enum.Font.GothamBold
FeaturesHeader.TextXAlignment = Enum.TextXAlignment.Center
FeaturesHeader.ZIndex = 5
FeaturesHeader.Parent = RightPanel

-- Features subtitle
local FeaturesSub = Instance.new("TextLabel")
FeaturesSub.Size = UDim2.new(1, -20, 0, 20)
FeaturesSub.Position = UDim2.new(0, 10, 0, 52)
FeaturesSub.BackgroundTransparency = 1
FeaturesSub.Text = "ACTIVE MODULES"
FeaturesSub.TextColor3 = Color3.fromRGB(140, 120, 190)
FeaturesSub.TextSize = 9
FeaturesSub.Font = Enum.Font.Gotham
FeaturesSub.TextXAlignment = Enum.TextXAlignment.Center
FeaturesSub.ZIndex = 5
FeaturesSub.Parent = RightPanel

-- Divider
local RightDivider = Instance.new("Frame")
RightDivider.Size = UDim2.new(0.8, 0, 0, 1)
RightDivider.Position = UDim2.new(0.1, 0, 0, 80)
RightDivider.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
RightDivider.BackgroundTransparency = 0.7
RightDivider.BorderSizePixel = 0
RightDivider.ZIndex = 5
RightDivider.Parent = RightPanel

-- Feature list container
local FeatureContainer = Instance.new("Frame")
FeatureContainer.Size = UDim2.new(1, -20, 0, 200)
FeatureContainer.Position = UDim2.new(0, 10, 0, 95)
FeatureContainer.BackgroundTransparency = 1
FeatureContainer.ZIndex = 5
FeatureContainer.Parent = RightPanel

local features = {
    {name = "ESP CANDY", icon = "🍬", desc = "Player ESP & Item highlight"},
    {name = "AUTO POPCORN", icon = "🍿", desc = "Auto collect popcorn"},
    {name = "AUTO FARM", icon = "🌾", desc = "Auto farming system"},
    {name = "DUPE", icon = "🔄", desc = "Item duplication exploit"}
}

for i, feature in ipairs(features) do
    local yPos = (i - 1) * 48
    
    local featureFrame = Instance.new("Frame")
    featureFrame.Size = UDim2.new(1, 0, 0, 42)
    featureFrame.Position = UDim2.new(0, 0, 0, yPos)
    featureFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
    featureFrame.BackgroundTransparency = 0.5
    featureFrame.BorderSizePixel = 0
    featureFrame.ZIndex = 5
    featureFrame.Parent = FeatureContainer
    local featureFrameCorner = Instance.new("UICorner", featureFrame)
    featureFrameCorner.CornerRadius = UDim.new(0, 10)
    
    -- Feature icon
    local featureIcon = Instance.new("TextLabel")
    featureIcon.Size = UDim2.new(0, 35, 1, 0)
    featureIcon.Position = UDim2.new(0, 8, 0, 0)
    featureIcon.BackgroundTransparency = 1
    featureIcon.Text = feature.icon
    featureIcon.TextColor3 = Color3.fromRGB(200, 180, 255)
    featureIcon.TextSize = 20
    featureIcon.Font = Enum.Font.Gotham
    featureIcon.TextXAlignment = Enum.TextXAlignment.Center
    featureIcon.ZIndex = 5
    featureIcon.Parent = featureFrame
    
    -- Feature name
    local featureName = Instance.new("TextLabel")
    featureName.Size = UDim2.new(1, -55, 0, 18)
    featureName.Position = UDim2.new(0, 48, 0, 6)
    featureName.BackgroundTransparency = 1
    featureName.Text = feature.name
    featureName.TextColor3 = Color3.fromRGB(200, 180, 255)
    featureName.TextSize = 12
    featureName.Font = Enum.Font.GothamBold
    featureName.TextXAlignment = Enum.TextXAlignment.Left
    featureName.ZIndex = 5
    featureName.Parent = featureFrame
    
    -- Feature description
    local featureDesc = Instance.new("TextLabel")
    featureDesc.Size = UDim2.new(1, -55, 0, 14)
    featureDesc.Position = UDim2.new(0, 48, 0, 24)
    featureDesc.BackgroundTransparency = 1
    featureDesc.Text = feature.desc
    featureDesc.TextColor3 = Color3.fromRGB(130, 110, 180)
    featureDesc.TextSize = 9
    featureDesc.Font = Enum.Font.Gotham
    featureDesc.TextXAlignment = Enum.TextXAlignment.Left
    featureDesc.ZIndex = 5
    featureDesc.Parent = featureFrame
    
    -- Status indicator
    local statusDot = Instance.new("Frame")
    statusDot.Size = UDim2.new(0, 6, 0, 6)
    statusDot.Position = UDim2.new(1, -14, 0.5, -3)
    statusDot.BackgroundColor3 = Color3.fromRGB(80, 200, 100)
    statusDot.BorderSizePixel = 0
    statusDot.ZIndex = 5
    statusDot.Parent = featureFrame
    local dotCorner = Instance.new("UICorner", statusDot)
    dotCorner.CornerRadius = UDim.new(1, 0)
    
    -- Blinking status
    task.spawn(function()
        local blink = false
        while ScreenGui.Parent do
            blink = not blink
            statusDot.BackgroundColor3 = blink and Color3.fromRGB(100, 220, 120) or Color3.fromRGB(50, 150, 70)
            task.wait(0.8)
        end
    end)
end

-- Bottom text on right panel
local RightFooter = Instance.new("TextLabel")
RightFooter.Size = UDim2.new(1, -20, 0, 20)
RightFooter.Position = UDim2.new(0, 10, 1, -28)
RightFooter.BackgroundTransparency = 1
RightFooter.Text = "● ALL SYSTEMS ONLINE"
RightFooter.TextColor3 = Color3.fromRGB(100, 200, 120)
RightFooter.TextSize = 9
RightFooter.Font = Enum.Font.Gotham
RightFooter.TextXAlignment = Enum.TextXAlignment.Center
RightFooter.ZIndex = 5
RightFooter.Parent = RightPanel

-- ========== MODERN ANIMATING ORBS ==========
local OrbContainer = Instance.new("Frame")
OrbContainer.Size = UDim2.new(1, 0, 1, 0)
OrbContainer.BackgroundTransparency = 1
OrbContainer.ZIndex = 3
OrbContainer.Parent = Background

-- Orb 1 (Large - Glassmorphism)
local Orb1 = Instance.new("Frame")
Orb1.Size = UDim2.new(0, 220, 0, 220)
Orb1.Position = UDim2.new(0.5, -110, 0.5, -110)
Orb1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orb1.BackgroundTransparency = 0.94
Orb1.BorderSizePixel = 0
Orb1.ZIndex = 3
Orb1.Parent = OrbContainer
local Orb1Corner = Instance.new("UICorner", Orb1)
Orb1Corner.CornerRadius = UDim.new(1, 0)

local Orb1Border = Instance.new("UIStroke", Orb1)
Orb1Border.Color = Color3.fromRGB(200, 180, 255)
Orb1Border.Thickness = 1.5
Orb1Border.Transparency = 0.5

local Orb1Glow = Instance.new("Frame")
Orb1Glow.Size = UDim2.new(0.85, 0, 0.85, 0)
Orb1Glow.Position = UDim2.new(0.075, 0, 0.075, 0)
Orb1Glow.BackgroundColor3 = Color3.fromRGB(150, 120, 250)
Orb1Glow.BackgroundTransparency = 0.92
Orb1Glow.BorderSizePixel = 0
Orb1Glow.ZIndex = 2
Orb1Glow.Parent = Orb1
local GlowCorner = Instance.new("UICorner", Orb1Glow)
GlowCorner.CornerRadius = UDim.new(1, 0)

-- Orb 2 (Medium)
local Orb2 = Instance.new("Frame")
Orb2.Size = UDim2.new(0, 130, 0, 130)
Orb2.Position = UDim2.new(0.22, -65, 0.18, -65)
Orb2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orb2.BackgroundTransparency = 0.95
Orb2.BorderSizePixel = 0
Orb2.ZIndex = 3
Orb2.Parent = OrbContainer
local Orb2Corner = Instance.new("UICorner", Orb2)
Orb2Corner.CornerRadius = UDim.new(1, 0)

local Orb2Border = Instance.new("UIStroke", Orb2)
Orb2Border.Color = Color3.fromRGB(180, 160, 230)
Orb2Border.Thickness = 1
Orb2Border.Transparency = 0.65

-- Orb 3 (Small)
local Orb3 = Instance.new("Frame")
Orb3.Size = UDim2.new(0, 85, 0, 85)
Orb3.Position = UDim2.new(0.78, -42.5, 0.78, -42.5)
Orb3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Orb3.BackgroundTransparency = 0.96
Orb3.BorderSizePixel = 0
Orb3.ZIndex = 3
Orb3.Parent = OrbContainer
local Orb3Corner = Instance.new("UICorner", Orb3)
Orb3Corner.CornerRadius = UDim.new(1, 0)

local Orb3Border = Instance.new("UIStroke", Orb3)
Orb3Border.Color = Color3.fromRGB(160, 140, 210)
Orb3Border.Thickness = 1
Orb3Border.Transparency = 0.7

-- Orb pulsing animation
local function animateOrb(orb, orbGlow, baseSize, pulseAmount)
    local growing = true
    
    while ScreenGui.Parent do
        local targetSize = baseSize
        local targetGlowSize = baseSize * 0.85
        
        if growing then
            targetSize = baseSize + pulseAmount
            targetGlowSize = (baseSize + pulseAmount) * 0.85
        else
            targetSize = baseSize - (pulseAmount * 0.6)
            targetGlowSize = (baseSize - (pulseAmount * 0.6)) * 0.85
        end
        
        local sizeUDim = UDim2.new(0, targetSize, 0, targetSize)
        local posOffset = -targetSize / 2
        local posUDim = UDim2.new(orb.Position.X.Scale, posOffset, orb.Position.Y.Scale, posOffset)
        
        local tweenInfo = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        TweenService:Create(orb, tweenInfo, {Size = sizeUDim, Position = posUDim}):Play()
        
        if orbGlow then
            local glowSize = targetSize * 0.85
            local glowOffset = -(glowSize - targetSize) / 2
            TweenService:Create(orbGlow, tweenInfo, {
                Size = UDim2.new(0, glowSize, 0, glowSize),
                Position = UDim2.new(glowOffset / targetSize, 0, glowOffset / targetSize, 0)
            }):Play()
        end
        
        growing = not growing
        task.wait(2.8)
    end
end

task.spawn(function() animateOrb(Orb1, Orb1Glow, 220, 25) end)
task.spawn(function() animateOrb(Orb2, nil, 130, 18) end)
task.spawn(function() animateOrb(Orb3, nil, 85, 12) end)

-- Orb rotation
local function rotateOrbs()
    local angle = 0
    while ScreenGui.Parent do
        angle = angle + 0.0025
        local offsetX = math.sin(angle) * 35
        local offsetY = math.cos(angle * 0.85) * 22
        local offsetX2 = math.cos(angle) * 30
        local offsetY2 = math.sin(angle * 0.7) * 18
        
        Orb2.Position = UDim2.new(0.22, -65 + offsetX, 0.18, -65 + offsetY)
        Orb3.Position = UDim2.new(0.78, -42.5 + offset X2, 0.78, -42.5 + offsetY2)
        
        task.wait(0.05)
    end
end

task.spawn(rotateOrbs)

-- ========== LOADING SCREEN INSIDE ORBS ==========
local InnerLoadingFrame = Instance.new("Frame")
InnerLoadingFrame.Size = UDim2.new(0, 180, 0, 140)
InnerLoadingFrame.Position = UDim2.new(0.5, -90, 0.5, -70)
InnerLoadingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InnerLoadingFrame.BackgroundTransparency = 0.9
InnerLoadingFrame.BorderSizePixel = 0
InnerLoadingFrame.ZIndex = 10
InnerLoadingFrame.Parent = OrbContainer
local InnerCorner = Instance.new("UICorner", InnerLoadingFrame)
InnerCorner.CornerRadius = UDim.new(0, 22)

local InnerStroke = Instance.new("UIStroke", InnerLoadingFrame)
InnerStroke.Color = Color3.fromRGB(200, 180, 255)
InnerStroke.Thickness = 1.2
InnerStroke.Transparency = 0.5

local BrandText = Instance.new("TextLabel")
BrandText.Size = UDim2.new(1, 0, 0, 30)
BrandText.Position = UDim2.new(0, 0, 0, 12)
BrandText.BackgroundTransparency = 1
BrandText.Text = "MODERN"
BrandText.TextColor3 = Color3.fromRGB(200, 180, 255)
BrandText.TextSize = 22
BrandText.Font = Enum.Font.GothamBold
BrandText.TextXAlignment = Enum.TextXAlignment.Center
BrandText.ZIndex = 10
BrandText.Parent = InnerLoadingFrame

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, 0, 0, 16)
SubText.Position = UDim2.new(0, 0, 0, 44)
SubText.BackgroundTransparency = 1
SubText.Text = "Initializing System"
SubText.TextColor3 = Color3.fromRGB(160, 140, 210)
SubText.TextSize = 10
SubText.Font = Enum.Font.Gotham
SubText.TextXAlignment = Enum.TextXAlignment.Center
SubText.ZIndex = 10
SubText.Parent = InnerLoadingFrame

task.spawn(function()
    local dots = 0
    while ScreenGui.Parent do
        dots = (dots + 1) % 4
        SubText.Text = "Initializing System" .. string.rep(".", dots)
        task.wait(0.4)
    end
end)

local ProgressTrack = Instance.new("Frame")
ProgressTrack.Size = UDim2.new(0.8, 0, 0, 3)
ProgressTrack.Position = UDim2.new(0.1, 0, 0, 68)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
ProgressTrack.BorderSizePixel = 0
ProgressTrack.ZIndex = 10
ProgressTrack.Parent = InnerLoadingFrame
local TrackCorner = Instance.new("UICorner", ProgressTrack)
TrackCorner.CornerRadius = UDim.new(1, 0)

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(200, 180, 255)
ProgressFill.BorderSizePixel = 0
ProgressFill.ZIndex = 11
ProgressFill.Parent = ProgressTrack
local FillCorner = Instance.new("UICorner", ProgressFill)
FillCorner.CornerRadius = UDim.new(1, 0)

local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 0, 14)
PercentText.Position = UDim2.new(0, 0, 0, 78)
PercentText.BackgroundTransparency = 1
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(200, 180, 255)
PercentText.TextSize = 11
PercentText.Font = Enum.Font.GothamBold
PercentText.TextXAlignment = Enum.TextXAlignment.Center
PercentText.ZIndex = 10
PercentText.Parent = InnerLoadingFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 12)
StatusText.Position = UDim2.new(0, 0, 0, 96)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Loading modules..."
StatusText.TextColor3 = Color3.fromRGB(130, 110, 180)
StatusText.TextSize = 8
StatusText.Font = Enum.Font.Gotham
StatusText.TextXAlignment = Enum.TextXAlignment.Center
StatusText.ZIndex = 10
StatusText.Parent = InnerLoadingFrame

-- ========== BOTTOM LOGS PANEL ==========
local LogPanel = Instance.new("Frame")
LogPanel.Size = UDim2.new(0, 500, 0, 100)
LogPanel.Position = UDim2.new(0.5, -250, 1, -110)
LogPanel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogPanel.BackgroundTransparency = 0.92
LogPanel.BorderSizePixel = 0
LogPanel.ZIndex = 5
LogPanel.Parent = Background
local LogPanelCorner = Instance.new("UICorner", LogPanel)
LogPanelCorner.CornerRadius = UDim.new(0, 14)

local LogPanelStroke = Instance.new("UIStroke", LogPanel)
LogPanelStroke.Color = Color3.fromRGB(200, 180, 255)
LogPanelStroke.Thickness = 1
LogPanelStroke.Transparency = 0.55

local LogHeader = Instance.new("Frame")
LogHeader.Size = UDim2.new(1, 0, 0, 26)
LogHeader.Position = UDim2.new(0, 0, 0, 0)
LogHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogHeader.BackgroundTransparency = 0.96
LogHeader.BorderSizePixel = 0
LogHeader.ZIndex = 5
LogHeader.Parent = LogPanel

local LogTitle = Instance.new("TextLabel")
LogTitle.Size = UDim2.new(1, -15, 0, 26)
LogTitle.Position = UDim2.new(0, 12, 0, 0)
LogTitle.BackgroundTransparency = 1
LogTitle.Text = "📋 SYSTEM LOG"
LogTitle.TextColor3 = Color3.fromRGB(200, 180, 255)
LogTitle.TextSize = 11
LogTitle.Font = Enum.Font.GothamBold
LogTitle.TextXAlignment = Enum.TextXAlignment.Left
LogTitle.ZIndex = 5
LogTitle.Parent = LogHeader

local LogFrame = Instance.new("Frame")
LogFrame.Size = UDim2.new(1, -16, 0, 64)
LogFrame.Position = UDim2.new(0, 8, 0, 32)
LogFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 12)
LogFrame.BackgroundTransparency = 0.4
LogFrame.BorderSizePixel = 0
LogFrame.ZIndex = 5
LogFrame.ClipsDescendants = true
LogFrame.Parent = LogPanel
local LogFrameCorner = Instance.new("UICorner", LogFrame)
LogFrameCorner.CornerRadius = UDim.new(0, 8)

local LogLayout = Instance.new("UIListLayout", LogFrame)
LogLayout.SortOrder = Enum.SortOrder.LayoutOrder
LogLayout.Padding = UDim.new(0, 2)

local logLines = {}
local logIndex = 0

local logMessages = {
    {txt = "✓ Core modules initialized", color = Color3.fromRGB(200, 180, 255)},
    {txt = "→ Establishing secure connection...", color = Color3.fromRGB(160, 140, 210)},
    {txt = "→ Verifying system integrity", color = Color3.fromRGB(140, 120, 190)},
    {txt = "✓ Environment ready", color = Color3.fromRGB(200, 180, 255)},
    {txt = "→ Loading configuration files", color = Color3.fromRGB(160, 140, 210)},
    {txt = "→ Bypassing security layers", color = Color3.fromRGB(140, 120, 190)},
    {txt = "✓ Security check passed", color = Color3.fromRGB(200, 180, 255)},
    {txt = "→ Injecting core components", color = Color3.fromRGB(160, 140, 210)},
    {txt = "✓ ESP CANDY module loaded", color = Color3.fromRGB(200, 180, 255)},
    {txt = "✓ AUTO POPCORN module loaded", color = Color3.fromRGB(200, 180, 255)},
    {txt = "✓ AUTO FARM module loaded", color = Color3.fromRGB(200, 180, 255)},
    {txt = "✓ DUPE module loaded", color = Color3.fromRGB(200, 180, 255)},
    {txt = "→ Synchronizing with server", color = Color3.fromRGB(160, 140, 210)},
    {txt = "→ Finalizing setup", color = Color3.fromRGB(140, 120, 190)},
}

local function addLog(msg, color)
    logIndex += 1
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, 0, 0, 10)
    line.BackgroundTransparency = 1
    line.Text = msg
    line.TextColor3 = color or Color3.fromRGB(140, 120, 190)
    line.TextSize = 9
    line.Font = Enum.Font.Gotham
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.LayoutOrder = logIndex
    line.ZIndex = 6
    line.Parent = LogFrame

    table.insert(logLines, line)

    if #logLines > 6 then
        local old = table.remove(logLines, 1)
        old:Destroy()
    end
end

task.spawn(function()
    while ScreenGui.Parent do
        for _, log in ipairs(logMessages) do
            task.wait(math.random(3, 6) * 0.1)
            addLog(log.txt, log.color)
        end
    end
end)

-- ========== CLICK BLOCKER ==========
local Blocker = Instance.new("TextButton")
Blocker.Size = UDim2.new(1, 0, 1, 0)
Blocker.BackgroundTransparency = 1
Blocker.Text = ""
Blocker.ZIndex = 0
Blocker.Parent = ScreenGui

-- ========== PROGRESS (Stops at 96.2%) ==========
local progress = 0

local steps = {
    {target = 8, speed = 0.8},
    {target = 18, speed = 1.0},
    {target = 29, speed = 1.2},
    {target = 41, speed = 1.4},
    {target = 55, speed = 1.6},
    {target = 67, speed = 1.4},
    {target = 76, speed = 1.8},
    {target = 84, speed = 2.0},
    {target = 91, speed = 1.8},
    {target = 96.2, speed = 2.5},
}

for _, step in ipairs(steps) do
    while progress < step.target do
        progress = math.min(progress + 0.3, step.target)
        TweenService:Create(ProgressFill, TweenInfo.new(0.1), {
            Size = UDim2.new(progress / 100, 0, 1, 0)
        }):Play()
        PercentText.Text = string.format("%.1f%%", progress)
        
        if progress < 20 then
            StatusText.Text = "Loading core modules..."
        elseif progress < 50 then
            StatusText.Text = "Initializing components..."
        elseif progress < 75 then
            StatusText.Text = "Establishing connection..."
        elseif progress < 96.2 then
            StatusText.Text = "Finalizing setup..."
        else
            StatusText.Text = "System stable at 96.2%"
        end
        
        task.wait(step.speed * 0.15)
    end
    task.wait(step.speed)
end

PercentText.Text = "96.2%"
print("[Modern] Loading stuck at 96.2% | Made by Summer Script")
