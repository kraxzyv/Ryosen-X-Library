-- [[ RYOSEN UI LIBRARY ENGINE - V2.3 ]] --
-- [[ CREATOR: KRAXZYV / VANNDERL ]] --

local RyosenLib = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Fungsi Utama Buat Bikin Window UI
function RyosenLib:CreateWindow(Config)
    local HubName = Config.Name or "RYOSEN HUB"
    local WebhookUrl = Config.Webhook or "" -- Masukin url webhook di script utama lu
    
    if CoreGui:FindFirstChild("RyosenHub_Ultimate") then 
        CoreGui.RyosenHub_Ultimate:Destroy() 
    end

    local Gui = Instance.new("ScreenGui", CoreGui)
    Gui.Name = "RyosenHub_Ultimate"

    -- [[ INTEGRASI DISCORD WEBHOOK ]] --
    if WebhookUrl ~= "" then
        task.spawn(function()
            local request = syn and syn.request or http_request or request or HttpService and HttpService.Request
            if request then
                pcall(function()
                    request({
                        Url = WebhookUrl,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = HttpService:JSONEncode({
                            content = "🚀 Ui Library Has Execution"
                        })
                    })
                end)
            end
        end)
    end

    -- MAIN WINDOW (UI UTAMA) - Hide dulu pas loading
    local Main = Instance.new("Frame", Gui)
    Main.Size = UDim2.new(0, 580, 0, 440)
    Main.Position = UDim2.new(0.5, -290, 0.5, -220)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Visible = false -- Sembunyi dulu pas loading screen jalan
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
    local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Color3.fromRGB(240, 240, 245); MainStroke.Thickness = 1.5

    -- [[ FLOATING BAR: TEKS GEDE FULL, PUTIH SOFT ANTI-NEON ]] --
    local MiniBar = Instance.new("TextButton", Gui)
    MiniBar.Size = UDim2.new(0, 240, 0, 44) 
    MiniBar.Position = UDim2.new(0.5, -120, 0, 25)
    MiniBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    MiniBar.Text = HubName 
    MiniBar.TextColor3 = Color3.fromRGB(225, 225, 230) 
    MiniBar.Font = Enum.Font.GothamBold
    MiniBar.TextSize = 15 
    MiniBar.TextWrapped = true 
    MiniBar.Visible = false -- Sembunyi pas loading
    MiniBar.Active = true
    MiniBar.Draggable = true
    Instance.new("UICorner", MiniBar).CornerRadius = UDim.new(0, 6)
    
    local MiniBarStroke = Instance.new("UIStroke", MiniBar)
    MiniBarStroke.Color = Color3.fromRGB(225, 225, 230) 
    MiniBarStroke.Thickness = 1.5

    local TextStroke = Instance.new("UIStroke", MiniBar)
    TextStroke.Target = Enum.UIStrokeTarget.Text
    TextStroke.Color = Color3.fromRGB(10, 10, 12)
    TextStroke.Thickness = 1

    local AccentLine = Instance.new("Frame", MiniBar)
    AccentLine.Size = UDim2.new(1, 0, 0, 3)
    AccentLine.Position = UDim2.new(0, 0, 0, 0)
    AccentLine.BackgroundColor3 = Color3.fromRGB(225, 225, 230) 
    AccentLine.BorderSizePixel = 0
    Instance.new("UICorner", AccentLine).CornerRadius = UDim.new(0, 2)

    -- Tombol (-) Buat Nge-minimize
    local MinBtn = Instance.new("TextButton", Main)
    MinBtn.Size = UDim2.new(0, 32, 0, 32)
    MinBtn.Position = UDim2.new(1, -42, 0, 10)
    MinBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 18
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)
    local MinBtnStroke = Instance.new("UIStroke", MinBtn); MinBtnStroke.Color = Color3.fromRGB(240, 240, 245); MinBtnStroke.Thickness = 1

    MinBtn.MouseButton1Click:Connect(function() Main.Visible = false; MiniBar.Visible = true end)
    MiniBar.MouseButton1Click:Connect(function() MiniBar.Visible = false; Main.Visible = true end)

    -- SIDEBAR
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 165, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Sidebar.BorderSizePixel = 0
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
    local SideLayout = Instance.new("UIListLayout", Sidebar); SideLayout.Padding = UDim.new(0, 6); SideLayout.HorizontalAlignment = "Center"

    local Brand = Instance.new("TextLabel", Sidebar)
    Brand.Size = UDim2.new(0.85, 0, 0, 45)
    Brand.Text = HubName
    Brand.TextColor3 = Color3.fromRGB(255, 255, 255)
    Brand.Font = Enum.Font.GothamBold
    Brand.TextSize = 16
    Brand.TextXAlignment = "Left"
    Brand.BackgroundTransparency = 1

    -- CONTAINER (TEMPAT HALAMAN TABS)
    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -185, 1, -50)
    Container.Position = UDim2.new(0, 175, 0, 45)
    Container.BackgroundTransparency = 1

    -- AVATAR REAL-TIME VERSI PAS & FIX ENGINE KOSONG
    local Profile = Instance.new("Frame", Sidebar)
    Profile.Size = UDim2.new(0.9, 0, 0, 85) 
    Profile.Position = UDim2.new(0.05, 0, 1, -95)
    Profile.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
    Instance.new("UICorner", Profile).CornerRadius = UDim.new(0, 8)
    local ProfileStroke = Instance.new("UIStroke", Profile); ProfileStroke.Color = Color3.fromRGB(240, 240, 245); ProfileStroke.Thickness = 1

    local Avatar = Instance.new("ImageLabel", Profile)
    Avatar.Size = UDim2.new(0, 46, 0, 46) 
    Avatar.Position = UDim2.new(0, 10, 0, 10)
    Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
    Avatar.BackgroundTransparency = 1
    Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

    local UserText = Instance.new("TextLabel", Profile)
    UserText.Size = UDim2.new(1, -72, 0, 36) 
    UserText.Position = UDim2.new(0, 64, 0, 14) 
    UserText.Text = LocalPlayer.DisplayName .. "\n@" .. LocalPlayer.Name
    UserText.TextColor3 = Color3.new(1, 1, 1)
    UserText.Font = Enum.Font.GothamBold
    UserText.TextSize = 11 
    UserText.TextXAlignment = "Left"
    UserText.TextYAlignment = "Center" 
    UserText.BackgroundTransparency = 1

    local StatusDot = Instance.new("Frame", Profile)
    StatusDot.Size = UDim2.new(0, 8, 0, 8)
    StatusDot.Position = UDim2.new(0, 14, 1, -20)
    StatusDot.BackgroundColor3 = Color3.fromRGB(0, 215, 100)
    Instance.new("UICorner", StatusDot)

    local StatusText = Instance.new("TextLabel", Profile)
    StatusText.Size = UDim2.new(0, 100, 0, 16)
    StatusText.Position = UDim2.new(0, 28, 1, -24)
    StatusText.Text = "Aktif"
    StatusText.TextColor3 = Color3.fromRGB(0, 215, 100)
    StatusText.Font = Enum.Font.GothamBold
    StatusText.TextSize = 10
    StatusText.TextXAlignment = "Left"
    StatusText.BackgroundTransparency = 1

    LocalPlayer.Idled:Connect(function() StatusDot.BackgroundColor3 = Color3.fromRGB(255, 50, 50); StatusText.Text = "AFK"; StatusText.TextColor3 = Color3.fromRGB(255, 50, 50) end)
    UserInputService.InputBegan:Connect(function() if StatusText.Text == "AFK" then StatusDot.BackgroundColor3 = Color3.fromRGB(0, 215, 100); StatusText.Text = "Aktif"; StatusText.TextColor3 = Color3.fromRGB(0, 215, 100) end end)

    -- [[ RAYFIELD-STYLE LOADING SCREEN ENGINE ]] --
    local LoadingFrame = Instance.new("Frame", Gui)
    LoadingFrame.Size = UDim2.new(0, 360, 0, 160)
    LoadingFrame.Position = UDim2.new(0.5, -180, 0.5, -80)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 10)
    local LoadStroke = Instance.new("UIStroke", LoadingFrame); LoadStroke.Color = Color3.fromRGB(45, 45, 50); LoadStroke.Thickness = 1

    local LoadTitle = Instance.new("TextLabel", LoadingFrame)
    LoadTitle.Size = UDim2.new(1, 0, 0, 50)
    LoadTitle.Position = UDim2.new(0, 0, 0, 25)
    LoadTitle.Text = "RYOSEN" -- Tulisan Ryosen Sesuai Request, Bos!
    LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadTitle.Font = Enum.Font.GothamBold
    LoadTitle.TextSize = 28
    LoadTitle.BackgroundTransparency = 1

    local BarBg = Instance.new("Frame", LoadingFrame)
    BarBg.Size = UDim2.new(0.8, 0, 0, 6)
    BarBg.Position = UDim2.new(0.1, 0, 0, 85)
    BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    BarBg.BorderSizePixel = 0
    Instance.new("UICorner", BarBg)

    local BarFill = Instance.new("Frame", BarBg)
    BarFill.Size = UDim2.new(0, 0, 1, 0) -- Mulai dari 0%
    BarFill.BackgroundColor3 = Color3.fromRGB(225, 225, 230) -- Putih Soft Kalem selaras MiniBar
    BarFill.BorderSizePixel = 0
    Instance.new("UICorner", BarFill)

    local PercentText = Instance.new("TextLabel", LoadingFrame)
    PercentText.Size = UDim2.new(1, 0, 0, 20)
    PercentText.Position = UDim2.new(0, 0, 0, 105)
    PercentText.Text = "Loading... 0%"
    PercentText.TextColor3 = Color3.fromRGB(140, 140, 145)
    PercentText.Font = Enum.Font.Gotham
    PercentText.TextSize = 12
    PercentText.BackgroundTransparency = 1

    -- Animasi Loading Jalan
    task.spawn(function()
        for i = 1, 100 do
            local formula = i / 100
            BarFill.Size = UDim2.new(formula, 0, 1, 0)
            PercentText.Text = "Loading... " .. i .. "%"
            task.wait(0.02) -- Kecepatan loading screen (total +- 2 detik)
        end
        task.wait(0.2)
        -- Hancurkan Loading, Munculkan UI Utama
        LoadingFrame:Destroy()
        Main.Visible = true
    end)

    -- GLOBAL KEYBIND (RIGHT SHIFT)
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
            if Main.Visible then Main.Visible = false; MiniBar.Visible = false else Main.Visible = true; MiniBar.Visible = false end
        end
    end)

    local WindowObj = {}
    local FirstTab = true

    -- FUNGSI APINYA: BIKIN TAB BARU
    function WindowObj:CreateTab(TabName)
        local Page = Instance.new("ScrollingFrame", Container)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = FirstTab
        Page.ScrollBarThickness = 0
        local Layout = Instance.new("UIListLayout", Page); Layout.Padding = UDim.new(0, 8)
        
        local Btn = Instance.new("TextButton", Sidebar)
        Btn.Size = UDim2.new(0.9, 0, 0, 36)
        Btn.BackgroundColor3 = FirstTab and Color3.fromRGB(35, 35, 45) or Color3.fromRGB(25, 25, 30)
        Btn.Text = "   " .. TabName
        Btn.TextColor3 = FirstTab and Color3.new(1, 1, 1) or Color3.fromRGB(180, 180, 180)
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 12
        Btn.TextXAlignment = "Left"
        Instance.new("UICorner", Btn)
        local BtnStroke = Instance.new("UIStroke", Btn); BtnStroke.Color = FirstTab and Color3.fromRGB(240, 240, 245) or Color3.fromRGB(45, 45, 50); BtnStroke.Thickness = 1

        Btn.MouseButton1Click:Connect(function()
            for _, p in pairs(Container:GetChildren()) do p.Visible = false end
            for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.TextColor3 = Color3.fromRGB(180, 180, 180); b.UIStroke.Color = Color3.fromRGB(45, 45, 50) end end
            Page.Visible = true
            Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            Btn.TextColor3 = Color3.new(1, 1, 1)
            Btn.UIStroke.Color = Color3.fromRGB(240, 240, 245)
        end)

        FirstTab = false
        local TabObj = {}

        -- FUNGSI APINYA: BIKIN TOGGLE
        function TabObj:CreateToggle(Config)
            local text = Config.Name or "Toggle"
            local default = Config.CurrentValue or false
            local callback = Config.Callback or function() end
            local state = default

            local Tgl = Instance.new("TextButton", Page); Tgl.Size = UDim2.new(0.95, 0, 0, 42); Tgl.BackgroundColor3 = Color3.fromRGB(22, 22, 26); Tgl.Text = "   " .. text; Tgl.TextColor3 = Color3.new(1, 1, 1); Tgl.Font = Enum.Font.Gotham; Tgl.TextSize = 13; Tgl.TextXAlignment = "Left"; Instance.new("UICorner", Tgl)
            local TglStroke = Instance.new("UIStroke", Tgl); TglStroke.Color = Color3.fromRGB(240, 240, 245); TglStroke.Thickness = 1

            local Switch = Instance.new("Frame", Tgl); Switch.Size = UDim2.new(0, 28, 0, 16); Switch.Position = UDim2.new(1, -38, 0.5, -8); Switch.BackgroundColor3 = default and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(50, 50, 55); Instance.new("UICorner", Switch)
            local Dot = Instance.new("Frame", Switch); Dot.Size = UDim2.new(0, 12, 0, 12); Dot.Position = default and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6); Dot.BackgroundColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", Dot)
            
            Tgl.MouseButton1Click:Connect(function()
                state = not state
                Switch.BackgroundColor3 = state and Color3.fromRGB(0, 180, 90) or Color3.fromRGB(50, 50, 55)
                Dot.Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
                callback(state)
            end)
        end

        -- FUNGSI APINYA: BIKIN BUTTON
        function TabObj:CreateButton(Config)
            local text = Config.Name or "Button"
            local callback = Config.Callback or function() end

            local BtnElm = Instance.new("TextButton", Page)
            BtnElm.Size = UDim2.new(0.95, 0, 0, 42)
            BtnElm.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
            BtnElm.Text = "   " .. text
            BtnElm.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnElm.Font = Enum.Font.GothamBold
            BtnElm.TextSize = 13
            BtnElm.TextXAlignment = "Left"
            Instance.new("UICorner", BtnElm).CornerRadius = UDim.new(0, 6)
            local Stroke = Instance.new("UIStroke", BtnElm); Stroke.Color = Color3.fromRGB(240, 240, 245); Stroke.Thickness = 1

            BtnElm.MouseButton1Click:Connect(function()
                BtnElm.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                callback()
                task.wait(0.1)
                BtnElm.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
            end)
        end

        return TabObj
    end

    return WindowObj
end

return RyosenLib
