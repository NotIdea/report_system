local blur = Material("pp/blurscreen")
function ReportSystemBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

surface.CreateFont("ReportSF32",{
	font = "Arial",
	weight = 1000,
	size = ScrH() / 40
})

surface.CreateFont("ReportSF320",{
    font = "Arial",
    weight = 10,
    size = ScrH() / 40
})

surface.CreateFont("ReportSF50",{
    font = "Arial",
    weight = 10,
    size = ScrH() / 60
})