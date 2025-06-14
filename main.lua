-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonsterDropdownGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

-- ComboBox1: Levels
local levelDropdown = Instance.new("TextButton")
levelDropdown.Size = UDim2.new(1, -20, 0, 40)
levelDropdown.Position = UDim2.new(0, 10, 0, 10)
levelDropdown.Text = "Select Level"
levelDropdown.TextColor3 = Color3.new(1,1,1)
levelDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
levelDropdown.Parent = mainFrame

-- ComboBox2: Monsters
local monsterDropdown = Instance.new("TextButton")
monsterDropdown.Size = UDim2.new(1, -20, 0, 40)
monsterDropdown.Position = UDim2.new(0, 10, 0, 60)
monsterDropdown.Text = "Select Monster"
monsterDropdown.TextColor3 = Color3.new(1,1,1)
monsterDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
monsterDropdown.Parent = mainFrame

-- Dropdown container (for Level)
local levelList = Instance.new("Frame")
levelList.Size = UDim2.new(1, -20, 0, 100)
levelList.Position = UDim2.new(0, 10, 0, 50)
levelList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
levelList.Visible = false
levelList.Parent = mainFrame

local levelLayout = Instance.new("UIListLayout", levelList)
levelLayout.Padding = UDim.new(0, 2)

-- Dropdown container (for Monster)
local monsterList = Instance.new("Frame")
monsterList.Size = UDim2.new(1, -20, 0, 100)
monsterList.Position = UDim2.new(0, 10, 0, 100)
monsterList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
monsterList.Visible = false
monsterList.Parent = mainFrame

local monsterLayout = Instance.new("UIListLayout", monsterList)
monsterLayout.Padding = UDim.new(0, 2)

-- Fill Level Dropdown
local levelsFolder = workspace:FindFirstChild("Levels")
local levelNames = {}

if levelsFolder then
    for _, level in ipairs(levelsFolder:GetChildren()) do
        table.insert(levelNames, level.Name)
    end
end

for _, levelName in ipairs(levelNames) do
    local option = Instance.new("TextButton")
    option.Text = levelName
    option.Size = UDim2.new(1, 0, 0, 25)
    option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    option.TextColor3 = Color3.new(1,1,1)
    option.Parent = levelList

    option.MouseButton1Click:Connect(function()
        levelDropdown.Text = levelName
        levelList.Visible = false
        monsterDropdown.Text = "Select Monster"
        
        -- Clear previous monster list
        for _, child in ipairs(monsterList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        -- Populate monsters for selected level
        local levelFolder = levelsFolder:FindFirstChild(levelName)
        if levelFolder then
            local monstersFolder = levelFolder:FindFirstChild("Monsters")
            if monstersFolder then
                for _, monster in ipairs(monstersFolder:GetChildren()) do
                    local monsterOption = Instance.new("TextButton")
                    monsterOption.Text = monster.Name
                    monsterOption.Size = UDim2.new(1, 0, 0, 25)
                    monsterOption.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    monsterOption.TextColor3 = Color3.new(1,1,1)
                    monsterOption.Parent = monsterList

                    monsterOption.MouseButton1Click:Connect(function()
                        monsterDropdown.Text = monster.Name
                        monsterList.Visible = false
                    end)
                end
            end
        end
    end)
end

-- Toggle visibility
levelDropdown.MouseButton1Click:Connect(function()
    levelList.Visible = not levelList.Visible
    monsterList.Visible = false
end)

monsterDropdown.MouseButton1Click:Connect(function()
    if levelDropdown.Text ~= "Select Level" then
        monsterList.Visible = not monsterList.Visible
        levelList.Visible = false
    end
end)
