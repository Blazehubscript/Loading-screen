loadstring([[
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 500, 0, 300)
Frame.Position = UDim2.new(0.5, -250, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1,0,0,30)
TextLabel.Text = "> SYSTEM LOADING _"
TextLabel.TextColor3 = Color3.fromRGB(0,255,150)
TextLabel.BackgroundTransparency = 1
TextLabel.Font = Enum.Font.Code
TextLabel.TextSize = 18
TextLabel.Parent = Frame

local Terminal = Instance.new("TextLabel")
Terminal.Size = UDim2.new(1,-20,1,-80)
Terminal.Position = UDim2.new(0,10,0,40)
Terminal.BackgroundTransparency = 1
Terminal.TextXAlignment = Enum.TextXAlignment.Left
Terminal.TextYAlignment = Enum.TextYAlignment.Top
Terminal.Font = Enum.Font.Code
Terminal.TextSize = 14
Terminal.TextColor3 = Color3.fromRGB(180,130,255)
Terminal.Text = ""
Terminal.TextWrapped = true
Terminal.Parent = Frame

local Progress = Instance.new("Frame")
Progress.Size = UDim2.new(0,0,0,6)
Progress.Position = UDim2.new(0,10,1,-30)
Progress.BackgroundColor3 = Color3.fromRGB(0,255,150)
Progress.Parent = Frame

local Percent = Instance.new("TextLabel")
Percent.Size = UDim2.new(1,0,0,20)
Percent.Position = UDim2.new(0,0,1,-20)
Percent.Text = "0%"
Percent.TextColor3 = Color3.fromRGB(0,255,150)
Percent.BackgroundTransparency = 1
Percent.Font = Enum.Font.Code
Percent.TextSize = 14
Percent.Parent = Frame

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

-- typing effect
spawn(function()
	for i,v in ipairs(logs) do
		for c = 1,#v do
			Terminal.Text = Terminal.Text .. string.sub(v,c,c)
			wait(0.02)
		end
		Terminal.Text = Terminal.Text .. "\n"
		wait(0.2)
	end
end)

-- progress (stuck 99.8%)
spawn(function()
	while true do
		if progress < 99.8 then
			progress = progress + math.random()*3
			if progress > 99.8 then
				progress = 99.8
			end
		end
		
		Progress.Size = UDim2.new(progress/100,0,0,6)
		Percent.Text = string.format("%.1f%%",progress)
		
		wait(0.5)
	end
end)
]])()
