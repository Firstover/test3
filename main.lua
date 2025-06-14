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

-- Add scrollable frame
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.BackgroundTransparency = 1
scroll.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.Parent = scroll

-- Helper to add section title
local function addSection(title)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = "-- " .. title .. " --"
    label.TextColor3 = Color3.fromRGB(255, 200, 0)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 20
    label.Parent = scroll
end

-- Helper to add monster name
local function addMonster(name)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    label.Parent = scroll
end

-- Scan Levels and list monsters
local levels = workspace:FindFirstChild("Levels")
if levels then
    for _, level in ipairs(levels:GetChildren()) do
        local monsters = level:FindFirstChild("Monsters")
        if monsters and #monsters:GetChildren() > 0 then
            addSection(level.Name)
            for _, monster in ipairs(monsters:GetChildren()) do
                addMonster(monster.Name)
            end
        end
    end
else
    warn("Levels folder not found.")
end

-- Resize scroll based on content
task.wait(0.1)
scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
