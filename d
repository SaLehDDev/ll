-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Visible = false
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "Xeon Learning Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Parent = frame

-- List all players
local function updatePlayerList()
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    local yPos = 60
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 30)
            button.Position = UDim2.new(0, 5, 0, yPos)
            button.Text = p.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            button.Parent = frame

            button.MouseButton1Click:Connect(function()
                print("تعليمياً: ضغطت على اللاعب "..p.Name)
                -- إضافة وظائف تعليمية هنا
            end)
            yPos = yPos + 35
        end
    end
end

updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- تفعيل GUI عند الضغط على حرف C
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.C then
        frame.Visible = not frame.Visible
    end
end)
