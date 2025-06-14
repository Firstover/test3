-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonsterListGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.Parent = mainFrame

-- Helper to add monster name to GUI
local function addMonsterName(name)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 20
    label.Parent = mainFrame
end

-- Scan Levels -> Level1 to Level6
local levels = workspace:FindFirstChild("Levels")
if levels then
    for _, level in pairs(levels:GetChildren()) do
        local monstersFolder = level:FindFirstChild("Monsters")
        if monstersFolder then
            for _, monster in pairs(monstersFolder:GetChildren()) do
                addMonsterName(monster.Name)
            end
        end
    end
end

-- Scan Activity1 -> Monsters
local activity = workspace:FindFirstChild("Activity1")
if activity then
    local monsters = activity:FindFirstChild("Monsters")
    if monsters then
        for _, monster in pairs(monsters:GetChildren()) do
            addMonsterName(monster.Name)
        end
    end
end
