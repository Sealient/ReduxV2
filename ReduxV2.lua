-- ReduxV2 UI Library - Ultra Sleek Edition
local ReduxV2 = {}

-- Add this Colors table at the top of your ReduxV2 library (replace your existing Colors table)
local Colors = {
	Background = Color3.fromRGB(10, 10, 15),
	Secondary = Color3.fromRGB(20, 20, 28),
	Accent = Color3.fromRGB(147, 51, 234), -- Vibrant Purple
	AccentHover = Color3.fromRGB(167, 71, 254),
	Text = Color3.fromRGB(245, 245, 245),
	TextMuted = Color3.fromRGB(180, 180, 190),
	Hover = Color3.fromRGB(35, 35, 45),
	Border = Color3.fromRGB(45, 45, 55),
	Success = Color3.fromRGB(34, 197, 94)
}

local NotificationService = {}

function ReduxV2:CreateMain(title)
	local player = game.Players.LocalPlayer
	local parent = player:WaitForChild("PlayerGui")

	-- Destroy existing UI with same name
	local destroyIfExist = parent:GetChildren()
	for _, gui in pairs(destroyIfExist) do
		if gui.Name == title then
			print("ReduxV2: Destroyed existing "..tostring(title))
			gui:Destroy()
		end
	end

	-- Main UI Instances
	local ReduxV2 = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local TopBar = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local CloseButton = Instance.new("TextButton")
	local MinimizeButton = Instance.new("TextButton")
	local TabContainer = Instance.new("Frame")
	local TabList = Instance.new("ScrollingFrame")
	local TabListLayout = Instance.new("UIListLayout")
	local ContentContainer = Instance.new("Frame")
	local Content = Instance.new("Frame")
	local ContentLayout = Instance.new("UIListLayout")

	-- ScreenGui
	ReduxV2.Name = title
	ReduxV2.Parent = parent
	ReduxV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ReduxV2.ResetOnSpawn = false

	-- Main Frame (Thinner and Sleeker)
	MainFrame.Name = "MainFrame"
	MainFrame.Parent = ReduxV2
	MainFrame.BackgroundColor3 = Colors.Background
	MainFrame.BorderColor3 = Colors.Border
	MainFrame.BorderSizePixel = 1
	MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
	MainFrame.Size = UDim2.new(0, 400, 0, 300) -- More compact
	MainFrame.ClipsDescendants = true

	-- Top Bar (Thinner)
	TopBar.Name = "TopBar"
	TopBar.Parent = MainFrame
	TopBar.BackgroundColor3 = Colors.Secondary
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(1, 0, 0, 28) -- Reduced height

	-- Title
	Title.Name = "Title"
	Title.Parent = TopBar
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 12, 0, 0)
	Title.Size = UDim2.new(0.7, 0, 1, 0)
	Title.Font = Enum.Font.GothamMedium
	Title.Text = title
	Title.TextColor3 = Colors.Accent
	Title.TextSize = 13
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- Close Button (Minimal)
	CloseButton.Name = "CloseButton"
	CloseButton.Parent = TopBar
	CloseButton.BackgroundTransparency = 1
	CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
	CloseButton.Size = UDim2.new(0, 28, 1, 0)
	CloseButton.Font = Enum.Font.GothamMedium
	CloseButton.Text = "×"
	CloseButton.TextColor3 = Colors.TextMuted
	CloseButton.TextSize = 16

	-- Minimize Button
	MinimizeButton.Name = "MinimizeButton"
	MinimizeButton.Parent = TopBar
	MinimizeButton.BackgroundTransparency = 1
	MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
	MinimizeButton.Size = UDim2.new(0, 28, 1, 0)
	MinimizeButton.Font = Enum.Font.GothamMedium
	MinimizeButton.Text = "−"
	MinimizeButton.TextColor3 = Colors.TextMuted
	MinimizeButton.TextSize = 16

	-- Tab Container (Thinner)
	TabContainer.Name = "TabContainer"
	TabContainer.Parent = MainFrame
	TabContainer.BackgroundColor3 = Colors.Secondary
	TabContainer.BorderSizePixel = 0
	TabContainer.Position = UDim2.new(0, 0, 0, 28)
	TabContainer.Size = UDim2.new(0, 100, 0, 272) -- Narrower tabs

	-- Tab List
	TabList.Name = "TabList"
	TabList.Parent = TabContainer
	TabList.BackgroundTransparency = 1
	TabList.BorderSizePixel = 0
	TabList.Position = UDim2.new(0, 4, 0, 4)
	TabList.Size = UDim2.new(1, -8, 1, -8)
	TabList.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabList.ScrollBarThickness = 2
	TabList.ScrollBarImageColor3 = Colors.Accent

	TabListLayout.Name = "TabListLayout"
	TabListLayout.Parent = TabList
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabListLayout.Padding = UDim.new(0, 3) -- Tighter spacing

	-- Content Container
	ContentContainer.Name = "ContentContainer"
	ContentContainer.Parent = MainFrame
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Position = UDim2.new(0, 100, 0, 28)
	ContentContainer.Size = UDim2.new(0, 300, 0, 272)

	-- Content
	Content.Name = "Content"
	Content.Parent = ContentContainer
	Content.BackgroundTransparency = 1
	Content.Position = UDim2.new(0, 8, 0, 8)
	Content.Size = UDim2.new(1, -16, 1, -16)

	ContentLayout.Name = "ContentLayout"
	ContentLayout.Parent = Content
	ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ContentLayout.Padding = UDim.new(0, 6) -- Tighter spacing

	-- Make window draggable
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	TopBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	-- Button functionality
	CloseButton.MouseButton1Click:Connect(function()
		ReduxV2.Enabled = not ReduxV2.Enabled
	end)

	CloseButton.MouseEnter:Connect(function()
		CloseButton.TextColor3 = Colors.Text
	end)

	CloseButton.MouseLeave:Connect(function()
		CloseButton.TextColor3 = Colors.TextMuted
	end)

	MinimizeButton.MouseEnter:Connect(function()
		MinimizeButton.TextColor3 = Colors.Text
	end)

	MinimizeButton.MouseLeave:Connect(function()
		MinimizeButton.TextColor3 = Colors.TextMuted
	end)

	local minimized = false
	MinimizeButton.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			ContentContainer.Visible = false
			TabContainer.Visible = false
			MainFrame.Size = UDim2.new(0, 400, 0, 28)
			MinimizeButton.Text = "+"
		else
			ContentContainer.Visible = true
			TabContainer.Visible = true
			MainFrame.Size = UDim2.new(0, 400, 0, 300)
			MinimizeButton.Text = "−"
		end
	end)

	-- UI Functions
	local uiFunctions = {}
	local currentTab = nil

	function uiFunctions:CreateTab(tabName, tabIcon)
		local TabButton = Instance.new("TextButton")

		TabButton.Name = tabName
		TabButton.Parent = TabList
		TabButton.BackgroundColor3 = Colors.Secondary
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(1, 0, 0, 30) -- Slightly thinner
		TabButton.Font = Enum.Font.Gotham
		TabButton.Text = ""
		TabButton.TextColor3 = Colors.TextMuted
		TabButton.TextSize = 11
		TabButton.AutoButtonColor = false

		-- Tab Content
		local TabIcon = Instance.new("TextLabel")
		TabIcon.Name = "Icon"
		TabIcon.Parent = TabButton
		TabIcon.BackgroundTransparency = 1
		TabIcon.Position = UDim2.new(0, 8, 0, 0)
		TabIcon.Size = UDim2.new(0, 16, 1, 0)
		TabIcon.Font = Enum.Font.GothamMedium
		TabIcon.Text = tabIcon or "»"
		TabIcon.TextColor3 = Colors.TextMuted
		TabIcon.TextSize = 11
		TabIcon.TextXAlignment = Enum.TextXAlignment.Left

		local TabName = Instance.new("TextLabel")
		TabName.Name = "TabName"
		TabName.Parent = TabButton
		TabName.BackgroundTransparency = 1
		TabName.Position = UDim2.new(0, 28, 0, 0)
		TabName.Size = UDim2.new(1, -28, 1, 0)
		TabName.Font = Enum.Font.Gotham
		TabName.Text = tabName
		TabName.TextColor3 = Colors.TextMuted
		TabName.TextSize = 11
		TabName.TextXAlignment = Enum.TextXAlignment.Left

		-- Tab Content Frame
		local TabContent = Instance.new("ScrollingFrame")
		TabContent.Name = tabName .. "Content"
		TabContent.Parent = Content
		TabContent.BackgroundTransparency = 1
		TabContent.BorderSizePixel = 0
		TabContent.Size = UDim2.new(1, 0, 1, 0)
		TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
		TabContent.ScrollBarThickness = 2
		TabContent.ScrollBarImageColor3 = Colors.Accent
		TabContent.Visible = false

		local TabContentLayout = Instance.new("UIListLayout")
		TabContentLayout.Name = "Layout"
		TabContentLayout.Parent = TabContent
		TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TabContentLayout.Padding = UDim.new(0, 6)

		-- Update canvas size
		TabContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 10)
		end)

		-- Tab button functionality
		TabButton.MouseEnter:Connect(function()
			if currentTab ~= TabContent then
				game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.15), {BackgroundColor3 = Colors.Hover}):Play()
			end
		end)

		TabButton.MouseLeave:Connect(function()
			if currentTab ~= TabContent then
				game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.15), {BackgroundColor3 = Colors.Secondary}):Play()
			end
		end)

		TabButton.MouseButton1Click:Connect(function()
			-- Hide all tab contents
			for _, child in pairs(Content:GetChildren()) do
				if child:IsA("ScrollingFrame") then
					child.Visible = false
				end
			end

			-- Reset all tab buttons
			for _, tabBtn in pairs(TabList:GetChildren()) do
				if tabBtn:IsA("TextButton") then
					game:GetService("TweenService"):Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = Colors.Secondary}):Play()
					if tabBtn:FindFirstChild("Icon") then
						game:GetService("TweenService"):Create(tabBtn.Icon, TweenInfo.new(0.15), {TextColor3 = Colors.TextMuted}):Play()
					end
					if tabBtn:FindFirstChild("TabName") then
						game:GetService("TweenService"):Create(tabBtn.TabName, TweenInfo.new(0.15), {TextColor3 = Colors.TextMuted}):Play()
					end
				end
			end

			-- Show selected tab
			TabContent.Visible = true
			game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.15), {BackgroundColor3 = Colors.Accent}):Play()
			game:GetService("TweenService"):Create(TabIcon, TweenInfo.new(0.15), {TextColor3 = Colors.Text}):Play()
			game:GetService("TweenService"):Create(TabName, TweenInfo.new(0.15), {TextColor3 = Colors.Text}):Play()
			currentTab = TabContent
		end)

		-- Make first tab active by default
		if #TabList:GetChildren() == 1 then
			TabButton.BackgroundColor3 = Colors.Accent
			TabIcon.TextColor3 = Colors.Text
			TabName.TextColor3 = Colors.Text
			TabContent.Visible = true
			currentTab = TabContent
		end

		-- Update tab list size
		TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabList.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
		end)

		-- Tab-specific functions
		local tabFunctions = {}

		function tabFunctions:CreateSection(sectionName)
			local Section = Instance.new("Frame")
			local SectionHeader = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local SectionDivider = Instance.new("Frame")
			local SectionContent = Instance.new("Frame")
			local SectionLayout = Instance.new("UIListLayout")

			Section.Name = "Section"
			Section.Parent = TabContent
			Section.BackgroundTransparency = 1
			Section.Size = UDim2.new(1, 0, 0, 0)

			-- Section Header
			SectionHeader.Name = "SectionHeader"
			SectionHeader.Parent = Section
			SectionHeader.BackgroundTransparency = 1
			SectionHeader.Size = UDim2.new(1, 0, 0, 20)

			SectionTitle.Name = "SectionTitle"
			SectionTitle.Parent = SectionHeader
			SectionTitle.BackgroundTransparency = 1
			SectionTitle.Position = UDim2.new(0, 0, 0, 0)
			SectionTitle.Size = UDim2.new(1, 0, 1, 0)
			SectionTitle.Font = Enum.Font.GothamMedium
			SectionTitle.Text = string.upper(sectionName)
			SectionTitle.TextColor3 = Colors.Accent
			SectionTitle.TextSize = 10
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

			-- Thin divider line
			SectionDivider.Name = "SectionDivider"
			SectionDivider.Parent = SectionHeader
			SectionDivider.BackgroundColor3 = Colors.Border
			SectionDivider.BorderSizePixel = 0
			SectionDivider.Position = UDim2.new(0, 0, 1, -1)
			SectionDivider.Size = UDim2.new(1, 0, 0, 1)

			SectionContent.Name = "SectionContent"
			SectionContent.Parent = Section
			SectionContent.BackgroundTransparency = 1
			SectionContent.Position = UDim2.new(0, 0, 0, 20)
			SectionContent.Size = UDim2.new(1, 0, 0, 0)

			SectionLayout.Name = "SectionLayout"
			SectionLayout.Parent = SectionContent
			SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SectionLayout.Padding = UDim.new(0, 4)

			-- Update section size
			SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				SectionContent.Size = UDim2.new(1, 0, 0, SectionLayout.AbsoluteContentSize.Y)
				Section.Size = UDim2.new(1, 0, 0, SectionLayout.AbsoluteContentSize.Y + 20)
			end)

			local sectionFunctions = {}

			function sectionFunctions:CreateButton(buttonText, callback)
				local Button = Instance.new("TextButton")

				Button.Name = buttonText
				Button.Parent = SectionContent
				Button.BackgroundColor3 = Colors.Secondary
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(1, 0, 0, 26) -- Thinner
				Button.Font = Enum.Font.Gotham
				Button.Text = buttonText
				Button.TextColor3 = Colors.Text
				Button.TextSize = 11
				Button.AutoButtonColor = false

				-- Smooth hover effects
				Button.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Colors.Hover}):Play()
				end)

				Button.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Colors.Secondary}):Play()
				end)

				Button.MouseButton1Click:Connect(function()
					-- Click feedback
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Colors.Accent}):Play()
					task.wait(0.1)
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Colors.Hover}):Play()

					if callback then
						pcall(callback)
					end
				end)

				return Button
			end

			function sectionFunctions:CreateToggle(toggleText, defaultState, callback)
				local ToggleFrame = Instance.new("Frame")
				local ToggleContainer = Instance.new("Frame")
				local ToggleButton = Instance.new("TextButton")
				local Checkbox = Instance.new("Frame")
				local Checkmark = Instance.new("TextLabel")
				local ToggleLabel = Instance.new("TextLabel")

				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = SectionContent
				ToggleFrame.BackgroundTransparency = 1
				ToggleFrame.Size = UDim2.new(1, 0, 0, 24)

				ToggleContainer.Name = "ToggleContainer"
				ToggleContainer.Parent = ToggleFrame
				ToggleContainer.BackgroundTransparency = 1
				ToggleContainer.Size = UDim2.new(1, 0, 1, 0)

				-- Label
				ToggleLabel.Name = "ToggleLabel"
				ToggleLabel.Parent = ToggleContainer
				ToggleLabel.BackgroundTransparency = 1
				ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
				ToggleLabel.Size = UDim2.new(0.75, 0, 1, 0)
				ToggleLabel.Font = Enum.Font.GothamMedium
				ToggleLabel.Text = toggleText
				ToggleLabel.TextColor3 = Colors.Text
				ToggleLabel.TextSize = 11
				ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

				-- Checkbox
				Checkbox.Name = "Checkbox"
				Checkbox.Parent = ToggleContainer
				Checkbox.BackgroundColor3 = Colors.Secondary
				Checkbox.BorderColor3 = Colors.Border
				Checkbox.BorderSizePixel = 1
				Checkbox.Position = UDim2.new(0.85, 0, 0.25, 0)
				Checkbox.Size = UDim2.new(0, 16, 0, 16)

				-- Checkmark
				Checkmark.Name = "Checkmark"
				Checkmark.Parent = Checkbox
				Checkmark.BackgroundTransparency = 1
				Checkmark.Size = UDim2.new(1, 0, 1, 0)
				Checkmark.Font = Enum.Font.GothamBold
				Checkmark.Text = "✓"
				Checkmark.TextColor3 = Colors.Background
				Checkmark.TextSize = 12
				Checkmark.TextTransparency = 1

				-- Button
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = ToggleContainer
				ToggleButton.BackgroundTransparency = 1
				ToggleButton.Position = UDim2.new(0.75, 0, 0, 0)
				ToggleButton.Size = UDim2.new(0.25, 0, 1, 0)
				ToggleButton.Text = ""
				ToggleButton.AutoButtonColor = false

				local isToggled = defaultState or false

				local function updateToggle()
					if isToggled then
						-- Checked
						game:GetService("TweenService"):Create(Checkbox, TweenInfo.new(0.2), {
							BackgroundColor3 = Colors.Accent,
							BorderColor3 = Colors.Accent
						}):Play()
						game:GetService("TweenService"):Create(Checkmark, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							TextTransparency = 0
						}):Play()
					else
						-- Unchecked
						game:GetService("TweenService"):Create(Checkbox, TweenInfo.new(0.2), {
							BackgroundColor3 = Colors.Secondary,
							BorderColor3 = Colors.Border
						}):Play()
						game:GetService("TweenService"):Create(Checkmark, TweenInfo.new(0.15), {
							TextTransparency = 1
						}):Play()
					end
				end

				-- Hover effects
				ToggleButton.MouseEnter:Connect(function()
					if not isToggled then
						game:GetService("TweenService"):Create(Checkbox, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Hover
						}):Play()
					end
				end)

				ToggleButton.MouseLeave:Connect(function()
					if not isToggled then
						game:GetService("TweenService"):Create(Checkbox, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Secondary
						}):Play()
					end
				end)

				ToggleButton.MouseButton1Click:Connect(function()
					isToggled = not isToggled

					-- Click animation
					game:GetService("TweenService"):Create(Checkbox, TweenInfo.new(0.1), {
						Size = UDim2.new(0, 14, 0, 14)
					}):Play()
					game:GetService("TweenService"):Create(Checkbox, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
						Size = UDim2.new(0, 16, 0, 16)
					}):Play()

					updateToggle()

					if callback then
						pcall(callback, isToggled)
					end
				end)

				updateToggle()

				return {
					Set = function(state)
						isToggled = state
						updateToggle()
					end,
					Get = function()
						return isToggled
					end
				}
			end

			function sectionFunctions:CreateSlider(sliderText, minValue, maxValue, defaultValue, callback)
				local SliderFrame = Instance.new("Frame")
				local SliderContainer = Instance.new("Frame")
				local SliderHeader = Instance.new("Frame")
				local SliderLabel = Instance.new("TextLabel")
				local ValueLabel = Instance.new("TextLabel")
				local SliderTrack = Instance.new("Frame")
				local SliderFill = Instance.new("Frame")
				local SliderKnob = Instance.new("TextButton")

				SliderFrame.Name = "SliderFrame"
				SliderFrame.Parent = SectionContent
				SliderFrame.BackgroundTransparency = 1
				SliderFrame.Size = UDim2.new(1, 0, 0, 32)

				SliderContainer.Name = "SliderContainer"
				SliderContainer.Parent = SliderFrame
				SliderContainer.BackgroundTransparency = 1
				SliderContainer.Size = UDim2.new(1, 0, 1, 0)

				-- Header - more compact
				SliderHeader.Name = "SliderHeader"
				SliderHeader.Parent = SliderContainer
				SliderHeader.BackgroundTransparency = 1
				SliderHeader.Size = UDim2.new(1, 0, 0, 16)

				SliderLabel.Name = "SliderLabel"
				SliderLabel.Parent = SliderHeader
				SliderLabel.BackgroundTransparency = 1
				SliderLabel.Position = UDim2.new(0, 0, 0, 0)
				SliderLabel.Size = UDim2.new(0.65, 0, 1, 0)
				SliderLabel.Font = Enum.Font.GothamMedium
				SliderLabel.Text = sliderText
				SliderLabel.TextColor3 = Colors.Text
				SliderLabel.TextSize = 11
				SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
				SliderLabel.TextYAlignment = Enum.TextYAlignment.Center

				ValueLabel.Name = "ValueLabel"
				ValueLabel.Parent = SliderHeader
				ValueLabel.BackgroundTransparency = 1
				ValueLabel.Position = UDim2.new(0.65, 0, 0, 0)
				ValueLabel.Size = UDim2.new(0.35, -18, 1, 0)
				ValueLabel.Font = Enum.Font.GothamBold
				ValueLabel.Text = tostring(defaultValue or minValue)
				ValueLabel.TextColor3 = Colors.Accent
				ValueLabel.TextSize = 11
				ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
				ValueLabel.TextYAlignment = Enum.TextYAlignment.Center

				-- Modern track with horizontal padding
				SliderTrack.Name = "SliderTrack"
				SliderTrack.Parent = SliderContainer
				SliderTrack.BackgroundColor3 = Colors.Secondary
				SliderTrack.BorderSizePixel = 0
				SliderTrack.Position = UDim2.new(0, 8, 0, 18) -- Added left padding
				SliderTrack.Size = UDim2.new(1, -18, 0, 3) -- Added right padding (16px total padding)

				local TrackCorner = Instance.new("UICorner")
				TrackCorner.Parent = SliderTrack
				TrackCorner.CornerRadius = UDim.new(1, 0)

				-- Fill
				SliderFill.Name = "SliderFill"
				SliderFill.Parent = SliderTrack
				SliderFill.BackgroundColor3 = Colors.Accent
				SliderFill.BorderSizePixel = 0
				SliderFill.Size = UDim2.new(0, 0, 1, 0)

				local FillCorner = Instance.new("UICorner")
				FillCorner.Parent = SliderFill
				FillCorner.CornerRadius = UDim.new(1, 0)

				-- Compact knob with proper edge handling
				SliderKnob.Name = "SliderKnob"
				SliderKnob.Parent = SliderTrack
				SliderKnob.BackgroundColor3 = Colors.Text
				SliderKnob.BorderSizePixel = 0
				SliderKnob.Position = UDim2.new(0, -5, 0, -4)
				SliderKnob.Size = UDim2.new(0, 10, 0, 10)
				SliderKnob.AutoButtonColor = false
				SliderKnob.Text = ""
				SliderKnob.ZIndex = 2

				local KnobCorner = Instance.new("UICorner")
				KnobCorner.Parent = SliderKnob
				KnobCorner.CornerRadius = UDim.new(1, 0)

				-- Smaller inner dot
				local KnobDot = Instance.new("Frame")
				KnobDot.Name = "KnobDot"
				KnobDot.Parent = SliderKnob
				KnobDot.BackgroundColor3 = Colors.Accent
				KnobDot.BorderSizePixel = 0
				KnobDot.Position = UDim2.new(0.3, 0, 0.3, 0)
				KnobDot.Size = UDim2.new(0.4, 0, 0.4, 0)

				local DotCorner = Instance.new("UICorner")
				DotCorner.Parent = KnobDot
				DotCorner.CornerRadius = UDim.new(1, 0)

				local currentValue = defaultValue or minValue
				local sliding = false

				local function updateSlider(value)
					currentValue = math.clamp(value, minValue, maxValue)
					local ratio = (currentValue - minValue) / (maxValue - minValue)

					ValueLabel.Text = tostring(math.floor(currentValue))

					-- Update fill with proper bounds
					game:GetService("TweenService"):Create(SliderFill, TweenInfo.new(0.1), {
						Size = UDim2.new(ratio, 0, 1, 0)
					}):Play()

					-- Update knob position with proper bounds (0 to 1 scale)
					game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.1), {
						Position = UDim2.new(ratio, -5, 0, -4)
					}):Play()

					if callback then
						pcall(callback, currentValue)
					end
				end

				-- Hover animations
				SliderKnob.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.2), {
						Size = UDim2.new(0, 12, 0, 12),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					}):Play()
				end)

				SliderKnob.MouseLeave:Connect(function()
					if not sliding then
						game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.2), {
							Size = UDim2.new(0, 10, 0, 10),
							BackgroundColor3 = Colors.Text
						}):Play()
					end
				end)

				-- Drag functionality
				SliderKnob.MouseButton1Down:Connect(function()
					sliding = true
					game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.1), {
						Size = UDim2.new(0, 8, 0, 8)
					}):Play()
				end)

				game:GetService("UserInputService").InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and sliding then
						sliding = false
						game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.2), {
							Size = UDim2.new(0, 10, 0, 10)
						}):Play()
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
						local mousePos = game:GetService("UserInputService"):GetMouseLocation()
						local trackAbsolutePos = SliderTrack.AbsolutePosition
						local trackAbsoluteSize = SliderTrack.AbsoluteSize

						-- Calculate position within the padded track
						local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
						relativeX = math.clamp(relativeX, 0, 1)

						local value = minValue + (relativeX * (maxValue - minValue))
						updateSlider(value)
					end
				end)

				-- Track click functionality
				SliderTrack.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local mousePos = input.Position
						local trackAbsolutePos = SliderTrack.AbsolutePosition
						local trackAbsoluteSize = SliderTrack.AbsoluteSize

						-- Calculate position within the padded track
						local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
						relativeX = math.clamp(relativeX, 0, 1)

						local value = minValue + (relativeX * (maxValue - minValue))
						updateSlider(value)
					end
				end)

				-- Initialize
				updateSlider(currentValue)

				return {
					Set = function(value)
						updateSlider(value)
					end,
					Get = function()
						return currentValue
					end,
					SetRange = function(newMin, newMax)
						minValue = newMin
						maxValue = newMax
						updateSlider(math.clamp(currentValue, newMin, newMax))
					end
				}
			end

			function sectionFunctions:CreateLabel(labelText, labelType, accentColor)
				-- Default to "Default" style if invalid type provided
				local validTypes = {"Default", "Info", "Success", "Warning", "Error", "Accent", "Muted"}
				labelType = table.find(validTypes, labelType) and labelType or "Default"

				local LabelContainer = Instance.new("Frame")
				local LabelBackground = Instance.new("Frame")
				local Label = Instance.new("TextLabel")
				local LabelIcon = Instance.new("TextLabel")
				local LabelDivider = Instance.new("Frame")

				LabelContainer.Name = "LabelContainer"
				LabelContainer.Parent = SectionContent
				LabelContainer.BackgroundTransparency = 1
				LabelContainer.Size = UDim2.new(1, 0, 0, 24)

				-- Define label styles with safe color fallbacks
				local labelStyles = {
					Default = {
						Background = Colors.Secondary or Color3.fromRGB(25, 25, 35),
						TextColor = Colors.Text or Color3.fromRGB(240, 240, 240),
						Icon = "•",
						ShowIcon = false,
						ShowDivider = false
					},
					Info = {
						Background = Color3.fromRGB(25, 35, 65),
						TextColor = Color3.fromRGB(100, 150, 255),
						Icon = "ℹ",
						ShowIcon = true,
						ShowDivider = true
					},
					Success = {
						Background = Color3.fromRGB(25, 65, 35),
						TextColor = Color3.fromRGB(100, 255, 150),
						Icon = "✓",
						ShowIcon = true,
						ShowDivider = true
					},
					Warning = {
						Background = Color3.fromRGB(65, 55, 25),
						TextColor = Color3.fromRGB(255, 200, 100),
						Icon = "⚠",
						ShowIcon = true,
						ShowDivider = true
					},
					Error = {
						Background = Color3.fromRGB(65, 25, 35),
						TextColor = Color3.fromRGB(255, 100, 150),
						Icon = "✕",
						ShowIcon = true,
						ShowDivider = true
					},
					Accent = {
						Background = Color3.fromRGB(35, 25, 65),
						TextColor = Colors.Accent or Color3.fromRGB(147, 51, 234), -- Safe fallback
						Icon = "★",
						ShowIcon = true,
						ShowDivider = false
					},
					Muted = {
						Background = Colors.Secondary or Color3.fromRGB(25, 25, 35),
						TextColor = Colors.TextMuted or Color3.fromRGB(150, 150, 150),
						Icon = "•",
						ShowIcon = false,
						ShowDivider = false
					}
				}

				local style = labelStyles[labelType]

				-- Use custom color if provided
				if accentColor then
					style.Background = accentColor
					style.TextColor = accentColor
				end

				-- Label background with rounded corners
				LabelBackground.Name = "LabelBackground"
				LabelBackground.Parent = LabelContainer
				LabelBackground.BackgroundColor3 = style.Background
				LabelBackground.BackgroundTransparency = 0.9
				LabelBackground.BorderSizePixel = 0
				LabelBackground.Size = UDim2.new(1, 0, 0, 20)
				LabelBackground.Position = UDim2.new(0, 0, 0, 2)

				local BackgroundCorner = Instance.new("UICorner")
				BackgroundCorner.Name = "BackgroundCorner"
				BackgroundCorner.Parent = LabelBackground
				BackgroundCorner.CornerRadius = UDim.new(0, 4)

				-- Icon (optional)
				if style.ShowIcon then
					LabelIcon.Name = "LabelIcon"
					LabelIcon.Parent = LabelContainer
					LabelIcon.BackgroundTransparency = 1
					LabelIcon.Position = UDim2.new(0, 8, 0, 0)
					LabelIcon.Size = UDim2.new(0, 16, 0, 20)
					LabelIcon.Font = Enum.Font.GothamMedium
					LabelIcon.Text = style.Icon
					LabelIcon.TextColor3 = style.TextColor
					LabelIcon.TextSize = 12
					LabelIcon.TextXAlignment = Enum.TextXAlignment.Left
				end

				-- Main label text
				Label.Name = "Label"
				Label.Parent = LabelContainer
				Label.BackgroundTransparency = 1
				Label.Position = UDim2.new(0, style.ShowIcon and 24 or 8, 0, 0)
				Label.Size = UDim2.new(1, style.ShowIcon and -24 or -8, 0, 20)
				Label.Font = Enum.Font.Gotham
				Label.Text = labelText
				Label.TextColor3 = style.TextColor
				Label.TextSize = 11
				Label.TextXAlignment = Enum.TextXAlignment.Left
				Label.TextYAlignment = Enum.TextYAlignment.Center

				-- Subtle divider (optional)
				if style.ShowDivider then
					LabelDivider.Name = "LabelDivider"
					LabelDivider.Parent = LabelContainer
					LabelDivider.BackgroundColor3 = style.TextColor
					LabelDivider.BackgroundTransparency = 0.7
					LabelDivider.BorderSizePixel = 0
					LabelDivider.Position = UDim2.new(0, 0, 1, -1)
					LabelDivider.Size = UDim2.new(1, 0, 0, 1)
				end

				-- Add hover effect for interactive feel
				local hoverConnection
				if labelType == "Accent" then
					hoverConnection = LabelContainer.MouseEnter:Connect(function()
						game:GetService("TweenService"):Create(LabelBackground, TweenInfo.new(0.2), {
							BackgroundTransparency = 0.8
						}):Play()
					end)

					LabelContainer.MouseLeave:Connect(function()
						game:GetService("TweenService"):Create(LabelBackground, TweenInfo.new(0.2), {
							BackgroundTransparency = 0.9
						}):Play()
					end)
				end

				local labelFunctions = {}

				function labelFunctions:SetText(newText)
					Label.Text = newText
				end

				function labelFunctions:SetColor(newColor)
					Label.TextColor3 = newColor
					if LabelIcon then
						LabelIcon.TextColor3 = newColor
					end
					if LabelDivider then
						LabelDivider.BackgroundColor3 = newColor
					end
				end

				function labelFunctions:SetType(newType)
					local newStyle = labelStyles[newType or "Default"]
					if newStyle then
						LabelBackground.BackgroundColor3 = newStyle.Background
						Label.TextColor3 = newStyle.TextColor
						if LabelIcon then
							LabelIcon.Text = newStyle.Icon
							LabelIcon.TextColor3 = newStyle.TextColor
							LabelIcon.Visible = newStyle.ShowIcon
						end
						if LabelDivider then
							LabelDivider.BackgroundColor3 = newStyle.TextColor
							LabelDivider.Visible = newStyle.ShowDivider
						end
					end
				end

				function labelFunctions:SetVisible(visible)
					LabelContainer.Visible = visible
				end

				function labelFunctions:Destroy()
					if hoverConnection then
						hoverConnection:Disconnect()
					end
					LabelContainer:Destroy()
				end

				return labelFunctions
			end

			function sectionFunctions:CreateTextBox(placeholderText, callback, defaultValue)
				local TextBoxContainer = Instance.new("Frame")
				local TextBoxFrame = Instance.new("Frame")
				local TextBox = Instance.new("TextBox")
				local TextBoxLine = Instance.new("Frame")

				TextBoxContainer.Name = "TextBoxContainer"
				TextBoxContainer.Parent = SectionContent
				TextBoxContainer.BackgroundTransparency = 1
				TextBoxContainer.Size = UDim2.new(1, 0, 0, 32)

				-- Clean frame
				TextBoxFrame.Name = "TextBoxFrame"
				TextBoxFrame.Parent = TextBoxContainer
				TextBoxFrame.BackgroundColor3 = Colors.Secondary
				TextBoxFrame.BorderSizePixel = 0
				TextBoxFrame.Position = UDim2.new(0, 0, 0, 6)
				TextBoxFrame.Size = UDim2.new(1, 0, 0, 20)

				local FrameCorner = Instance.new("UICorner")
				FrameCorner.Parent = TextBoxFrame
				FrameCorner.CornerRadius = UDim.new(0, 4)

				-- Animated accent line
				TextBoxLine.Name = "TextBoxLine"
				TextBoxLine.Parent = TextBoxFrame
				TextBoxLine.BackgroundColor3 = Colors.Accent
				TextBoxLine.BorderSizePixel = 0
				TextBoxLine.Position = UDim2.new(0, 0, 1, -1)
				TextBoxLine.Size = UDim2.new(0, 0, 0, 2)

				local LineCorner = Instance.new("UICorner")
				LineCorner.Parent = TextBoxLine
				LineCorner.CornerRadius = UDim.new(1, 0)

				-- TextBox
				TextBox.Name = "TextBox"
				TextBox.Parent = TextBoxFrame
				TextBox.BackgroundTransparency = 1
				TextBox.Position = UDim2.new(0, 8, 0, 0)
				TextBox.Size = UDim2.new(1, -16, 1, 0)
				TextBox.Font = Enum.Font.Gotham
				TextBox.PlaceholderText = placeholderText or "Enter text..."
				TextBox.PlaceholderColor3 = Colors.TextMuted
				TextBox.Text = defaultValue or ""
				TextBox.TextColor3 = Colors.Text
				TextBox.TextSize = 11
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				TextBox.TextYAlignment = Enum.TextYAlignment.Center

				-- Focus effects
				TextBox.Focused:Connect(function()
					game:GetService("TweenService"):Create(TextBoxFrame, TweenInfo.new(0.2), {
						BackgroundColor3 = Colors.Hover
					}):Play()

					game:GetService("TweenService"):Create(TextBoxLine, TweenInfo.new(0.3), {
						Size = UDim2.new(1, 0, 0, 2)
					}):Play()
				end)

				TextBox.FocusLost:Connect(function(enterPressed)
					game:GetService("TweenService"):Create(TextBoxFrame, TweenInfo.new(0.2), {
						BackgroundColor3 = Colors.Secondary
					}):Play()

					game:GetService("TweenService"):Create(TextBoxLine, TweenInfo.new(0.2), {
						Size = UDim2.new(0, 0, 0, 2)
					}):Play()

					if enterPressed and callback then
						pcall(callback, TextBox.Text)
					end
				end)

				local textBoxFunctions = {}

				function textBoxFunctions:SetText(newText)
					TextBox.Text = newText
				end

				function textBoxFunctions:GetText()
					return TextBox.Text
				end

				function textBoxFunctions:SetPlaceholder(text)
					TextBox.PlaceholderText = text
				end

				function textBoxFunctions:Focus()
					TextBox:CaptureFocus()
				end

				function textBoxFunctions:Clear()
					TextBox.Text = ""
				end

				return textBoxFunctions
			end

			function sectionFunctions:CreateDropdown(dropdownText, options, callback, defaultValue)
				local DropdownContainer = Instance.new("Frame")
				local DropdownMain = Instance.new("Frame")
				local DropdownButton = Instance.new("TextButton")
				local DropdownBackground = Instance.new("Frame")
				local DropdownLabel = Instance.new("TextLabel")
				local DropdownIcon = Instance.new("TextLabel")
				local DropdownArrow = Instance.new("TextLabel")
				local DropdownList = Instance.new("Frame")
				local DropdownScroll = Instance.new("ScrollingFrame")
				local DropdownListLayout = Instance.new("UIListLayout")
				local DropdownBorder = Instance.new("Frame")

				DropdownContainer.Name = "DropdownContainer"
				DropdownContainer.Parent = SectionContent
				DropdownContainer.BackgroundTransparency = 1
				DropdownContainer.Size = UDim2.new(1, 0, 0, 32)
				DropdownContainer.ClipsDescendants = true

				-- Main dropdown frame
				DropdownMain.Name = "DropdownMain"
				DropdownMain.Parent = DropdownContainer
				DropdownMain.BackgroundTransparency = 1
				DropdownMain.Size = UDim2.new(1, 0, 0, 32)

				-- Background with rounded corners
				DropdownBackground.Name = "DropdownBackground"
				DropdownBackground.Parent = DropdownMain
				DropdownBackground.BackgroundColor3 = Colors.Secondary
				DropdownBackground.BorderSizePixel = 0
				DropdownBackground.Size = UDim2.new(1, 0, 0, 28)
				DropdownBackground.Position = UDim2.new(0, 0, 0, 2)

				local BackgroundCorner = Instance.new("UICorner")
				BackgroundCorner.Name = "BackgroundCorner"
				BackgroundCorner.Parent = DropdownBackground
				BackgroundCorner.CornerRadius = UDim.new(0, 6)

				-- Animated border
				DropdownBorder.Name = "DropdownBorder"
				DropdownBorder.Parent = DropdownBackground
				DropdownBorder.BackgroundColor3 = Colors.Accent
				DropdownBorder.BorderSizePixel = 0
				DropdownBorder.Size = UDim2.new(1, 0, 1, 0)
				DropdownBorder.Visible = false

				local BorderCorner = Instance.new("UICorner")
				BorderCorner.Parent = DropdownBorder
				BorderCorner.CornerRadius = UDim.new(0, 6)

				-- Inner frame to clip border
				local InnerFrame = Instance.new("Frame")
				InnerFrame.Name = "InnerFrame"
				InnerFrame.Parent = DropdownBackground
				InnerFrame.BackgroundColor3 = Colors.Secondary
				InnerFrame.BorderSizePixel = 0
				InnerFrame.Position = UDim2.new(0, 1, 0, 1)
				InnerFrame.Size = UDim2.new(1, -2, 1, -2)

				local InnerCorner = Instance.new("UICorner")
				InnerCorner.Parent = InnerFrame
				InnerCorner.CornerRadius = UDim.new(0, 5)

				-- Main button
				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = DropdownMain
				DropdownButton.BackgroundTransparency = 1
				DropdownButton.Size = UDim2.new(1, 0, 0, 28)
				DropdownButton.Position = UDim2.new(0, 0, 0, 2)
				DropdownButton.Text = ""
				DropdownButton.AutoButtonColor = false

				-- Icon
				DropdownIcon.Name = "DropdownIcon"
				DropdownIcon.Parent = DropdownButton
				DropdownIcon.BackgroundTransparency = 1
				DropdownIcon.Position = UDim2.new(0, 8, 0, 0)
				DropdownIcon.Size = UDim2.new(0, 16, 1, 0)
				DropdownIcon.Font = Enum.Font.GothamMedium
				DropdownIcon.Text = "▼"
				DropdownIcon.TextColor3 = Colors.TextMuted
				DropdownIcon.TextSize = 10
				DropdownIcon.TextXAlignment = Enum.TextXAlignment.Left

				-- Label
				DropdownLabel.Name = "DropdownLabel"
				DropdownLabel.Parent = DropdownButton
				DropdownLabel.BackgroundTransparency = 1
				DropdownLabel.Position = UDim2.new(0, 28, 0, 0)
				DropdownLabel.Size = UDim2.new(0.7, 0, 1, 0)
				DropdownLabel.Font = Enum.Font.GothamMedium
				DropdownLabel.Text = dropdownText
				DropdownLabel.TextColor3 = Colors.Text
				DropdownLabel.TextSize = 11
				DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
				DropdownLabel.TextYAlignment = Enum.TextYAlignment.Center

				-- Arrow
				DropdownArrow.Name = "DropdownArrow"
				DropdownArrow.Parent = DropdownButton
				DropdownArrow.BackgroundTransparency = 1
				DropdownArrow.Position = UDim2.new(0.9, 0, 0, 0)
				DropdownArrow.Size = UDim2.new(0.1, 0, 1, 0)
				DropdownArrow.Font = Enum.Font.GothamBold
				DropdownArrow.Text = "▾"
				DropdownArrow.TextColor3 = Colors.TextMuted
				DropdownArrow.TextSize = 12
				DropdownArrow.TextTransparency = 0.3

				-- Dropdown list container
				DropdownList.Name = "DropdownList"
				DropdownList.Parent = DropdownContainer
				DropdownList.BackgroundColor3 = Colors.Background
				DropdownList.BorderSizePixel = 0
				DropdownList.Position = UDim2.new(0, 0, 0, 32)
				DropdownList.Size = UDim2.new(1, 0, 0, 0)
				DropdownList.ClipsDescendants = true
				DropdownList.Visible = false

				local ListCorner = Instance.new("UICorner")
				ListCorner.Parent = DropdownList
				ListCorner.CornerRadius = UDim.new(0, 6)

				-- List border
				local ListBorder = Instance.new("Frame")
				ListBorder.Name = "ListBorder"
				ListBorder.Parent = DropdownList
				ListBorder.BackgroundColor3 = Colors.Border
				ListBorder.BorderSizePixel = 0
				ListBorder.Size = UDim2.new(1, 0, 1, 0)
				ListBorder.ZIndex = -1

				local ListBorderCorner = Instance.new("UICorner")
				ListBorderCorner.Parent = ListBorder
				ListBorderCorner.CornerRadius = UDim.new(0, 6)

				-- Scroll frame for options
				DropdownScroll.Name = "DropdownScroll"
				DropdownScroll.Parent = DropdownList
				DropdownScroll.BackgroundTransparency = 1
				DropdownScroll.BorderSizePixel = 0
				DropdownScroll.Position = UDim2.new(0, 2, 0, 2)
				DropdownScroll.Size = UDim2.new(1, -4, 1, -4)
				DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 3
				DropdownScroll.ScrollBarImageColor3 = Colors.Accent
				DropdownScroll.ScrollBarImageTransparency = 0.7

				DropdownListLayout.Name = "DropdownListLayout"
				DropdownListLayout.Parent = DropdownScroll
				DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DropdownListLayout.Padding = UDim.new(0, 2)

				local isOpen = false
				local selectedOption = defaultValue or options[1]

				-- Update selected display
				local function updateSelectedDisplay()
					if selectedOption then
						DropdownLabel.Text = selectedOption
						DropdownLabel.TextColor3 = Colors.Text
					else
						DropdownLabel.Text = dropdownText
						DropdownLabel.TextColor3 = Colors.TextMuted
					end
				end

				-- Calculate dropdown height
				local function getDropdownHeight()
					local optionCount = math.min(#options, 6) -- Max 6 options visible
					return optionCount * 24 + 4 -- 24px per option + padding
				end

				-- Toggle dropdown with smooth animation
				local function toggleDropdown()
					isOpen = not isOpen

					if isOpen then
						-- Open dropdown
						DropdownList.Visible = true
						local dropdownHeight = getDropdownHeight()

						-- Expand container to make room
						game:GetService("TweenService"):Create(DropdownContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 32 + dropdownHeight)
						}):Play()

						-- Animate list opening
						game:GetService("TweenService"):Create(DropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, dropdownHeight)
						}):Play()

						-- Button animations
						game:GetService("TweenService"):Create(DropdownBackground, TweenInfo.new(0.2), {
							BackgroundColor3 = Colors.Hover
						}):Play()
						game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {
							Rotation = 180,
							TextColor3 = Colors.Accent
						}):Play()
						game:GetService("TweenService"):Create(DropdownIcon, TweenInfo.new(0.2), {
							TextColor3 = Colors.Accent
						}):Play()

						-- Show border
						DropdownBorder.Visible = true
						DropdownBorder.BackgroundTransparency = 0.8
						game:GetService("TweenService"):Create(DropdownBorder, TweenInfo.new(0.3), {
							BackgroundTransparency = 0.3
						}):Play()

					else
						-- Close dropdown
						local dropdownHeight = getDropdownHeight()

						-- Button animations
						game:GetService("TweenService"):Create(DropdownBackground, TweenInfo.new(0.2), {
							BackgroundColor3 = Colors.Secondary
						}):Play()
						game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2), {
							Rotation = 0,
							TextColor3 = Colors.TextMuted
						}):Play()
						game:GetService("TweenService"):Create(DropdownIcon, TweenInfo.new(0.2), {
							TextColor3 = Colors.TextMuted
						}):Play()

						-- Hide border
						game:GetService("TweenService"):Create(DropdownBorder, TweenInfo.new(0.2), {
							BackgroundTransparency = 1
						}):Play()

						-- Animate list closing
						game:GetService("TweenService"):Create(DropdownList, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 0)
						}):Play()

						game:GetService("TweenService"):Create(DropdownContainer, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 32)
						}):Play()

						delay(0.25, function()
							if not isOpen then
								DropdownList.Visible = false
								DropdownBorder.Visible = false
							end
						end)
					end
				end

				-- Create dropdown options
				for index, option in pairs(options) do
					local OptionButton = Instance.new("TextButton")
					local OptionBackground = Instance.new("Frame")
					local OptionLabel = Instance.new("TextLabel")
					local OptionCheck = Instance.new("TextLabel")

					OptionButton.Name = option
					OptionButton.Parent = DropdownScroll
					OptionButton.BackgroundTransparency = 1
					OptionButton.Size = UDim2.new(1, 0, 0, 22)
					OptionButton.Text = ""
					OptionButton.AutoButtonColor = false

					-- Option background
					OptionBackground.Name = "OptionBackground"
					OptionBackground.Parent = OptionButton
					OptionBackground.BackgroundColor3 = Colors.Secondary
					OptionBackground.BorderSizePixel = 0
					OptionBackground.Size = UDim2.new(1, 0, 1, 0)

					local OptionCorner = Instance.new("UICorner")
					OptionCorner.Parent = OptionBackground
					OptionCorner.CornerRadius = UDim.new(0, 4)

					-- Option label
					OptionLabel.Name = "OptionLabel"
					OptionLabel.Parent = OptionButton
					OptionLabel.BackgroundTransparency = 1
					OptionLabel.Position = UDim2.new(0, 8, 0, 0)
					OptionLabel.Size = UDim2.new(1, -24, 1, 0)
					OptionLabel.Font = Enum.Font.Gotham
					OptionLabel.Text = option
					OptionLabel.TextColor3 = Colors.Text
					OptionLabel.TextSize = 11
					OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
					OptionLabel.TextYAlignment = Enum.TextYAlignment.Center

					-- Check mark for selected option
					OptionCheck.Name = "OptionCheck"
					OptionCheck.Parent = OptionButton
					OptionCheck.BackgroundTransparency = 1
					OptionCheck.Position = UDim2.new(1, -20, 0, 0)
					OptionCheck.Size = UDim2.new(0, 16, 1, 0)
					OptionCheck.Font = Enum.Font.GothamBold
					OptionCheck.Text = "✓"
					OptionCheck.TextColor3 = Colors.Accent
					OptionCheck.TextSize = 12
					OptionCheck.TextTransparency = option == selectedOption and 0 or 1
					OptionCheck.Visible = option == selectedOption

					-- Hover effects
					OptionButton.MouseEnter:Connect(function()
						game:GetService("TweenService"):Create(OptionBackground, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Hover
						}):Play()
					end)

					OptionButton.MouseLeave:Connect(function()
						game:GetService("TweenService"):Create(OptionBackground, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Secondary
						}):Play()
					end)

					-- Click functionality
					OptionButton.MouseButton1Click:Connect(function()
						selectedOption = option
						updateSelectedDisplay()

						-- Show check mark on selected option
						for _, child in pairs(DropdownScroll:GetChildren()) do
							if child:IsA("TextButton") and child:FindFirstChild("OptionCheck") then
								if child.Name == option then
									child.OptionCheck.Visible = true
									game:GetService("TweenService"):Create(child.OptionCheck, TweenInfo.new(0.2), {
										TextTransparency = 0
									}):Play()
								else
									game:GetService("TweenService"):Create(child.OptionCheck, TweenInfo.new(0.2), {
										TextTransparency = 1
									}):Play()
									delay(0.2, function()
										if child.Name ~= option then
											child.OptionCheck.Visible = false
										end
									end)
								end
							end
						end

						-- Close dropdown after selection
						toggleDropdown()

						if callback then
							pcall(callback, option)
						end
					end)
				end

				-- Update scroll size
				DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, DropdownListLayout.AbsoluteContentSize.Y)
				end)

				-- Button interactions
				DropdownButton.MouseEnter:Connect(function()
					if not isOpen then
						game:GetService("TweenService"):Create(DropdownBackground, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Hover
						}):Play()
					end
				end)

				DropdownButton.MouseLeave:Connect(function()
					if not isOpen then
						game:GetService("TweenService"):Create(DropdownBackground, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Secondary
						}):Play()
					end
				end)

				DropdownButton.MouseButton1Click:Connect(toggleDropdown)

				-- Close dropdown when clicking outside
				local closeConnection
				closeConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
					if isOpen and input.UserInputType == Enum.UserInputType.MouseButton1 then
						local mousePos = input.Position
						local absolutePos = DropdownContainer.AbsolutePosition
						local absoluteSize = DropdownContainer.AbsoluteSize

						if mousePos.X < absolutePos.X or mousePos.X > absolutePos.X + absoluteSize.X or
							mousePos.Y < absolutePos.Y or mousePos.Y > absolutePos.Y + absoluteSize.Y then
							toggleDropdown()
						end
					end
				end)

				-- Initialize
				updateSelectedDisplay()

				-- Dropdown functions
				local dropdownFunctions = {}

				function dropdownFunctions:SetSelected(option)
					if table.find(options, option) then
						selectedOption = option
						updateSelectedDisplay()

						-- Update check marks
						for _, child in pairs(DropdownScroll:GetChildren()) do
							if child:IsA("TextButton") and child:FindFirstChild("OptionCheck") then
								if child.Name == option then
									child.OptionCheck.Visible = true
									child.OptionCheck.TextTransparency = 0
								else
									child.OptionCheck.TextTransparency = 1
									child.OptionCheck.Visible = false
								end
							end
						end

						if callback then
							pcall(callback, option)
						end
					end
				end

				function dropdownFunctions:GetSelected()
					return selectedOption
				end

				function dropdownFunctions:SetOptions(newOptions)
					-- Clear existing options
					for _, child in pairs(DropdownScroll:GetChildren()) do
						if child:IsA("TextButton") then
							child:Destroy()
						end
					end

					options = newOptions
					if not table.find(newOptions, selectedOption) then
						selectedOption = newOptions[1]
					end
					updateSelectedDisplay()

					-- Recreate options
					for index, option in pairs(newOptions) do
						local OptionButton = Instance.new("TextButton")
						local OptionBackground = Instance.new("Frame")
						local OptionLabel = Instance.new("TextLabel")
						local OptionCheck = Instance.new("TextLabel")

						OptionButton.Name = option
						OptionButton.Parent = DropdownScroll
						OptionButton.BackgroundTransparency = 1
						OptionButton.Size = UDim2.new(1, 0, 0, 22)
						OptionButton.Text = ""
						OptionButton.AutoButtonColor = false

						OptionBackground.Name = "OptionBackground"
						OptionBackground.Parent = OptionButton
						OptionBackground.BackgroundColor3 = Colors.Secondary
						OptionBackground.BorderSizePixel = 0
						OptionBackground.Size = UDim2.new(1, 0, 1, 0)

						local OptionCorner = Instance.new("UICorner")
						OptionCorner.Parent = OptionBackground
						OptionCorner.CornerRadius = UDim.new(0, 4)

						OptionLabel.Name = "OptionLabel"
						OptionLabel.Parent = OptionButton
						OptionLabel.BackgroundTransparency = 1
						OptionLabel.Position = UDim2.new(0, 8, 0, 0)
						OptionLabel.Size = UDim2.new(1, -24, 1, 0)
						OptionLabel.Font = Enum.Font.Gotham
						OptionLabel.Text = option
						OptionLabel.TextColor3 = Colors.Text
						OptionLabel.TextSize = 11
						OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
						OptionLabel.TextYAlignment = Enum.TextYAlignment.Center

						OptionCheck.Name = "OptionCheck"
						OptionCheck.Parent = OptionButton
						OptionCheck.BackgroundTransparency = 1
						OptionCheck.Position = UDim2.new(1, -20, 0, 0)
						OptionCheck.Size = UDim2.new(0, 16, 1, 0)
						OptionCheck.Font = Enum.Font.GothamBold
						OptionCheck.Text = "✓"
						OptionCheck.TextColor3 = Colors.Accent
						OptionCheck.TextSize = 12
						OptionCheck.TextTransparency = option == selectedOption and 0 or 1
						OptionCheck.Visible = option == selectedOption

						OptionButton.MouseEnter:Connect(function()
							game:GetService("TweenService"):Create(OptionBackground, TweenInfo.new(0.15), {
								BackgroundColor3 = Colors.Hover
							}):Play()
						end)

						OptionButton.MouseLeave:Connect(function()
							game:GetService("TweenService"):Create(OptionBackground, TweenInfo.new(0.15), {
								BackgroundColor3 = Colors.Secondary
							}):Play()
						end)

						OptionButton.MouseButton1Click:Connect(function()
							selectedOption = option
							updateSelectedDisplay()

							for _, child in pairs(DropdownScroll:GetChildren()) do
								if child:IsA("TextButton") and child:FindFirstChild("OptionCheck") then
									if child.Name == option then
										child.OptionCheck.Visible = true
										game:GetService("TweenService"):Create(child.OptionCheck, TweenInfo.new(0.2), {
											TextTransparency = 0
										}):Play()
									else
										game:GetService("TweenService"):Create(child.OptionCheck, TweenInfo.new(0.2), {
											TextTransparency = 1
										}):Play()
										delay(0.2, function()
											if child.Name ~= option then
												child.OptionCheck.Visible = false
											end
										end)
									end
								end
							end

							toggleDropdown()

							if callback then
								pcall(callback, option)
							end
						end)
					end
				end

				function dropdownFunctions:Open()
					if not isOpen then
						toggleDropdown()
					end
				end

				function dropdownFunctions:Close()
					if isOpen then
						toggleDropdown()
					end
				end

				function dropdownFunctions:Destroy()
					if closeConnection then
						closeConnection:Disconnect()
					end
					DropdownContainer:Destroy()
				end

				return dropdownFunctions
			end
			
			function sectionFunctions:CreateColorPicker(pickerText, defaultColor, callback)
				local ColorPickerContainer = Instance.new("Frame")
				local ColorPickerButton = Instance.new("TextButton")
				local ColorPickerLabel = Instance.new("TextLabel")
				local ColorPickerPreview = Instance.new("Frame")

				ColorPickerContainer.Name = "ColorPickerContainer"
				ColorPickerContainer.Parent = SectionContent
				ColorPickerContainer.BackgroundTransparency = 1
				ColorPickerContainer.Size = UDim2.new(1, 0, 0, 32)

				-- Main button
				ColorPickerButton.Name = "ColorPickerButton"
				ColorPickerButton.Parent = ColorPickerContainer
				ColorPickerButton.BackgroundColor3 = Colors.Secondary
				ColorPickerButton.BorderSizePixel = 0
				ColorPickerButton.Size = UDim2.new(1, 0, 0, 28)
				ColorPickerButton.Position = UDim2.new(0, 0, 0, 2)
				ColorPickerButton.Text = ""
				ColorPickerButton.AutoButtonColor = false

				local ButtonCorner = Instance.new("UICorner")
				ButtonCorner.Parent = ColorPickerButton
				ButtonCorner.CornerRadius = UDim.new(0, 6)

				-- Label
				ColorPickerLabel.Name = "ColorPickerLabel"
				ColorPickerLabel.Parent = ColorPickerButton
				ColorPickerLabel.BackgroundTransparency = 1
				ColorPickerLabel.Position = UDim2.new(0, 12, 0, 0)
				ColorPickerLabel.Size = UDim2.new(0.7, 0, 1, 0)
				ColorPickerLabel.Font = Enum.Font.GothamMedium
				ColorPickerLabel.Text = pickerText
				ColorPickerLabel.TextColor3 = Colors.Text
				ColorPickerLabel.TextSize = 11
				ColorPickerLabel.TextXAlignment = Enum.TextXAlignment.Left
				ColorPickerLabel.TextYAlignment = Enum.TextYAlignment.Center

				-- Color preview
				ColorPickerPreview.Name = "ColorPickerPreview"
				ColorPickerPreview.Parent = ColorPickerButton
				ColorPickerPreview.BackgroundColor3 = defaultColor or Colors.Accent
				ColorPickerPreview.BorderSizePixel = 0
				ColorPickerPreview.Position = UDim2.new(0.85, 0, 0.18, 0)
				ColorPickerPreview.Size = UDim2.new(0, 20, 0, 20)

				local PreviewCorner = Instance.new("UICorner")
				PreviewCorner.Parent = ColorPickerPreview
				PreviewCorner.CornerRadius = UDim.new(0, 4)

				-- Preview border
				local PreviewBorder = Instance.new("Frame")
				PreviewBorder.Name = "PreviewBorder"
				PreviewBorder.Parent = ColorPickerPreview
				PreviewBorder.BackgroundColor3 = Colors.Border
				PreviewBorder.BorderSizePixel = 0
				PreviewBorder.Position = UDim2.new(-0.1, 0, -0.1, 0)
				PreviewBorder.Size = UDim2.new(1.2, 0, 1.2, 0)
				PreviewBorder.ZIndex = -1

				local PreviewBorderCorner = Instance.new("UICorner")
				PreviewBorderCorner.Parent = PreviewBorder
				PreviewBorderCorner.CornerRadius = UDim.new(0, 5)

				-- Popup ScreenGui
				local ColorPickerScreenGui = Instance.new("ScreenGui")
				ColorPickerScreenGui.Name = "ColorPickerPopup"
				ColorPickerScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
				ColorPickerScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
				ColorPickerScreenGui.ResetOnSpawn = false
				ColorPickerScreenGui.Enabled = false

				-- Overlay
				local Overlay = Instance.new("TextButton")
				Overlay.Name = "Overlay"
				Overlay.Parent = ColorPickerScreenGui
				Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Overlay.BackgroundTransparency = 0.6
				Overlay.BorderSizePixel = 0
				Overlay.Size = UDim2.new(1, 0, 1, 0)
				Overlay.Text = ""
				Overlay.ZIndex = 98

				-- Main popup
				local ColorPickerPopup = Instance.new("Frame")
				ColorPickerPopup.Name = "ColorPickerPopup"
				ColorPickerPopup.Parent = ColorPickerScreenGui
				ColorPickerPopup.BackgroundColor3 = Colors.Background
				ColorPickerPopup.BorderColor3 = Colors.Border
				ColorPickerPopup.BorderSizePixel = 1
				ColorPickerPopup.Position = UDim2.new(0.5, -140, 0.5, -100)
				ColorPickerPopup.Size = UDim2.new(0, 280, 0, 200)
				ColorPickerPopup.ZIndex = 99
				ColorPickerPopup.ClipsDescendants = true

				local PopupCorner = Instance.new("UICorner")
				PopupCorner.Parent = ColorPickerPopup
				PopupCorner.CornerRadius = UDim.new(0, 8)

				-- Header
				local PopupHeader = Instance.new("Frame")
				PopupHeader.Name = "PopupHeader"
				PopupHeader.Parent = ColorPickerPopup
				PopupHeader.BackgroundColor3 = Colors.Secondary
				PopupHeader.BorderSizePixel = 0
				PopupHeader.Size = UDim2.new(1, 0, 0, 32)
				PopupHeader.ZIndex = 100

				local HeaderLabel = Instance.new("TextLabel")
				HeaderLabel.Name = "HeaderLabel"
				HeaderLabel.Parent = PopupHeader
				HeaderLabel.BackgroundTransparency = 1
				HeaderLabel.Position = UDim2.new(0, 12, 0, 0)
				HeaderLabel.Size = UDim2.new(1, -24, 1, 0)
				HeaderLabel.Font = Enum.Font.GothamBold
				HeaderLabel.Text = "SELECT COLOR"
				HeaderLabel.TextColor3 = Colors.Text
				HeaderLabel.TextSize = 12
				HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
				HeaderLabel.ZIndex = 101

				-- Close button
				local CloseButton = Instance.new("TextButton")
				CloseButton.Name = "CloseButton"
				CloseButton.Parent = PopupHeader
				CloseButton.BackgroundTransparency = 1
				CloseButton.Position = UDim2.new(1, -28, 0, 0)
				CloseButton.Size = UDim2.new(0, 28, 1, 0)
				CloseButton.Font = Enum.Font.GothamBold
				CloseButton.Text = "×"
				CloseButton.TextColor3 = Colors.TextMuted
				CloseButton.TextSize = 16
				CloseButton.TextTransparency = 0.5
				CloseButton.ZIndex = 101
				CloseButton.AutoButtonColor = false

				-- Content
				local PopupContent = Instance.new("Frame")
				PopupContent.Name = "PopupContent"
				PopupContent.Parent = ColorPickerPopup
				PopupContent.BackgroundTransparency = 1
				PopupContent.Position = UDim2.new(0, 10, 0, 42)
				PopupContent.Size = UDim2.new(1, -20, 1, -52)
				PopupContent.ZIndex = 100

				-- Color spectrum (minimalist)
				local SpectrumContainer = Instance.new("Frame")
				SpectrumContainer.Name = "SpectrumContainer"
				SpectrumContainer.Parent = PopupContent
				SpectrumContainer.BackgroundColor3 = Colors.Secondary
				SpectrumContainer.BorderSizePixel = 0
				SpectrumContainer.Size = UDim2.new(1, 0, 0, 120)
				SpectrumContainer.ZIndex = 101

				local SpectrumCorner = Instance.new("UICorner")
				SpectrumCorner.Parent = SpectrumContainer
				SpectrumCorner.CornerRadius = UDim.new(0, 6)

				-- Spectrum image (simple gradient)
				local SpectrumImage = Instance.new("ImageLabel")
				SpectrumImage.Name = "SpectrumImage"
				SpectrumImage.Parent = SpectrumContainer
				SpectrumImage.BackgroundTransparency = 1
				SpectrumImage.BorderSizePixel = 0
				SpectrumImage.Position = UDim2.new(0, 4, 0, 4)
				SpectrumImage.Size = UDim2.new(1, -8, 1, -8)
				SpectrumImage.Image = "rbxassetid://10709791876" -- Color spectrum
				SpectrumImage.ZIndex = 102

				local ImageCorner = Instance.new("UICorner")
				ImageCorner.Parent = SpectrumImage
				ImageCorner.CornerRadius = UDim.new(0, 4)

				-- Spectrum selector
				local SpectrumSelector = Instance.new("Frame")
				SpectrumSelector.Name = "SpectrumSelector"
				SpectrumSelector.Parent = SpectrumImage
				SpectrumSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SpectrumSelector.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SpectrumSelector.BorderSizePixel = 2
				SpectrumSelector.Size = UDim2.new(0, 12, 0, 12)
				SpectrumSelector.Position = UDim2.new(0.5, -6, 0.5, -6)
				SpectrumSelector.ZIndex = 103

				local SelectorCorner = Instance.new("UICorner")
				SelectorCorner.Parent = SpectrumSelector
				SelectorCorner.CornerRadius = UDim.new(1, 0)

				-- Current color display
				local CurrentColorContainer = Instance.new("Frame")
				CurrentColorContainer.Name = "CurrentColorContainer"
				CurrentColorContainer.Parent = PopupContent
				CurrentColorContainer.BackgroundTransparency = 1
				CurrentColorContainer.Position = UDim2.new(0, 0, 0, 130)
				CurrentColorContainer.Size = UDim2.new(1, 0, 0, 28)
				CurrentColorContainer.ZIndex = 101

				local CurrentColorPreview = Instance.new("Frame")
				CurrentColorPreview.Name = "CurrentColorPreview"
				CurrentColorPreview.Parent = CurrentColorContainer
				CurrentColorPreview.BackgroundColor3 = defaultColor or Colors.Accent
				CurrentColorPreview.BorderSizePixel = 0
				CurrentColorPreview.Position = UDim2.new(0, 0, 0, 4)
				CurrentColorPreview.Size = UDim2.new(0, 40, 0, 20)
				CurrentColorPreview.ZIndex = 102

				local CurrentColorCorner = Instance.new("UICorner")
				CurrentColorCorner.Parent = CurrentColorPreview
				CurrentColorCorner.CornerRadius = UDim.new(0, 4)

				local CurrentColorLabel = Instance.new("TextLabel")
				CurrentColorLabel.Name = "CurrentColorLabel"
				CurrentColorLabel.Parent = CurrentColorContainer
				CurrentColorLabel.BackgroundTransparency = 1
				CurrentColorLabel.Position = UDim2.new(0, 50, 0, 0)
				CurrentColorLabel.Size = UDim2.new(1, -50, 1, 0)
				CurrentColorLabel.Font = Enum.Font.Gotham
				CurrentColorLabel.Text = "#FFFFFF"
				CurrentColorLabel.TextColor3 = Colors.TextMuted
				CurrentColorLabel.TextSize = 11
				CurrentColorLabel.TextXAlignment = Enum.TextXAlignment.Left
				CurrentColorLabel.TextYAlignment = Enum.TextYAlignment.Center
				CurrentColorLabel.ZIndex = 102

				-- State
				local isOpen = false
				local currentColor = defaultColor or Color3.fromRGB(255, 255, 255)
				local dragging = false

				-- Color functions
				local function RGBToHex(color)
					return string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
				end

				local function updateColorDisplay(color)
					currentColor = color
					ColorPickerPreview.BackgroundColor3 = color
					CurrentColorPreview.BackgroundColor3 = color
					CurrentColorLabel.Text = RGBToHex(color)
				end

				-- Toggle popup
				local function togglePopup()
					isOpen = not isOpen
					ColorPickerScreenGui.Enabled = isOpen

					if isOpen then
						-- Animate in
						ColorPickerPopup.Size = UDim2.new(0, 0, 0, 0)
						ColorPickerPopup.Position = UDim2.new(0.5, 0, 0.5, 0)

						game:GetService("TweenService"):Create(ColorPickerPopup, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							Size = UDim2.new(0, 280, 0, 200),
							Position = UDim2.new(0.5, -140, 0.5, -100)
						}):Play()

						-- Button hover effect
						ColorPickerButton.BackgroundColor3 = Colors.Hover

					else
						-- Animate out
						game:GetService("TweenService"):Create(ColorPickerPopup, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
							Size = UDim2.new(0, 0, 0, 0),
							Position = UDim2.new(0.5, 0, 0.5, 0)
						}):Play()

						-- Reset button
						ColorPickerButton.BackgroundColor3 = Colors.Secondary
					end
				end
				
				local function updateColorFromMouse(mousePos)
					if not dragging then return end

					local absolutePos = SpectrumImage.AbsolutePosition
					local absoluteSize = SpectrumImage.AbsoluteSize

					local relativeX = (mousePos.X - absolutePos.X) / absoluteSize.X
					local relativeY = (mousePos.Y - absolutePos.Y) / absoluteSize.Y

					relativeX = math.clamp(relativeX, 0, 1)
					relativeY = math.clamp(relativeY, 0, 1)

					SpectrumSelector.Position = UDim2.new(relativeX, -6, relativeY, -6)

					-- Convert position to HSV
					local hue = relativeX
					local saturation = 1 - relativeY
					local value = 1 -- Full brightness for spectrum

					local newColor = Color3.fromHSV(hue, saturation, value)
					updateColorDisplay(newColor)
				end

				-- Spectrum interaction
				SpectrumImage.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						updateColorFromMouse(input.Position)
					end
				end)

				-- Mouse handling
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
						updateColorFromMouse(input.Position)
					end
				end)

				game:GetService("UserInputService").InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)

				-- Button interactions
				ColorPickerButton.MouseEnter:Connect(function()
					if not isOpen then
						ColorPickerButton.BackgroundColor3 = Colors.Hover
					end
				end)

				ColorPickerButton.MouseLeave:Connect(function()
					if not isOpen then
						ColorPickerButton.BackgroundColor3 = Colors.Secondary
					end
				end)

				ColorPickerButton.MouseButton1Click:Connect(togglePopup)
				Overlay.MouseButton1Click:Connect(togglePopup)
				CloseButton.MouseButton1Click:Connect(togglePopup)

				-- Close button hover
				CloseButton.MouseEnter:Connect(function()
					CloseButton.TextTransparency = 0
				end)

				CloseButton.MouseLeave:Connect(function()
					CloseButton.TextTransparency = 0.5
				end)

				-- Apply color when popup closes
				Overlay.MouseButton1Click:Connect(function()
					if callback then
						pcall(callback, currentColor)
					end
				end)

				CloseButton.MouseButton1Click:Connect(function()
					if callback then
						pcall(callback, currentColor)
					end
				end)

				-- Initialize
				updateColorDisplay(currentColor)

				-- Color picker functions
				local colorPickerFunctions = {}

				function colorPickerFunctions:SetColor(color)
					updateColorDisplay(color)
					if callback then
						pcall(callback, color)
					end
				end

				function colorPickerFunctions:GetColor()
					return currentColor
				end

				function colorPickerFunctions:SetCallback(newCallback)
					callback = newCallback
				end

				return colorPickerFunctions
			end
			
			-- DYNAaMIC CONTENT MANAGEMENT FUNCTIONS
			function sectionFunctions:Clear()
				-- Remove all elements from the section
				for _, child in pairs(SectionContent:GetChildren()) do
					if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
						child:Destroy()
					end
				end
			end

			function sectionFunctions:RemoveElement(elementName)
				-- Remove specific element by name
				local element = SectionContent:FindFirstChild(elementName)
				if element then
					element:Destroy()
					return true
				end
				return false
			end

			function sectionFunctions:GetElements()
				-- Get all elements in the section
				local elements = {}
				for _, child in pairs(SectionContent:GetChildren()) do
					if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
						table.insert(elements, {
							Name = child.Name,
							Element = child,
							Type = child.ClassName
						})
					end
				end
				return elements
			end

			function sectionFunctions:AddButton(buttonText, callback)
				-- Dynamically add a button
				local Button = Instance.new("TextButton")

				Button.Name = buttonText
				Button.Parent = SectionContent
				Button.BackgroundColor3 = Colors.Secondary
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(1, 0, 0, 26)
				Button.Font = Enum.Font.Gotham
				Button.Text = buttonText
				Button.TextColor3 = Colors.Text
				Button.TextSize = 11
				Button.AutoButtonColor = false

				-- Hover effects
				Button.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.15), {
						BackgroundColor3 = Colors.Hover
					}):Play()
				end)

				Button.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.15), {
						BackgroundColor3 = Colors.Secondary
					}):Play()
				end)

				Button.MouseButton1Click:Connect(function()
					-- Click feedback
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {
						BackgroundColor3 = Colors.Accent
					}):Play()
					task.wait(0.1)
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {
						BackgroundColor3 = Colors.Hover
					}):Play()

					if callback then
						pcall(callback)
					end
				end)

				return Button
			end

			function sectionFunctions:AddLabel(labelText, labelStyle)
				-- Dynamically add a label
				local LabelContainer = Instance.new("Frame")
				local Label = Instance.new("TextLabel")

				LabelContainer.Name = labelText
				LabelContainer.Parent = SectionContent
				LabelContainer.BackgroundTransparency = 1
				LabelContainer.Size = UDim2.new(1, 0, 0, 20)

				Label.Name = "Label"
				Label.Parent = LabelContainer
				Label.BackgroundTransparency = 1
				Label.Size = UDim2.new(1, 0, 1, 0)
				Label.Font = Enum.Font.Gotham
				Label.Text = labelText
				Label.TextColor3 = Colors.TextMuted
				Label.TextSize = 11
				Label.TextXAlignment = Enum.TextXAlignment.Left
				Label.TextYAlignment = Enum.TextYAlignment.Center

				-- Style options
				if labelStyle == "Accent" then
					Label.TextColor3 = Colors.Accent
					Label.Font = Enum.Font.GothamMedium
				elseif labelStyle == "Success" then
					Label.TextColor3 = Color3.fromRGB(100, 255, 150)
				elseif labelStyle == "Warning" then
					Label.TextColor3 = Color3.fromRGB(255, 200, 100)
				elseif labelStyle == "Error" then
					Label.TextColor3 = Color3.fromRGB(255, 100, 150)
				end

				return LabelContainer
			end

			function sectionFunctions:AddSeparator()
				-- Add a visual separator
				local Separator = Instance.new("Frame")
				Separator.Name = "Separator"
				Separator.Parent = SectionContent
				Separator.BackgroundColor3 = Colors.Border
				Separator.BorderSizePixel = 0
				Separator.Size = UDim2.new(1, 0, 0, 1)
				Separator.Position = UDim2.new(0, 0, 0, 2)

				return Separator
			end

			function sectionFunctions:AddSpacer(height)
				-- Add empty space
				height = height or 8
				local Spacer = Instance.new("Frame")
				Spacer.Name = "Spacer"
				Spacer.Parent = SectionContent
				Spacer.BackgroundTransparency = 1
				Spacer.Size = UDim2.new(1, 0, 0, height)

				return Spacer
			end

			function sectionFunctions:Update()
				-- Force update section size
				SectionContent.Size = UDim2.new(1, 0, 0, SectionLayout.AbsoluteContentSize.Y)
				Section.Size = UDim2.new(1, 0, 0, SectionLayout.AbsoluteContentSize.Y + 20)
			end
			
			
			
			
			return sectionFunctions
		end
		
		-- Inside your CreateTab function, add these to tabFunctions:
		function tabFunctions:ClearSections()
			-- Remove all sections from the tab
			for _, child in pairs(TabContent:GetChildren()) do
				if child:IsA("Frame") and child.Name:find("Content") then
					for _, section in pairs(child:GetChildren()) do
						if section:IsA("Frame") then
							section:Destroy()
						end
					end
				end
			end
		end

		function tabFunctions:GetSections()
			-- Get all sections in the tab
			local sections = {}
			for _, child in pairs(TabContent:GetChildren()) do
				if child:IsA("Frame") and child.Name:find("Content") then
					for _, section in pairs(child:GetChildren()) do
						if section:IsA("Frame") then
							table.insert(sections, section)
						end
					end
				end
			end
			return sections
		end
		
		return tabFunctions
	end
	
	
	return uiFunctions
end

function ReduxV2:CreatePopup()
	local popupService = {}

	-- Get player gui
	local player = game.Players.LocalPlayer
	local parent = player:WaitForChild("PlayerGui")

	-- Popup styles that match your UI theme
	local PopupStyles = {
		Default = {
			Accent = Colors.Accent,
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "⚡",
			Border = Colors.Border
		},
		Success = {
			Accent = Color3.fromRGB(34, 197, 94),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "✓",
			Border = Colors.Border
		},
		Warning = {
			Accent = Color3.fromRGB(245, 158, 11),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "⚠",
			Border = Colors.Border
		},
		Error = {
			Accent = Color3.fromRGB(239, 68, 68),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "✕",
			Border = Colors.Border
		},
		Question = {
			Accent = Color3.fromRGB(59, 130, 246),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "?",
			Border = Colors.Border
		}
	}

	-- Main popup creation function
	function popupService:Show(options)
		options = options or {}

		local style = PopupStyles[options.Style or "Default"]
		local title = options.Title or "Notification"
		local message = options.Message or ""
		local buttons = options.Buttons or {"OK"}
		local duration = options.Duration or 0
		local callback = options.Callback

		print("🎯 [POPUP] Creating popup:", title)

		-- Create popup ScreenGui
		local PopupScreenGui = Instance.new("ScreenGui")
		PopupScreenGui.Name = "ReduxV2Popup_" .. tostring(tick())
		PopupScreenGui.Parent = parent
		PopupScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
		PopupScreenGui.ResetOnSpawn = false

		-- Main popup frame (matches your UI design)
		local Popup = Instance.new("Frame")
		Popup.Name = "Popup"
		Popup.Parent = PopupScreenGui
		Popup.BackgroundColor3 = style.Background
		Popup.BorderColor3 = style.Border
		Popup.BorderSizePixel = 1
		Popup.Position = UDim2.new(0.5, -175, 0.5, -100)
		Popup.Size = UDim2.new(0, 350, 0, 0) -- Start at 0 height for animation
		Popup.ClipsDescendants = true
		Popup.ZIndex = 100

		local PopupCorner = Instance.new("UICorner")
		PopupCorner.Parent = Popup
		PopupCorner.CornerRadius = UDim.new(0, 8)

		-- Header (matches your top bar design)
		local Header = Instance.new("Frame")
		Header.Name = "Header"
		Header.Parent = Popup
		Header.BackgroundColor3 = style.Secondary
		Header.BorderSizePixel = 0
		Header.Size = UDim2.new(1, 0, 0, 32)
		Header.ZIndex = 101

		local HeaderCorner = Instance.new("UICorner")
		HeaderCorner.Parent = Header
		HeaderCorner.CornerRadius = UDim.new(0, 7)

		-- Accent bar at top (thin like your UI)
		local AccentBar = Instance.new("Frame")
		AccentBar.Name = "AccentBar"
		AccentBar.Parent = Header
		AccentBar.BackgroundColor3 = style.Accent
		AccentBar.BorderSizePixel = 0
		AccentBar.Size = UDim2.new(1, 0, 0, 2)
		AccentBar.ZIndex = 102

		-- Header content
		local HeaderContent = Instance.new("Frame")
		HeaderContent.Name = "HeaderContent"
		HeaderContent.Parent = Header
		HeaderContent.BackgroundTransparency = 1
		HeaderContent.Position = UDim2.new(0, 12, 0, 0)
		HeaderContent.Size = UDim2.new(1, -24, 1, 0)
		HeaderContent.ZIndex = 103

		local Icon = Instance.new("TextLabel")
		Icon.Name = "Icon"
		Icon.Parent = HeaderContent
		Icon.BackgroundTransparency = 1
		Icon.Position = UDim2.new(0, 0, 0, 0)
		Icon.Size = UDim2.new(0, 20, 1, 0)
		Icon.Font = Enum.Font.GothamBold
		Icon.Text = style.Icon
		Icon.TextColor3 = style.Accent
		Icon.TextSize = 14
		Icon.TextTransparency = 0
		Icon.ZIndex = 104

		local Title = Instance.new("TextLabel")
		Title.Name = "Title"
		Title.Parent = HeaderContent
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 25, 0, 0)
		Title.Size = UDim2.new(0.7, 0, 1, 0)
		Title.Font = Enum.Font.GothamMedium
		Title.Text = string.upper(title)
		Title.TextColor3 = Colors.Text
		Title.TextSize = 13
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.TextTransparency = 0
		Title.ZIndex = 104

		-- Close button (matches your UI close button)
		local CloseButton = Instance.new("TextButton")
		CloseButton.Name = "CloseButton"
		CloseButton.Parent = HeaderContent
		CloseButton.BackgroundTransparency = 1
		CloseButton.Position = UDim2.new(1, -28, 0, 0)
		CloseButton.Size = UDim2.new(0, 28, 1, 0)
		CloseButton.Font = Enum.Font.GothamMedium
		CloseButton.Text = "×"
		CloseButton.TextColor3 = Colors.TextMuted
		CloseButton.TextSize = 16
		CloseButton.TextTransparency = 0
		CloseButton.ZIndex = 104
		CloseButton.AutoButtonColor = false

		-- Content area with proper text wrapping
		local Content = Instance.new("Frame")
		Content.Name = "Content"
		Content.Parent = Popup
		Content.BackgroundTransparency = 1
		Content.Position = UDim2.new(0, 15, 0, 40)
		Content.Size = UDim2.new(1, -30, 0, 0)
		Content.ZIndex = 101

		-- Message container for proper text wrapping
		local MessageContainer = Instance.new("Frame")
		MessageContainer.Name = "MessageContainer"
		MessageContainer.Parent = Content
		MessageContainer.BackgroundTransparency = 1
		MessageContainer.Size = UDim2.new(1, 0, 0, 0)
		MessageContainer.ZIndex = 102

		local Message = Instance.new("TextLabel")
		Message.Name = "Message"
		Message.Parent = MessageContainer
		Message.BackgroundTransparency = 1
		Message.Size = UDim2.new(1, 0, 0, 0)
		Message.Font = Enum.Font.Gotham
		Message.Text = message
		Message.TextColor3 = Colors.Text
		Message.TextSize = 12
		Message.TextWrapped = true
		Message.TextYAlignment = Enum.TextYAlignment.Top
		Message.TextTransparency = 0
		Message.ZIndex = 103

		-- Buttons container
		local ButtonsContainer = Instance.new("Frame")
		ButtonsContainer.Name = "ButtonsContainer"
		ButtonsContainer.Parent = Popup
		ButtonsContainer.BackgroundTransparency = 1
		ButtonsContainer.Position = UDim2.new(0, 15, 1, -45)
		ButtonsContainer.Size = UDim2.new(1, -30, 0, 35)
		ButtonsContainer.ZIndex = 101

		local ButtonsLayout = Instance.new("UIListLayout")
		ButtonsLayout.Parent = ButtonsContainer
		ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
		ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		ButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ButtonsLayout.Padding = UDim.new(0, 8)

		-- Calculate dynamic sizes based on content with proper text wrapping
		local function calculateSizes()
			-- Force text bounds calculation
			Message.Size = UDim2.new(1, 0, 0, 0) -- Reset to calculate natural height

			-- Wait for text bounds to update
			wait(0.05)

			local messageHeight = math.min(Message.TextBounds.Y + 20, 300) -- Increased max height for long text
			local totalHeight = 85 + messageHeight + 45

			Content.Size = UDim2.new(1, -30, 0, messageHeight)
			MessageContainer.Size = UDim2.new(1, 0, 0, messageHeight)
			Message.Size = UDim2.new(1, 0, 0, messageHeight)

			return totalHeight
		end
		
		-- Close popup function
		local function closePopup(button)
			print("🎯 [POPUP] Closing popup")

			-- Animate out
			game:GetService("TweenService"):Create(Popup, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 350, 0, 0),
				Position = UDim2.new(0.5, -175, 0.5, 0)
			}):Play()

			-- Fade out content
			game:GetService("TweenService"):Create(Icon, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()
			game:GetService("TweenService"):Create(Title, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()
			game:GetService("TweenService"):Create(Message, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()

			-- Destroy after animation
			delay(0.3, function()
				if PopupScreenGui and PopupScreenGui.Parent then
					PopupScreenGui:Destroy()
				end
			end)

			if callback and button then
				pcall(callback, button)
			end
		end

		-- Button creation function
		local function createButtons()
			for i, buttonText in pairs(buttons) do
				local Button = Instance.new("TextButton")
				Button.Name = buttonText
				Button.Parent = ButtonsContainer
				Button.BackgroundColor3 = i == #buttons and style.Accent or style.Secondary
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(0, 80, 0, 28)
				Button.Font = Enum.Font.GothamMedium
				Button.Text = buttonText
				Button.TextColor3 = Colors.Text
				Button.TextSize = 11
				Button.AutoButtonColor = false
				Button.ZIndex = 102

				local ButtonCorner = Instance.new("UICorner")
				ButtonCorner.Parent = Button
				ButtonCorner.CornerRadius = UDim.new(0, 6)

				-- Button hover effects (matches your UI)
				Button.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.15), {
						BackgroundColor3 = i == #buttons and style.Accent or Colors.Hover
					}):Play()
				end)

				Button.MouseLeave:Connect(function()
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.15), {
						BackgroundColor3 = i == #buttons and style.Accent or style.Secondary
					}):Play()
				end)

				-- Button click
				Button.MouseButton1Click:Connect(function()
					print("🎯 [POPUP] Button clicked:", buttonText)
					-- Click feedback
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {
						BackgroundColor3 = Colors.Accent
					}):Play()
					task.wait(0.1)
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1), {
						BackgroundColor3 = i == #buttons and style.Accent or style.Secondary
					}):Play()

					if callback then
						pcall(callback, buttonText)
					end
					closePopup()
				end)
			end
		end

		-- Close button interactions
		CloseButton.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.15), {
				TextColor3 = Colors.Text
			}):Play()
		end)

		CloseButton.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.15), {
				TextColor3 = Colors.TextMuted
			}):Play()
		end)

		CloseButton.MouseButton1Click:Connect(function()
			closePopup("Close")
		end)

		-- Auto-close if duration is set
		if duration > 0 then
			delay(duration, function()
				if PopupScreenGui and PopupScreenGui.Parent then
					print("🎯 [POPUP] Auto-closing popup")
					closePopup("Auto")
				end
			end)
		end

		-- Calculate sizes and create buttons after a delay for proper text bounds
		delay(0.1, function()
			if PopupScreenGui and PopupScreenGui.Parent then
				local totalHeight = calculateSizes()
				createButtons()

				-- Animate in
				Popup.Size = UDim2.new(0, 0, 0, 0)
				Popup.Position = UDim2.new(0.5, 0, 0.5, 0)

				game:GetService("TweenService"):Create(Popup, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 350, 0, totalHeight),
					Position = UDim2.new(0.5, -175, 0.5, -totalHeight/2)
				}):Play()
			end
		end)

		print("✅ [POPUP] Popup created successfully")

		-- Return control functions
		local popupControl = {}

		function popupControl:Close(button)
			closePopup(button or "Programmatic")
		end

		function popupControl:Update(newOptions)
			if newOptions.Title then
				Title.Text = string.upper(newOptions.Title)
			end
			if newOptions.Message then
				Message.Text = newOptions.Message
				delay(0.05, function()
					calculateSizes()
				end)
			end
		end

		return popupControl
	end

	-- Quick popup methods
	function popupService:Alert(title, message, callback)
		return self:Show({
			Title = title,
			Message = message,
			Style = "Default",
			Buttons = {"OK"},
			Callback = callback
		})
	end

	function popupService:Confirm(title, message, callback)
		return self:Show({
			Title = title,
			Message = message,
			Style = "Question",
			Buttons = {"Cancel", "Confirm"},
			Callback = callback
		})
	end

	function popupService:Success(title, message, callback)
		return self:Show({
			Title = title,
			Message = message,
			Style = "Success",
			Buttons = {"OK"},
			Callback = callback
		})
	end

	function popupService:Error(title, message, callback)
		return self:Show({
			Title = title,
			Message = message,
			Style = "Error",
			Buttons = {"OK"},
			Callback = callback
		})
	end

	function popupService:Warning(title, message, callback)
		return self:Show({
			Title = title,
			Message = message,
			Style = "Warning",
			Buttons = {"OK"},
			Callback = callback
		})
	end

	return popupService
end

function ReduxV2:Notifications()
	local notificationService = {}

	-- Get player gui
	local player = game.Players.LocalPlayer
	local parent = player:WaitForChild("PlayerGui")

	-- Notification styles that match your UI theme
	local NotificationStyles = {
		Success = {
			Accent = Color3.fromRGB(34, 197, 94),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "✓",
			Border = Colors.Border
		},
		Error = {
			Accent = Color3.fromRGB(239, 68, 68),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "✕",
			Border = Colors.Border
		},
		Warning = {
			Accent = Color3.fromRGB(245, 158, 11),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "⚠",
			Border = Colors.Border
		},
		Info = {
			Accent = Color3.fromRGB(59, 130, 246),
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "ℹ",
			Border = Colors.Border
		},
		Premium = {
			Accent = Colors.Accent,
			Background = Colors.Background,
			Secondary = Colors.Secondary,
			Icon = "⚡",
			Border = Colors.Border
		}
	}

	-- Track active notifications for stacking
	local activeNotifications = {}
	local notificationOffset = 10 -- Starting offset from top
	local notificationSpacing = 8 -- Space between notifications
	local maxNotifications = 5 -- Maximum notifications visible at once

	-- Function to update all notification positions
	local function updateNotificationPositions()
		local currentOffset = notificationOffset

		-- Sort notifications by creation time (oldest first)
		table.sort(activeNotifications, function(a, b)
			return a.createdTime < b.createdTime
		end)

		-- Update positions for all active notifications
		for i, notificationData in ipairs(activeNotifications) do
			if notificationData.gui and notificationData.gui.Parent then
				local targetPosition = UDim2.new(1, -310, 0, currentOffset)

				-- Animate to new position
				game:GetService("TweenService"):Create(notificationData.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = targetPosition
				}):Play()

				-- Calculate next position
				if notificationData.frame and notificationData.frame.AbsoluteSize then
					currentOffset = currentOffset + notificationData.frame.AbsoluteSize.Y + notificationSpacing
				else
					currentOffset = currentOffset + 80 + notificationSpacing -- Fallback height
				end
			end
		end
	end

	-- Function to remove notification from tracking
	local function removeNotification(notificationId)
		for i, notificationData in ipairs(activeNotifications) do
			if notificationData.id == notificationId then
				table.remove(activeNotifications, i)
				break
			end
		end
		updateNotificationPositions()
	end

	-- Main notification function
	function notificationService:Notify(style, title, message, duration)
		duration = duration or 5
		local styleData = NotificationStyles[style] or NotificationStyles.Info

		print("🔔 [NOTIFICATION] Creating:", title, message)

		-- Create individual notification ScreenGui for each notification
		local NotificationGui = Instance.new("ScreenGui")
		local notificationId = "Notification_" .. tostring(tick())
		NotificationGui.Name = notificationId
		NotificationGui.Parent = parent
		NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
		NotificationGui.ResetOnSpawn = false

		-- Main notification frame
		local Notification = Instance.new("Frame")
		Notification.Name = "Notification"
		Notification.Parent = NotificationGui
		Notification.BackgroundColor3 = styleData.Background
		Notification.BorderColor3 = styleData.Border
		Notification.BorderSizePixel = 1
		Notification.Size = UDim2.new(0, 300, 0, 0) -- Start at 0 height for animation
		Notification.Position = UDim2.new(1, 10, 0, 0)
		Notification.ClipsDescendants = true
		Notification.ZIndex = 51

		local NotificationCorner = Instance.new("UICorner")
		NotificationCorner.Parent = Notification
		NotificationCorner.CornerRadius = UDim.new(0, 6)

		-- Thin accent border on left
		local AccentBorder = Instance.new("Frame")
		AccentBorder.Name = "AccentBorder"
		AccentBorder.Parent = Notification
		AccentBorder.BackgroundColor3 = styleData.Accent
		AccentBorder.BorderSizePixel = 0
		AccentBorder.Size = UDim2.new(0, 3, 1, 0)
		AccentBorder.ZIndex = 52

		local BorderCorner = Instance.new("UICorner")
		BorderCorner.Parent = AccentBorder
		BorderCorner.CornerRadius = UDim.new(0, 2)

		-- Content area
		local Content = Instance.new("Frame")
		Content.Name = "Content"
		Content.Parent = Notification
		Content.BackgroundTransparency = 1
		Content.Position = UDim2.new(0, 10, 0, 8)
		Content.Size = UDim2.new(1, -20, 1, -16)
		Content.ZIndex = 53

		-- Header row
		local Header = Instance.new("Frame")
		Header.Name = "Header"
		Header.Parent = Content
		Header.BackgroundTransparency = 1
		Header.Size = UDim2.new(1, 0, 0, 20)
		Header.ZIndex = 54

		local Icon = Instance.new("TextLabel")
		Icon.Name = "Icon"
		Icon.Parent = Header
		Icon.BackgroundTransparency = 1
		Icon.Position = UDim2.new(0, 0, 0, 0)
		Icon.Size = UDim2.new(0, 20, 1, 0)
		Icon.Font = Enum.Font.GothamBold
		Icon.Text = styleData.Icon
		Icon.TextColor3 = styleData.Accent
		Icon.TextSize = 12
		Icon.ZIndex = 55

		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Name = "Title"
		TitleLabel.Parent = Header
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0, 25, 0, 0)
		TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
		TitleLabel.Font = Enum.Font.GothamMedium
		TitleLabel.Text = string.upper(title)
		TitleLabel.TextColor3 = Colors.Text
		TitleLabel.TextSize = 11
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.ZIndex = 55

		-- Close button
		local CloseButton = Instance.new("TextButton")
		CloseButton.Name = "CloseButton"
		CloseButton.Parent = Header
		CloseButton.BackgroundTransparency = 1
		CloseButton.Position = UDim2.new(1, -20, 0, 2)
		CloseButton.Size = UDim2.new(0, 16, 0, 16)
		CloseButton.Font = Enum.Font.GothamMedium
		CloseButton.Text = "×"
		CloseButton.TextColor3 = Colors.TextMuted
		CloseButton.TextSize = 14
		CloseButton.ZIndex = 55
		CloseButton.AutoButtonColor = false

		-- Message content with proper text wrapping
		local MessageContainer = Instance.new("Frame")
		MessageContainer.Name = "MessageContainer"
		MessageContainer.Parent = Content
		MessageContainer.BackgroundTransparency = 1
		MessageContainer.Position = UDim2.new(0, 0, 0, 25)
		MessageContainer.Size = UDim2.new(1, 0, 0, 0)
		MessageContainer.ZIndex = 54

		local MessageLabel = Instance.new("TextLabel")
		MessageLabel.Name = "Message"
		MessageLabel.Parent = MessageContainer
		MessageLabel.BackgroundTransparency = 1
		MessageLabel.Size = UDim2.new(1, 0, 0, 0)
		MessageLabel.Font = Enum.Font.Gotham
		MessageLabel.Text = message
		MessageLabel.TextColor3 = Colors.TextMuted
		MessageLabel.TextSize = 11
		MessageLabel.TextWrapped = true
		MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
		MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
		MessageLabel.ZIndex = 54

		-- Progress bar
		local ProgressTrack = Instance.new("Frame")
		ProgressTrack.Name = "ProgressTrack"
		ProgressTrack.Parent = Notification
		ProgressTrack.BackgroundColor3 = styleData.Secondary
		ProgressTrack.BorderSizePixel = 0
		ProgressTrack.Position = UDim2.new(0, 3, 1, -2)
		ProgressTrack.Size = UDim2.new(1, -6, 0, 1)
		ProgressTrack.ZIndex = 52

		local ProgressFill = Instance.new("Frame")
		ProgressFill.Name = "ProgressFill"
		ProgressFill.Parent = ProgressTrack
		ProgressFill.BackgroundColor3 = styleData.Accent
		ProgressFill.BorderSizePixel = 0
		ProgressFill.Size = UDim2.new(1, 0, 1, 0)
		ProgressFill.ZIndex = 53

		-- Calculate dynamic height with proper text wrapping
		local function calculateHeight()
			-- Force text bounds calculation
			MessageLabel.Size = UDim2.new(1, 0, 0, 0) -- Reset to calculate natural height

			-- Wait for text bounds to update
			wait(0.05)

			local messageHeight = math.min(MessageLabel.TextBounds.Y + 4, 120) -- Increased max height for more text
			local totalHeight = 32 + messageHeight + 4

			Content.Size = UDim2.new(1, -20, 0, 24 + messageHeight)
			MessageContainer.Size = UDim2.new(1, 0, 0, messageHeight)
			MessageLabel.Size = UDim2.new(1, 0, 0, messageHeight)
			Notification.Size = UDim2.new(0, 300, 0, totalHeight)

			return totalHeight
		end

		-- Close notification function
		local function closeNotification()
			print("🔔 [NOTIFICATION] Closing:", title)

			-- Remove from tracking
			removeNotification(notificationId)

			-- Slide out animation
			game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
				Position = UDim2.new(1, 10, 0, -Notification.AbsoluteSize.Y)
			}):Play()

			-- Fade out content
			game:GetService("TweenService"):Create(Icon, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()
			game:GetService("TweenService"):Create(TitleLabel, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()
			game:GetService("TweenService"):Create(MessageLabel, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
				TextTransparency = 1
			}):Play()

			-- Destroy after animation
			delay(0.3, function()
				if NotificationGui and NotificationGui.Parent then
					NotificationGui:Destroy()
				end
			end)
		end

		-- Close button interactions
		CloseButton.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.15), {
				TextColor3 = Colors.Text
			}):Play()
		end)

		CloseButton.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.15), {
				TextColor3 = Colors.TextMuted
			}):Play()
		end)

		CloseButton.MouseButton1Click:Connect(function()
			closeNotification()
		end)

		-- Auto-close after duration
		if duration > 0 then
			-- Progress bar animation
			game:GetService("TweenService"):Create(ProgressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
				Size = UDim2.new(0, 0, 1, 0)
			}):Play()

			delay(duration, function()
				if NotificationGui and NotificationGui.Parent then
					closeNotification()
				end
			end)
		end

		-- Calculate final height after a small delay to ensure text bounds are calculated
		delay(0.1, function()
			if NotificationGui and NotificationGui.Parent then
				local totalHeight = calculateHeight()

				-- Add to active notifications tracking
				local notificationData = {
					id = notificationId,
					gui = NotificationGui,
					frame = Notification,
					createdTime = tick()
				}
				table.insert(activeNotifications, notificationData)

				-- Limit maximum notifications
				if #activeNotifications > maxNotifications then
					local oldestNotification = activeNotifications[1]
					if oldestNotification and oldestNotification.gui then
						oldestNotification.gui:Destroy()
						table.remove(activeNotifications, 1)
					end
				end

				-- Start position (off-screen right)
				Notification.Position = UDim2.new(1, 10, 0, -totalHeight)

				-- Slide in animation
				game:GetService("TweenService"):Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Position = UDim2.new(1, -310, 0, -totalHeight)
				}):Play()

				-- Update all notification positions after a brief delay
				delay(0.1, function()
					updateNotificationPositions()
				end)
			end
		end)

		print("✅ [NOTIFICATION] Created successfully:", title)

		-- Return notification control
		local notificationControl = {}

		function notificationControl:Close()
			closeNotification()
		end

		function notificationControl:Update(newMessage, newStyle, newDuration)
			if newStyle and NotificationStyles[newStyle] then
				local newStyleData = NotificationStyles[newStyle]
				styleData = newStyleData

				AccentBorder.BackgroundColor3 = newStyleData.Accent
				ProgressFill.BackgroundColor3 = newStyleData.Accent
				Icon.Text = newStyleData.Icon
				Icon.TextColor3 = newStyleData.Accent
				TitleLabel.Text = string.upper(title)
			end

			if newMessage then
				MessageLabel.Text = newMessage
				delay(0.05, function()
					calculateHeight()
					updateNotificationPositions()
				end)
			end

			if newDuration then
				-- Reset progress bar
				ProgressFill.Size = UDim2.new(1, 0, 1, 0)
				game:GetService("TweenService"):Create(ProgressFill, TweenInfo.new(newDuration, Enum.EasingStyle.Linear), {
					Size = UDim2.new(0, 0, 1, 0)
				}):Play()
			end
		end

		return notificationControl
	end

	-- Quick notification methods
	function notificationService:Success(message, duration)
		return self:Notify("Success", "Success", message, duration)
	end

	function notificationService:Error(message, duration)
		return self:Notify("Error", "Error", message, duration)
	end

	function notificationService:Warning(message, duration)
		return self:Notify("Warning", "Warning", message, duration)
	end

	function notificationService:Info(message, duration)
		return self:Notify("Info", "Information", message, duration)
	end

	function notificationService:Premium(message, duration)
		return self:Notify("Premium", "Premium", message, duration)
	end

	-- Clear all notifications
	function notificationService:ClearAll()
		print("🔔 [NOTIFICATION] Clearing all notifications")
		for _, notificationData in ipairs(activeNotifications) do
			if notificationData.gui and notificationData.gui.Parent then
				notificationData.gui:Destroy()
			end
		end
		activeNotifications = {}
	end

	-- Get notification count
	function notificationService:GetCount()
		return #activeNotifications
	end

	return notificationService
end

return ReduxV2