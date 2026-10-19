-- TeleportScript.server.lua

local TeleportService = game:GetService("TeleportService")

local function onPlayerAdded(player)
    -- Create a tool for teleportation
    local teleportTool = Instance.new("Tool")
    teleportTool.Name = "TeleportTool"
    teleportTool.Parent = player.Backpack

    -- Create a GUI for the teleport tool
    local teleportGui = Instance.new("ScreenGui")
    teleportGui.Name = "TeleportGui"
    teleportGui.Parent = player.PlayerGui

    -- Create a frame for the teleport GUI
    local teleportFrame = Instance.new("Frame")
    teleportFrame.Name = "TeleportFrame"
    teleportFrame.Size = UDim2.new(0, 200, 0, 100)
    teleportFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
    teleportFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    teleportFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    teleportFrame.Parent = teleportGui

    -- Create a button for each teleport location
    local locations = {
        {Name = "Spawn", Position = Vector3.new(0, 10, 0)},
        {Name = "Location1", Position = Vector3.new(100, 10, 0)},
        {Name = "Location2", Position = Vector3.new(0, 10, 100)}
    }

    for i, location in ipairs(locations) do
        local teleportButton = Instance.new("TextButton")
        teleportButton.Name = location.Name
        teleportButton.Text = location.Name
        teleportButton.Size = UDim2.new(0, 180, 0, 30)
        teleportButton.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 40)
        teleportButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        teleportButton.TextColor3 = Color3.new(1, 1, 1)
        teleportButton.Parent = teleportFrame

        teleportButton.MouseButton1Click:Connect(function()
            player.Character:MoveTo(location.Position)
        end)
    end

    -- Function to handle tool equipped
    local function onToolEquipped()
        teleportGui.Enabled = true
    end

    -- Function to handle tool unequipped
    local function onToolUnequipped()
        teleportGui.Enabled = false
    end

    -- Connect tool events
    teleportTool.Equipped:Connect(onToolEquipped)
    teleportTool.Unequipped:Connect(onToolUnequipped)
end

-- Connect player added event
game.Players.PlayerAdded:Connect(onPlayerAdded)

-- Function to handle player removal
local function onPlayerRemoving(player)
    -- Clean up GUI when player leaves
    local teleportGui = player.PlayerGui:FindFirstChild("TeleportGui")
    if teleportGui then
        teleportGui:Destroy()
    end
end

-- Connect player removing event
game.Players.PlayerRemoving:Connect(onPlayerRemoving)