-- Settings
local DROPDOWN_WIDTH = 300
local DROPDOWN_HEIGHT = 35

-- Create GUI container
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "ModernDropdown"

-- Main dropdown button
local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(0, DROPDOWN_WIDTH, 0, DROPDOWN_HEIGHT)
dropdownBtn.Position = UDim2.new(0.5, -DROPDOWN_WIDTH/2, 0.4, 0)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
dropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
dropdownBtn.Font = Enum.Font.SourceSans
dropdownBtn.TextSize = 18
dropdownBtn.Text = "Select Level ▼"
dropdownBtn.AutoButtonColor = false
dropdownBtn.Parent = gui

-- Add border stroke
local stroke = Instance.new("UIStroke", dropdownBtn)
stroke.Color = Color3.fromRGB(200, 200, 200)
stroke.Thickness = 1.5

-- Dropdown list container
local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(0, DROPDOWN_WIDTH, 0, 0)
dropdownList.Position = UDim2.new(0.5, -DROPDOWN_WIDTH/2, 0.4, DROPDOWN_HEIGHT + 4)
dropdownList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownList.ClipsDescendants = true
dropdownList.Visible = false
dropdownList.Parent = gui

local listLayout = Instance.new("UIListLayout", dropdownList)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Hover effect function
local function applyHover(button)
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end)
end

-- Example levels (replace with real)
local levelNames = { "Level1", "Level2", "Level3", "Level4", "Level5", "Level6", "Activity1" }

for _, levelName in ipairs(levelNames) do
	local item = Instance.new("TextButton")
	item.Size = UDim2.new(1, 0, 0, DROPDOWN_HEIGHT)
	item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	item.TextColor3 = Color3.fromRGB(0, 0, 0)
	item.Font = Enum.Font.SourceSans
	item.TextSize = 18
	item.Text = levelName
	item.BorderSizePixel = 0
	item.Parent = dropdownList

	applyHover(item)

	item.MouseButton1Click:Connect(function()
		dropdownBtn.Text = levelName .. " ▼"
		dropdownList.Visible = false
	end)
end

-- Animate dropdown open/close
local isOpen = false
dropdownBtn.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	dropdownList.Visible = isOpen
	dropdownList.Size = isOpen
		and UDim2.new(0, DROPDOWN_WIDTH, 0, #levelNames * DROPDOWN_HEIGHT)
		or UDim2.new(0, DROPDOWN_WIDTH, 0, 0)
end)
