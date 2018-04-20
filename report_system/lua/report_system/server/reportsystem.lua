local ReportsEmpty = {}

hook.Add("Initialize","CreateLaTableGmod", function() 
	if !sql.TableExists("reports_system") then
		print("Création de la table...")
		sql.Query("CREATE TABLE reports_system (id INTEGER PRIMARY KEY AUTOINCREMENT, creator varchar(255), reported varchar(255), reason varchar(255), traited varchar(255))")
	else
		print("Table existante...")
	end
end)

hook.Add("PlayerSay", "ReportSystemChat", function(ply, text)
	if ( string.Left(text, 1) == "@" ) or ( string.Left(text, 3) == "///" ) then
		local SQLTableReports = sql.Query("SELECT * FROM reports_system")

		net.Start("NotIdea.ReportS.Open")
			if SQLTableReports != nil then
				net.WriteTable(SQLTableReports)
			else
				net.WriteTable(ReportsEmpty)
			end
		net.Send(ply)
	end
end)

net.Receive("NotIdea.ReportS.Report", function(len, ply)
	local entity = net.ReadEntity()
	local reason = net.ReadString()

	sql.Query("INSERT INTO reports_system (creator, reported, reason, traited) VALUES ('" ..ply:Name() .."', '" ..entity:Name() .."', '" ..reason .."', 'false')") 
end)

net.Receive("NotIdea.ReportS.Traited", function(len, ply)
	if !ply:IsAdmin() then
		return DarkRP.notify(ply, 1, 5, "La plainte n'a pas été traitée")
	end

	local idInt = net.ReadInt(32)

	local viewStatusReport = sql.Query("SELECT traited FROM reports_system WHERE id = " ..idInt)

	if viewStatusReport[1].traited == "true" then
		sql.Query("UPDATE reports_system SET traited = 'false' WHERE id = " ..idInt)
		DarkRP.notify(ply, 0, 5, "La plainte n'est plus traitée")
	else
		sql.Query("UPDATE reports_system SET traited = 'true' WHERE id = " ..idInt)
		DarkRP.notify(ply, 0, 5, "La plainte est traitée")
	end
end)

net.Receive("NotIdea.ReportS.Delete", function(len, ply)
	if !ply:IsAdmin() then
		return DarkRP.notify(ply, 1, 5, "La plainte n'a pas été supprimée")
	end

	local idInt = net.ReadInt(32)

	sql.Query("DELETE FROM reports_system WHERE id = " ..idInt)

	DarkRP.notify(ply, 0, 5, "La plainte numéro " ..idInt .." a été supprimée avec succès")
end)