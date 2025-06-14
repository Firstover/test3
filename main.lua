-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Parent = ScreenGui

-- Add a UIListLayout to stack text labels
local layout = Instance.new("UIListLayout")
layout.Parent = mainFrame

-- Get monsters
local monstersFolder = workspace:FindFirstChild("Monsters") or workspace:FindFirstChild("Enemies")

if monstersFolder then
    for _, monster in ipairs(monstersFolder:GetChildren()) do
        local label = Instance.new("TextLabel")
        label.Text = monster.Name
        label.Size = UDim2.new(1, 0, 0, 30)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.Parent = mainFrame
    end
else
    warn("No monster folder found.")
end
