ReportSystem = ReportSystem or {}

local function includefile(path, boolean)
	local pathfile = file.Find(path .."*", "LUA")
	for k, v in pairs(pathfile) do
		if boolean == true then
			include(path ..v)
		else
			AddCSLuaFile(path ..v)
		end
	end
end

if SERVER then
	includefile("report_system/server/", true)

	includefile("report_system/client/", false)
	includefile("report_system/vgui/", false)
	includefile("report_system/", false)
end

if CLIENT then
	includefile("report_system/client/", true)
	includefile("report_system/vgui/", true)
	includefile("report_system/", true)
end
