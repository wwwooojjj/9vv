----- Script -----
local Script = {
	Version = "1.0";
	VersionType = "BETA";
	RandomFooters = { 
		'Originaly known as "gamesense"';
		"Never Stress 😉";
		"Not pasted!";
	};
	LoadTime = os.clock();
	ReachClipboard = {
		InfiniteReach = false; OwnerCheck = false;
		ReachSizeX = 0; ReachSizeY = 0; ReachSizeZ = 0;
		ReachOffsetX = 0; ReachOffsetY = 0; ReachOffsetZ = 0;
		ReachRotationX = 0; ReachRotationY = 0; ReachRotationZ = 0;
		ReachShape = "Block";
	};

	Connections = {};
	Storage = {
		Balls = {};
		BallPrediction = {};
		HomboloMacro = {A1 = nil; Align = nil;};
	};
}

-- Fixes
local cloneref = cloneref or clonereference or function(instance) return instance end
local getgenv = getgenv or function() return shared end
local protectgui = protectgui or (syn and syn.protect_gui) or function() end
local gethui = gethui or function() return CoreGui end
local gethwid = gethwid or function() return game:GetService("RbxAnalyticsService"):GetClientId() end
local request = request or (syn and syn.request) or function() end

-- Libraries
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()

-- Services
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local TweenService = cloneref(game:GetService("TweenService"))
local HttpService = cloneref(game:GetService("HttpService"))
local CoreGui = cloneref(game:GetService("CoreGui"))

-- Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local BallsFolder = workspace:FindFirstChild("Balls", true) or nil

----- UI -----
local Toggles = Library.Toggles
local Options = Library.Options

-- Intro
local function SafeParentUI(Instance, Parent)
	local success, error = pcall(function()
		if not Parent then
			Parent = CoreGui
		end

		if typeof(Parent) == "function" then
			Instance.Parent = Parent()
		else
			Instance.Parent = Parent
		end
	end)

	if not (success and Instance.Parent) then
		Instance.Parent = Library.LocalPlayer:WaitForChild("PlayerGui", math.huge)
	end
end

local function ParentUI(UI, SkipHiddenUI)
	if SkipHiddenUI then
		SafeParentUI(UI, CoreGui)
		return
	end

	pcall(protectgui, UI)
	SafeParentUI(UI, gethui)
end
if not getgenv().vv_skipintro then
	local IntroGUI = Instance.new("ScreenGui"); IntroGUI.Name = HttpService:GenerateGUID(true); IntroGUI.IgnoreGuiInset = true
	local IntroBackground = Instance.new("Frame"); IntroBackground.Name = HttpService:GenerateGUID(true); IntroBackground.BackgroundColor3 = Color3.new(0, 0, 0); IntroBackground.BackgroundTransparency = 1; IntroBackground.Size = UDim2.fromScale(1, 1); IntroBackground.Parent = IntroGUI
	local IntroFrame = Instance.new("Frame"); IntroFrame.Name = HttpService:GenerateGUID(true); IntroFrame.AnchorPoint = Vector2.new(0, 0.5); IntroFrame.BackgroundTransparency = 1; IntroFrame.Position = UDim2.fromScale(0, 0.5); IntroFrame.Size = UDim2.fromScale(1, 0.2); IntroFrame.ClipsDescendants = true; IntroFrame.Parent = IntroGUI
	local IntroImage = Instance.new("ImageLabel"); IntroFrame.Name = HttpService:GenerateGUID(true); IntroImage.BackgroundTransparency = 1; IntroImage.Size = UDim2.fromScale(1, 1); IntroImage.Position = UDim2.fromScale(0, 1); IntroImage.Image = "rbxassetid://138587191422287"; IntroImage.ImageColor3 = Color3.new(0.5, 0, 1); IntroImage.ScaleType = Enum.ScaleType.Fit; IntroImage.Parent = IntroFrame
	ParentUI(IntroGUI)
	TweenService:Create(IntroBackground, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.5}):Play(); task.wait(0.5)
	TweenService:Create(IntroImage, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {Position = UDim2.fromScale(0, 0)}):Play(); task.wait(2)
	TweenService:Create(IntroFrame, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.fromScale(-1, 0.5)}):Play()
	TweenService:Create(IntroImage, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = UDim2.fromScale(1, 0)}):Play(); task.wait(1)
	TweenService:Create(IntroBackground, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play(); task.wait(1)
	IntroGUI:Destroy()
end

-- UI Creation
local Window = Library:CreateWindow({
	Title = "9vv.cc";
	Footer = "made by: @__woj | V: "..Script.Version.."-"..string.sub(Script.VersionType, 1, 1).." | "..Script.RandomFooters[math.random(1, #Script.RandomFooters)];
	ToggleKeybind = Enum.KeyCode.Insert;
	ShowCustomCursor = false;
	Icon = 86221982170775;
	Compact = true;
})

-- Login
local ACD1 = "DA2BMWWBH8DKSJEJATVF7IRFZOP239OM"; local ACD2 = "1ACF3TWA4ZBJYP0XLN77UKIGFYA40XPN"; local ACD3 = "PQCG78WRMUA67JEX1T0MCDRURTJTI4QW"; local ACD4 = "Z057CLEULGLM0H5SH7G4HEQH5V9M065L"; local ACD5 = "4U4F8FJ7YJLBBF9Q1QWAZLZMSET31IMO"; local ACD6 = "OLIPG48HQ35SWO7YJ8ODSW2NO9V4G9HR"; local ACD7 = "A1APW2WQW90B8O21LUCYMK9WJ3EHHEH7"; local ACD8 = "NDEIKDHNB4LJ474S1NNWD2NF9TUKEV82"; local ACD9 = "RU8OJZFA0E7K49KJPM4BY0123HSJIYP4"; local ACD10 = "7GJY85XLDLXG0UHAFZNNQ0HYRWD0E5PY"; local ACD11 = "8B69N7XDVEVWOXSU3I951846JEC2EYOH"; local ACD12 = "U5WK4IE6FNYURR7CG7S9M55X3TVO1H4X"; local ACD13 = "KD7YMJZXL8AF9OJ0TONFU4RLJJ3IT5N8"; local ACD14 = "20MPFY20XRHQVIBC1VTL45J8BACVV3A4"; local ACD15 = "JSHWUKG7D94N4B6ZPN3PHYY10IS6GJR1"; local ACD16 = "G9CUQXGYOSMLBFLPZ6AS2FS3D93723PY"; local ACD17 = "44PPSXD88BSH7LGQISOY94TW0GTXEW2B"; local ACD18 = "8T217LKC77B2M57FAEUKPWGPSSUW54YR"; local ACD19 = "E1UOW8AIXDHABDJOV35O1RD2IHFHCZ3V"; local ACD20 = "JQQF3E4A5MPBN3IKH0TWRBS8FAW4E7O9"; local ACD21 = "PF7VJUHK8A53ORNCJMEIGEUDUIHGJCCK"; local ACD22 = "I39WNPXES8OT3BNPS35YZ2KZBOJGVS1G"; local ACD23 = "28W391VPJ2B35Z3553D2LD49O9X21CRB"; local ACD24 = "SWIM5KYYV93O9FXAPASMHCFMR0TA7HU4"; local ACD25 = "BHQZFRXYF437777MTXEHF8PYVD3YTD3F"; local ACD26 = "OGG7CKCQN3HIPFRDENSXNZU5JM7RHYRB"; local ACD27 = "XCTKYYKUDVH3VT62WFXJSM08QAS11XXN"; local ACD28 = "KCR2GD25B2H8BWUL8S220LDRTQHVZN7K"; local ACD29 = "9MG6SUJ4JQEDOVTS31C1QWWTBLLWY4A2"; local ACD30 = "MSIBAEAJ9KU0MX201562PAS75OC2RP1H"; local ACD31 = "EIDSI9VQFKSUOCGWA4TW1T8TO6B2LVJL"; local ACD32 = "T8P8C9J4LN6XMHRRW4H2BY68VG7FT7YW"; local ACD33 = "VXNKIK1KM8OH3N8MK3RGXZKEVV1F7VUO"; local ACD34 = "P8G39OJOUIPZ0KJ97PVGPC70OB9AXUC5"; local ACD35 = "XNPPD9GAVLCEZI45QAGQLZ4KBB2PVY6A"; local ACD36 = "VZLV62H4WFMHEGK9473L7A2MN7H9G53R"; local ACD37 = "LT8N5FX5UDKYK5EU6GAZKJPYSGBWZ8W0"; local ACD38 = "VMBXQT2KVTZLFHTZSGBJ8XEWQG0U8VNH"; local ACD39 = "2O3BF1VXK1G4F9L1F2VQR8G354JJEQXU"; local ACD40 = "8L52TG6JZNRLWEGTT2JRF8GE4X1HRHWS"; local ACD41 = "TCP1JCMP0AXJ8LCLZJ7XNFEXYRHDQWJ2"; local ACD42 = "PSIBQFIVXWH025M30RVT7VS6OHRL2MMG"; local ACD43 = "4I1VDUSTOUJ2I3H3DKQJZWWJGEF8TDS3"; local ACD44 = "76H2DZV3OREJZZGS8X0DJMCT9BAC0P5R"; local ACD45 = "F7RFDNEO20T1D1XYL20SPBAAEQR1RKJE"; local ACD46 = "KG4M7FBYIQ00F8ACFBS8CE7K95T9QECB"; local ACD47 = "H6IAXIA4ANMUPYXZMPP4ELTZEGCYJXI3"; local ACD48 = "0PHQDIU1WDE5TKLUFNJN9Z0AAP6VM6JT"; local ACD49 = "3CE8EXL1W61R0BKT5HK2P5TQGV7G9PUD"; local ACD50 = "6QM2AKA7U1N4XBEH4FRK3ZWWH8LNE8OJ"; local ACD51 = "3P5N6GL9Q5INGL2C23IK5TWHCPI07R74"; local ACD52 = "TO489250KK9H1KT0R6KOO8CPZ5GB8OUH"; local ACD53 = "NG53CJ8SS4UKPYXFRRGIKWQD59KV2TNB"; local ACD54 = "4P7UXNEEVFVRED7OSXAFJRLN3PDBS4S4"; local ACD55 = "M5EA3FN1IIKS8PWDLNZCP1FF4PNMREA7"; local ACD56 = "ONZHJQIXG8N4EZ9BXBIYHETWGF2IN5AF"; local ACD57 = "R97TR96KR1191H9NO7044QKUSCL8SCJA"; local ACD58 = "B0VG4951EA9NK4OTUUDKO079N9RI4DFK"; local ACD59 = "2RY0A2APX0IBYO3LWG021JZ0BTF8TQJ2"; local ACD60 = "6BFKT4BTF5GP4Z1R4NVWZX8BTB1NZQDX"; local ACD61 = "KW2EKPQFDPXY9EZ9O5ONF6WN4F07WWEU"; local ACD62 = "B29NPSU1EZK2G498QL3ADRYYKKUXFFOS"; local ACD63 = "31L8VPCE2H5NPPBFYJVN5X3YO9XDYOTQ"; local ACD64 = "4YC8EXRT98CF6TXA2BUAP6L7ECUAI6TZ"; local ACD65 = "KJG7IORZ3U6BX7C1G0CUZRJX76Y04O2U"; local ACD66 = "6TBWWP4UDN2TLX6WMZWMU6QPA619J3V8"; local ACD67 = "MBE0SW240U66Y5TWNF658XMJ8UVBLBW6"; local ACD68 = "7WIYH61P5PKYL0VJLSCPXSGKI3SPNBNR"; local ACD69 = "Z4NEHB32J700UA74Z36H959QH71489V0"; local ACD70 = "0L4HYUA8WEBWHGN4KWME2NRG1Q5SQ8C0"; local ACD71 = "RLQ0ND8G1FVWO0VSL9WSNF8B5W0PFWU9"; local ACD72 = "0N60N3ZO3FEMX4GQK825CM3FSGKVDWRD"; local ACD73 = "44YI1GSEJGPGH43VZ6AQS7YASNO9EV3N"; local ACD74 = "1BT41YQ83AD1G2V225M7ISIN6G3R7XW5"; local ACD75 = "G0VSY3ZFQOX41V8TMJZQ0A6EXG8TCUHY"; local ACD76 = "JL43ZS61T4QHV6OZFLGQAXHFQGTP84EB"; local ACD77 = "3W2F62C1VJ77W0S77ZTZPQB939KS5V58"; local ACD78 = "LJJBW7LJV3KLQWNJA30MWVJ7P784ZWP5"; local ACD79 = "V544028MIHZ2P5AOK12KILUASJ10C8TU"; local ACD80 = "ONNBBOQSPRB41OTWDYYREFVGA871H6IU"; local ACD81 = "VA5BGQAM0NEGR89ML6KJI5I36C81GIQA"; local ACD82 = "UM20GYQ446S8PKO00RVFLQYJ2ZZF0UU8"; local ACD83 = "GW7DFGNLRBUAK4NSOJLFN419QG6D1LWC"; local ACD84 = "DKK1OUCI5O7LFF1YEWK4ETHOSQFHSAP6"; local ACD85 = "BL3TJVMD18MMPA5ZU14PZDWAU8S48DH9"; local ACD86 = "62YD98982TYBHP5XTNLSR2DH29PQ9GXB"; local ACD87 = "LWDNG39UQNMTUA8RF13QPWTCGJ4WX4WZ"; local ACD88 = "S0VU0JWNEIJ8B13IECFFV9321TCUPQT3"; local ACD89 = "0N31GDLRE5YBOD96D9XXF5DPCQAMYXIX"; local ACD90 = "R2M3KGTJ03787BSY439W5JYWF1XY5N6U"; local ACD91 = "IKUQ4H9V8RS6HKYM4S5DJB6KHX9TT74M"; local ACD92 = "ZLPCO4MFM4R3EIFZHH6ZKMB52ACV5NXX"; local ACD93 = "01WY1U3YCVBW0XNSEIYLZ0WJ0G89PUXK"; local ACD94 = "7KZZ87LA8R3SZ6IGVHATVFVHREWXY94R"; local ACD95 = "7JBL7Z9MRI31G31FP09CCLZ1QZJIN1PB"; local ACD96 = "99J88LYGHTNX3YSYPUE50J4PI6ZC96V0"; local ACD97 = "PAR9842WWJ5ZDWPSYMWNF1T9QTCSSE2M"; local ACD98 = "9YZNEFD65MYR8XGVLLIAQR6ZLH1M7XEC"; local ACD99 = "HUXBIB6U87XW7RVX05AUVQRVRQ7KEWQ0"; local ACD100 = "RIFM1U0SLKH5JWCRXJCFWPP0LZTKE22O";
local LoginTab = Window:AddKeyTab("Login", "key")
LoginTab:AddKeyBox(function(Success, ReceivedKey)
	local AuthInit = HttpService:JSONDecode(game:HttpGet("https://keyauth.win/api/1.3/?type=init&ver=&name=9vv&ownerid=ELOz6WTyfA"))

	if AuthInit.success then
		local AuthLogin = HttpService:JSONDecode(game:HttpGet("https://keyauth.win/api/1.3/?type=license&key="..ReceivedKey.."&sessionid="..AuthInit.sessionid.."&name=9vv&ownerid=ELOz6WTyfA&hwid="..gethwid()))
		if AuthLogin.success then
			ACD58 = "U1BKTLOYOXIYP3A2KIRPZH8EKHK4MABT"
		else
			Library:Notify(AuthLogin.message, 3)
		end
	else
		Library:Notify(AuthInit.message or "Unknown Error", 3)
	end
end)
repeat task.wait() until ACD58 == "U1BKTLOYOXIYP3A2KIRPZH8EKHK4MABT"
Script.LoadTime = os.clock()

Library:SetWatermark("9vv.cc | Version "..Script.Version.."-"..string.sub(Script.VersionType, 1, 1))
Library:SetWatermarkVisibility(true)

local HomeTab = Window:AddTab("Home", "house")
local ReachTab = Window:AddTab("Reach", "footprints")
local VisualsTab = Window:AddTab("Visuals", "eye")
local CharacterTab = Window:AddTab("Character", "user")
local ConfigrationTab = Window:AddTab("Configuration", "settings")

-- Home
local HomeGroupbox = HomeTab:AddLeftGroupbox("Hello "..LocalPlayer.DisplayName.."!", "hand")
HomeGroupbox:AddLabel("Thank you for using our script!")
HomeGroupbox:AddDivider()
HomeGroupbox:AddLabel("Script Version:", false)
HomeGroupbox:AddLabel('<font color="rgb(155, 255, 255)">'..Script.Version.." "..Script.VersionType..'</font>', false)

-- Reach
local ReachMainGroupbox = ReachTab:AddLeftGroupbox("Main", "volleyball")
ReachMainGroupbox:AddCheckbox("ReachEnabled", {Text = "Enabled";})
local ReachMainBox = ReachMainGroupbox:AddDependencyBox()
ReachMainBox:AddCheckbox("ReachVisualizer", {
	Text = "Visualizer";
}):AddColorPicker("ReachVisualizerColor", {
	Title = "Visualizer Color";
	Default = Color3.new(1, 1, 1);
	Transparency = 0.5;
})
ReachMainBox:SetupDependencies({{Toggles.ReachEnabled, true};})

local ReachTabbox = ReachTab:AddRightTabbox("Reach", "wrench")
local function CreateReachTab(Name)
	local Tab = ReachTabbox:AddTab(Name)
	Tab:AddCheckbox(Name.."ReachEnabled", {Text = "Enabled";})
	local Box = Tab:AddDependencyBox()

	Box:AddCheckbox(Name.."InfiniteReach", {
		Text = "Infinite";
		Risky = true;
	})
	Box:AddCheckbox(Name.."OwnerCheck", {Text = "Owner Check";})
	Box:AddDivider()
	Box:AddSlider(Name.."ReachSizeX", {
		Text = "Size X";
		Min = 0;
		Max = 10;
		Rounding = 1;
		Compact = true;
	})
	Box:AddSlider(Name.."ReachSizeY", {
		Text = "Size Y";
		Min = 0;
		Max = 10;
		Rounding = 1;
		Compact = true;
	})
	Box:AddSlider(Name.."ReachSizeZ", {
		Text = "Size Z";
		Min = 0;
		Max = 10;
		Rounding = 1;
		Compact = true;
	})
	Box:AddDivider()
	Box:AddSlider(Name.."ReachOffsetX", {
		Text = "Offset X";
		Min = -5;
		Max = 5;
		Rounding = 1;
		Compact = true;
	})
	Box:AddSlider(Name.."ReachOffsetY", {
		Text = "Offset Y";
		Min = -5;
		Max = 5;
		Rounding = 1;
		Compact = true;
	})
	Box:AddSlider(Name.."ReachOffsetZ", {
		Text = "Offset Z";
		Min = -5;
		Max = 5;
		Rounding = 1;
		Compact = true;
	})
	Box:AddDivider()
	Box:AddSlider(Name.."ReachRotationX", {
		Text = "Rotation X";
		Min = -180;
		Max = 180;
		Compact = true;
	})
	Box:AddSlider(Name.."ReachRotationY", {
		Text = "Rotation Y";
		Min = -180;
		Max = 180;
		Compact = true;
	})
	Box:AddSlider(Name.."ReachRotationZ", {
		Text = "Rotation Z";
		Min = -180;
		Max = 180;
		Compact = true;
	})
	Box:AddDivider()
	Box:AddDropdown(Name.."ReachShape", {
		Text = "Shape";
		Values = {"Ball", "Block", "Cylinder"};
		Default = "Block";
	})

	Box:AddButton({
		Text = "Copy Configuration";
		Func = function()
			Script.ReachClipboard = {
				InfiniteReach = Toggles[Name.."InfiniteReach"].Value; OwnerCheck = Toggles[Name.."OwnerCheck"].Value;
				ReachSizeX = Options[Name.."ReachSizeX"].Value; ReachSizeY = Options[Name.."ReachSizeY"].Value; ReachSizeZ = Options[Name.."ReachSizeZ"].Value;
				ReachOffsetX = Options[Name.."ReachOffsetX"].Value; ReachOffsetY = Options[Name.."ReachOffsetY"].Value; ReachOffsetZ = Options[Name.."ReachOffsetZ"].Value;
				ReachRotationX = Options[Name.."ReachRotationX"].Value; ReachRotationY = Options[Name.."ReachRotationY"].Value; ReachRotationZ = Options[Name.."ReachRotationZ"].Value;
				ReachShape = Options[Name.."ReachShape"].Value;
			};
		end;
	})
	Box:AddButton({
		Text = "Paste Configuration";
		Func = function()
			for ID, Configuration in pairs(Script.ReachClipboard) do
				if not pcall(function()
						Toggles[Name..ID]:SetValue(Configuration)
					end)
				then
					Options[Name..ID]:SetValue(Configuration)
				end
			end
		end;
	})

	Box:SetupDependencies({{Toggles[Name.."ReachEnabled"], true};})
end
for ID, Tab in pairs({"Shoot", "Pass", "Long", "Tackle", "Dribble", "Save"}) do
	CreateReachTab(Tab)
end

-- Visuals
local VisualsPredictionGroupbox = VisualsTab:AddLeftGroupbox("Prediction", "volleyball")
VisualsPredictionGroupbox:AddCheckbox("BallPredictionEnabled", {
	Text = "Ball Prediction";
}):AddColorPicker("BallPredictionColor0", {
	Title = "Ball Prediction Color 0";
	Default = Color3.new(1, 1, 1);
	Transparency = 0;
}):AddColorPicker("BallPredictionColor1", {
	Title = "Ball Prediction Color 1";
	Default = Color3.new(1, 1, 1);
	Transparency = 0;
})
local VisualsPredictionBox = VisualsPredictionGroupbox:AddDependencyBox()
VisualsPredictionBox:AddSlider("BallPredictionThreshold", {
	Text = "Velocity Threshold";
	Default = 25;
	Min = 1;
	Max = 100;
})
VisualsPredictionBox:AddDivider()
VisualsPredictionBox:AddSlider("BallPredictionSize0", {
	Text = "Trail Size 0";
	Default = 0.2;
	Min = 0;
	Max = 5;
	Rounding = 2;
})
VisualsPredictionBox:AddSlider("BallPredictionSize1", {
	Text = "Trail Size 1";
	Default = 0.2;
	Min = 0;
	Max = 5;
	Rounding = 2;
})
VisualsPredictionBox:SetupDependencies({{Toggles.BallPredictionEnabled, true};})

local VisualsDesyncGroupbox = VisualsTab:AddLeftGroupbox("Desync", "network")
VisualsDesyncGroupbox:AddCheckbox("DesyncVisualizerEnabled", {
	Text = "Desync Visualizer";
}):AddColorPicker("DesyncVisualizerColor", {
	Title = "Desync Visualizer Color";
	Default = Color3.new(1, 1, 1);
	Transparency = 0.5;
})

-- Character
local CharacterHumanoidGroupbox = CharacterTab:AddLeftGroupbox("Humanoid", "user")
CharacterHumanoidGroupbox:AddCheckbox("WalkSpeedEnabled", {Text = "CFrame WalkSpeed";})
local CharacterHumanoidBox = CharacterHumanoidGroupbox:AddDependencyBox()
CharacterHumanoidBox:AddSlider("WalkSpeedSlider", {
	Text = "WalkSpeed";
	Min = 0;
	Max = 20;
	Rounding = 1;
})
CharacterHumanoidBox:SetupDependencies({{Toggles.WalkSpeedEnabled, true};})

local CharacterMacroGroupbox = CharacterTab:AddRightGroupbox("Macro", "workflow")
CharacterMacroGroupbox:AddCheckbox("HomboloMacro", {Text = "Hombolo Macro";})
	:AddKeyPicker("HomboloMacroKeybind", {
		Text = "Keybind";
		Default = "F1";
		SyncToggleState = true;
	})
CharacterMacroGroupbox:AddCheckbox("PowerShoot", {Text = "Power Shoot";})
	:AddKeyPicker("PowerShootKeybind", {
		Text = "Keybind";
		Default = "F2";
	})
CharacterMacroGroupbox:AddSlider("PowerShootPower", {
	Text = "Power Shoot Power";
	Default = 500;
	Min = 100;
	Max = 1000;
})

-- Configuration
local ConfigurationInterfaceGroupbox = ConfigrationTab:AddLeftGroupbox("Interface", "group")
ConfigurationInterfaceGroupbox:AddLabel("Menu Keybind")
	:AddKeyPicker("MenuKeybind", {
		Text = "Keybind";
		Default = "Insert";
		NoUI = true;
	})
ConfigurationInterfaceGroupbox:AddCheckbox("WatermarkEnabled", {
	Text = "Watermark";
	Default = true;
})
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
SaveManager:SetFolder("9vv")
SaveManager:BuildConfigSection(ConfigrationTab)
SaveManager:LoadAutoloadConfig()
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("9vv")
ThemeManager:ApplyToTab(ConfigrationTab)
ThemeManager:LoadDefault()





------ Functionality -----
-- Functions
local ReachBox = Instance.new("Part")
ReachBox.Name = HttpService:GenerateGUID(true)
ReachBox.CastShadow = false
ReachBox.Material = Enum.Material.SmoothPlastic
ReachBox.CanCollide = false
ReachBox.CanQuery = false
ReachBox.CanTouch = false
ReachBox.AudioCanCollide = false
ReachBox.Anchored = true
ReachBox.Parent = workspace
local function RemoveReachBox()
	ReachBox.Size = Vector3.new(0, 0, 0)
	ReachBox.CFrame = CFrame.new(math.huge, math.huge, math.huge)
	ReachBox.Transparency = 1
end

local DesyncBox = Instance.new("Part")
DesyncBox.Name = HttpService:GenerateGUID(true)
DesyncBox.CastShadow = false
DesyncBox.Material = Enum.Material.SmoothPlastic
DesyncBox.Size = Vector3.new(4, 5, 1)
DesyncBox.CanCollide = false
DesyncBox.CanQuery = false
DesyncBox.CanTouch = false
DesyncBox.AudioCanCollide = false
DesyncBox.Anchored = true
DesyncBox.Parent = workspace

local function CreatePrediction(Ball)
	local A0 = Instance.new("Attachment")
	A0.Parent = workspace.Terrain
	local A1 = Instance.new("Attachment")
	A1.Parent = workspace.Terrain
	local Beam = Instance.new("Beam")
	Beam.Brightness = 10
	Beam.LightInfluence = 0
	Beam.TextureSpeed = 0
	Beam.Transparency = NumberSequence.new(0)
	Beam.Attachment0 = A0
	Beam.Attachment1 = A1
	Beam.FaceCamera = true
	Beam.Segments = 1
	Beam.Width0 = 0.2
	Beam.Width1 = 0.2
	Beam.Parent = workspace.Terrain
	Script.Storage.BallPrediction[Ball] = {
		A0 = A0;
		A1 = A1;
		Beam = Beam;
	}
end

local function quadraticSolver(a, b, c)
	local x1 = (-b + math.sqrt((b*b) -4 * a * c)) / (2 * a)
	local x2 = (-b - math.sqrt((b*b) -4 * a * c)) / (2 * a)
	return x2 > x1 and x2 or x1
end
local function findTimeAtHeight(a, vel, h, startingH)
	local x = h - startingH
	local x1 = (math.sqrt((vel * vel) + 2 * a * x ) - vel) / a
	local x2 = -(math.sqrt((vel * vel) + 2 * a * x) + vel) / a
	return x2 > x1 and x2 or x1
end
local function findHeightAtTime(vel, t)
	return vel.Y * t + 0.5 * -workspace.Gravity * (t*t)
end
local function findPositionAtTime(vel, t, startingPos)
	local height = findHeightAtTime(vel, t)
	return startingPos + Vector3.new(vel.X * t, height, vel.Z * t)
end
local function findPositionAtHeight(vel, t, startingPos, height)
	return startingPos + Vector3.new(vel.X * t, height, vel.Z * t)
end
local function findLandingPosition(Vo, startingPosition)
	local acc = -workspace.Gravity
	local seconds = quadraticSolver((0.5 * acc), Vo.Y, startingPosition.Y)
	local lastPosition = startingPosition

	local nextPosition = findPositionAtTime(Vo, seconds, startingPosition)

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {Script.Storage.Balls}
	params.RespectCanCollide = true
	local result = workspace:Raycast(lastPosition, (nextPosition - lastPosition), params)
	if result then
		local baseHeight = result.Position.Y
		local timeAtHeight = findTimeAtHeight(acc, Vo.Y, baseHeight, startingPosition.Y)
		local offset = findPositionAtTime(Vo, timeAtHeight, startingPosition)
		return offset
	end
	lastPosition = nextPosition

	local horizontalVel = Vector3.new(Vo.X, 0, Vo.Z)
	local endingOffset = horizontalVel * seconds
	return startingPosition + endingOffset + Vector3.new(0, findHeightAtTime(Vo, seconds), 0)
end

-- Events
LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
	Character = NewCharacter
	Humanoid = Character:WaitForChild("Humanoid")
	HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

local Reaching = false
RunService.Heartbeat:Connect(function(DeltaTime)
	if Character and HumanoidRootPart then
		if Toggles.ReachEnabled.Value then
			local ReachType = nil
			local Tool = Character:FindFirstChildOfClass("Tool")

			if Tool then
				if Tool.Name == "Shoot" or Tool.Name == "Kick" then
					ReachType = "Shoot"
				elseif Tool.Name == "Pass" then
					ReachType = "Pass"
				elseif Tool.Name == "Long" then
					ReachType = "Long"
				elseif Tool.Name == "Tackle" then
					ReachType = "Tackle"
				elseif Tool.Name == "Dribble" then
					ReachType = "Dribble"
				elseif Tool.Name == "Save" or Tool.Name == "Clear" or Tool.Name == "GK" or Tool.Name == "Goalie" then
					ReachType = "Save"
				end

				if ReachType then
					if Toggles[ReachType.."ReachEnabled"].Value and not Toggles[ReachType.."InfiniteReach"].Value then
						ReachBox.Size = Vector3.new(
							Options[ReachType.."ReachSizeX"].Value,
							Options[ReachType.."ReachSizeY"].Value,
							Options[ReachType.."ReachSizeZ"].Value
						)
						ReachBox.CFrame = HumanoidRootPart.CFrame *
							CFrame.new(
								Options[ReachType.."ReachOffsetX"].Value,
								Options[ReachType.."ReachOffsetY"].Value,
								Options[ReachType.."ReachOffsetZ"].Value
							) *
							CFrame.Angles(
								math.rad(Options[ReachType.."ReachRotationX"].Value),
								math.rad(Options[ReachType.."ReachRotationY"].Value),
								math.rad(Options[ReachType.."ReachRotationZ"].Value)
							)
						ReachBox.Shape = Options[ReachType.."ReachShape"].Value
						if Toggles.ReachVisualizer.Value then
							ReachBox.Color = Library.Options.ReachVisualizerColor.Value
							ReachBox.Transparency = Library.Options.ReachVisualizerColor.Transparency
						end
					else
						RemoveReachBox()
					end

					local TouchingBalls = {}
					if Toggles[ReachType.."InfiniteReach"].Value then
						TouchingBalls = Script.Storage.Balls
					else
						local Params = OverlapParams.new()
						Params.FilterType = Enum.RaycastFilterType.Include
						Params.FilterDescendantsInstances = {Script.Storage.Balls}
						TouchingBalls = workspace:GetPartsInPart(ReachBox, Params)
					end

					if #TouchingBalls > 0 then
						table.sort(TouchingBalls, function(A, B) return (A.Position - HumanoidRootPart.Position).Magnitude < (B.Position - HumanoidRootPart.Position).Magnitude end)
						local TargetBall = TouchingBalls[1]

						if Toggles[ReachType.."OwnerCheck"].Value then
							if TargetBall:FindFirstChild("Owner") or TargetBall:FindFirstChild("owner") then
								local OwnerValue = TargetBall:FindFirstChild("Owner") or TargetBall:FindFirstChild("owner")
								if OwnerValue.Value == LocalPlayer or OwnerValue.Value == LocalPlayer.Name or OwnerValue.Value == LocalPlayer.UserId then
									return
								end
							end
						end

						local TouchParts = {}
						for ID, Part in pairs(Character:GetChildren()) do
							if Part:IsA("BasePart") then
								table.insert(TouchParts, Part)
							end
						end
						table.sort(TouchParts, function(A, B) return (A.Position - TargetBall.Position).Magnitude < (B.Position - TargetBall.Position).Magnitude end)
						for ID, Part in pairs(TouchParts) do
							firetouchinterest(TargetBall, Part, 0)
							firetouchinterest(TargetBall, Part, 1)
						end
						Reaching = true
					else
					  Reaching = false
					end
				else
					RemoveReachBox()
					Reaching = false
				end
			else
				RemoveReachBox()
				Reaching = false
			end
		end

		if Toggles.WalkSpeedEnabled.Value then
			Character:PivotTo(Character.PrimaryPart.CFrame + Humanoid.MoveDirection * DeltaTime * Options.WalkSpeedSlider.Value)
		end
	end

	if Toggles.BallPredictionEnabled.Value then
		for Ball, Info in pairs(Script.Storage.BallPrediction) do
			if Ball.AssemblyLinearVelocity.Magnitude > Options.BallPredictionThreshold.Value then
				local Prediction = findLandingPosition(Ball.AssemblyLinearVelocity, Ball.Position)
				Info.A0.WorldPosition = Ball.Position
				Info.A1.WorldPosition = Prediction
				Info.Beam.Color = ColorSequence.new(Library.Options.BallPredictionColor0.Value, Library.Options.BallPredictionColor1.Value)
				Info.Beam.Transparency = NumberSequence.new(Library.Options.BallPredictionColor0.Transparency, Library.Options.BallPredictionColor1.Transparency)
				Info.Beam.Width0 = Options.BallPredictionSize0.Value
				Info.Beam.Width1 = Options.BallPredictionSize1.Value
				Info.Beam.Enabled = true
			else
				Info.Beam.Enabled = false
			end
		end
	end
	
	if Toggles.DesyncVisualizerEnabled.Value then
		local PlayerPosition = HumanoidRootPart.CFrame
		DesyncBox.Color = Library.Options.DesyncVisualizerColor.Value
		DesyncBox.Transparency = Library.Options.DesyncVisualizerColor.Transparency
		task.wait(LocalPlayer:GetNetworkPing() * 10)
		DesyncBox.CFrame = PlayerPosition * CFrame.new(0, -0.5, 0)
	end
end)

if BallsFolder then
	for ID, Ball in pairs(BallsFolder:GetChildren()) do
		table.insert(Script.Storage.Balls, Ball)
		CreatePrediction(Ball)
	end
	BallsFolder.ChildAdded:Connect(function(Ball)
		table.insert(Script.Storage.Balls, Ball)
		CreatePrediction(Ball)
	end)
	BallsFolder.ChildRemoved:Connect(function(Ball)
		table.remove(Script.Storage.Balls, table.find(Script.Storage.Balls, Ball))
		for ID, instance in pairs(Script.Storage.BallPrediction[Ball]) do
			instance:Destroy()
			instance = nil
		end
		table.clear(Script.Storage.BallPrediction[Ball])
		Script.Storage.BallPrediction[Ball] = nil
	end)
else
	for ID, Ball in pairs(workspace:GetChildren()) do
		if Ball:IsA("BasePart") and Ball:FindFirstChildOfClass("BodyForce") and (Ball:WaitForChild("Owner") or Ball:WaitForChild("owner")) then
			table.insert(Script.Storage.Balls, Ball)
			CreatePrediction(Ball)
		end
	end
	workspace.ChildAdded:Connect(function(Ball)
		task.wait(1)
		if Ball:IsA("BasePart") and Ball:FindFirstChildOfClass("BodyForce") and (Ball:WaitForChild("Owner") or Ball:WaitForChild("owner")) then
			table.insert(Script.Storage.Balls, Ball)
			CreatePrediction(Ball)
		end
	end)
	workspace.ChildRemoved:Connect(function(Ball)
		local BallIndex = table.find(Script.Storage.Balls, Ball)
		if BallIndex then
			table.remove(Script.Storage.Balls, BallIndex)
			for ID, instance in pairs(Script.Storage.BallPrediction[Ball]) do
				instance:Destroy()
				instance = nil
			end
			table.clear(Script.Storage.BallPrediction[Ball])
			Script.Storage.BallPrediction[Ball] = nil
		end
	end)
end

-- Hooks
local OldGetTouhcingParts = nil
OldGetTouhcingParts = hookmetamethod(Instance.new("Part"), "__namecall", newcclosure(function(Self, ...)
	local Method = getnamecallmethod()
	if Reaching and not checkcaller() and Method == "GetTouchingParts" then
		local TouchParts = OldGetTouhcingParts(Self, ...)
		for ID, Part in pairs(Character:GetChildren()) do
			if Part:IsA("BasePart") then
				table.insert(TouchParts, Part)
			end
		end
		for ID, Part in pairs(Script.Storage.Balls) do
			table.insert(TouchParts, Part)
		end
		return TouchParts
	end

	return OldGetTouhcingParts(Self, ...)
end))

-- UI Events
Toggles.ReachEnabled:OnChanged(function()
	if not Toggles.ReachEnabled.Value then
		RemoveReachBox()
		Reaching = false
	end
end)
Toggles.ReachVisualizer:OnChanged(function()
	if not Toggles.ReachVisualizer.Value then
		ReachBox.Transparency = 1
	end
end)
Toggles.BallPredictionEnabled:OnChanged(function()
	if not Toggles.BallPredictionEnabled.Value then
		for Ball, Info in pairs(Script.Storage.BallPrediction) do
			Info.Beam.Enabled = false
		end
	end
end)
Toggles.HomboloMacro:OnChanged(function()
	if Toggles.HomboloMacro.Value then
		if Script.Storage.HomboloMacro.A1 then Script.Storage.HomboloMacro.A1:Destroy() end
		if Script.Storage.HomboloMacro.Align then Script.Storage.HomboloMacro.Align:Destroy() end

		local Balls = Script.Storage.Balls
		if #Balls > 0 then
			table.sort(Balls, function(A, B) return (A.Position - HumanoidRootPart.Position).Magnitude < (B.Position - HumanoidRootPart.Position).Magnitude end)
			local TargetBall = Balls[1]

			local A1 = Instance.new("Attachment")
			A1.Name = HttpService:GenerateGUID(true)
			A1.Parent = TargetBall
			local Align = Instance.new("AlignPosition")
			Align.Name = HttpService:GenerateGUID(true)
			Align.ApplyAtCenterOfMass = true
			Align.Attachment0 = A1
			Align.Attachment1 = Character.Head.FaceCenterAttachment
			Align.ForceLimitMode = Enum.ForceLimitMode.PerAxis
			Align.MaxAxesForce = Vector3.new(math.huge, 0, math.huge)
			Align.Responsiveness = math.huge
			Align.Parent = TargetBall
			Script.Storage.HomboloMacro.A1 = A1
			Script.Storage.HomboloMacro.Align = Align
		end
	else
		if Script.Storage.HomboloMacro.A1 then Script.Storage.HomboloMacro.A1:Destroy() Script.Storage.HomboloMacro.A1 = nil end
		if Script.Storage.HomboloMacro.Align then Script.Storage.HomboloMacro.Align:Destroy() Script.Storage.HomboloMacro.Align = nil end
	end
end)
Options.PowerShootKeybind:OnClick(function()
	if Toggles.PowerShoot.Value and Character and HumanoidRootPart then
		local Balls = Script.Storage.Balls
		if #Balls > 0 then
			table.sort(Balls, function(A, B) return (A.Position - HumanoidRootPart.Position).Magnitude < (B.Position - HumanoidRootPart.Position).Magnitude end)
			local TargetBall = Balls[1]

			TargetBall.AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector * Options.PowerShootPower.Value * 10
		end
	end
end)
Library.ToggleKeybind = Options.MenuKeybind
Toggles.WatermarkEnabled:OnChanged(function()
	Library:SetWatermarkVisibility(Toggles.WatermarkEnabled.Value)
end)

-- Finish
Library:Notify("Loaded in "..math.floor((os.clock() - Script.LoadTime) * 1000).."ms !", 3)

print("\n░░░░░▄▄▄▄▀▀▀▀▀▀▀▀▄▄▄▄▄▄░░░░░░░░\n░░░░░█░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░▀▀▄░░░░\n░░░░█░░░▒▒▒▒▒▒░░░░░░░░▒▒▒░░█░░░\n░░░█░░░░░░▄██▀▄▄░░░░░▄▄▄░░░░█░░\n░▄▀▒▄▄▄▒░█▀▀▀▀▄▄█░░░██▄▄█░░░░█░\n█░▒█▒▄░▀▄▄▄▀░░░░░░░░█░░░▒▒▒▒▒░█\n█░▒█░█▀▄▄░░░░░█▀░░░░▀▄░░▄▀▀▀▄▒█\n░█░▀▄░█▄░█▀▄▄░▀░▀▀░▄▄▀░░░░█░░█░\n░░█░░░▀▄▀█▄▄░█▀▀▀▄▄▄▄▀▀█▀██░█░░\n░░░█░░░░██░░▀█▄▄▄█▄▄█▄████░█░░░\n░░░░█░░░░▀▀▄░█░░░█░█▀██████░█░░\n░░░░░▀▄░░░░░▀▀▄▄▄█▄█▄█▄█▄▀░░█░░\n░░░░░░░▀▄▄░▒▒▒▒░░░░░░░░░░▒░░░█░\n░░░░░░░░░░▀▀▄▄░▒▒▒▒▒▒▒▒▒▒░░░░█░\n░░░░░░░░░░░░░░▀▄▄▄▄▄░░░░░░░░█░░\n")