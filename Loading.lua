-- HACKER LOADING SCREEN (FOR GAME)

local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HackLoading"
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

-- FULLSCREEN FRAME
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1,0,1,0)
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- BLOCK INPUT
local Block = Instance.new("TextButton")
Block.Size = UDim2.new(1,0,1,0)
Block.BackgroundTransparency = 1
Block.Text = ""
Block.AutoButtonColor = false
Block.Parent = Frame

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Position = UDim2.new(0,0,0,10)
Title.Text = "> SYSTEM LOADING _"
Title.TextColor3 = Color3.fromRGB(0,255,150)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code
Title.TextSize = 22
Title.Parent = Frame

-- TERMINAL
local Terminal = Instance.new("TextLabel")
Terminal.Size = UDim2.new(1,-40,1,-120)
Terminal.Position = UDim2.new(0,20,0,60)
Terminal.BackgroundTransparency = 1
Terminal.TextXAlignment = Enum.TextXAlignment.Left
Terminal.TextYAlignment = Enum.TextYAlignment.Top
Terminal.Font = Enum.Font.Code
Terminal.TextSize = 16
Terminal.TextColor3 = Color3.fromRGB(180,130,255)
Terminal.Text = ""
Terminal.TextWrapped = true
Terminal.Parent = Frame

-- PROGRESS BG
local ProgressBG = Instance.new("Frame")
ProgressBG.Size = UDim2.new(1,-40,0,8)
ProgressBG.Position = UDim2.new(0,20,1,-40)
ProgressBG.BackgroundColor3 = Color3.fromRGB(0,50,30)
ProgressBG.BorderSizePixel = 0
ProgressBG.Parent = Frame

-- PROGRESS BAR
local Progress = Instance.new("Frame")
Progress.Size = UDim2.new(0,0,1,0)
Progress.BackgroundColor3 = Color3.fromRGB(0,255,150)
Progress.BorderSizePixel = 0
Progress.Parent = ProgressBG

-- PERCENT
local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(1,0,0,20)
Percent.Position = UDim2.new(0,0,1,-20)
Percent.Text = "0%"
Percent.TextColor3 = Color3.fromRGB(0,255,150)
Percent.BackgroundTransparency = 1
Percent.Font = Enum.Font.Code
Percent.TextSize = 16
Percent.Parent = Frame

-- LOG
local logs = {
"> [SUCCESS] Blazehub module initialized.",
"> Establishing secure connection...",
"> Verifying game integrity...",
"> Injecting execution environment...",
"> Patching anti-tamper routines...",
"> [SUCCESS] Core engine loaded.",
"> Resolving remote endpoints...",
"> Decrypting payload data...",
"> Allocating memory buffer...",
"> [SUCCESS] Trade module verified.",
"> Synchronizing with game server...",
"> Bypassing detection layer 2...",
"> Rewriting function pointers...",
"> [SUCCESS] Auto module verified.",
"> Finalizing injection...",
"> Stack trace cleared."
}

local progress = 0

-- TYPING EFFECT
task.spawn(function()
	for _,v in ipairs(logs) do
		for i = 1,#v do
			Terminal.Text = Terminal.Text .. v:sub(i,i)
			task.wait(0.015)
		end
		Terminal.Text = Terminal.Text .. "\n"
		task.wait(0.15)
	end
end)

-- PROGRESS STUCK
task.spawn(function()
	while true do
		if progress < 99.8 then
			progress += math.random() * 3
			if progress > 99.8 then
				progress = 99.8
			end
		end
		
		Progress.Size = UDim2.new(progress/100,0,1,0)
		Percent.Text = string.format("%.1f%%",progress)
		
		task.wait(0.4)
	end
end)		Progress.Size = UDim2.new(progress/100,0,1,0)
		Percent.Text = string.format("%.1f%%",progress)
		
		wait(0.4)
	end
end)
]])()		Progress.Size = UDim2.new(progress/100,0,1,0)
		Percent.Text = string.format("%.1f%%",progress)
		
		wait(0.4)
	end
end)
]])()
