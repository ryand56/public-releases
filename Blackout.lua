local Library = {};

local CoreGui = game:GetService("CoreGui");
local RunService = game:GetService("RunService");

-- Returns a Window object that contains controls
function Library:Window(Title: string, Color: Color3)
    local WColor = typeof(Color) == "Color3" and Color or Color3.fromRGB(255, 255, 255);

    local W = {
        Name = Title,
        Tabs = 0
    }

    local Window = Instance.new("ScreenGui");
    Window.Name = "Window";
    Window.Parent = CoreGui;

    local WindowFrame = Instance.new("Frame");
    WindowFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    WindowFrame.BorderColor3 = Color3.fromRGB(0, 0, 0);
    WindowFrame.BorderSizePixel = 2;
    WindowFrame.Name = "WindowMain";
    WindowFrame.Position = UDim2.fromScale(0.202, 0.226);
    WindowFrame.Size = UDim2.fromOffset(518, 684);
    WindowFrame.Parent = Window;

    local WFGradient = Instance.new("UIGradient");
    WFGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(26, 26, 26))
    });
    WFGradient.Offset = Vector2.new(0, -0.9);
    WFGradient.Rotation = 90;
    WFGradient.Parent = WindowFrame;

    local WFHeader = Instance.new("Frame");
    WFHeader.BackgroundColor3 = WColor;
    WFHeader.BorderColor3 = Color3.fromRGB(0, 0, 0);
    WFHeader.BorderSizePixel = 2;
    WFHeader.Name = "Header";
    WFHeader.Position = UDim2.new();
    WFHeader.Size = UDim2.fromOffset(517, 5);
    WFHeader.Parent = WindowFrame;

    local WindowContent = Instance.new("Frame");
    WindowContent.BackgroundTransparency = 1;
    WindowContent.Name = "WindowContent";
    WindowContent.Position = UDim2.fromScale(0.015, 0.015);
    WindowContent.Size = UDim2.fromOffset(503, 667);
    WindowContent.Parent = WindowFrame;

    local SubContent = Instance.new("Frame");
    SubContent.BackgroundTransparency = 1;
    SubContent.Name = "Content";
    SubContent.Position = UDim2.fromScale(0.014, 0.055);
    SubContent.Size = UDim2.fromOffset(489, 620);
    SubContent.Parent = WindowContent;

    local SCMain = Instance.new("Frame");
    SCMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    SCMain.BorderColor3 = Color3.fromRGB(0, 0, 0);
    SCMain.BorderSizePixel = 2;
    SCMain.Name = "Main";
    SCMain.Position = UDim2.fromScale(0, 0.019);
    SCMain.Size = UDim2.fromOffset(489, 607);
    SCMain.Parent = SubContent;

    local SCMainGradient = Instance.new("UIGradient");
    SCMainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 13, 13))
    });
    SCMainGradient.Offset = Vector2.new(0, -0.92);
    SCMainGradient.Rotation = 90;
    SCMainGradient.Parent = SCMain;

    local SCMainTabHolder = Instance.new("Frame");
    SCMainTabHolder.BackgroundTransparency = 1;
    SCMainTabHolder.Name = "TabHolder";
    SCMainTabHolder.Position = UDim2.new();
    SCMainTabHolder.Size = UDim2.fromOffset(488, 48);
    SCMainTabHolder.Parent = SCMain;

    local SCMainTHLayout = Instance.new("UIListLayout");
    SCMainTHLayout.FillDirection = Enum.FillDirection.Horizontal;
    SCMainTHLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    SCMainTHLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    SCMainTHLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
    SCMainTHLayout.Parent = SCMainTabHolder;

    local SCHeader = Instance.new("Frame");
    SCHeader.BackgroundColor3 = WColor;
    SCHeader.BorderColor3 = Color3.fromRGB(0, 0, 0);
    SCHeader.BorderSizePixel = 2;
    SCHeader.Name = "Header";
    SCHeader.Position = UDim2.new();
    SCHeader.Size = UDim2.fromOffset(489, 5);
    SCHeader.Parent = SubContent;

    local WCTitle = Instance.new("TextLabel");
    WCTitle.BackgroundTransparency = 1;
    WCTitle.Name = "Title";
    WCTitle.Position = UDim2.new();
    WCTitle.Size = UDim2.fromOffset(503, 27);
    WCTitle.Font = Enum.Font.SourceSans;
    WCTitle.Text = Title;
    WCTitle.TextColor3 = Color3.fromRGB(255, 255, 255);
    WCTitle.TextSize = 24;
    WCTitle.Parent = WindowContent;

    WCTitle:GetPropertyChangedSignal("Text"):Connect(function()
        W.Name = WCTitle.Text;
    end);

    function W:Tab(TabTitle: string)
        if self.Tabs < 5 then
            local T = {
                Name = TabTitle,
                Sections = 0
            };

            self.Tabs += 1;

            local SCMainTab = Instance.new("TextButton");
            SCMainTab.AutoButtonColor = false;
            SCMainTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
            SCMainTab.BackgroundTransparency = self.Tabs == 1 and 1 or 0;
            SCMainTab.BorderColor3 = Color3.fromRGB(0, 0, 0);
            SCMainTab.BorderSizePixel = 2;
            SCMainTab.LayoutOrder = self.Tabs;
            SCMainTab.Name = "TabButton" .. self.Tabs;
            SCMainTab.Size = self.Tabs == 5 and UDim2.fromOffset(93, 48) or UDim2.fromOffset(99, 48);
            SCMainTab.Font = Enum.Font.SourceSans;
            SCMainTab.Text = TabTitle;
            SCMainTab.TextColor3 = Color3.fromRGB(255, 255, 255);
            SCMainTab.TextSize = 20;
            SCMainTab.Parent = SCMainTabHolder;

            SCMainTab:GetPropertyChangedSignal("Text"):Connect(function()
                T.Name = SCMainTab.Text;
            end);

            local SCMainTabContent = Instance.new("Frame");
            SCMainTabContent.BackgroundTransparency = 1;
            SCMainTabContent.Name = "TabContent" .. self.Tabs;
            SCMainTabContent.Position = UDim2.fromScale(0.039, 0.143);
            SCMainTabContent.Size = UDim2.fromOffset(489, 558);
            SCMainTabContent.Parent = SCMain;

            local SCMainTabContentLayout = Instance.new("UIGridLayout");
            SCMainTabContentLayout.CellPadding = UDim2.fromOffset(5, 5);
            SCMainTabContentLayout.CellSize = UDim2.fromOffset(225, 225);
            SCMainTabContentLayout.FillDirection = Enum.FillDirection.Horizontal;
            SCMainTabContentLayout.FillDirectionMaxCells = 2;
            SCMainTabContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
            SCMainTabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder;
            SCMainTabContentLayout.StartCorner = Enum.StartCorner.TopLeft;
            SCMainTabContentLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
            SCMainTabContentLayout.Parent = SCMainTabContent;

            local SCMainTabContentObj = Instance.new("ObjectValue");
            SCMainTabContentObj.Name = "Content";
            SCMainTabContentObj.Value = SCMainTabContent;
            SCMainTabContentObj.Parent = SCMainTab;

            SCMainTab.MouseButton1Click:Connect(function()
                if SCMainTab.BackgroundTransparency == 0 then
                    for _, Child in next, SCMainTabHolder:GetChildren() do
                        if Child:IsA("TextButton") and Child ~= SCMainTab then
                            Child.BackgroundTransparency = 0;
                            local TabContent = Child:FindFirstChildWhichIsA("ObjectValue");
                            if TabContent ~= nil then
                                if TabContent.Value ~= nil and TabContent.Value:IsA("Frame") then
                                    TabContent.Value.Visible = false;
                                end;
                            end;
                        end;
                    end;
                    SCMainTab.BackgroundTransparency = 1;
                    local TabContent = SCMainTab:FindFirstChildWhichIsA("ObjectValue");
                    if TabContent ~= nil then
                        if TabContent.Value ~= nil and TabContent.Value:IsA("Frame") then
                            TabContent.Value.Visible = true;
                        end;
                    end;
                end;
            end);

            function T:Section(SectTitle: string)
                local S = {
                    Name = SectTitle
                };

                self.Sections += 1;

                local SCMainTabSection = Instance.new("Frame");
                SCMainTabSection.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
                SCMainTabSection.BorderColor3 = Color3.fromRGB(0, 0, 0);
                SCMainTabSection.BorderSizePixel = 2;
                SCMainTabSection.LayoutOrder = self.Sections;
                SCMainTabSection.Name = "TabSection" .. self.Sections;
                SCMainTabSection.Parent = SCMainTabContent;

                local SCMainTabSectHeader = Instance.new("Frame");
                SCMainTabSectHeader.BackgroundColor3 = WColor;
                SCMainTabSectHeader.BorderColor3 = Color3.fromRGB(0, 0, 0);
                SCMainTabSectHeader.BorderSizePixel = 2;
                SCMainTabSectHeader.Name = "Header";
                SCMainTabSectHeader.Position = UDim2.new();
                SCMainTabSectHeader.Size = UDim2.fromOffset(224, 3);
                SCMainTabSectHeader.Parent = SCMainTabSection;

                local SCMainTabSHTitle = Instance.new("TextLabel");
                SCMainTabSHTitle.BackgroundTransparency = 1;
                SCMainTabSHTitle.Name = "Title";
                SCMainTabSHTitle.Position = UDim2.fromScale(0.045, 3);
                SCMainTabSHTitle.Size = UDim2.fromOffset(204, 16);
                SCMainTabSHTitle.Font = Enum.Font.SourceSans;
                SCMainTabSHTitle.Text = SectTitle;
                SCMainTabSHTitle.TextColor3 = Color3.fromRGB(255, 255, 255);
                SCMainTabSHTitle.TextSize = 20;
                SCMainTabSHTitle.TextXAlignment = Enum.TextXAlignment.Left;
                SCMainTabSHTitle.Parent = SCMainTabSectHeader;

                SCMainTabSHTitle:GetPropertyChangedSignal("Text"):Connect(function()
                    S.Name = SCMainTabSHTitle.Text;
                end);

                local SCMainTabSectContent = Instance.new("Frame");
                SCMainTabSectContent.BackgroundTransparency = 1;
                SCMainTabSectContent.Name = "SectionContent";
                SCMainTabSectContent.Position = UDim2.fromScale(0.044, 0.147);
                SCMainTabSectContent.Size = UDim2.fromOffset(204, 183);
                SCMainTabSectContent.Parent = SCMainTabSection;

                local SCMainTabSectCLayout = Instance.new("UIListLayout");
                SCMainTabSectCLayout.Padding = UDim.new(0, 5);
                SCMainTabSectCLayout.FillDirection = Enum.FillDirection.Vertical;
                SCMainTabSectCLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
                SCMainTabSectCLayout.SortOrder = Enum.SortOrder.LayoutOrder;
                SCMainTabSectCLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
                SCMainTabSectCLayout.Parent = SCMainTabSectContent;

                function S:Toggle(Text: string, Checked: boolean, Callback)
                    if type(Callback) == "function" then
                        local Toggle = {
                            State = Checked
                        };

                        local SCMainTabSectCToggleLabel = Instance.new("TextLabel");
                        SCMainTabSectCToggleLabel.BackgroundTransparency = 1;
                        SCMainTabSectCToggleLabel.Name = "Toggle";
                        SCMainTabSectCToggleLabel.Size = UDim2.fromOffset(70, 23);
                        SCMainTabSectCToggleLabel.Font = Enum.Font.SourceSans;
                        SCMainTabSectCToggleLabel.Text = Text;
                        SCMainTabSectCToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                        SCMainTabSectCToggleLabel.TextScaled = true;
                        SCMainTabSectCToggleLabel.TextXAlignment = Enum.TextXAlignment.Left;
                        SCMainTabSectCToggleLabel.Parent = SCMainTabSectContent;

                        local SCMainTabSectCToggle = Instance.new("TextButton");
                        SCMainTabSectCToggle.AutoButtonColor = false;
                        SCMainTabSectCToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                        SCMainTabSectCToggle.BorderColor3 = Color3.fromRGB(0, 0, 0);
                        SCMainTabSectCToggle.BorderSizePixel = 2;
                        SCMainTabSectCToggle.Name = "Toggle";
                        SCMainTabSectCToggle.Position = UDim2.fromScale(0.7, 0.174);
                        SCMainTabSectCToggle.Size = UDim2.fromOffset(15, 15);
                        SCMainTabSectCToggle.Font = Enum.Font.SourceSans;
                        SCMainTabSectCToggle.Text = "";
                        SCMainTabSectCToggle.Parent = SCMainTabSectCToggleLabel;

                        local SCMainTabSectCToggleGradient = Instance.new("UIGradient");
                        SCMainTabSectCToggleGradient.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 13, 13))
                        });
                        SCMainTabSectCToggleGradient.Offset = Vector2.new(0, -0.5);
                        SCMainTabSectCToggleGradient.Rotation = 90;
                        SCMainTabSectCToggleGradient.Parent = SCMainTabSectCToggle;

                        local SCMainTabSectCToggleImage = Instance.new("ImageLabel");
                        SCMainTabSectCToggleImage.BackgroundTransparency = 1;
                        SCMainTabSectCToggleImage.Name = "Check";
                        SCMainTabSectCToggleImage.Position = UDim2.new();
                        SCMainTabSectCToggleImage.Size = UDim2.fromOffset(15, 15);
                        SCMainTabSectCToggleImage.Visible = Toggle.State;
                        SCMainTabSectCToggleImage.Image = "rbxassetid://6290039376";
                        SCMainTabSectCToggleImage.ImageColor3 = Color3.fromRGB(255, 255, 255);
                        SCMainTabSectCToggleImage.ResampleMode = Enum.ResamplerMode.Default;
                        SCMainTabSectCToggleImage.ScaleType = Enum.ScaleType.Fit;
                        SCMainTabSectCToggleImage.Parent = SCMainTabSectCToggle;

                        SCMainTabSectCToggle.MouseButton1Click:Connect(function()
                            Toggle.State = not Toggle.State;

                            if Toggle.State then
                                SCMainTabSectCToggleImage.Visible = true;
                            else
                                SCMainTabSectCToggleImage.Visible = false;
                            end;

                            Callback(Toggle.State);
                        end);

                        return Toggle;
                    end;
                end;

                function S:Button(Text: string, Callback)
                    if type(Callback) == "function" then
                        local SCMainTabSectCButton = Instance.new("TextButton");
                        SCMainTabSectCButton.AutoButtonColor = false;
                        SCMainTabSectCButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                        SCMainTabSectCButton.BorderColor3 = Color3.fromRGB(0, 0, 0);
                        SCMainTabSectCButton.BorderSizePixel = 2;
                        SCMainTabSectCButton.Name = "Button";
                        SCMainTabSectCButton.Size = UDim2.fromOffset(135, 22);
                        SCMainTabSectCButton.Font = Enum.Font.SourceSans;
                        SCMainTabSectCButton.Text = "";
                        SCMainTabSectCButton.Parent = SCMainTabSectContent;

                        local SCMainTabSectCBGradient = Instance.new("UIGradient");
                        SCMainTabSectCBGradient.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 13, 13))
                        });
                        SCMainTabSectCBGradient.Offset = Vector2.new(0, -0.5);
                        SCMainTabSectCBGradient.Rotation = 90;
                        SCMainTabSectCBGradient.Parent = SCMainTabSectCButton;

                        local SCMainTabSectCButtonLabel = Instance.new("TextLabel");
                        SCMainTabSectCButtonLabel.BackgroundTransparency = 1;
                        SCMainTabSectCButtonLabel.Name = "Label";
                        SCMainTabSectCButtonLabel.Position = UDim2.new();
                        SCMainTabSectCButtonLabel.Size = UDim2.fromOffset(135, 22);
                        SCMainTabSectCButtonLabel.Font = Enum.Font.SourceSans;
                        SCMainTabSectCButtonLabel.Text = Text;
                        SCMainTabSectCButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
                        SCMainTabSectCButtonLabel.TextSize = 18;
                        SCMainTabSectCButtonLabel.Parent = SCMainTabSectCButton;

                        SCMainTabSectCButton.MouseButton1Click:Connect(Callback);
                    end;
                end;

                return S;
            end;

            return T;
        end;
    end;

    return W;
end;

return Library;