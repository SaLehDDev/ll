-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0.5, -100, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Visible = false
Frame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Function لتحديث قائمة اللاعبين
local function updatePlayerList()
    Frame:ClearAllChildren()
    UIListLayout.Parent = Frame
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Text = player.Name
            btn.Parent = Frame
            btn.MouseButton1Click:Connect(function()
                -- تحريك الكاميرا إلى اللاعب
                local targetPos = player.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)
                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(Camera, tweenInfo, {CFrame = CFrame.new(targetPos)})
                tween:Play()
                Frame.Visible = false
            end)
        end
    end
end

-- Toggle GUI عند الضغط على T
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.T then
        Frame.Visible = not Frame.Visible
        if Frame.Visible then
            updatePlayerList()
        end
    end
end)
