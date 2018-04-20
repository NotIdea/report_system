net.Receive("NotIdea.ReportS.Open", function()
	ReportTable = net.ReadTable()

	local ReportSystemNavbar = {
		[1] = {
			name = "Se plaindre",
			action = function()
				ReportSPanel:Clear()
				ReportSystemReports()
			end
		},
		[2] = {
			name = "Liste des plaintes",
			action = function()
				ReportSPanel:Clear()
				ReportSystemReportsList()
			end
		},
		[3] = {
			name = "Joueurs",
			action = function()
				ReportSPanel:Clear()
				ReportSystemPlayers()
			end
		},
	}

	ReportSF = vgui.Create("DFrame")
	ReportSF:SetSize(ScrW() / 2, ScrH() / 1.8)
	ReportSF:Center()
	ReportSF:ShowCloseButton(false)
	ReportSF:SetDraggable(false)
	ReportSF:SetTitle("")
	ReportSF:MakePopup()
	ReportSF.Paint = function(self,w,h)
		ReportSystemBlur(self, 12)

		--fond
		draw.RoundedBoxEx(4,w / 4.32,h / 11,w / 1.3,h / 1.1,Color(49,73,94,240), false, false, false, true)
		--navbar
		draw.RoundedBoxEx(4,0,0,w / 4.3,h,Color(54,73,91,250),false,false,true,false)
		--haut nav pour afficher img profil
		draw.RoundedBoxEx(4,0,h / 11,w / 4.3,h / 7,Color(49,67,85,235),false,false,true,false)
		--barre foncée
		draw.RoundedBoxEx(4,0,0,w,h / 11,Color(44,62,80,255), true, true, false, false)

		draw.SimpleText("Report System","ReportSF32",w / 90,h / 24,Color(255,255,255),0,1)
		draw.SimpleText("Profil:","ReportSF50",w / 80,h / 8,Color(255,255,255),0,1)
		draw.SimpleText(LocalPlayer():Name(),"ReportSF50",w / 19,h / 5.25,Color(255,255,255),0,1)
	end

	local ReportSAvatar = vgui.Create("AvatarImage", ReportSF)
	ReportSAvatar:SetSize(ReportSF:GetWide() / 30, ReportSF:GetTall() / 20)
	ReportSAvatar:SetPos(ReportSF:GetWide() / 80, ReportSF:GetTall() / 6)
	ReportSAvatar:SetPlayer(LocalPlayer(), 64)

	local ReportSScroll = vgui.Create("DScrollPanel", ReportSF)
	ReportSScroll:SetSize(ReportSF:GetWide() / 4.04, ReportSF:GetTall() / 1.3)
	ReportSScroll:SetPos(0, ReportSF:GetTall() / 4.3)
	local RSPaint = ReportSScroll:GetVBar()
	function RSPaint:Paint() end
	function RSPaint.btnUp:Paint() end
	function RSPaint.btnDown:Paint() end
	function RSPaint.btnGrip:Paint() end

	local ReportSIcon = vgui.Create("DIconLayout", ReportSScroll)
	ReportSIcon:Dock(FILL)

	local NavButtonSel = 0

	for i=1,#ReportSystemNavbar do
		if ReportSystemNavbar[i].name == "Liste des plaintes" and !LocalPlayer():IsAdmin() then
			continue
		end

		local ReportSButtons = vgui.Create("ReportSButton", ReportSIcon)
		ReportSButtons:SetSize(ReportSScroll:GetWide() / 1.06, ReportSScroll:GetTall() / 10)
		ReportSButtons:SetPos(0, ReportSScroll:GetTall() / 10)
		ReportSButtons:SetText(ReportSystemNavbar[i].name)
		ReportSButtons.PaintOver = function(self,w,h)
			if NavButtonSel == i then
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,60))
			end
		end
		ReportSButtons.DoClick = function()
			NavButtonSel = i

			ReportSystemNavbar[i]["action"]()
		end
	end

	local ReportSClose = vgui.Create("ReportSButton", ReportSF)
	ReportSClose:SetSize(ReportSF:GetWide() / 23, ReportSF:GetTall() / 15)
	ReportSClose:SetPos(ReportSF:GetWide() / 1.055, ReportSF:GetTall() / 70)
	ReportSClose:SetText("X")
	ReportSClose.DoClick = function()
		ReportSF:Close()
	end

	ReportSPanel = vgui.Create("DPanel", ReportSF)
	ReportSPanel:SetSize(ReportSF:GetWide() / 1.3, ReportSF:GetTall() / 1.1)
	ReportSPanel:SetPos(ReportSF:GetWide() / 4.32, ReportSF:GetTall() / 11)
	ReportSPanel:SetBackgroundColor(Color(0,0,0,0))
end)
