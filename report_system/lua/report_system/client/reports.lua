function ReportSystemReports()

	local ReportPlayerSelected = ""

	local ReportPlayer = vgui.Create("DComboBox", ReportSPanel)
	ReportPlayer:SetSize(ReportSPanel:GetWide() / 1.025, ReportSPanel:GetTall() / 15)
	ReportPlayer:SetPos(ReportSPanel:GetWide() / 80, ReportSPanel:GetTall() / 50)
	ReportPlayer:SetText("Choisissez un joueur...")
	for i=1,#player.GetAll() do
		if player.GetAll()[i]:Name() == LocalPlayer():Name() then
			continue
		end

		ReportPlayer:AddChoice(player.GetAll()[i]:Name())
	end
	ReportPlayer.OnSelect = function(panel,value)
		ReportPlayerSelected = value
	end

	local ReportValue = ""

	ReportsReasons = vgui.Create("DComboBox", ReportSPanel)
	ReportsReasons:SetSize(ReportSPanel:GetWide() / 1.023, ReportSPanel:GetTall() / 15)
	ReportsReasons:SetPos(ReportSPanel:GetWide() / 80, ReportSPanel:GetTall() / 8)
	ReportsReasons:SetText("Choisissez la raison...")
	ReportsReasons:AddChoice("Freekill")
	ReportsReasons:AddChoice("Autres...")
	ReportsReasons.OnSelect = function(panel, index, value)
		ReportValue = value

		if ReportValue == "Autres..." then
			ReportReasonT = vgui.Create("DTextEntry", ReportSPanel)
			ReportReasonT:SetSize(ReportSPanel:GetWide() / 1.023, ReportSPanel:GetTall() / 15)
			ReportReasonT:SetPos(ReportSPanel:GetWide() / 80, ReportSPanel:GetTall() / 5)
			ReportReasonT:SetText("Entrez la raison...")
		else
			if ReportReasonT:IsValid() then
				ReportReasonT:Remove()
			end
		end
	end

	local ReportPC = vgui.Create("ReportSButton", ReportSPanel)
	ReportPC:SetSize(ReportSPanel:GetWide() / 1.023, ReportSPanel:GetTall() / 10)
	ReportPC:SetPos(ReportSPanel:GetWide() / 80, ReportSPanel:GetTall() / 1.13)
	ReportPC:SetText("Se plaindre")
	ReportPC.DoClick = function()
		net.Start("NotIdea.ReportS.Report")
			net.WriteEntity(player.GetAll()[ReportPlayerSelected])
			if ReportValue == "Autres..." then
				net.WriteString(ReportReasonT:GetValue())
			else
				net.WriteString(ReportsReasons:GetValue())
			end
		net.SendToServer()

		ReportSF:Close()
	end
end