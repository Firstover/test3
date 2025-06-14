-- SETTINGS
local WIDTH = 250
local HEIGHT = 35

local player = game.Players.LocalPlayer
local LevelsFolder = workspace:FindFirstChild("Levels")

-- GUI Container
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "MonsterUI"

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, WIDTH + 20, 0, 200)
frame.Position = UDim2.new(0.5, -WIDTH/2, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(180, 180, 180)
stroke.Thickness = 1

-- Create Dropdown Function
local function createDropdown(yPos, placeholderText)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, WIDTH, 0, HEIGHT)
	button.Position = UDim2.new(0, 10, 0, yPos)
	button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	button.TextColor3 = Color3.fromRGB(0, 0, 0)
	button.Font = Enum.Font.SourceSans
	button.TextSize = 18
	button.Text = placeholderText .. " ▼"
	button.Parent = frame

	local list = Instance.new("Frame")
	list.Position = UDim2.new(0, 10, 0, yPos + HEIGHT + 2)
	list.Size = UDim2.new(0, WIDTH, 0, 0)
	list.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	list.Visible = false
	list.ClipsDescendants = true
	list.Parent = frame

	local layout = Instance.new("UIListLayout", list)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 2)

	return button, list
end

-- Hover Styling
local function hoverEffect(btn)
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end)
end

-- Create Dropdown 1 (Level) & 2 (Monster)
local levelBtn, levelList = createDropdown(10, "Select Level")
local monsterBtn, monsterList = createDropdown(70, "Select Monster")

-- Handle Dropdown Toggle
levelBtn.MouseButton1Click:Connect(function()
	levelList.Visible = not levelList.Visible
	monsterList.Visible = false
	levelList.Size = levelList.Visible and UDim2.new(0, WIDTH, 0, #levelList:GetChildren() * HEIGHT) or UDim2.new(0, WIDTH, 0, 0)
end)

monsterBtn.MouseButton1Click:Connect(function()
	if monsterList:GetChildren()[1] then
		monsterList.Visible = not monsterList.Visible
		levelList.Visible = false
		monsterList.Size = monsterList.Visible and UDim2.new(0, WIDTH, 0, #monsterList:GetChildren() * HEIGHT) or UDim2.new(0, WIDTH, 0, 0)
	end
end)

-- Build Level List
if LevelsFolder then
	for _, levelFolder in ipairs(LevelsFolder:GetChildren()) do
		local option = Instance.new("TextButton")
		option.Size = UDim2.new(1, 0, 0, HEIGHT)
		option.Text = levelFolder.Name
		option.Font = Enum.Font.SourceSans
		option.TextSize = 18
		option.TextColor3 = Color3.new(0, 0, 0)
		option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		option.BorderSizePixel = 0
		option.Parent = levelList
		hoverEffect(option)

		option.MouseButton1Click:Connect(function()
			levelBtn.Text = levelFolder.Name .. " ▼"
			levelList.Visible = false
			monsterBtn.Text = "Select Monster ▼"

			-- Clear monster list
			for _, c in ipairs(monsterList:GetChildren()) do
				if c:IsA("TextButton") then c:Destroy() end
			end

			-- Build Monster List for Selected Level
			local monsters = levelFolder:FindFirstChild("Monsters")
			if monsters then
				for _, m in ipairs(monsters:GetChildren()) do
					local mOption = Instance.new("TextButton")
					mOption.Size = UDim2.new(1, 0, 0, HEIGHT)
					mOption.Text = m.Name
					mOption.Font = Enum.Font.SourceSans
					mOption.TextSize = 18
					mOption.TextColor3 = Color3.new(0, 0, 0)
					mOption.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					mOption.BorderSizePixel = 0
					mOption.Parent = monsterList
					hoverEffect(mOption)

					mOption.MouseButton1Click:Connect(function()
						monsterBtn.Text = m.Name .. " ▼"
						monsterList.Visible = false
					end)
				end
			end
		end)
	end
end
