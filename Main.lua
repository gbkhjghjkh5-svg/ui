local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local baseWidth, baseHeight = 400, 300
local currentScale = 1

local main = Instance.new("Frame")
main.Size = UDim2.new(0, baseWidth, 0, baseHeight)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
main.BackgroundTransparency = 0.05
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
header.BackgroundTransparency = 0.05
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "BESE V1.0 Beta"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Code
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 24)
closeBtn.Position = UDim2.new(1, -50, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.Code
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.AutoButtonColor = false
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(40,40,45)
closeStroke.Thickness = 1
closeStroke.Parent = closeBtn

local logsContainer = Instance.new("ScrollingFrame")
logsContainer.Size = UDim2.new(1, -20, 1, -60)
logsContainer.Position = UDim2.new(0, 10, 0, 50)
logsContainer.BackgroundTransparency = 1
logsContainer.BorderSizePixel = 0
logsContainer.ScrollBarThickness = 10
logsContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
logsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
logsContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
logsContainer.Parent = main
logsContainer.ScrollBarImageTransparency = 0.25
logsContainer.ScrollingEnabled = true
logsContainer.ClipsDescendants = true

local logsLayout = Instance.new("UIListLayout")
logsLayout.Padding = UDim.new(0, 6)
logsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
logsLayout.Parent = logsContainer

local popupOverlay = Instance.new("Frame")
popupOverlay.Size = UDim2.new(1, 0, 1, 0)
popupOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
popupOverlay.BackgroundTransparency = 1
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
popupTitle.Font = Enum.Font.Code
popupTitle.TextSize = 18
popupTitle.Parent = popup

local popupMessage = Instance.new("TextLabel")
popupMessage.Size = UDim2.new(1, -20, 0, 50)
popupMessage.Position = UDim2.new(0, 10, 0, 40)
popupMessage.BackgroundTransparency = 1
popupMessage.Text = "Message"
popupMessage.TextColor3 = Color3.fromRGB(200, 200, 200)
popupMessage.Font = Enum.Font.Code
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
    btn.Font = Enum.Font.Code
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
        local r = math.clamp(color.R * 255 * 1.2, 0, 255)
        local g = math.clamp(color.G * 255 * 1.2, 0, 255)
        local b = math.clamp(color.B * 255 * 1.2, 0, 255)
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(r,g,b)}):Play()
    end)

    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.18), {BackgroundColor3 = color}):Play()
    end)

    return btn
end

local Logs = {}
local Popups = {}

logsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    logsContainer.CanvasPosition = Vector2.new(0, math.max(0, logsLayout.AbsoluteContentSize.Y - logsContainer.AbsoluteSize.Y))
end)

function Logs:AddLog(typeStr, message, color)
    color = color or Color3.fromRGB(100,150,255)
    local timestamp = os.date("%H:%M:%S")

    local outer = Instance.new("Frame")
    outer.Size = UDim2.new(1, 0, 0, 0)
    outer.BackgroundTransparency = 1
    outer.BorderSizePixel = 0
    outer.Parent = logsContainer

    local logBg = Instance.new("Frame")
    logBg.Size = UDim2.new(1, -18, 0, 28)
    logBg.Position = UDim2.new(0, 0, 0, 0)
    logBg.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    logBg.BackgroundTransparency = 0.02
    logBg.BorderSizePixel = 0
    logBg.Parent = outer

    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 6)
    bgCorner.Parent = logBg

    local bgStroke = Instance.new("UIStroke")
    bgStroke.Color = Color3.fromRGB(45,45,50)
    bgStroke.Thickness = 1
    bgStroke.Parent = logBg

    local timestampLabel = Instance.new("TextLabel")
    timestampLabel.Size = UDim2.new(0, 65, 1, 0)
    timestampLabel.Position = UDim2.new(0, 8, 0, 0)
    timestampLabel.BackgroundTransparency = 1
    timestampLabel.Text = "["..timestamp.."]"
    timestampLabel.TextColor3 = Color3.fromRGB(130,130,140)
    timestampLabel.Font = Enum.Font.Code
    timestampLabel.TextSize = 12
    timestampLabel.Parent = logBg

    local typeLabel = Instance.new("TextLabel")
    typeLabel.Size = UDim2.new(0, 60, 1, 0)
    typeLabel.Position = UDim2.new(0, 75, 0, 0)
    typeLabel.BackgroundTransparency = 0
    typeLabel.BackgroundColor3 = Color3.fromRGB(20,20,24)
    typeLabel.Text = " " .. (typeStr or "INFO")
    typeLabel.TextColor3 = color
    typeLabel.Font = Enum.Font.Code
    typeLabel.TextSize = 12
    typeLabel.BorderSizePixel = 0
    typeLabel.Parent = logBg

    local typeCorner = Instance.new("UICorner")
    typeCorner.CornerRadius = UDim.new(0, 4)
    typeCorner.Parent = typeLabel

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -170, 1, 0)
    messageLabel.Position = UDim2.new(0, 140, 0, 0)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message or ""
    messageLabel.TextColor3 = Color3.fromRGB(230,230,230)
    messageLabel.Font = Enum.Font.Code
    messageLabel.TextSize = 12
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.TextTransparency = 1
    messageLabel.Parent = logBg

    local tweenSize = TweenService:Create(outer, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 34)})
    tweenSize:Play()
    TweenService:Create(messageLabel, TweenInfo.new(0.35), {TextTransparency = 0}):Play()

    logBg.Position = UDim2.new(0, 0, 0, 4)
    TweenService:Create(logBg, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
end

function Popups:ShowPopup(titleText, messageText, button2Text, button2Callback)
    popupTitle.Text = titleText or "Notification"
    popupMessage.Text = messageText or ""

    for _, child in pairs(buttonContainer:GetChildren()) do
        if child ~= buttonLayout then
            child:Destroy()
        end
    end

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
    popup.Position = UDim2.new(0.5, 0, 0.5, 0)

    local tweenIn = TweenService:Create(popupOverlay, TweenInfo.new(0.28), {BackgroundTransparency = 0.7})
    local tweenPopup = TweenService:Create(popup, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 150)})
    tweenIn:Play()
    tweenPopup:Play()
end

function Popups:HidePopup()
    local tweenOut = TweenService:Create(popupOverlay, TweenInfo.new(0.28), {BackgroundTransparency = 1})
    local tweenPopup = TweenService:Create(popup, TweenInfo.new(0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tweenOut:Play()
    tweenPopup:Play()
    tweenOut.Completed:Connect(function()
        popupOverlay.Visible = false
    end)
end

local isClosed = false
local function setClosed(state)
    isClosed = state
    if state then
        local t1 = TweenService:Create(main, TweenInfo.new(0.26, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
        local t2 = TweenService:Create(main, TweenInfo.new(0.26, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 0)})
        t2.Completed:Connect(function() main.Visible = false end)
        t1:Play()
        t2:Play()
    else
        main.Visible = true
        local w, h = baseWidth * currentScale, baseHeight * currentScale
        main.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(main, TweenInfo.new(0.30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, w, 0, h), BackgroundTransparency = 0.05}):Play()
    end
end

closeBtn.MouseButton1Click:Connect(function()
    setClosed(true)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.P then
            setClosed(not isClosed)
        elseif input.KeyCode == Enum.KeyCode.LeftBracket then
            currentScale = math.clamp(currentScale - 0.1, 0.5, 2)
            local w, h = baseWidth * currentScale, baseHeight * currentScale
            TweenService:Create(main, TweenInfo.new(0.18), {Size = UDim2.new(0, w, 0, h)}):Play()
        elseif input.KeyCode == Enum.KeyCode.RightBracket then
            currentScale = math.clamp(currentScale + 0.1, 0.5, 2)
            local w, h = baseWidth * currentScale, baseHeight * currentScale
            TweenService:Create(main, TweenInfo.new(0.18), {Size = UDim2.new(0, w, 0, h)}):Play()
        end
    end
end)

local dragging = false
local dragStart = Vector2.new(0,0)
local startPos = Vector2.new(0,0)
local viewportCenter = Camera and (Camera.ViewportSize / 2) or Vector2.new(400,300)
local targetPos = viewportCenter

local function toTop(instance)
    instance.Parent = instance.Parent
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = UserInputService:GetMouseLocation()
        if main.AbsoluteSize.X > 0 and main.AbsoluteSize.Y > 0 then
            startPos = Vector2.new(main.AbsolutePosition.X + main.AbsoluteSize.X/2, main.AbsolutePosition.Y + main.AbsoluteSize.Y/2)
        else
            startPos = viewportCenter
        end
        targetPos = startPos
        toTop(main)
        TweenService:Create(header, TweenInfo.new(0.12), {BackgroundTransparency = 0.02}):Play()
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        TweenService:Create(header, TweenInfo.new(0.12), {BackgroundTransparency = 0.05}):Play()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouse = UserInputService:GetMouseLocation()
        local delta = mouse - dragStart
        targetPos = startPos + delta
    end
end)

RunService.RenderStepped:Connect(function(dt)
    local lerpFactor = 12 * dt
    local curCenter
    if main.AbsoluteSize.X > 0 and main.AbsoluteSize.Y > 0 then
        curCenter = Vector2.new(main.AbsolutePosition.X + main.AbsoluteSize.X/2, main.AbsolutePosition.Y + main.AbsoluteSize.Y/2)
    else
        curCenter = targetPos
    end
    if not dragging then
        targetPos = curCenter
    end
    local newCenter = curCenter + (targetPos - curCenter) * lerpFactor
    main.Position = UDim2.new(0, newCenter.X, 0, newCenter.Y)
end)

return {Logs = Logs, Popups = Popups}
