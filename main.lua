-- Settings
local WIDTH = 250
local HEIGHT = 40

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "DropdownUI"

-- Main container
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, WIDTH + 20, 0, 180)
frame.Position = UDim2.new(0.5, -WIDTH/2, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- UI Stroke
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(200, 200, 200)
stroke.Thickness = 1

-- Function to create a dropdown
local function createDropdown(labelText, yPosition)
	local dropdownBtn = Instance.new("TextButton")
	dropdownBtn.Size = UDim2.new(0, WIDTH, 0, HEIGHT)
	dropdownBtn.Position = UDim2.new(0, 10, 0, yPosition)
	dropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	dropdownBtn.Font = Enum.Font.SourceSans
	dropdownBtn.TextSize = 18
	dropdownBtn.Text = labelText .. " ▼"
	dropdownBtn.BorderSizePixel = 0
	dropdownBtn.AutoButtonColor = false
	dropdownBtn.Parent = frame

	local dropdownList = Instance.new("Frame")
	dropdownList.Size = UDim2.new(0, WIDTH, 0, 0)
	dropdownList.Position = UDim2.new(0, 10, 0, yPosition + HEIGHT + 2)
	dropdownList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdownList.Visible = false
	dropdownList.ClipsDescendants = true
	dropdownList.Parent = frame

	local listLayout = Instance.new("UIListLayout", dropdownList)
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0, 2)

	return dropdownBtn, dropdownList
end

-- Hover effect for options
local function applyHover(btn)
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end)
end

-- Create ComboBox1 (Levels)
local levelDropdownBtn, levelDropdownList = createDropdown("Select Level", 10)

-- Create ComboBox2 (Monsters)
local monsterDropdownBtn, monsterDropdownList = createDropdown("Select Monster", 70)

-- Get levels from Workspace.Levels
local levelFolder = workspace:FindFirstChild("Levels")
local levelNames = {}
if levelFolder then
	for _, level in ipairs(levelFolder:GetChildren()) do
		table.insert(levelNames, level.Name)
	end
end

-- Populate ComboBox1
for _, levelName in ipairs(levelNames) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, HEIGHT)
	btn.Text = levelName
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 18
	btn.TextColor3 = Color3.new(0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.BorderSizePixel = 0
	btn.Parent = levelDropdownList

	applyHover(btn)

	btn.MouseButton1Click:Connect(function()
		levelDropdownBtn.Text = levelName .. " ▼"
		levelDropdownList.Visible = false
		monsterDropdownList.Visible = false
		monsterDropdownBtn.Text = "Select Monster ▼"

		-- Clear old monster list
		for _, child in ipairs(monsterDropdownList:GetChildren()) do
			if child:IsA("TextButton") then child:Destroy() end
		end

		-- Load monsters
		local level = levelFolder:FindFirstChild(levelName)
		local monsters = level and level:FindFirstChild("Monsters")
		if monsters then
			for _, monster in ipairs(monsters:GetChildren()) do
				local mbtn = Instance.new("TextButton")
				mbtn.Size = UDim2.new(1, 0, 0, HEIGHT)
				mbtn.Text = monster.Name
				mbtn.Font = Enum.Font.SourceSans
				mbtn.TextSize = 18
				mbtn.TextColor3 = Color3.new(0, 0, 0)
				mbtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				mbtn.BorderSizePixel = 0
				mbtn.Parent = monsterDropdownList

				applyHover(mbtn)

				mbtn.MouseButton1Click:Connect(function()
					monsterDropdownBtn.Text = monster.Name .. " ▼"
					monsterDropdownList.Visible = false
				end)
			end
		end
	end)
end

-- Toggle dropdowns
levelDropdownBtn.MouseButton1Click:Connect(function()
	levelDropdownList.Visible = not levelDropdownList.Visible
	monsterDropdownList.Visible = false
	levelDropdownList.Size = levelDropdownList.Visible
		and UDim2.new(0, WIDTH, 0, #levelNames * HEIGHT)
		or UDim2.new(0, WIDTH, 0, 0)
end)

monsterDropdownBtn.MouseButton1Click:Connect(function()
	if monsterDropdownList:GetChildren()[1] then
		monsterDropdownList.Visible = not monsterDropdownList.Visible
		levelDropdownList.Visible = false
		monsterDropdownList.Size = monsterDropdownList.Visible
			and UDim2.new(0, WIDTH, 0, #monsterDropdownList:GetChildren() * HEIGHT)
			or UDim2.new(0, WIDTH, 0, 0)
	end
end)
