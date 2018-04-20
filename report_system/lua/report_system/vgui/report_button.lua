local PANEL = {}

function PANEL:Init()
	self:SetText("")
	self:SetFont("ReportSF50")
	self:SetTextColor(Color(220,220,220,255))
	self.anim = 0
end

function PANEL:Paint(w,h)
	if self:IsHovered() then
		self.anim = Lerp(FrameTime() * 10, self.anim, 50)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,self.anim))
	else
		self.anim = Lerp(FrameTime() * 10, self.anim, 0)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,self.anim))
	end
end

vgui.Register("ReportSButton", PANEL , "DButton")