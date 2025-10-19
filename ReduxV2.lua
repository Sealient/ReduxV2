local ReduxV2 = require(game.ReplicatedStorage.Rodus)
local UI = ReduxV2:CreateMain("ReduxV2 - Test Suite")

-- Get notification service
local Notify = UI:Notifications()

-- ===== DEMO TAB =====
local DemoTab = UI:CreateTab("Demo", "🎮")
local ComponentsSection = DemoTab:CreateSection("UI COMPONENTS")

-- Button Demo
ComponentsSection:CreateButton("Test Button", function()
	Notify:Success("Button clicked!")
	print("Button pressed at: " .. os.date("%X"))
end)

-- Toggle Demo
local toggleState = false
local demoToggle = ComponentsSection:CreateToggle("Demo Toggle", false, function(state)
	toggleState = state
	if state then
		Notify:Info("Toggle enabled")
	else
		Notify:Warning("Toggle disabled")
	end
end)

-- Slider Demo
local demoSlider = ComponentsSection:CreateSlider("Volume", 0, 100, 50, function(value)
	print("Volume set to: " .. value)
end)

-- Label Demo
ComponentsSection:CreateLabel("This is an info label", "Info")
ComponentsSection:CreateLabel("Operation successful!", "Success")
ComponentsSection:CreateLabel("Warning: High memory usage", "Warning")
ComponentsSection:CreateLabel("Error: Connection failed", "Error")

-- TextBox Demo
local demoTextBox = ComponentsSection:CreateTextBox("Enter your name", function(text)
	if text ~= "" then
		Notify:Success("Hello, " .. text .. "!")
	end
end)

-- Dropdown Demo
local demoDropdown = ComponentsSection:CreateDropdown("Select Weapon", {"AK-47", "M4A1", "AWP", "Deagle", "Knife"}, function(selected)
	Notify:Info("Selected: " .. selected)
end, "AK-47")

-- Color Picker Demo
local demoColorPicker = ComponentsSection:CreateColorPicker("Theme Color", Color3.fromRGB(147, 51, 234), function(color)
	local hex = string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
	Notify:Premium("Color set to: " .. hex)
end)

-- ===== NOTIFICATIONS TAB =====
local NotificationsTab = UI:CreateTab("Notifications", "🔔")
local NotificationTests = NotificationsTab:CreateSection("NOTIFICATION TESTS")

-- Quick Notification Tests
NotificationTests:CreateButton("Success Notification", function()
	Notify:Success("Operation completed successfully!\nAll systems are functioning properly.")
end)

NotificationTests:CreateButton("Error Notification", function()
	Notify:Error("Connection failed!\nPlease check your internet connection and try again.")
end)

NotificationTests:CreateButton("Warning Notification", function()
	Notify:Warning("Storage almost full!\nConsider cleaning up unused files.")
end)

NotificationTests:CreateButton("Info Notification", function()
	Notify:Info("New update available!\nVersion 2.1.0 includes performance improvements.")
end)

NotificationTests:CreateButton("Premium Notification", function()
	Notify:Premium("Premium feature unlocked!\nYou now have access to all exclusive features.")
end)

-- Duration Tests
local DurationTests = NotificationsTab:CreateSection("DURATION TESTS")
DurationTests:CreateButton("Short (3s)", function()
	Notify:Info("This will disappear in 3 seconds", 3)
end)

DurationTests:CreateButton("Medium (6s)", function()
	Notify:Warning("Medium duration notification", 6)
end)

DurationTests:CreateButton("Long (10s)", function()
	Notify:Success("Long notification with progress bar", 10)
end)

DurationTests:CreateButton("Permanent (Click to close)", function()
	Notify:Error("This stays until you click it", 0)
end)

-- Interactive Tests
local InteractiveTests = NotificationsTab:CreateSection("INTERACTIVE TESTS")
InteractiveTests:CreateButton("Multiple Notifications", function()
	Notify:Info("Notification 1")
	wait(0.3)
	Notify:Success("Notification 2")
	wait(0.3)
	Notify:Warning("Notification 3")
	wait(0.3)
	Notify:Error("Notification 4")
end)

InteractiveTests:CreateButton("Updating Notification", function()
	local notif = Notify:Info("Starting process...", 8)

	wait(2)
	notif:Update("Processing data...", "Warning", 6)

	wait(2)
	notif:Update("Almost done...", "Info", 4)

	wait(2)
	notif:Update("Process complete!", "Success", 2)
end)

InteractiveTests:CreateButton("Rapid Fire (5x)", function()
	for i = 1, 5 do
		Notify:Info("Quick notification #" .. i)
		wait(0.2)
	end
end)

-- Management
local ManagementTests = NotificationsTab:CreateSection("MANAGEMENT")
ManagementTests:CreateButton("Clear All Notifications", function()
	Notify:ClearAll()
	Notify:Success("All notifications cleared!")
end)

ManagementTests:CreateButton("Show Notification Count", function()
	local count = Notify:GetCount()
	Notify:Info("Active notifications: " .. count)
end)

-- ===== COLOR PICKER TAB =====
local ColorTab = UI:CreateTab("Colors", "🎨")
local ColorSection = ColorTab:CreateSection("COLOR PICKERS")

-- Multiple Color Pickers
local primaryColor = ColorSection:CreateColorPicker("Primary Color", Color3.fromRGB(147, 51, 234), function(color)
	local hex = string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
	print("Primary color set to: " .. hex)
end)

local accentColor = ColorSection:CreateColorPicker("Accent Color", Color3.fromRGB(59, 130, 246), function(color)
	local hex = string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
	print("Accent color set to: " .. hex)
end)

local successColor = ColorSection:CreateColorPicker("Success Color", Color3.fromRGB(34, 197, 94), function(color)
	local hex = string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
	print("Success color set to: " .. hex)
end)

-- Color Actions
local ColorActions = ColorTab:CreateSection("COLOR ACTIONS")
ColorActions:CreateButton("Randomize Primary Color", function()
	local randomColor = Color3.fromRGB(
		math.random(0, 255),
		math.random(0, 255), 
		math.random(0, 255)
	)
	primaryColor:SetColor(randomColor)
	Notify:Premium("Primary color randomized!")
end)

ColorActions:CreateButton("Get Current Colors", function()
	local primary = primaryColor:GetColor()
	local accent = accentColor:GetColor()
	local success = successColor:GetColor()

	print("Primary:", primary)
	print("Accent:", accent) 
	print("Success:", success)

	Notify:Info("Colors logged to console")
end)

-- ===== INTERACTIVE TAB =====
local InteractiveTab = UI:CreateTab("Interactive", "⚡")
local StateSection = InteractiveTab:CreateSection("STATE MANAGEMENT")

-- Dynamic Updates
local dynamicLabel = StateSection:CreateLabel("Counter: 0", "Info")
local counter = 0

StateSection:CreateButton("Increment Counter", function()
	counter = counter + 1
	dynamicLabel:SetText("Counter: " .. counter)

	if counter % 5 == 0 then
		Notify:Success("Reached " .. counter .. "!")
	end
end)

StateSection:CreateButton("Reset Counter", function()
	counter = 0
	dynamicLabel:SetText("Counter: 0")
	Notify:Warning("Counter reset")
end)

-- Toggle Group
local ToggleGroup = InteractiveTab:CreateSection("TOGGLE GROUP")
local toggle1 = ToggleGroup:CreateToggle("Feature 1", false, function(state)
	print("Feature 1:", state)
end)

local toggle2 = ToggleGroup:CreateToggle("Feature 2", true, function(state)
	print("Feature 2:", state)
end)

local toggle3 = ToggleGroup:CreateToggle("Feature 3", false, function(state)
	print("Feature 3:", state)
end)

ToggleGroup:CreateButton("Enable All Features", function()
	toggle1:Set(true)
	toggle2:Set(true)
	toggle3:Set(true)
	Notify:Success("All features enabled")
end)

ToggleGroup:CreateButton("Disable All Features", function()
	toggle1:Set(false)
	toggle2:Set(false)
	toggle3:Set(false)
	Notify:Warning("All features disabled")
end)

-- Slider Group
local SliderGroup = InteractiveTab:CreateSection("SLIDER GROUP")
local volumeSlider = SliderGroup:CreateSlider("Master Volume", 0, 100, 75, function(value)
	print("Master volume:", value)
end)

local brightnessSlider = SliderGroup:CreateSlider("Brightness", 0, 100, 80, function(value)
	print("Brightness:", value)
end)

local sensitivitySlider = SliderGroup:CreateSlider("Sensitivity", 1, 10, 5, function(value)
	print("Sensitivity:", value)
end)

SliderGroup:CreateButton("Reset All Sliders", function()
	volumeSlider:Set(75)
	brightnessSlider:Set(80)
	sensitivitySlider:Set(5)
	Notify:Info("All sliders reset to default")
end)

-- ===== SETTINGS TAB =====
local SettingsTab = UI:CreateTab("Settings", "⚙️")
local ConfigSection = SettingsTab:CreateSection("CONFIGURATION")

-- Dropdown Settings
local themeDropdown = ConfigSection:CreateDropdown("UI Theme", {"Dark", "Light", "Auto", "Purple", "Blue"}, function(selected)
	Notify:Info("Theme set to: " .. selected)
end, "Dark")

local languageDropdown = ConfigSection:CreateDropdown("Language", {"English", "Spanish", "French", "German", "Japanese"}, function(selected)
	Notify:Info("Language set to: " .. selected)
end, "English")

-- Performance Settings
local PerformanceSection = SettingsTab:CreateSection("PERFORMANCE")
PerformanceSection:CreateToggle("VSync", true, function(state)
	Notify:Info("VSync: " .. (state and "Enabled" or "Disabled"))
end)

PerformanceSection:CreateToggle("Anti-Aliasing", true, function(state)
	Notify:Info("Anti-Aliasing: " .. (state and "Enabled" or "Disabled"))
end)

PerformanceSection:CreateSlider("FPS Limit", 30, 240, 60, function(value)
	Notify:Info("FPS Limit set to: " .. value)
end)

local PlayerListTab = UI:CreateDynamicTab("Players", "👥")

local function createPlayerList()
	local players = game:GetService("Players"):GetPlayers()
	local content = {
		["PLAYER LIST"] = {}
	}

	for _, player in pairs(players) do
		table.insert(content["PLAYER LIST"], {
			Type = "Button",
			Text = player.Name .. " (" .. player.UserId .. ")",
			Data = player
		})
	end

	-- Add management buttons
	table.insert(content["PLAYER LIST"], {
		Type = "Button", Text = "────────────", Data = "separator"
	})
	table.insert(content["PLAYER LIST"], {
		Type = "Button", Text = "Refresh List", Data = "refresh"
	})
	table.insert(content["PLAYER LIST"], {
		Type = "Toggle", Text = "Auto-Refresh", Data = "autorefresh", Default = false
	})

	PlayerListTab:UpdateContent(content, function(text, value, data)
		if data == "refresh" then
			createPlayerList()
		elseif data == "autorefresh" then
			-- Handle auto-refresh toggle
			print("Auto-refresh:", value)
		elseif typeof(data) == "Instance" and data:IsA("Player") then
			-- Player button clicked
			print("Selected player:", data.Name)
			-- Add your player action here
		end
	end)
end

-- Initial creation
createPlayerList()

-- Auto-update when players change
local playersService = game:GetService("Players")
playersService.PlayerAdded:Connect(createPlayerList)
playersService.PlayerRemoving:Connect(createPlayerList)


-- About Section
local AboutSection = SettingsTab:CreateSection("ABOUT")
AboutSection:CreateLabel("ReduxV2 UI Library", "Premium")
AboutSection:CreateLabel("Version 2.1.0", "Info")
AboutSection:CreateLabel("Built with 💜 by Developer", "Muted")

AboutSection:CreateButton("Show All Features", function()
	Notify:Premium("ReduxV2 UI Library")
	wait(0.5)
	Notify:Success("✓ Buttons, Toggles, Sliders")
	wait(0.3)
	Notify:Success("✓ Labels, TextBoxes, Dropdowns") 
	wait(0.3)
	Notify:Success("✓ Color Pickers, Search Bars")
	wait(0.3)
	Notify:Success("✓ Notifications System")
	wait(0.3)
	Notify:Premium("✓ Complete UI Framework!")
end)

-- ===== INITIALIZATION =====
print("ReduxV2 Test UI loaded successfully!")
print("Available tabs: Demo, Notifications, Colors, Search, Interactive, Settings")
Notify:Success("ReduxV2 Test Suite Ready!")
-- Return UI for external access if needed
return {
	UI = UI,
	Notify = Notify,
	Components = {
		PrimaryColor = primaryColor,
		DemoSlider = demoSlider,
		DemoToggle = demoToggle,
	}
}
