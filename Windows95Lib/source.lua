local Library = {};

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local TweenInformation = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0);

local CoreGui = game:GetService("CoreGui");
local MainUI = Instance.new("ScreenGui", CoreGui);

local WindowXOffset = 10;

function Library:Window(Title: string)
    local W = {
        Minimized = false,
        DragInfo = {
            Dragging = false,
            DragInput = nil,
            DragStart = Vector3.new(),
            StartPos = UDim2.new()
        }
    };

    local Window = Instance.new("Frame");
    Window.BackgroundColor3 = Color3.fromRGB(94, 94, 94);
    Window.Position = UDim2.fromOffset(WindowXOffset, 10);
    Window.Size = UDim2.fromOffset(160, 30);
    Window.Parent = MainUI;

    local WindowUIStroke = Instance.new("UIStroke");
    WindowUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    WindowUIStroke.Color = Color3.fromRGB(75, 75, 75);
    WindowUIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    WindowUIStroke.Thickness = 2;
    WindowUIStroke.Transparency = 0;
    WindowUIStroke.Parent = Window;

    local WindowUISGrad = Instance.new("UIGradient");
    WindowUISGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(179, 179, 179))
    });
    WindowUISGrad.Rotation = -90;
    WindowUISGrad.Parent = WindowUIStroke;

    local WindowContent = Instance.new("Frame");
    WindowContent.AutomaticSize = Enum.AutomaticSize.Y;
    WindowContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    WindowContent.Position = UDim2.fromOffset(0, 30);
    WindowContent.Size = UDim2.fromOffset(160, 190);
    WindowContent.Parent = Window;

    local WindowCGrad = Instance.new("UIGradient");
    WindowCGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(94, 94, 94)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 116, 116))
    });
    WindowCGrad.Rotation = 90;
    WindowCGrad.Parent = WindowContent;

    local WindowCStroke = Instance.new("UIStroke");
    WindowCStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    WindowCStroke.Color = Color3.fromRGB(75, 75, 75);
    WindowCStroke.LineJoinMode = Enum.LineJoinMode.Round;
    WindowCStroke.Thickness = 2;
    WindowCStroke.Transparency = 0;
    WindowCStroke.Parent = WindowContent;

    local WindowCStrokeGrad = Instance.new("UIGradient");
    WindowCStrokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(179, 179, 179))
    });
    WindowCStrokeGrad.Rotation = -90;
    WindowCStrokeGrad.Parent = WindowCStroke;

    local WindowContentHolder = Instance.new("Frame");
    WindowContentHolder.BackgroundTransparency = 1;
    WindowContentHolder.Position = UDim2.fromScale(0, 0.037);
    WindowContentHolder.Size = UDim2.fromOffset(160, 183);
    WindowContentHolder.Parent = WindowContent;

    local WindowCHListLayout = Instance.new("UIListLayout");
    WindowCHListLayout.Padding = UDim.new(0, 10);
    WindowCHListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    WindowCHListLayout.Parent = WindowContentHolder;

    local WindowMinimize = Instance.new("TextButton");
    WindowMinimize.BackgroundTransparency = 1;
    WindowMinimize.Position = UDim2.fromOffset(5, 5);
    WindowMinimize.Size = UDim2.fromOffset(20, 20);
    WindowMinimize.Font = Enum.Font.SourceSans;
    WindowMinimize.Text = "▼";
    WindowMinimize.TextColor3 = Color3.fromRGB(130, 130, 130);
    WindowMinimize.TextSize = 15;
    WindowMinimize.Parent = Window;

    local WindowMUIStroke = Instance.new("UIStroke");
    WindowMUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    WindowMUIStroke.Color = Color3.fromRGB(32, 32, 32);
    WindowMUIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    WindowMUIStroke.Thickness = 1;
    WindowMUIStroke.Transparency = 0;
    WindowMUIStroke.Parent = WindowMinimize;

    local WindowMUIStrokeAlt = Instance.new("UIStroke");
    WindowMUIStrokeAlt.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    WindowMUIStrokeAlt.Color = Color3.fromRGB(130, 130, 130);
    WindowMUIStrokeAlt.LineJoinMode = Enum.LineJoinMode.Round;
    WindowMUIStrokeAlt.Thickness = 2;
    WindowMUIStrokeAlt.Transparency = 0;
    WindowMUIStrokeAlt.Parent = WindowMinimize;

    local WindowMUISAltGrad = Instance.new("UIGradient");
    WindowMUISAltGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(95, 95, 95)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    });
    WindowMUISAltGrad.Rotation = -90;
    WindowMUISAltGrad.Parent = WindowMUIStrokeAlt;

    local WindowTitle = Instance.new("TextLabel");
    WindowTitle.BackgroundTransparency = 1;
    WindowTitle.Position = UDim2.fromScale(0.213, 0.167);
    WindowTitle.Size = UDim2.fromOffset(120, 20);
    WindowTitle.Font = Enum.Font.TitilliumWeb;
    WindowTitle.Text = Title;
    WindowTitle.TextColor3 = Color3.fromRGB(255, 255, 255);
    WindowTitle.TextSize = 22;
    WindowTitle.TextWrapped = true;
    WindowTitle.Parent = Window;

    local WindowTUIStroke = Instance.new("UIStroke");
    WindowTUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    WindowTUIStroke.Color = Color3.fromRGB(32, 32, 32);
    WindowTUIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    WindowTUIStroke.Thickness = 1.5;
    WindowTUIStroke.Transparency = 0;
    WindowTUIStroke.Parent = WindowTitle;

    local WindowTUIStrokeAlt = Instance.new("UIStroke");
    WindowTUIStrokeAlt.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    WindowTUIStrokeAlt.Color = Color3.fromRGB(130, 130, 130);
    WindowTUIStrokeAlt.LineJoinMode = Enum.LineJoinMode.Round;
    WindowTUIStrokeAlt.Thickness = 2;
    WindowTUIStrokeAlt.Transparency = 0;
    WindowTUIStrokeAlt.Parent = WindowTitle;

    local WindowTUISAltGrad = Instance.new("UIGradient");
    WindowTUISAltGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(95, 95, 95)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    });
    WindowTUISAltGrad.Rotation = -90;
    WindowTUISAltGrad.Parent = WindowTUIStrokeAlt;

    function W:Button(Text: string, Callback)
        if type(Callback) ~= "function" then
            error("Callback must be a function");
        end;

        local WindowCHButton = Instance.new("TextButton");
        WindowCHButton.AutoButtonColor = false;
        WindowCHButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90);
        WindowCHButton.BorderColor3 = Color3.fromRGB(75, 75, 75);
        WindowCHButton.BorderSizePixel = 2;
        WindowCHButton.Size = UDim2.fromOffset(151, 21);
        WindowCHButton.Font = Enum.Font.TitilliumWeb;
        WindowCHButton.Text = Text;
        WindowCHButton.TextColor3 = Color3.fromRGB(255, 255, 255);
        WindowCHButton.TextSize = 22;
        WindowCHButton.Parent = WindowContentHolder;

        local WindowCHButtonStroke = Instance.new("UIStroke");
        WindowCHButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        WindowCHButtonStroke.Color = Color3.fromRGB(32, 32, 32);
        WindowCHButtonStroke.LineJoinMode = Enum.LineJoinMode.Round;
        WindowCHButtonStroke.Thickness = 1;
        WindowCHButtonStroke.Transparency = 0;
        WindowCHButtonStroke.Parent = WindowCHButton;

        WindowCHButton.MouseEnter:Connect(function()
            local EnterTween = TweenService:Create(WindowCHButton, TweenInformation, {
                ["BackgroundColor3"] = Color3.fromRGB(65, 65, 65)
            });
            EnterTween:Play();
        end);

        WindowCHButton.MouseLeave:Connect(function()
            local ExitTween = TweenService:Create(WindowCHButton, TweenInformation, {
                ["BackgroundColor3"] = Color3.fromRGB(90, 90, 90)
            });
            ExitTween:Play();
        end);

        WindowCHButton.MouseButton1Click:Connect(Callback);
    end;

    function W:Toggle(Text: string, Value: boolean, Callback)
        if type(Callback) ~= "function" then
            error("Callback must be a function");
        end;

        local T = {
            State = Value
        };

        local WindowCHToggleLabel = Instance.new("TextLabel");
        WindowCHToggleLabel.BackgroundTransparency = 1;
        WindowCHToggleLabel.Size = UDim2.fromOffset(143, 24);
        WindowCHToggleLabel.Font = Enum.Font.TitilliumWeb;
        WindowCHToggleLabel.Text = Text;
        WindowCHToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        WindowCHToggleLabel.TextSize = 22;
        WindowCHToggleLabel.TextXAlignment = Enum.TextXAlignment.Left;
        WindowCHToggleLabel.Parent = WindowContentHolder;

        local WindowCHTLabelStroke = Instance.new("UIStroke");
        WindowCHTLabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        WindowCHTLabelStroke.Color = Color3.fromRGB(32, 32, 32);
        WindowCHTLabelStroke.LineJoinMode = Enum.LineJoinMode.Round;
        WindowCHTLabelStroke.Thickness = 1;
        WindowCHTLabelStroke.Transparency = 0;
        WindowCHTLabelStroke.Parent = WindowCHToggleLabel;

        local WindowCHToggle = Instance.new("TextButton");
        WindowCHToggle.AutoButtonColor = false;
        WindowCHToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        WindowCHToggle.BorderColor3 = Color3.fromRGB(75, 75, 75);
        WindowCHToggle.BorderSizePixel = 2;
        WindowCHToggle.Position = UDim2.fromScale(0.876, 0.167);
        WindowCHToggle.Size = UDim2.fromOffset(16, 16);
        WindowCHToggle.Text = "";
        WindowCHToggle.Parent = WindowCHToggleLabel;

        local WindowCHToggleGrad = Instance.new("UIGradient");
        WindowCHToggleGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, T.State and Color3.fromRGB(175, 175, 175) or Color3.fromRGB(94, 94, 94)),
            ColorSequenceKeypoint.new(1, T.State and Color3.fromRGB(230, 230, 230) or Color3.fromRGB(116, 116, 116))
        });
        WindowCHToggleGrad.Rotation = -90;
        WindowCHToggleGrad.Parent = WindowCHToggle;

        WindowCHToggle.MouseButton1Click:Connect(function()
            T.State = not T.State;
            WindowCHToggleGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, T.State and Color3.fromRGB(175, 175, 175) or Color3.fromRGB(94, 94, 94)),
                ColorSequenceKeypoint.new(1, T.State and Color3.fromRGB(230, 230, 230) or Color3.fromRGB(116, 116, 116))
            });
            Callback(T.State);
        end);

        return T;
    end;

    WindowMinimize.MouseButton1Click:Connect(function()
        if not W.Minimized then
            for _, Child in next, WindowContentHolder:GetChildren() do
                if Child:IsA("TextLabel") then
                    local Tween = TweenService:Create(Child, TweenInformation, {
                        ["TextTransparency"] = 1
                    });

                    for _, Descendant in next, Child:GetChildren() do
                        if Descendant:IsA("TextButton") then
                            local TweenButton = TweenService:Create(Descendant, TweenInformation, {
                                ["BackgroundTransparency"] = 1
                            });
                            TweenButton:Play();
                        end;
                    end;

                    Tween:Play();

                    Child.Visible = false;
                elseif Child:IsA("TextButton") then
                    local Tween = TweenService:Create(Child, TweenInformation, {
                        ["BackgroundTransparency"] = 1,
                        ["TextTransparency"] = 1
                    });

                    local ChildUIStroke = Child:FindFirstChildWhichIsA("UIStroke");

                    if ChildUIStroke ~= nil then
                        local TweenUIStroke = TweenService:Create(ChildUIStroke, TweenInformation, {
                            ["Transparency"] = 1
                        });
                        TweenUIStroke:Play();
                    end;

                    Tween:Play();

                    Child.Visible = false;
                end;
            end;

            WindowContent.AutomaticSize = Enum.AutomaticSize.None;

            local WindowContentTween = TweenService:Create(WindowContent, TweenInformation, {
                ["Size"] = UDim2.fromOffset(160, 0)
            });

            WindowContentTween:Play();

            local WindowMinimizeTween = TweenService:Create(WindowMinimize, TweenInformation, {
                ["Rotation"] = -90
            });

            WindowMinimizeTween:Play();

            W.Minimized = true;
        else
            local WindowMinimizeTween = TweenService:Create(WindowMinimize, TweenInformation, {
                ["Rotation"] = 0
            });

            WindowMinimizeTween:Play();

            local WindowContentTween = TweenService:Create(WindowContent, TweenInformation, {
                ["Size"] = UDim2.fromOffset(160, 190)
            });

            WindowContentTween:Play();

            WindowContent.AutomaticSize = Enum.AutomaticSize.Y;

            for _, Child in next, WindowContentHolder:GetChildren() do
                if Child:IsA("TextLabel") then
                    Child.Visible = true;

                    local Tween = TweenService:Create(Child, TweenInformation, {
                        ["TextTransparency"] = 0
                    });

                    for _, Descendant in next, Child:GetChildren() do
                        if Descendant:IsA("TextButton") then
                            local TweenButton = TweenService:Create(Descendant, TweenInformation, {
                                ["BackgroundTransparency"] = 0
                            });
                            TweenButton:Play();
                        end;
                    end;

                    Tween:Play();
                elseif Child:IsA("TextButton") then
                    Child.Visible = true;

                    local Tween = TweenService:Create(Child, TweenInformation, {
                        ["BackgroundTransparency"] = 0,
                        ["TextTransparency"] = 0
                    });

                    local ChildUIStroke = Child:FindFirstChildWhichIsA("UIStroke");

                    if ChildUIStroke ~= nil then
                        local TweenUIStroke = TweenService:Create(ChildUIStroke, TweenInformation, {
                            ["Transparency"] = 0
                        });
                        TweenUIStroke:Play();
                    end;

                    Tween:Play();
                end;
            end;

            W.Minimized = false;
        end;
    end);

    Window.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            W.DragInfo.Dragging = true;
            W.DragInfo.DragStart = Input.Position;
            W.DragInfo.StartPos = Window.Position;

            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    W.DragInfo.Dragging = false;
                end;
            end);
        end;
    end);

    Window.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            W.DragInfo.DragInput = Input;
        end;
    end);

    UserInputService.InputChanged:Connect(function(Input)
        if Input == W.DragInfo.DragInput and W.DragInfo.Dragging then
            local Delta = Input.Position - W.DragInfo.DragStart;
            local StartPos =  W.DragInfo.StartPos;
            Window.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y);
        end;
    end);

    WindowXOffset = WindowXOffset + 200;

    return W;
end;

return Library;