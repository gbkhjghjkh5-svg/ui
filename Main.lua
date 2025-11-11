local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 300)
main.Position = UDim2.new(0.5, -200, 0.5, -150)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
main.BorderSizePixel = 0
main.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = main

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 70)
UIStroke.Thickness = 2
UIStroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "BESE V1.0 Beta"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = header

local logsContainer = Instance.new("ScrollingFrame")
logsContainer.Size = UDim2.new(1, -20, 1, -60)
logsContainer.Position = UDim2.new(0, 10, 0, 50)
logsContainer.BackgroundTransparency = 1
logsContainer.BorderSizePixel = 0
logsContainer.ScrollBarThickness = 4
logsContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
logsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
logsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
logsContainer.Parent = main

local logsLayout = Instance.new("UIListLayout")
logsLayout.Padding = UDim.new(0, 5)
logsLayout.Parent = logsContainer

local popupOverlay = Instance.new("Frame")
popupOverlay.Size = UDim2.new(1, 0, 1, 0)
popupOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
popupOverlay.BackgroundTransparency = 0.7
popupOverlay.BorderSizePixel = 0
popupOverlay.Visible = false
popupOverlay.Parent = main

local popup = Instance.new("Frame")
popup.Size = UDim2.new(0, 300, 0, 150)
popup.Position = UDim2.new(0.5, -150, 0.5, -75)
popup.AnchorPoint = Vector2.new(0.5, 0.5)
popup.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
popup.BorderSizePixel = 0
popup.Parent = popupOverlay

local popupCorner = Instance.new("UICorner")
popupCorner.CornerRadius = UDim.new(0, 8)
popupCorner.Parent = popup

local popupStroke = Instance.new("UIStroke")
popupStroke.Color = Color3.fromRGB(80, 80, 90)
popupStroke.Thickness = 2
popupStroke.Parent = popup

local popupTitle = Instance.new("TextLabel")
popupTitle.Size = UDim2.new(1, 0, 0, 40)
popupTitle.BackgroundTransparency = 1
popupTitle.Text = "Notification"
popupTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
popupTitle.Font = Enum.Font.GothamBold
popupTitle.TextSize = 18
popupTitle.Parent = popup

local popupMessage = Instance.new("TextLabel")
popupMessage.Size = UDim2.new(1, -20, 0, 50)
popupMessage.Position = UDim2.new(0, 10, 0, 40)
popupMessage.BackgroundTransparency = 1
popupMessage.Text = "Message"
popupMessage.TextColor3 = Color3.fromRGB(200, 200, 200)
popupMessage.Font = Enum.Font.Gotham
popupMessage.TextSize = 14
popupMessage.TextWrapped = true
popupMessage.Parent = popup

local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, -20, 0, 30)
buttonContainer.Position = UDim2.new(0, 10, 1, -40)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = popup

local buttonLayout = Instance.new("UIListLayout")
buttonLayout.FillDirection = Enum.FillDirection.Horizontal
buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
buttonLayout.Padding = UDim.new(0, 10)
buttonLayout.Parent = buttonContainer

local function createButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 1, 0)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = buttonContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(80, 80, 90)
    btnStroke.Thickness = 1
    btnStroke.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(
            math.floor(color.R * 255 * 1.2),
            math.floor(color.G * 255 * 1.2),
            math.floor(color.B * 255 * 1.2)
        )}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)
    
    return btn
end

local Logs = {}
local Popups = {}

function Logs:AddLog(type, message, color)
    local timestamp = os.date("%H:%M:%S")
    local logFrame = Instance.new("Frame")
    logFrame.Size = UDim2.new(1, 0, 0, 25)
    logFrame.BackgroundTransparency = 1
    logFrame.Parent = logsContainer
    
    local timestampLabel = Instance.new("TextLabel")
    timestampLabel.Size = UDim2.new(0, 60, 1, 0)
    timestampLabel.BackgroundTransparency = 1
    timestampLabel.Text = "["..timestamp.."]"
    timestampLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    timestampLabel.Font = Enum.Font.Gotham
    timestampLabel.TextSize = 12
    timestampLabel.Parent = logFrame
    
    local typeLabel = Instance.new("TextLabel")
    typeLabel.Size = UDim2.new(0, 40, 1, 0)
    typeLabel.Position = UDim2.new(0, 65, 0, 0)
    typeLabel.BackgroundTransparency = 1
    typeLabel.Text = type
    typeLabel.TextColor3 = color or Color3.fromRGB(100, 150, 255)
    typeLabel.Font = Enum.Font.GothamBold
    typeLabel.TextSize = 12
    typeLabel.Parent = logFrame
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -110, 1, 0)
    messageLabel.Position = UDim2.new(0, 110, 0, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 12
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Parent = logFrame
    
    logFrame.Size = UDim2.new(1, 0, 0, 0)
    TweenService:Create(logFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 25)}):Play()
end

function Popups:ShowPopup(title, message, button2Text, button2Callback)
    popupTitle.Text = title
    popupMessage.Text = message
    
    buttonContainer:ClearAllChildren()
    buttonLayout.Parent = buttonContainer
    
    local okBtn = createButton("OK", Color3.fromRGB(80, 80, 160))
    okBtn.MouseButton1Click:Connect(function()
        Popups:HidePopup()
    end)
    
    if button2Text then
        local customBtn = createButton(button2Text, Color3.fromRGB(60, 140, 80))
        customBtn.MouseButton1Click:Connect(function()
            if button2Callback then
                button2Callback()
            end
            Popups:HidePopup()
        end)
    end
    
    popupOverlay.Visible = true
    popupOverlay.BackgroundTransparency = 1
    popup.Size = UDim2.new(0, 0, 0, 0)
    
    local tweenIn = TweenService:Create(popupOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.7})
    local tweenPopup = TweenService:Create(popup, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 150)})
    
    tweenIn:Play()
    tweenPopup:Play()
end

function Popups:HidePopup()
    local tweenOut = TweenService:Create(popupOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 1})
    local tweenPopup = TweenService:Create(popup, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    
    tweenOut:Play()
    tweenPopup:Play()
    
    tweenOut.Completed:Connect(function()
        popupOverlay.Visible = false
    end)
end


return {Logs = Logs, Popups = Popups}