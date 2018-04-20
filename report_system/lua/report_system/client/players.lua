function ReportSystemPlayers()
	local PlayersList = vgui.Create("DListView", ReportSPanel)
	PlayersList:Dock(FILL)
	PlayersList:AddColumn("ID")
	PlayersList:AddColumn("Nom")
	PlayersList:AddColumn("SteamID")
	PlayersList:AddColumn("Grade")
	PlayersList.Paint = function()

	end

	for i=1,#player.GetAll() do
		PlayersList:AddLine(i, player.GetAll()[i]:Name(), player.GetAll()[i]:SteamID(), player.GetAll()[i]:GetUserGroup())
	end
end
