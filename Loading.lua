-- PIKA SCRIPTS LOADING (ROBLOX GUI)

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.IgnoreGuiInset = true

-- MAIN FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(1,0,1,0)
frame.BackgroundColor3 = Color3.fromRGB(5,0,20)

-- GALAXY EFFECT (GRADIENT)
local grad = Instance.new("UIGradient", frame)
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20,0,60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
}
grad.Rotation = 45

-- PANEL
local panel = Instance.new("Frame", frame)
panel.Size = UDim2.new(0,300,0,420)
panel.Position = UDim2.new(0.5,-150,0.5,-210)
panel.BackgroundColor3 = Color3.fromRGB(15,0,40)
panel.BorderSizePixel = 0

local stroke = Instance.new("UIStroke", panel)
stroke.Color = Color3.fromRGB(180,120,255)

-- TITLE
local title = Instance.new("TextLabel", panel)
title.Text = "> PIKA SCRIPTS LOADING"
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(180,120,255)
title.Font = Enum.Font.Code
title.TextSize = 14

-- TIME
local timeLabel = Instance.new("TextLabel", panel)
timeLabel.Size = UDim2.new(1,0,0,20)
timeLabel.Position = UDim2.new(0,0,0,30)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.fromRGB(150,100,255)
timeLabel.Font = Enum.Font.Code
timeLabel.TextSize = 12

-- TERMINAL
local terminal = Instance.new("TextLabel", panel)
terminal.Size = UDim2.new(1,-20,0,200)
terminal.Position = UDim2.new(0,10,0,60)
terminal.BackgroundColor3 = Color3.fromRGB(5,0,20)
terminal.TextColor3 = Color3.fromRGB(180,120,255)
terminal.Font = Enum.Font.Code
terminal.TextSize = 12
terminal.TextXAlignment = Enum.TextXAlignment.Left
terminal.TextYAlignment = Enum.TextYAlignment.Top
terminal.TextWrapped = true
terminal.Text = ""

-- PROGRESS BAR
local bar = Instance.new("Frame", panel)
bar.Size = UDim2.new(1,-20,0,6)
bar.Position = UDim2.new(0,10,0,280)
bar.BackgroundColor3 = Color3.fromRGB(40,0,80)

local prog = Instance.new("Frame", bar)
prog.Size = UDim2.new(0,0,1,0)
prog.BackgroundColor3 = Color3.fromRGB(180,120,255)

-- PERCENT
local percentText = Instance.new("TextLabel", panel)
percentText.Position = UDim2.new(0,0,0,290)
percentText.Size = UDim2.new(1,0,0,20)
percentText.BackgroundTransparency = 1
percentText.TextColor3 = Color3.fromRGB(180,120,255)
percentText.Font = Enum.Font.Code
percentText.TextSize = 12
percentText.Text = "0%"

-- SIDE TEXT
local left = Instance.new("TextLabel", frame)
left.Text = "> BYPASS"
left.Position = UDim2.new(0,20,0.5,0)
left.Size = UDim2.new(0,200,0,30)
left.BackgroundTransparency = 1
left.TextColor3 = Color3.fromRGB(180,120,255)
left.Font = Enum.Font.Code
left.TextSize = 20

local right = left:Clone()
right.Parent = frame
right.Text = "PROCESSING >"
right.Position = UDim2.new(1,-200,0.5,0)

-- TIME LOOP
task.spawn(function()
	while true do
		local t = os.date("*t")
		timeLabel.Text = string.format("TIME: %02d:%02d:%02d | NEBULA", t.hour, t.min, t.sec)
		task.wait(1)
	end
end)

-- TERMINAL TEXT
local lines = {
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

-- GLITCH EFFECT
local function glitch()
	panel.Rotation = math.random(-2,2)
	task.wait(0.1)
	panel.Rotation = 0
end

-- TYPE LOOP
task.spawn(function()
	while true do
		terminal.Text = ""
		for i,v in ipairs(lines) do
			terminal.Text = terminal.Text .. v .. "\n"
			task.wait(math.random(4,8)/10)
		end
		glitch()
		task.wait(1)
	end
end)

-- PROGRESS LOOP (STUCK 98.6)
task.spawn(function()
	local p = 0
	while true do
		if p < 98.6 then
			p += math.random(3,6)
			if p > 98.6 then p = 98.6 end
			prog.Size = UDim2.new(p/100,0,1,0)
			percentText.Text = string.format("%.1f%%", p)
		end
		task.wait(0.7)
	end
end)

-- EMOJI RANDOM
task.spawn(function()
	local emojis = {"🚀","💻","⚡","🌌","✨"}
	while true do
		local e = Instance.new("TextLabel", frame)
		e.Text = emojis[math.random(1,#emojis)]
		e.Position = UDim2.new(math.random(),0,1,0)
		e.Size = UDim2.new(0,30,0,30)
		e.BackgroundTransparency = 1
		e.TextScaled = true

		task.spawn(function()
			for i=1,20 do
				e.Position = e.Position - UDim2.new(0,0,0.02,0)
				e.TextTransparency += 0.05
				task.wait(0.05)
			end
			e:Destroy()
		end)

		task.wait(0.3)
	end
end)

-- METEOR
task.spawn(function()
	while true do
		local m = Instance.new("Frame", frame)
		m.Size = UDim2.new(0,2,0,60)
		m.Position = UDim2.new(math.random(),0,0,0)
		m.BackgroundColor3 = Color3.fromRGB(255,255,255)

		task.spawn(function()
			for i=1,20 do
				m.Position = m.Position + UDim2.new(0.02,0,0.04,0)
				m.BackgroundTransparency += 0.05
				task.wait(0.05)
			end
			m:Destroy()
		end)

		task.wait(1)
	end
end)			task.wait(0.015)
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
