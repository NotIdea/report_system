function ReportSystemReportsList()
	local PlayersList = vgui.Create("DListView", ReportSPanel)
	PlayersList:Dock(FILL)
	PlayersList:AddColumn("ID")
	PlayersList:AddColumn("Par")
	PlayersList:AddColumn("Contre")
	PlayersList:AddColumn("Raison")
	PlayersList:AddColumn("Traité")
	PlayersList.Paint = function() end
	PlayersList.OnRowRightClick = function(panel, line)
		local Menu = DermaMenu()

		if PlayersList:GetLine(line):GetValue(5) == "Non traité" then
			local traiter = Menu:AddOption("Traiter le ticket", function()
				net.Start("NotIdea.ReportS.Traited")
					net.WriteInt(tonumber(PlayersList:GetLine(line):GetValue(1)),32) 
				net.SendToServer() 
				ReportSF:Close()
			end)
			traiter:SetIcon("icon16/accept.png")
		else
			local traiter = Menu:AddOption("Ne plus traiter le ticket", function()
				net.Start("NotIdea.ReportS.Traited")
					net.WriteInt(tonumber(PlayersList:GetLine(line):GetValue(1)),32) 
				net.SendToServer() 
				ReportSF:Close()
			end)
			traiter:SetIcon("icon16/cancel.png")
		end

		local traiter = Menu:AddOption("Supprimer", function()
			net.Start("NotIdea.ReportS.Delete")
				net.WriteInt(tonumber(PlayersList:GetLine(line):GetValue(1)),32) 
			net.SendToServer() 
			ReportSF:Close()
		end)
		traiter:SetIcon("icon16/cancel.png")

		Menu:AddSpacer()

		local TP2 = Menu:AddOption("Teleporter les 2 joueurs", function() RunConsoleCommand("ulx", "teleport", PlayersList:GetLine(line):GetValue(2)) RunConsoleCommand("ulx", "teleport", PlayersList:GetLine(line):GetValue(3)) end)
		TP2:SetIcon("icon16/group.png")

		local TPcreator = Menu:AddOption("Teleporter le créateur", function() RunConsoleCommand("ulx", "teleport", PlayersList:GetLine(line):GetValue(2)) end)
		TPcreator:SetIcon("icon16/user_add.png")

		local TPreported = Menu:AddOption("Teleporter le fautif", function() RunConsoleCommand("ulx", "teleport", PlayersList:GetLine(line):GetValue(3)) end)
		TPreported:SetIcon("icon16/user_delete.png")

		Menu:Open()
	end

	for i=1,#ReportTable do
		if ReportTable[i].traited == "false" then
			PlayersList:AddLine(ReportTable[i].id, ReportTable[i].creator, ReportTable[i].reported, ReportTable[i].reason, "Non traité")
		else
			PlayersList:AddLine(ReportTable[i].id, ReportTable[i].creator, ReportTable[i].reported, ReportTable[i].reason, "Traité")
		end
	end
end