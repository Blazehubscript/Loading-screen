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
BrandText.TextXAlignment = Enum.TextXAlignment.Center
BrandText.ZIndex = 10
BrandText.Parent = InnerLoadingFrame

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(1, 0, 0, 16)
SubText.Position = UDim2.n    {size = 120, startX = 150, startY = 200, intensity = 80, speedX = 0.4, speedY = 0.3, rangeX = 300, rangeY = 200},
    {size = 85, startX = 1200, startY = 500, intensity = 100, speedX = 0.5, speedY = 0.4, rangeX = 350, rangeY = 250},
    {size = 200, startX = 800, startY = 700, intensity = 60, speedX = 0.3, speedY = 0.35, rangeX = 400, rangeY = 300}
}

for i, data in ipairs(orbData) do
    local orb = createOrb(data.size, data.startX, data.startY, data.intensity)
    table.insert(orbs, {
        obj = orb,
        glow = orb:FindFirstChildWhichIsA("Frame"),
        x = data.startX,
        y = data.startY,
        startX = data.startX,
        startY = data.startY,
        size = data.size,
        speedX = data.speedX,
        speedY = data.speedY,
        rangeX = data.rangeX,
        rangeY = data.rangeY,
        angleX = math.random(0, 360),
        angleY = math.random(0, 360),
        pulseTime = math.random(0, 100) / 100,
        intensity = data.intensity
    })
end

-- Animate floating orbs
task.spawn(function()
    local time = 0
    while ScreenGui and ScreenGui.Parent do
        time = time + 0.016
        for _, orb in ipairs(orbs) do
            -- Calculate floating movement
            orb.angleX = orb.angleX + orb.speedX * 0.02
            orb.angleY = orb.angleY + orb.speedY * 0.02
            
            local offsetX = math.sin(orb.angleX) * orb.rangeX * 0.5
            local offsetY = math.cos(orb.angleY) * orb.rangeY * 0.5
            
            local newX = orb.startX + offsetX
            local newY = orb.startY + offsetY
            
            orb.x = newX
            orb.y = newY
            orb.obj.Position = UDim2.new(0, orb.x, 0, orb.y)
            
            -- Pulsing effect
            local pulse = (math.sin(time * 1.5 + orb.pulseTime * 10) + 1) / 2
            local transparency = 0.3 + (pulse * 0.3)
            local intensity = 80 + (pulse * 100)
            orb.obj.BackgroundColor3 = Color3.fromRGB(255, intensity, intensity)
            orb.obj.BackgroundTransparency = transparency
            
            -- Inner glow pulse
            if orb.glow then
                orb.glow.BackgroundColor3 = Color3.fromRGB(255, intensity + 50, intensity + 50)
                orb.glow.BackgroundTransparency = 0.3 + (pulse * 0.3)
            end
            
            -- Scale effect
            local scale = 1 + math.sin(time * 1.2 + orb.pulseTime * 8) * 0.03
            orb.obj.Size = UDim2.new(0, orb.size * scale, 0, orb.size * scale)
        end
        task.wait()
    end
end)

-- ========== HEXAGON GRID EFFECT ==========
local HexGrid = Instance.new("Frame")
HexGrid.Size = UDim2.new(1, 0, 1, 0)
HexGrid.BackgroundTransparency = 1
HexGrid.ZIndex = 2
HexGrid.Parent = Background

local function createHexagon(x, y, size)
    local hex = Instance.new("Frame")
    hex.Size = UDim2.new(0, size, 0, size)
    hex.Position = UDim2.new(0, x, 0, y)
    hex.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    hex.BackgroundTransparency = 0.85
    hex.BorderSizePixel = 1
    hex.BorderColor3 = Color3.fromRGB(255, 70, 70)
    hex.ZIndex = 2
    hex.Parent = HexGrid
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, size * 0.2)
    corner.Parent = hex
    
    return hex
end

-- Create floating hexagons
local hexagons = {}
local hexCount = 35

for i = 1, hexCount do
    local x = math.random(0, 2000)
    local y = math.random(0, 1200)
    local size = math.random(25, 55)
    local hex = createHexagon(x, y, size)
    hex.BackgroundTransparency = math.random(70, 95) / 100
    table.insert(hexagons, {
        obj = hex,
        x = x,
        y = y,
        speedX = (math.random(-30, 30)) / 100,
        speedY = (math.random(-20, 20)) / 100,
        size = size,
        pulse = math.random(0, 100) / 100
    })
end

-- Animate floating hexagons
task.spawn(function()
    local time = 0
    while ScreenGui and ScreenGui.Parent do
        time = time + 0.016
        for _, hex in ipairs(hexagons) do
            local newX = hex.x + hex.speedX
            local newY = hex.y + hex.speedY
            
            if newX > 2000 then newX = -100 end
            if newX < -100 then newX = 2000 end
            if newY > 1200 then newY = -100 end
            if newY < -100 then newY = 1200 end
            
            hex.x = newX
            hex.y = newY
            hex.obj.Position = UDim2.new(0, hex.x, 0, hex.y)
            
            -- Pulsing effect
            local pulse = (math.sin(time * 3 + hex.pulse * 10) + 1) / 2
            local transparency = 0.7 + (pulse * 0.2)
            hex.obj.BackgroundTransparency = transparency
            hex.obj.BorderColor3 = Color3.fromRGB(255, 70 + pulse * 50, 70 + pulse * 50)
            hex.obj.BackgroundColor3 = Color3.fromRGB(255, 70 + pulse * 30, 70 + pulse * 30)
        end
        task.wait()
    end
end)

-- ========== CIRCULAR PROGRESS RING ==========
local CenterRing = Instance.new("Frame")
CenterRing.Size = UDim2.new(0, 220, 0, 220)
CenterRing.Position = UDim2.new(0.5, -110, 0.5, -110)
CenterRing.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
CenterRing.BackgroundTransparency = 0.3
CenterRing.BorderSizePixel = 3
CenterRing.BorderColor3 = Color3.fromRGB(255, 60, 60)
CenterRing.ZIndex = 3
CenterRing.Parent = Background

local RingCorner = Instance.new("UICorner")
RingCorner.CornerRadius = UDim.new(1, 0)
RingCorner.Parent = CenterRing

local RingGlow = Instance.new("Frame")
RingGlow.Size = UDim2.new(1, 10, 1, 10)
RingGlow.Position = UDim2.new(0.5, -5, 0.5, -5)
RingGlow.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
RingGlow.BackgroundTransparency = 0.7
RingGlow.BorderSizePixel = 0
RingGlow.ZIndex = 2
RingGlow.Parent = CenterRing

local RingGlowCorner = Instance.new("UICorner")
RingGlowCorner.CornerRadius = UDim.new(1, 0)
RingGlowCorner.Parent = RingGlow

-- Inner content
local InnerContent = Instance.new("Frame")
InnerContent.Size = UDim2.new(0.85, 0, 0.85, 0)
InnerContent.Position = UDim2.new(0.075, 0, 0.075, 0)
InnerContent.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
InnerContent.BackgroundTransparency = 0.2
InnerContent.BorderSizePixel = 2
InnerContent.BorderColor3 = Color3.fromRGB(255, 70, 70)
InnerContent.ZIndex = 4
InnerContent.Parent = CenterRing

local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(1, 0)
InnerCorner.Parent = InnerContent

-- Percentage text
local PercentText = Instance.new("TextLabel")
PercentText.Size = UDim2.new(1, 0, 0.4, 0)
PercentText.Position = UDim2.new(0, 0, 0.3, 0)
PercentText.BackgroundTransparency = 1
PercentText.Text = "0%"
PercentText.TextColor3 = Color3.fromRGB(255, 80, 80)
PercentText.TextSize = 28
PercentText.Font = Enum.Font.GothamBold
PercentText.ZIndex = 5
PercentText.Parent = InnerContent

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0.25, 0)
StatusText.Position = UDim2.new(0, 0, 0.65, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "INITIALIZING"
StatusText.TextColor3 = Color3.fromRGB(255, 70, 70)
StatusText.TextSize = 10
StatusText.Font = Enum.Font.Gotham
StatusText.ZIndex = 5
StatusText.Parent = InnerContent

-- ========== SIDEBAR TERMINAL ==========
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 320, 1, -40)
Sidebar.Position = UDim2.new(1, -340, 0, 20)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
Sidebar.BackgroundTransparency = 0.15
Sidebar.BorderSizePixel = 2
Sidebar.BorderColor3 = Color3.fromRGB(255, 60, 60)
Sidebar.ZIndex = 3
Sidebar.Parent = Background

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarTitle = Instance.new("TextLabel")
SidebarTitle.Size = UDim2.new(1, -20, 0, 32)
SidebarTitle.Position = UDim2.new(0, 10, 0, 10)
SidebarTitle.BackgroundTransparency = 1
SidebarTitle.Text = "> MYSTRYX TERMINAL v2.4.7"
SidebarTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
SidebarTitle.TextSize = 12
SidebarTitle.Font = Enum.Font.GothamBold
SidebarTitle.TextXAlignment = Enum.TextXAlignment.Left
SidebarTitle.ZIndex = 4
SidebarTitle.Parent = Sidebar

-- Bypass text
local BypassText = Instance.new("TextLabel")
BypassText.Size = UDim2.new(0, 120, 0, 32)
BypassText.Position = UDim2.new(0, 15, 0, 45)
BypassText.BackgroundTransparency = 1
BypassText.Text = "> BYPASS MODE"
BypassText.TextColor3 = Color3.fromRGB(255, 70, 70)
BypassText.TextSize = 11
BypassText.Font = Enum.Font.GothamBold
BypassText.TextXAlignment = Enum.TextXAlignment.Left
BypassText.ZIndex = 4
BypassText.Parent = Sidebar

-- Processing text
local ProcessingText = Instance.new("TextLabel")
ProcessingText.Size = UDim2.new(0, 150, 0, 32)
ProcessingText.Position = UDim2.new(1, -165, 0, 45)
ProcessingText.BackgroundTransparency = 1
ProcessingText.Text = "PROCESSING >"
ProcessingText.TextColor3 = Color3.fromRGB(255, 70, 70)
ProcessingText.TextSize = 11
ProcessingText.Font = Enum.Font.GothamBold
ProcessingText.TextXAlignment = Enum.TextXAlignment.Right
ProcessingText.ZIndex = 4
ProcessingText.Parent = Sidebar

-- Blinking effect for BYPASS
task.spawn(function()
    local blink = false
    while ScreenGui and ScreenGui.Parent do
        blink = not blink
        if blink then
            BypassText.Text = "> BYPASS MODE [ACTIVE]"
            BypassText.TextColor3 = Color3.fromRGB(255, 100, 100)
        else
            BypassText.Text = "> BYPASS MODE"
            BypassText.TextColor3 = Color3.fromRGB(180, 50, 50)
        end
        task.wait(0.6)
    end
end)

-- Animated dots for PROCESSING
task.spawn(function()
    local dot = 0
    while ScreenGui and ScreenGui.Parent do
        dot = dot + 1
        if dot > 3 then dot = 1 end
        ProcessingText.Text = "PROCESSING" .. string.rep(".", dot) .. " >"
        task.wait(0.5)
    end
end)

local LogContainer = Instance.new("Frame")
LogContainer.Size = UDim2.new(1, -20, 1, -90)
LogContainer.Position = UDim2.new(0, 10, 0, 82)
LogContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
LogContainer.BackgroundTransparency = 0.5
LogContainer.BorderSizePixel = 0
LogContainer.ZIndex = 3
LogContainer.ClipsDescendants = true
LogContainer.Parent = Sidebar

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 6)
LogCorner.Parent = LogContainer

local LogLayout = Instance.new("UIListLayout")
LogLayout.SortOrder = Enum.SortOrder.LayoutOrder
LogLayout.Padding = UDim.new(0, 2)
LogLayout.Parent = LogContainer

-- ========== LEFT PANEL ==========
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 280, 1, -40)
LeftPanel.Position = UDim2.new(0, 20, 0, 20)
LeftPanel.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
LeftPanel.BackgroundTransparency = 0.2
LeftPanel.BorderSizePixel = 2
LeftPanel.BorderColor3 = Color3.fromRGB(255, 60, 60)
LeftPanel.ZIndex = 3
LeftPanel.Parent = Background

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 12)
LeftCorner.Parent = LeftPanel

-- Logo
local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 50)
LogoText.Position = UDim2.new(0, 0, 0, 20)
LogoText.BackgroundTransparency = 1
LogoText.Text = "MYSTRIX"
LogoText.TextColor3 = Color3.fromRGB(255, 80, 80)
LogoText.TextSize = 28
LogoText.Font = Enum.Font.GothamBlack
LogoText.ZIndex = 4
LogoText.Parent = LeftPanel

-- ========== SUBTITLE TEXT DIUBAH ==========
local LogoSub = Instance.new("TextLabel")
LogoSub.Size = UDim2.new(1, 0, 0, 20)
LogoSub.Position = UDim2.new(0, 0, 0, 70)
LogoSub.BackgroundTransparency = 1
LogoSub.Text = "BEST PVP ETFB SCRIPT"  -- Text diubah dari "BEST ETFB SCRIPT" menjadi "BEST PVP ETFB SCRIPT"
LogoSub.TextColor3 = Color3.fromRGB(255, 70, 70)
LogoSub.TextSize = 9
LogoSub.Font = Enum.Font.Gotham
LogoSub.ZIndex = 4
LogoSub.Parent = LeftPanel

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.85, 0, 0, 2)
Divider.Position = UDim2.new(0.075, 0, 0, 100)
Divider.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
Divider.BackgroundTransparency = 0.5
Divider.BorderSizePixel = 0
Divider.ZIndex = 4
Divider.Parent = LeftPanel

-- Stats frame
local StatsFrame = Instance.new("Frame")
StatsFrame.Size = UDim2.new(1, -30, 0, 210)
StatsFrame.Position = UDim2.new(0, 15, 0, 115)
StatsFrame.BackgroundTransparency = 1
StatsFrame.ZIndex = 4
StatsFrame.Parent = LeftPanel

local function addStat(parent, y, label, value)
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(0.5, -5, 0, 20)
    labelText.Position = UDim2.new(0, 0, 0, y)
    labelText.BackgroundTransparency = 1
    labelText.Text = label
    labelText.TextColor3 = Color3.fromRGB(200, 60, 60)
    labelText.TextSize = 10
    labelText.Font = Enum.Font.Gotham
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.ZIndex = 4
    labelText.Parent = parent
    
    local valueText = Instance.new("TextLabel")
    valueText.Size = UDim2.new(0.5, -5, 0, 20)
    valueText.Position = UDim2.new(0.5, 5, 0, y)
    valueText.BackgroundTransparency = 1
    valueText.Text = value
    valueText.TextColor3 = Color3.fromRGB(255, 90, 90)
    valueText.TextSize = 10
    valueText.Font = Enum.Font.GothamBold
    valueText.TextXAlignment = Enum.TextXAlignment.Right
    valueText.ZIndex = 4
    valueText.Parent = parent
    
    return valueText
end

local coreVersion = addStat(StatsFrame, 0, "> CORE ENGINE", "v2.4.7")
local encLayer = addStat(StatsFrame, 22, "> ENCRYPTION", "AES-256")
local protocol = addStat(StatsFrame, 44, "> PROTOCOL", "SECURE v3")
local activeNodes = addStat(StatsFrame, 66, "> ACTIVE NODES", "12/12")
local timeStat = addStat(StatsFrame, 88, "> SYSTEM TIME", os.date("%H:%M:%S"))

-- Credit text
local CreditText = Instance.new("TextLabel")
CreditText.Size = UDim2.new(1, -30, 0, 30)
CreditText.Position = UDim2.new(0, 15, 0, 118)
CreditText.BackgroundTransparency = 1
CreditText.Text = "> MADE BY SUMMER SCRIPT"
CreditText.TextColor3 = Color3.fromRGB(255, 70, 70)
CreditText.TextSize = 13
CreditText.Font = Enum.Font.GothamBold
CreditText.TextXAlignment = Enum.TextXAlignment.Left
CreditText.ZIndex = 4
CreditText.Parent = StatsFrame

-- Features text
local FeaturesText = Instance.new("TextLabel")
FeaturesText.Size = UDim2.new(1, -30, 0, 50)
FeaturesText.Position = UDim2.new(0, 15, 0, 152)
FeaturesText.BackgroundTransparency = 1
FeaturesText.Text = "> FEATURES : ESP CANDY, AUTO FARM, AUTO TOWER TRIAL, AUTO ARENA TSUNAMI, ETC."
FeaturesText.TextColor3 = Color3.fromRGB(255, 80, 80)
FeaturesText.TextSize = 10
FeaturesText.Font = Enum.Font.Gotham
FeaturesText.TextXAlignment = Enum.TextXAlignment.Left
FeaturesText.TextWrapped = true
FeaturesText.ZIndex = 4
FeaturesText.Parent = StatsFrame

-- Efek berkedip untuk credit text
task.spawn(function()
    local blinkState = false
    local blinkSpeed = 0.8
    
    while ScreenGui and ScreenGui.Parent do
        blinkState = not blinkState
        
        if blinkState then
            CreditText.TextColor3 = Color3.fromRGB(255, 120, 120)
            CreditText.TextTransparency = 0
            CreditText.TextStrokeTransparency = 0.3
            CreditText.TextStrokeColor3 = Color3.fromRGB(255, 50, 50)
        else
            CreditText.TextColor3 = Color3.fromRGB(180, 60, 60)
            CreditText.TextTransparency = 0.1
            CreditText.TextStrokeTransparency = 0.7
            CreditText.TextStrokeColor3 = Color3.fromRGB(100, 20, 20)
        end
        
        task.wait(blinkSpeed)
    end
end)

-- Efek fade in/out untuk features text
task.spawn(function()
    local pulseTime = 0
    while ScreenGui and ScreenGui.Parent do
        pulseTime = pulseTime + 0.033
        local pulse = (math.sin(pulseTime * 1.5) + 1) / 2
        local intensity = 70 + (pulse * 50)
        FeaturesText.TextColor3 = Color3.fromRGB(255, intensity, intensity)
        task.wait()
    end
end)

-- Divider
local CreditDivider = Instance.new("Frame")
CreditDivider.Size = UDim2.new(0.85, 0, 0, 2)
CreditDivider.Position = UDim2.new(0.075, 0, 0, 113)
CreditDivider.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CreditDivider.BackgroundTransparency = 0.5
CreditDivider.BorderSizePixel = 0
CreditDivider.ZIndex = 4
CreditDivider.Parent = StatsFrame

local FeaturesDivider = Instance.new("Frame")
FeaturesDivider.Size = UDim2.new(0.85, 0, 0, 1)
FeaturesDivider.Position = UDim2.new(0.075, 0, 0, 148)
FeaturesDivider.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
FeaturesDivider.BackgroundTransparency = 0.6
FeaturesDivider.BorderSizePixel = 0
FeaturesDivider.ZIndex = 4
FeaturesDivider.Parent = StatsFrame

-- Update time
task.spawn(function()
    while ScreenGui and ScreenGui.Parent do
        timeStat.Text = os.date("%H:%M:%S")
        task.wait(1)
    end
end)

-- ========== LOG MESSAGES ==========
local logLines = {}
local logIndex = 0

local logMessages = {
    {txt = "[BYPASS] > Bypassing security layer 1...", color = Color3.fromRGB(255, 80, 80)},
    {txt = "[BYPASS] > Security layer 1 bypassed [SUCCESS]", color = Color3.fromRGB(255, 120, 120)},
    {txt = "[PROCESS] > Processing authentication tokens...", color = Color3.fromRGB(255, 70, 70)},
    {txt = "[PROCESS] > Tokens validated [SUCCESS]", color = Color3.fromRGB(255, 120, 120)},
    {txt = "[BYPASS] > Bypassing security layer 2...", color = Color3.fromRGB(255, 80, 80)},
    {txt = "[BYPASS] > Security layer 2 bypassed [SUCCESS]", color = Color3.fromRGB(255, 120, 120)},
    {txt = "[PROCESS] > Processing encryption keys...", color = Color3.fromRGB(255, 70, 70)},
    {txt = "[PROCESS] > Keys decrypted [SUCCESS]", color = Color3.fromRGB(255, 120, 120)},
    {txt = "[BYPASS] > Bypassing firewall...", color = Color3.fromRGB(255, 80, 80)},
    {txt = "[BYPASS] > Firewall bypassed [SUCCESS]", color = Color3.fromRGB(255, 120, 120)},
    {txt = "[PROCESS] > Processing payload injection...", color = Color3.fromRGB(255, 70, 70)},
    {txt = "[PROCESS] > Payload injected [SUCCESS]", color = Color3.fromRGB(255, 120, 120)},
    {txt = "[BYPASS] > Bypassing detection system...", color = Color3.fromRGB(255, 80, 80)},
    {txt = "[BYPASS] > Detection bypassed [SUCCESS]", color = Color3.fromRGB(255, 120, 120)},
    {txt = "[PROCESS] > Finalizing connection...", color = Color3.fromRGB(255, 70, 70)},
    {txt = "[PROCESS] > Connection established [READY]", color = Color3.fromRGB(255, 120, 120)},
}

local function addLog(msg, color)
    logIndex = logIndex + 1
    local line = Instance.new("TextLabel")
    line.Size = UDim2.new(1, 0, 0, 14)
    line.BackgroundTransparency = 1
    line.Text = "> " .. msg
    line.TextColor3 = color or Color3.fromRGB(220, 70, 70)
    line.TextSize = 9
    line.Font = Enum.Font.Code
    line.TextXAlignment = Enum.TextXAlignment.Left
    line.LayoutOrder = logIndex
    line.ZIndex = 4
    line.Parent = LogContainer
    
    table.insert(logLines, line)
    
    if #logLines > 12 then
        local old = table.remove(logLines, 1)
        old:Destroy()
    end
end

-- ========== PROGRESS SIMULATION ==========
local progress = 0

local steps = {
    {target = 8, speed = 0.6},
    {target = 18, speed = 0.8},
    {target = 29, speed = 1.0},
    {target = 41, speed = 1.3},
    {target = 55, speed = 1.6},
    {target = 67, speed = 1.9},
    {target = 76, speed = 2.2},
    {target = 84, speed = 2.6},
    {target = 91, speed = 3.0},
    {target = 94.7, speed = 3.5},
    {target = 96.2, speed = 4.0},
}

local function updateCircularProgress(pct)
    PercentText.Text = string.format("%.1f%%", pct)
    
    local intensity = 60 + (pct / 100) * 195
    CenterRing.BorderColor3 = Color3.fromRGB(255, intensity, intensity)
    RingGlow.BackgroundColor3 = Color3.fromRGB(255, intensity * 0.8, intensity * 0.8)
    
    if pct < 30 then
        StatusText.Text = "BYPASSING..."
    elseif pct < 60 then
        StatusText.Text = "PROCESSING..."
    elseif pct < 85 then
        StatusText.Text = "INJECTING..."
    else
        StatusText.Text = "FINALIZING"
    end
end

-- Start progress animation
task.spawn(function()
    for _, step in ipairs(steps) do
        while progress < step.target do
            progress = math.min(progress + 0.3, step.target)
            updateCircularProgress(progress)
            task.wait(step.speed * 0.1)
        end
        task.wait(step.speed * 0.3)
    end
    
    PercentText.Text = "96.2%"
    StatusText.Text = "AWAITING SIGNAL"
    print("[Mystryx] Loading halted at 96.2% - Signal pending")
end)

-- Log animation
task.spawn(function()
    for i = 1, 5 do
        local log = logMessages[i]
        if log then
            task.wait(0.8)
            addLog(log.txt, log.color)
        end
    end
    
    local logIndexLoop = 1
    while ScreenGui and ScreenGui.Parent do
        task.wait(math.random(2, 4) * 0.3)
        local log = logMessages[logIndexLoop]
        if log then
            addLog(log.txt, log.color)
        end
        logIndexLoop = logIndexLoop + 1
        if logIndexLoop > #logMessages then
            logIndexLoop = 1
        end
    end
end)

-- Pulse animation on center ring
task.spawn(function()
    local pulseTime = 0
    while ScreenGui and ScreenGui.Parent do
        pulseTime = pulseTime + 0.033
        local scale = 1 + math.sin(pulseTime * 3) * 0.02
        CenterRing.Size = UDim2.new(0, 220 * scale, 0, 220 * scale)
        CenterRing.Position = UDim2.new(0.5, -110 * scale, 0.5, -110 * scale)
        task.wait()
    end
end)

-- Entry animations
Background.BackgroundTransparency = 1
TweenService:Create(Background, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(CenterRing, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 220, 0, 220)}):Play()
TweenService:Create(LeftPanel, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 20, 0, 20)}):Play()
TweenService:Create(Sidebar, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -340, 0, 20)}):Play()

-- Fade in orbs
for _, orb in ipairs(orbs) do
    orb.obj.BackgroundTransparency = 0.6
    TweenService:Create(orb.obj, TweenInfo.new(1), {BackgroundTransparency = 0.4}):Play()
end

-- Fade in texts
CreditText.TextTransparency = 1
TweenService:Create(CreditText, TweenInfo.new(1), {TextTransparency = 0}):Play()

FeaturesText.TextTransparency = 1
TweenService:Create(FeaturesText, TweenInfo.new(1.2), {TextTransparency = 0}):Play()

-- Click blocker
local Blocker = Instance.new("TextButton")
Blocker.Size = UDim2.new(1, 0, 1, 0)
Blocker.BackgroundTransparency = 1
Blocker.Text = ""
Blocker.ZIndex = 0
Blocker.Parent = ScreenGui

print("[Mystryx] Loading screen initialized successfully!")
print("[Mystryx] Subtitle: BEST PVP ETFB SCRIPT")
print("[Mystryx] Credit: MADE BY SUMMER SCRIPT")
print("[Mystryx] Features: ESP CANDY, AUTO FARM, AUTO TOWER TRIAL, AUTO ARENA TSUNAMI, ETC.")
