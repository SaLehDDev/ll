-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local UserInputService = game:GetService("UserInputService")
local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Character = LocalPlayer_upvr.Character or LocalPlayer_upvr.CharacterAdded:Wait()
local HumanoidRootPart_3_upvr = Character:WaitForChild("HumanoidRootPart")
local ImageButton_upvr = script.Parent.ImageButton
local Target = script.Parent:FindFirstChild("Target")
local RequestGui_upvr = ReplicatedStorage:WaitForChild("Dev-Events"):WaitForChild("RequestGui")
local Frame_upvr = script.Parent.Frame
local PickUp_upvr = Frame_upvr.PickUp
local GiveCashFrame_upvr = script.Parent.GiveCashFrame
local Dev_Target_upvr = ReplicatedStorage["Dev-Events"]["Dev-Target"]
local Bar_upvr = script.Parent.Bar

if game.PlaceId ~= 82872765463379 then
    game.Players.LocalPlayer:Kick("غير مسموح لك بالدخول لهذا الماب.")
end

local GUIVisible = false
local NearestPart, NearestPlayer

if Target then
    Target.Visible = UserInputService.TouchEnabled
end

-- Toggle GUI Function
local function updateGUI()
    ImageButton_upvr.Visible = GUIVisible
    if NearestPart or NearestPlayer then
        ImageButton_upvr.Image = "rbxassetid://94766488714309"
    else
        ImageButton_upvr.Image = "rbxassetid://113434574609516"
    end
end

-- Get nearest part
local TargetFolder_upvr = workspace:FindFirstChild("TargetFolder")
local function getNearestPart()
    local closest
    for _, v in pairs(TargetFolder_upvr:GetChildren()) do
        if v:IsA("BasePart") then
            local dist = (HumanoidRootPart_3_upvr.Position - v.Position).Magnitude
            if dist < 10 and (not closest or dist < closest.dist) then
                closest = {part=v, dist=dist}
            end
        end
    end
    return closest and closest.part
end

-- Get nearest player
local function getNearestPlayer()
    local closest
    for _, v in pairs(Players_upvr:GetPlayers()) do
        if v ~= LocalPlayer_upvr and v.Character then
            local hrp = v.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (HumanoidRootPart_3_upvr.Position - hrp.Position).Magnitude
                if dist < 10 and (not closest or dist < closest.dist) then
                    closest = {player=v, dist=dist}
                end
            end
        end
    end
    return closest and closest.player
end

-- Check if player allowed
local function isPlayerAllowed(player)
    if not player then return false end
    local canTarget = player:FindFirstChild("CanTarget")
    if canTarget and canTarget.Value == true then
        local requireTool = player:FindFirstChild("RequireTool")
        local teamVal = player:FindFirstChild("Team")
        local hasTool = not requireTool or requireTool.Value == "All" or Character:FindFirstChild(requireTool.Value)
        local correctTeam = not teamVal or teamVal.Value == "All" or (LocalPlayer_upvr.Team and LocalPlayer_upvr.Team.Name == teamVal.Value)
        return hasTool and correctTeam
    end
    return false
end

-- Toggle GUI with G or P keys
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.G or input.KeyCode == Enum.KeyCode.P then
            GUIVisible = not GUIVisible
            updateGUI()
        end
    end
end)

-- Update nearest objects each frame
game:GetService("RunService").Heartbeat:Connect(function()
    NearestPart = getNearestPart()
    NearestPlayer = getNearestPlayer()
    updateGUI()
end)

-- ImageButton click logic
ImageButton_upvr.MouseButton1Click:Connect(function()
    if NearestPart and isPlayerAllowed(NearestPart) then
        local firing = NearestPart:FindFirstChild("Firing")
        RequestGui_upvr:FireServer(NearestPart.Name, firing and firing.Value or nil)
    elseif NearestPlayer then
        Frame_upvr.Visible = true
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌";
            Text = "لاتمتلك صلاحيات هنا!⚠️";
            Duration = 6;
        })
    end
end)

-- Frame close buttons
Frame_upvr.Close.MouseButton1Click:Connect(function() Frame_upvr.Visible = false end)
GiveCashFrame_upvr.Close.MouseButton1Click:Connect(function() GiveCashFrame_upvr.Visible = false end)

-- باقي وظائف السكربت (PickUp, TheftFrame, GiveCashFrame، إلخ) تبقى كما هي
