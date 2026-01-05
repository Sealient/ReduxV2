-- ReduxV2 UI Library - Ultra Sleek Edition
local ReduxV2 = {}

-- Refined Color Scheme
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
				SliderFrame.Size = UDim2.new(1, 0, 0, 40)

				SliderContainer.Name = "SliderContainer"
				SliderContainer.Parent = SliderFrame
				SliderContainer.BackgroundTransparency = 1
				SliderContainer.Size = UDim2.new(1, 0, 1, 0)

				-- Header
				SliderHeader.Name = "SliderHeader"
				SliderHeader.Parent = SliderContainer
				SliderHeader.BackgroundTransparency = 1
				SliderHeader.Size = UDim2.new(1, 0, 0, 18)

				SliderLabel.Name = "SliderLabel"
				SliderLabel.Parent = SliderHeader
				SliderLabel.BackgroundTransparency = 1
				SliderLabel.Position = UDim2.new(0, 0, 0, 0)
				SliderLabel.Size = UDim2.new(0.6, 0, 1, 0)
				SliderLabel.Font = Enum.Font.GothamMedium
				SliderLabel.Text = sliderText
				SliderLabel.TextColor3 = Colors.Text
				SliderLabel.TextSize = 11
				SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

				ValueLabel.Name = "ValueLabel"
				ValueLabel.Parent = SliderHeader
				ValueLabel.BackgroundTransparency = 1
				ValueLabel.Position = UDim2.new(0.6, 0, 0, 0)
				ValueLabel.Size = UDim2.new(0.4, 0, 1, 0)
				ValueLabel.Font = Enum.Font.GothamBold
				ValueLabel.Text = tostring(defaultValue or minValue)
				ValueLabel.TextColor3 = Colors.Accent
				ValueLabel.TextSize = 11
				ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

				-- Modern track with rounded ends
				SliderTrack.Name = "SliderTrack"
				SliderTrack.Parent = SliderContainer
				SliderTrack.BackgroundColor3 = Colors.Secondary
				SliderTrack.BorderSizePixel = 0
				SliderTrack.Position = UDim2.new(0, 0, 0, 22)
				SliderTrack.Size = UDim2.new(1, 0, 0, 4)

				local TrackCorner = Instance.new("UICorner")
				TrackCorner.Parent = SliderTrack
				TrackCorner.CornerRadius = UDim.new(1, 0)

				-- Fill with gradient effect
				SliderFill.Name = "SliderFill"
				SliderFill.Parent = SliderTrack
				SliderFill.BackgroundColor3 = Colors.Accent
				SliderFill.BorderSizePixel = 0
				SliderFill.Size = UDim2.new(0, 0, 1, 0)

				local FillCorner = Instance.new("UICorner")
				FillCorner.Parent = SliderFill
				FillCorner.CornerRadius = UDim.new(1, 0)

				-- Elegant knob
				SliderKnob.Name = "SliderKnob"
				SliderKnob.Parent = SliderTrack
				SliderKnob.BackgroundColor3 = Colors.Text
				SliderKnob.BorderSizePixel = 0
				SliderKnob.Position = UDim2.new(0, -6, 0, -5)
				SliderKnob.Size = UDim2.new(0, 12, 0, 12)
				SliderKnob.AutoButtonColor = false
				SliderKnob.Text = ""
				SliderKnob.ZIndex = 2

				local KnobCorner = Instance.new("UICorner")
				KnobCorner.Parent = SliderKnob
				KnobCorner.CornerRadius = UDim.new(1, 0)

				-- Knob inner dot for premium look
				local KnobDot = Instance.new("Frame")
				KnobDot.Name = "KnobDot"
				KnobDot.Parent = SliderKnob
				KnobDot.BackgroundColor3 = Colors.Accent
				KnobDot.BorderSizePixel = 0
				KnobDot.Position = UDim2.new(0.25, 0, 0.25, 0)
				KnobDot.Size = UDim2.new(0.5, 0, 0.5, 0)

				local DotCorner = Instance.new("UICorner")
				DotCorner.Parent = KnobDot
				DotCorner.CornerRadius = UDim.new(1, 0)

				local currentValue = defaultValue or minValue
				local sliding = false

				local function updateSlider(value)
					currentValue = math.clamp(value, minValue, maxValue)
					local ratio = (currentValue - minValue) / (maxValue - minValue)

					ValueLabel.Text = tostring(math.floor(currentValue))

					game:GetService("TweenService"):Create(SliderFill, TweenInfo.new(0.1), {
						Size = UDim2.new(ratio, 0, 1, 0)
					}):Play()

					game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.1), {
						Position = UDim2.new(ratio, -6, 0, -5)
					}):Play()

					if callback then
						pcall(callback, currentValue)
					end
				end

				-- Hover animations
				SliderKnob.MouseEnter:Connect(function()
					game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.2), {
						Size = UDim2.new(0, 14, 0, 14),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					}):Play()
				end)

				SliderKnob.MouseLeave:Connect(function()
					if not sliding then
						game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.2), {
							Size = UDim2.new(0, 12, 0, 12),
							BackgroundColor3 = Colors.Text
						}):Play()
					end
				end)

				-- Drag functionality
				SliderKnob.MouseButton1Down:Connect(function()
					sliding = true
					game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.1), {
						Size = UDim2.new(0, 10, 0, 10)
					}):Play()
				end)

				game:GetService("UserInputService").InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and sliding then
						sliding = false
						game:GetService("TweenService"):Create(SliderKnob, TweenInfo.new(0.2), {
							Size = UDim2.new(0, 12, 0, 12)
						}):Play()
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
						local mousePos = game:GetService("UserInputService"):GetMouseLocation()
						local trackAbsolutePos = SliderTrack.AbsolutePosition
						local trackAbsoluteSize = SliderTrack.AbsoluteSize

						local relativeX = (mousePos.X - trackAbsolutePos.X) / trackAbsoluteSize.X
						relativeX = math.clamp(relativeX, 0, 1)

						local value = minValue + (relativeX * (maxValue - minValue))
						updateSlider(value)
					end
				end)


				return {
					Set = function(value)
						updateSlider(value)
					end,
					Get = function()
						return currentValue
					end
				}
			end

			function sectionFunctions:CreateLabel(labelText, labelStyle)
				local LabelContainer = Instance.new("Frame")
				local Label = Instance.new("TextLabel")
				local LabelAccent = Instance.new("Frame")

				LabelContainer.Name = "LabelContainer"
				LabelContainer.Parent = SectionContent
				LabelContainer.BackgroundTransparency = 1
				LabelContainer.Size = UDim2.new(1, 0, 0, 20)

				-- Style options
				local styles = {
					Default = {Color = Colors.TextMuted, Accent = false},
					Primary = {Color = Colors.Text, Accent = false},
					Accent = {Color = Colors.Accent, Accent = true},
					Success = {Color = Color3.fromRGB(100, 255, 150), Accent = true},
					Warning = {Color = Color3.fromRGB(255, 200, 100), Accent = true},
					Error = {Color = Color3.fromRGB(255, 100, 150), Accent = true}
				}

				local style = styles[labelStyle or "Default"]

				-- Accent bar
				if style.Accent then
					LabelAccent.Name = "LabelAccent"
					LabelAccent.Parent = LabelContainer
					LabelAccent.BackgroundColor3 = style.Color
					LabelAccent.BorderSizePixel = 0
					LabelAccent.Position = UDim2.new(0, 0, 0, 2)
					LabelAccent.Size = UDim2.new(0, 2, 0, 16)

					local AccentCorner = Instance.new("UICorner")
					AccentCorner.Parent = LabelAccent
					AccentCorner.CornerRadius = UDim.new(1, 0)
				end

				-- Main label
				Label.Name = "Label"
				Label.Parent = LabelContainer
				Label.BackgroundTransparency = 1
				Label.Position = UDim2.new(0, style.Accent and 8 or 0, 0, 0)
				Label.Size = UDim2.new(1, style.Accent and -8 or 0, 1, 0)
				Label.Font = Enum.Font.GothamMedium
				Label.Text = labelText
				Label.TextColor3 = style.Color
				Label.TextSize = 11
				Label.TextXAlignment = Enum.TextXAlignment.Left
				Label.TextYAlignment = Enum.TextYAlignment.Center

				-- Add subtle animation on creation
				Label.TextTransparency = 0.5
				game:GetService("TweenService"):Create(Label, TweenInfo.new(0.3), {
					TextTransparency = 0
				}):Play()

				local labelFunctions = {}

				function labelFunctions:SetText(newText)
					Label.Text = newText
				end

				function labelFunctions:SetColor(newColor)
					Label.TextColor3 = newColor
					if LabelAccent then
						LabelAccent.BackgroundColor3 = newColor
					end
				end

				function labelFunctions:SetStyle(newStyle)
					local newStyleData = styles[newStyle or "Default"]
					if newStyleData then
						Label.TextColor3 = newStyleData.Color
						if LabelAccent then
							LabelAccent.Visible = newStyleData.Accent
						elseif newStyleData.Accent then
							-- Create accent if it doesn't exist but should
							LabelAccent = Instance.new("Frame")
							LabelAccent.Name = "LabelAccent"
							LabelAccent.Parent = LabelContainer
							LabelAccent.BackgroundColor3 = newStyleData.Color
							LabelAccent.BorderSizePixel = 0
							LabelAccent.Position = UDim2.new(0, 0, 0, 2)
							LabelAccent.Size = UDim2.new(0, 2, 0, 16)
							LabelAccent.ZIndex = -1

							local AccentCorner = Instance.new("UICorner")
							AccentCorner.Parent = LabelAccent
							AccentCorner.CornerRadius = UDim.new(1, 0)

							Label.Position = UDim2.new(0, 8, 0, 0)
							Label.Size = UDim2.new(1, -8, 1, 0)
						end
					end
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

			function sectionFunctions:CreateDropdown(dropdownText, options, callback, isMegaMenu)
				local DropdownContainer = Instance.new("Frame")
				local DropdownButton = Instance.new("TextButton")
				local DropdownLabel = Instance.new("TextLabel")
				local DropdownIcon = Instance.new("TextLabel")
				local DropdownArrow = Instance.new("TextLabel")
				local DropdownList = Instance.new("ScrollingFrame")
				local DropdownListLayout = Instance.new("UIListLayout")
				local DropdownBackground = Instance.new("Frame")

				DropdownContainer.Name = "DropdownContainer"
				DropdownContainer.Parent = SectionContent
				DropdownContainer.BackgroundTransparency = 1
				DropdownContainer.Size = UDim2.new(1, 0, 0, isMegaMenu and 32 or 28)

				-- Background for mega menu (larger click area)
				DropdownBackground.Name = "DropdownBackground"
				DropdownBackground.Parent = DropdownContainer
				DropdownBackground.BackgroundColor3 = Colors.Secondary
				DropdownBackground.BorderSizePixel = 0
				DropdownBackground.Size = UDim2.new(1, 0, 0, isMegaMenu and 32 or 26)
				DropdownBackground.Position = UDim2.new(0, 0, 0, isMegaMenu and 0 or 2)

				local BackgroundCorner = Instance.new("UICorner")
				BackgroundCorner.Parent = DropdownBackground
				BackgroundCorner.CornerRadius = UDim.new(0, 6)

				-- Main dropdown button
				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = DropdownContainer
				DropdownButton.BackgroundTransparency = 1
				DropdownButton.Size = UDim2.new(1, 0, 0, isMegaMenu and 32 or 26)
				DropdownButton.Text = ""
				DropdownButton.AutoButtonColor = false

				-- Optional icon for mega menu
				if isMegaMenu then
					DropdownIcon.Name = "DropdownIcon"
					DropdownIcon.Parent = DropdownButton
					DropdownIcon.BackgroundTransparency = 1
					DropdownIcon.Position = UDim2.new(0, 12, 0, 0)
					DropdownIcon.Size = UDim2.new(0, 20, 1, 0)
					DropdownIcon.Font = Enum.Font.GothamMedium
					DropdownIcon.Text = "📊"
					DropdownIcon.TextColor3 = Colors.TextMuted
					DropdownIcon.TextSize = 12
					DropdownIcon.TextXAlignment = Enum.TextXAlignment.Left
				end

				-- Dropdown label
				DropdownLabel.Name = "DropdownLabel"
				DropdownLabel.Parent = DropdownButton
				DropdownLabel.BackgroundTransparency = 1
				DropdownLabel.Position = UDim2.new(0, isMegaMenu and 36 or 8, 0, 0)
				DropdownLabel.Size = UDim2.new(0.7, 0, 1, 0)
				DropdownLabel.Font = isMegaMenu and Enum.Font.GothamMedium or Enum.Font.Gotham
				DropdownLabel.Text = dropdownText
				DropdownLabel.TextColor3 = Colors.Text
				DropdownLabel.TextSize = isMegaMenu and 12 or 11
				DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left

				-- Dropdown arrow
				DropdownArrow.Name = "DropdownArrow"
				DropdownArrow.Parent = DropdownButton
				DropdownArrow.BackgroundTransparency = 1
				DropdownArrow.Position = UDim2.new(0.85, 0, 0, 0)
				DropdownArrow.Size = UDim2.new(0.15, 0, 1, 0)
				DropdownArrow.Font = Enum.Font.GothamMedium
				DropdownArrow.Text = "▼"
				DropdownArrow.TextColor3 = Colors.TextMuted
				DropdownArrow.TextSize = 10

				-- Dropdown list - Position it to the RIGHT side instead of below
				DropdownList.Name = "DropdownList"
				DropdownList.Parent = DropdownContainer.Parent.Parent.Parent -- Move to higher parent level
				DropdownList.BackgroundColor3 = Colors.Background
				DropdownList.BorderColor3 = Colors.Border
				DropdownList.BorderSizePixel = 1
				DropdownList.Position = UDim2.new(1, 10, 0, DropdownContainer.AbsolutePosition.Y - DropdownContainer.Parent.Parent.AbsolutePosition.Y)
				DropdownList.Size = UDim2.new(0, 200, 0, 0) -- Fixed width, starts at 0 height
				DropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownList.ScrollBarThickness = 3
				DropdownList.ScrollBarImageColor3 = Colors.Accent
				DropdownList.Visible = false
				DropdownList.ClipsDescendants = true
				DropdownList.ZIndex = 1000 -- Very high z-index to appear above everything

				local ListCorner = Instance.new("UICorner")
				ListCorner.Parent = DropdownList
				ListCorner.CornerRadius = UDim.new(0, 6)

				DropdownListLayout.Name = "DropdownListLayout"
				DropdownListLayout.Parent = DropdownList
				DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				DropdownListLayout.Padding = UDim.new(0, 4)

				local isOpen = false
				local selectedOption = nil

				-- Define updateDropdownSize FIRST
				local function updateDropdownSize()
					local totalHeight = 0
					for _, child in pairs(DropdownList:GetChildren()) do
						if child:IsA("Frame") then
							totalHeight = totalHeight + child.Size.Y.Offset
						elseif child:IsA("TextButton") then
							totalHeight = totalHeight + child.Size.Y.Offset + 4
						end
					end

					local maxHeight = isMegaMenu and 400 or 200
					local finalHeight = math.min(totalHeight, maxHeight)

					if isOpen then
						game:GetService("TweenService"):Create(DropdownList, TweenInfo.new(0.2), {
							Size = UDim2.new(0, 200, 0, finalHeight)
						}):Play()
					end

					DropdownList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
				end

				local function toggleDropdown()
					isOpen = not isOpen
					if isOpen then
						-- Position the dropdown to the right of the button
						local containerAbsolutePos = DropdownContainer.AbsolutePosition
						local parentAbsolutePos = DropdownContainer.Parent.Parent.AbsolutePosition
						local relativeY = containerAbsolutePos.Y - parentAbsolutePos.Y

						DropdownList.Position = UDim2.new(1, 10, 0, relativeY)
						DropdownList.Visible = true
						updateDropdownSize()
						game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.15), {
							TextColor3 = Colors.Accent,
							Rotation = 180
						}):Play()
						game:GetService("TweenService"):Create(DropdownBackground, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Hover
						}):Play()
					else
						game:GetService("TweenService"):Create(DropdownList, TweenInfo.new(0.15), {
							Size = UDim2.new(0, 200, 0, 0)
						}):Play()
						game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.15), {
							TextColor3 = Colors.TextMuted,
							Rotation = 0
						}):Play()
						game:GetService("TweenService"):Create(DropdownBackground, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Secondary
						}):Play()
						delay(0.15, function()
							if not isOpen then
								DropdownList.Visible = false
							end
						end)
					end
				end

				local function createOptionButton(option, parent, isSubOption)
					local OptionButton = Instance.new("TextButton")
					local OptionLabel = Instance.new("TextLabel")
					local OptionIcon = Instance.new("TextLabel")

					OptionButton.Name = option
					OptionButton.Parent = parent
					OptionButton.BackgroundColor3 = Colors.Secondary
					OptionButton.BorderSizePixel = 0
					OptionButton.Size = UDim2.new(1, 0, 0, isSubOption and 20 or 24)
					OptionButton.AutoButtonColor = false
					OptionButton.Text = ""
					OptionButton.ZIndex = 1001

					local OptionCorner = Instance.new("UICorner")
					OptionCorner.Parent = OptionButton
					OptionCorner.CornerRadius = UDim.new(0, 4)

					-- Optional icon for options
					if not isSubOption then
						OptionIcon.Name = "OptionIcon"
						OptionIcon.Parent = OptionButton
						OptionIcon.BackgroundTransparency = 1
						OptionIcon.Position = UDim2.new(0, 8, 0, 0)
						OptionIcon.Size = UDim2.new(0, 16, 1, 0)
						OptionIcon.Font = Enum.Font.Gotham
						OptionIcon.Text = "•"
						OptionIcon.TextColor3 = Colors.TextMuted
						OptionIcon.TextSize = 10
						OptionIcon.TextXAlignment = Enum.TextXAlignment.Left
						OptionIcon.ZIndex = 1002
					end

					-- Option label
					OptionLabel.Name = "OptionLabel"
					OptionLabel.Parent = OptionButton
					OptionLabel.BackgroundTransparency = 1
					OptionLabel.Position = UDim2.new(0, isSubOption and 8 or 24, 0, 0)
					OptionLabel.Size = UDim2.new(1, isSubOption and -8 or -24, 1, 0)
					OptionLabel.Font = Enum.Font.Gotham
					OptionLabel.Text = option
					OptionLabel.TextColor3 = Colors.Text
					OptionLabel.TextSize = isSubOption and 10 or 11
					OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
					OptionLabel.TextYAlignment = Enum.TextYAlignment.Center
					OptionLabel.ZIndex = 1002

					-- Hover effects
					OptionButton.MouseEnter:Connect(function()
						game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Hover
						}):Play()
						game:GetService("TweenService"):Create(OptionLabel, TweenInfo.new(0.15), {
							TextColor3 = Colors.Accent
						}):Play()
						if OptionIcon then
							game:GetService("TweenService"):Create(OptionIcon, TweenInfo.new(0.15), {
								TextColor3 = Colors.Accent
							}):Play()
						end
					end)

					OptionButton.MouseLeave:Connect(function()
						game:GetService("TweenService"):Create(OptionButton, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Secondary
						}):Play()
						game:GetService("TweenService"):Create(OptionLabel, TweenInfo.new(0.15), {
							TextColor3 = Colors.Text
						}):Play()
						if OptionIcon then
							game:GetService("TweenService"):Create(OptionIcon, TweenInfo.new(0.15), {
								TextColor3 = Colors.TextMuted
							}):Play()
						end
					end)

					return OptionButton
				end

				local function createMegaMenuOption(category, subOptions, parent)
					local MegaOption = Instance.new("Frame")
					local MegaHeader = Instance.new("TextButton")
					local MegaLabel = Instance.new("TextLabel")
					local MegaArrow = Instance.new("TextLabel")
					local MegaContent = Instance.new("Frame")
					local MegaLayout = Instance.new("UIListLayout")

					MegaOption.Name = category
					MegaOption.Parent = parent
					MegaOption.BackgroundTransparency = 1
					MegaOption.Size = UDim2.new(1, 0, 0, 28)
					MegaOption.ZIndex = 1001

					-- Mega menu header
					MegaHeader.Name = "MegaHeader"
					MegaHeader.Parent = MegaOption
					MegaHeader.BackgroundColor3 = Colors.Secondary
					MegaHeader.BorderSizePixel = 0
					MegaHeader.Size = UDim2.new(1, 0, 0, 28)
					MegaHeader.AutoButtonColor = false
					MegaHeader.Text = ""
					MegaHeader.ZIndex = 1002

					local HeaderCorner = Instance.new("UICorner")
					HeaderCorner.Parent = MegaHeader
					HeaderCorner.CornerRadius = UDim.new(0, 4)

					MegaLabel.Name = "MegaLabel"
					MegaLabel.Parent = MegaHeader
					MegaLabel.BackgroundTransparency = 1
					MegaLabel.Position = UDim2.new(0, 12, 0, 0)
					MegaLabel.Size = UDim2.new(0.8, 0, 1, 0)
					MegaLabel.Font = Enum.Font.GothamMedium
					MegaLabel.Text = category
					MegaLabel.TextColor3 = Colors.Text
					MegaLabel.TextSize = 11
					MegaLabel.TextXAlignment = Enum.TextXAlignment.Left
					MegaLabel.ZIndex = 1003

					MegaArrow.Name = "MegaArrow"
					MegaArrow.Parent = MegaHeader
					MegaArrow.BackgroundTransparency = 1
					MegaArrow.Position = UDim2.new(0.9, 0, 0, 0)
					MegaArrow.Size = UDim2.new(0.1, 0, 1, 0)
					MegaArrow.Font = Enum.Font.GothamMedium
					MegaArrow.Text = "▶"
					MegaArrow.TextColor3 = Colors.TextMuted
					MegaArrow.TextSize = 9
					MegaArrow.ZIndex = 1003

					-- Mega menu content (sub-options)
					MegaContent.Name = "MegaContent"
					MegaContent.Parent = MegaOption
					MegaContent.BackgroundTransparency = 1
					MegaContent.Position = UDim2.new(0, 8, 0, 28)
					MegaContent.Size = UDim2.new(1, -8, 0, 0)
					MegaContent.Visible = false
					MegaContent.ZIndex = 1001

					MegaLayout.Name = "MegaLayout"
					MegaLayout.Parent = MegaContent
					MegaLayout.SortOrder = Enum.SortOrder.LayoutOrder
					MegaLayout.Padding = UDim.new(0, 2)

					local megaOpen = false

					-- Create sub-options
					for _, subOption in pairs(subOptions) do
						local subButton = createOptionButton(subOption, MegaContent, true)
						subButton.MouseButton1Click:Connect(function()
							selectedOption = category .. " - " .. subOption
							DropdownLabel.Text = selectedOption
							toggleDropdown()
							if callback then
								pcall(callback, category, subOption)
							end
						end)
					end

					-- Update mega content size when layout changes
					MegaLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						if megaOpen then
							local contentHeight = MegaLayout.AbsoluteContentSize.Y
							MegaContent.Size = UDim2.new(1, -8, 0, contentHeight)
							MegaOption.Size = UDim2.new(1, 0, 0, 28 + contentHeight)
							updateDropdownSize()
						end
					end)

					-- Toggle mega menu section
					MegaHeader.MouseButton1Click:Connect(function()
						megaOpen = not megaOpen
						if megaOpen then
							MegaContent.Visible = true
							MegaArrow.Text = "▼"
							local contentHeight = MegaLayout.AbsoluteContentSize.Y
							MegaContent.Size = UDim2.new(1, -8, 0, contentHeight)
							MegaOption.Size = UDim2.new(1, 0, 0, 28 + contentHeight)
							game:GetService("TweenService"):Create(MegaArrow, TweenInfo.new(0.15), {
								TextColor3 = Colors.Accent
							}):Play()
						else
							MegaContent.Visible = false
							MegaArrow.Text = "▶"
							MegaOption.Size = UDim2.new(1, 0, 0, 28)
							game:GetService("TweenService"):Create(MegaArrow, TweenInfo.new(0.15), {
								TextColor3 = Colors.TextMuted
							}):Play()
						end

						updateDropdownSize()
					end)

					-- Hover effects for mega header
					MegaHeader.MouseEnter:Connect(function()
						game:GetService("TweenService"):Create(MegaHeader, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Hover
						}):Play()
					end)

					MegaHeader.MouseLeave:Connect(function()
						game:GetService("TweenService"):Create(MegaHeader, TweenInfo.new(0.15), {
							BackgroundColor3 = Colors.Secondary
						}):Play()
					end)

					return MegaOption
				end

				-- Create dropdown options based on type
				if isMegaMenu and type(options) == "table" then
					-- Mega menu structure: {Category1 = {"Option1", "Option2"}, Category2 = {"Option3", "Option4"}}
					for category, subOptions in pairs(options) do
						createMegaMenuOption(category, subOptions, DropdownList)
					end
				else
					-- Regular dropdown
					for _, option in pairs(options) do
						local optionButton = createOptionButton(option, DropdownList, false)
						optionButton.MouseButton1Click:Connect(function()
							selectedOption = option
							DropdownLabel.Text = option
							toggleDropdown()
							if callback then
								pcall(callback, option)
							end
						end)
					end
				end

				-- Update dropdown list size when layout changes
				DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					updateDropdownSize()
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
					if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
						local mousePos = input.Position
						local dropdownAbsolutePos = DropdownContainer.AbsolutePosition
						local listAbsolutePos = DropdownList.AbsolutePosition
						local listAbsoluteSize = DropdownList.AbsoluteSize

						local isInButton = (
							mousePos.X >= dropdownAbsolutePos.X and 
								mousePos.X <= dropdownAbsolutePos.X + DropdownContainer.AbsoluteSize.X and
								mousePos.Y >= dropdownAbsolutePos.Y and 
								mousePos.Y <= dropdownAbsolutePos.Y + DropdownContainer.AbsoluteSize.Y
						)

						local isInList = (
							mousePos.X >= listAbsolutePos.X and 
								mousePos.X <= listAbsolutePos.X + listAbsoluteSize.X and
								mousePos.Y >= listAbsolutePos.Y and 
								mousePos.Y <= listAbsolutePos.Y + listAbsoluteSize.Y
						)

						if not isInButton and not isInList then
							toggleDropdown()
						end
					end
				end)

				-- Dropdown functions
				local dropdownFunctions = {}

				function dropdownFunctions:Set(option)
					if isMegaMenu then
						-- For mega menu, option should be {category, subOption}
						if type(option) == "table" and #option == 2 then
							selectedOption = option[1] .. " - " .. option[2]
							DropdownLabel.Text = selectedOption
							if callback then
								pcall(callback, option[1], option[2])
							end
						end
					else
						if table.find(options, option) then
							selectedOption = option
							DropdownLabel.Text = option
							if callback then
								pcall(callback, option)
							end
						end
					end
				end

				function dropdownFunctions:Get()
					return selectedOption
				end

				function dropdownFunctions:SetOptions(newOptions, newIsMegaMenu)
					-- Clear existing options
					for _, child in pairs(DropdownList:GetChildren()) do
						if child:IsA("TextButton") or child:IsA("Frame") then
							child:Destroy()
						end
					end

					-- Create new options
					if newIsMegaMenu and type(newOptions) == "table" then
						for category, subOptions in pairs(newOptions) do
							createMegaMenuOption(category, subOptions, DropdownList)
						end
					else
						for _, option in pairs(newOptions) do
							local optionButton = createOptionButton(option, DropdownList, false)
							optionButton.MouseButton1Click:Connect(function()
								selectedOption = option
								DropdownLabel.Text = option
								toggleDropdown()
								if callback then
									pcall(callback, option)
								end
							end)
						end
					end

					updateDropdownSize()
				end

				function dropdownFunctions:SetIcon(icon)
					if DropdownIcon then
						DropdownIcon.Text = icon
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
					DropdownList:Destroy()
					DropdownContainer:Destroy()
				end

				return dropdownFunctions
			end

			return sectionFunctions
		end

		return tabFunctions
	end

	return uiFunctions
end

return ReduxV2
