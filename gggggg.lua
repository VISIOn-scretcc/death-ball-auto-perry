-- AUTO-PARRY ЧЕРЕЗ КАСАНИЕ ЭКРАНА
local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local autoParry = true
local parryRadius = 20

-- Функция эмуляции касания (в правом нижнем углу)
local function doParry()
    local viewport = Camera.ViewportSize
    local x = viewport.X * 0.85
    local y = viewport.Y * 0.85
    
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
end

-- Основной цикл
task.spawn(function()
    while task.wait(0.05) do
        if not autoParry then continue end
        
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        
        local root = char.HumanoidRootPart
        
        -- Ищем мяч (теперь мы знаем: Ball)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name == "Ball" then
                local dist = (v.Position - root.Position).Magnitude
                if dist <= parryRadius then
                    doParry()
                    break
                end
            end
        end
    end
end)

print("AUTO-PARRY РАБОТАЕТ! Мяч: Ball")
