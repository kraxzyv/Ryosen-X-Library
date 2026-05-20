-- [[ RYOSEN UI LIBRARY ENGINE - V2.5 (TOTAL FIX) ]] --
-- [[ CREATOR: KRAXZYV / VANNDERL ]] --

local RyosenLib = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

function RyosenLib:CreateWindow(Config)
    local HubName = Config.Name or "RYOSEN HUB"
    local WebhookUrl = Config.Webhook or ""
    
    -- Bersihin UI lama kalo ada biar gak tumpang tindih
    if CoreGui:FindFirstChild("RyosenHub_Ultimate") then 
        CoreGui.RyosenHub_Ultimate:Destroy() 
    end

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "RyosenHub_Ultimate"
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.ResetOnSpawn = false
    Gui.Parent = CoreGui

    -- =======================================================
    -- [[ 1. RAYFIELD-STYLE LOADING SCREEN (LANGSUNG JALAN) ]] --
    -- =======================================================
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Name = "LoadingFrame"
    LoadingFrame.Size = UDim2.new(0, 360, 0, 160)
    LoadingFrame.Position = UDim2.new(0.5, -180, 0.5, -80)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    LoadingFrame.BorderSizePixel = 0
    LoadingFrame.Visible = true
    LoadingFrame.Parent = Gui
    Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 10)
    
    local LoadStroke = Instance.new("UIStroke", LoadingFrame)
    LoadStroke.Color = Color3.fromRGB(45, 45, 50)
    LoadStroke.Thickness = 1.5

    local LoadTitle = Instance.new("TextLabel", LoadingFrame)
    LoadTitle.Size = UDim2.new(1, 0, 0, 50)
    LoadTitle.Position = UDim2.new(0, 0, 0, 25)
    LoadTitle.Text = "RYOSEN" -- Tetap RYOSEN sesuai request lu, Bos!
    LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadTitle.Font = Enum.Font.GothamBold
    LoadTitle.TextSize = 32
    LoadTitle.BackgroundTransparency = 1

    local BarBg = Instance.new("Frame", LoadingFrame)
    BarBg.Size = UDim2.new(0.8, 0, 0, 6)
    BarBg.Position = UDim2.new(0.1, 0, 0, 90)
    BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    BarBg.BorderSizePixel = 0
    Instance.new("UICorner", BarBg)

    local BarFill = Instance.new("Frame", BarBg)
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
    BarFill.BorderSizePixel = 0
    Instance.new("UICorner", BarFill)

    local PercentText = Instance.new("TextLabel", LoadingFrame)
    PercentText.Size = UDim2.new(1, 0, 0, 20)
    PercentText.Position = UDim2.new(0, 0, 0, 110)
    PercentText.Text = "Loading... 0%"
    PercentText.TextColor3 = Color3.fromRGB(140, 140, 145)
    PercentText.Font = Enum.Font.Gotham
    PercentText.TextSize = 13
    PercentText.BackgroundTransparency = 1

    -- =======================================================
    -- [[ 2. MAIN WINDOW DESIGN (STRUKTUR UI UTAMA) ]] --
    -- =======================================================
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 580, 0, 440)
    Main.Position = UDim2.new(0.5, -290, 0.5, -220)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Visible = false -- Sembunyi pas loading screen jalan
    Main.Parent = Gui
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
    local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Color3.fromRGB(240, 240, 245); MainStroke.Thickness = 1.5

    -- FLOATING MINI BAR
    local MiniBar = Instance.new("TextButton")
    MiniBar.Name = "MiniBar"
    MiniBar.Size = UDim2.new(0, 240, 0, 44) 
    MiniBar.Position = UDim2.new(0.5, -120, 0, 25)
    MiniBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    MiniBar.Text = HubName 
    MiniBar.TextColor3 = Color3.fromRGB(225, 225, 230) 
    MiniBar.Font = Enum.Font.GothamBold
    MiniBar.TextSize = 14
    MiniBar.TextWrapped = true 
    MiniBar.Visible = false 
    MiniBar.Active = true
    MiniBar.Draggable = true
    MiniBar.Parent = Gui
    Instance.new("UICorner", MiniBar).CornerRadius = UDim.new(0, 6)
    local MiniBarStroke = Instance.new("UIStroke", MiniBar); MiniBarStroke.Color = Color3.fromRGB(225, 225, 230); MiniBarStroke.Thickness = 1.5

    -- Tombol Minimize (-)
    local MinBtn = Instance.new("TextButton", Main)
    MinBtn.Size = UDim2.new(0, 28, 0, 28)
    MinBtn.Position = UDim2.new(1, -38, 0, 10)
    MinBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 16
    Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)
    local MinBtnStroke = Instance.new("UIStroke", MinBtn); MinBtnStroke.Color = Color3.fromRGB(240, 240, 245); MinBtnStroke.Thickness = 1

    MinBtn.MouseButton1Click:Connect(function() Main.Visible = false; MiniBar.Visible = true end)
    MiniBar.MouseButton1Click:Connect(function() MiniBar.Visible = false; Main.Visible = true end)

    -- SIDEBAR
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Sidebar.BorderSizePixel = 0
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)
    
    local SideLayout = Instance.new("UIListLayout", Sidebar)
    SideLayout.Padding = UDim.new(0, 6)
    SideLayout.HorizontalAlignment = "Center"

    local Brand = Instance.new("TextLabel", Sidebar)
    Brand.Size = UDim2.new(0.85, 0, 0, 45)
    Brand.Text = HubName
    Brand.TextColor3 = Color3.fromRGB(255, 255, 255)
    Brand.Font = Enum.Font.GothamBold
    Brand.TextSize = 14
    Brand.TextXAlignment = "Left"
    Brand.BackgroundTransparency = 1

    -- CONTAINER TABS
    local Container = Instance.new("Frame", Main)
    Container.Size = UDim2.new(1, -180, 1, -60)
    Container.Position = UDim2.new(0, 170, 0, 45)
    Container.BackgroundTransparency = 1

    -- PROFILE BANNER AVATAR
    local Profile = Instance.new("Frame", Sidebar)
    Profile.Size = UDim2.new(0.9, 0, 0, 75) 
    Profile.Position = UDim2.new(0.05, 0, 1, -85)
    Profile.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
    Instance.new("UICorner", Profile).CornerRadius = UDim.new(0, 8)

    local Avatar = Instance.new("ImageLabel", Profile)
    Avatar.Size = UDim2.new(0, 40, 0, 40) 
    Avatar.Position = UDim2.new(0, 8, 0, 10)
    Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LocalPlayer.UserId.."&w=150&h=150"
    Avatar.BackgroundTransparency = 1
    Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

    local UserText = Instance.new("TextLabel", Profile)
    UserText.Size = UDim2.new(1, -60, 0, 36) 
    UserText.Position = UDim2.new(0, 54, 0, 12) 
    UserText.Text = LocalPlayer.DisplayName .. "\n@" .. LocalPlayer.Name
    UserText.TextColor3 = Color3.new(1, 1, 1)
    UserText.Font = Enum.Font.GothamBold
    UserText.TextSize = 10 
    UserText.TextXAlignment = "Left"
    UserText.BackgroundTransparency = 1

    -- =======================================================
    -- [[ 3. SISTEM ASYNC LOGIC JALAN PARALEL ]] --
    -- =======================================================
    
    -- Jalankan Webhook secara terpisah total biar anti-stuck
    task.spawn(function()
        if WebhookUrl and WebhookUrl ~= "" and string.find(WebhookUrl, "http") then
            pcall(function()
                local req = syn and syn.request or http_request or request or (HttpService and HttpService.Request)
                if req then
                    req({
                        Url = WebhookUrl,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = HttpService:JSONEncode({ content = "🚀 Ui Library Has Execution" })
                    })
                end
            end)
        end
    end)

    -- Animasi Loading Screen
    task.spawn(function()
        for i = 1, 100 do
            BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
            PercentText.Text = "Loading... " .. i .. "%"
            task.wait(0.015)
        end
        task.wait(0.1)
        LoadingFrame:Destroy()
        Main.Visible = true
    end)

    -- Toggle via RightShift
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightShift then
            if Main.Visible then Main.Visible = false; MiniBar.Visible = false else Main.Visible = true; MiniBar.Visible = false end
        end
    end)

    local WindowObj = {}
    local FirstTab = true

    function WindowObj:CreateTab(TabName)
        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = FirstTab
        Page.ScrollBarThickness = 0
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.Parent = Container
        
        local Layout = Instance.new("UIListLayout", Page)
        Layout.Padding = UDim.new(0, 8)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
        end)
        
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
            for _, p in pairs(Container:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            for _, b in pairs(Sidebar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.TextColor3 = Color3.fromRGB(180, 180, 180); b.UIStroke.Color = Color3.fromRGB(45, 45, 50) end end
            Page.Visible = true
            Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            Btn.TextColor3 = Color3.new(1, 1, 1)
            Btn.UIStroke.Color = Color3.fromRGB(240, 240, 245)
        end)

        FirstTab = false
        local TabObj = {}

        function TabObj:CreateButton(Config)
            local text = Config.Name or "Button"
            local callback = Config.Callback or function() end

            local BtnElm = Instance.new("TextButton", Page)
            BtnElm.Size = UDim2.new(0.95, 0, 0, 40)
            BtnElm.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
            BtnElm.Text = "   " .. text
            BtnElm.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnElm.Font = Enum.Font.GothamBold
            BtnElm.TextSize = 12
            BtnElm.TextXAlignment = "Left"
            Instance.new("UICorner", BtnElm).CornerRadius = UDim.new(0, 6)
            local Stroke = Instance.new("UIStroke", BtnElm); Stroke.Color = Color3.fromRGB(60, 60, 65); Stroke.Thickness = 1

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
