
if(CLIENT) then
	print("Оригинал: ZeroByter'sHUD by ZeroByter. Перевёл и специализировал для ZS'ки - цвяточеГ.")
	
	enable = CreateClientConVar("zerobyter_hud_enable", 1, true, false)
	
	hook.Add("HUDShouldDraw", "HideHUD", function(name)
		if(enable:GetBool()) then
			for k,v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
				if(name  == v) then return false end
			end
		end
	end)
	
	surface.CreateFont("zerobyter_hud", {
		font = "coolvetica",
		size = 32,
		weight = 200,
		blursize = 0,
		scanlines = 0,
		antialias = false,
		outline = true,
	})
	
	surface.CreateFont("zerobyter_hud_sml", {
		font = "coolvetica",
		size = 24,
		weight = 200,
		blursize = 0,
		scanlines = 0,
		antialias = false,
		outline = true,
	})
	
	hook.Add("HUDPaint", "ZeroByterHUD_HUDPaint", function()
		if(enable:GetBool()) then
			local health = math.Clamp(LocalPlayer():Health(), 0, 99999999999999999999)
			if(health < 1) then
				health = "-"
			end
			local armor = LocalPlayer():Armor()
			
			if(LocalPlayer():GetActiveWeapon():IsWeapon()) then
				clip1 = LocalPlayer():GetActiveWeapon():Clip1()
				clip2 = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
				weapon = LocalPlayer():GetActiveWeapon():GetClass()
				weaponName = LocalPlayer():GetActiveWeapon():GetPrintName()
			else
				clip1 = 0
				clip2 = 0
				weapon = ""
				weaponName = ""
			end
			--ЯД
			local lp = LocalPlayer()
			if lp:IsValid() then
				local status = lp:GetStatus("ghoultouch")
				if status and status:IsValid() then
					draw.RoundedBox(8, 32, ScrH() - 170, 189, 67, Color(255,0,0,130))
					draw.SimpleText(math.ceil(math.max(status.DieTime - CurTime(), 0)), "zerobyter_hud_sml", 128, ScrH() - 150, Color(255,255,255), TEXT_ALIGN_CENTER)
					draw.SimpleText("ЯД", "zerobyter_hud_sml", 128, ScrH() - 130, Color(255,255,255), TEXT_ALIGN_CENTER)
				end
			end
			--Показатель комманды
			if(LocalPlayer():Team() == TEAM_UNDEAD) then
				draw.RoundedBox(8, 32, ScrH() - 90, 189, 67, Color(255,0,0,130))
				draw.SimpleText("Зомби", "zerobyter_hud_sml", 128, ScrH() - 48, Color(255,255,255), TEXT_ALIGN_CENTER)
			end
			if(LocalPlayer():Team() == TEAM_HUMAN) then
				draw.RoundedBox(8, 32, ScrH() - 90, 189, 67, Color(120,180,120,130))
				draw.SimpleText("Выживший", "zerobyter_hud_sml", 126, ScrH() - 48, Color(255,255,255), TEXT_ALIGN_CENTER)
			end
			if(LocalPlayer():Team() == TEAM_HUMAN || LocalPlayer():Team() == TEAM_UNDEAD) then else
				draw.RoundedBox(8, 32, ScrH() - 90, 189, 67, Color(120,180,120,130))
				draw.SimpleText("Жизнь", "zerobyter_hud_sml", 126, ScrH() - 48, Color(255,255,255), TEXT_ALIGN_CENTER)
			end
			draw.SimpleText(health, "zerobyter_hud", 128, ScrH() - 76, Color(255,255,255), TEXT_ALIGN_CENTER)
			if(armor > 0) then
				draw.RoundedBox(8, 262, ScrH() - 90, 202, 67, Color(150,150,180,120))
				draw.SimpleText("Броня", "zerobyter_hud_sml", 364, ScrH() - 48, Color(255,255,255), TEXT_ALIGN_CENTER)
				draw.SimpleText(armor, "zerobyter_hud", 365, ScrH() - 76, Color(255,255,255), TEXT_ALIGN_CENTER)
			end
			
			if(clip1 == -1 || weapon == "weapon_zs_medicalkit" || weapon == "weapon_zs_hammer") then else
				draw.RoundedBox(8, ScrW() - 280, ScrH() - 90, 246, 67, Color(180,180,180,140))
				draw.SimpleText("Боеприпасы", "zerobyter_hud_sml", ScrW() - 217, ScrH() - 48, Color(255,255,255), TEXT_ALIGN_CENTER)
				draw.SimpleText(clip1, "zerobyter_hud", ScrW() - 150, ScrH() - 76, Color(255,255,255), TEXT_ALIGN_CENTER)
				if(clip2 > 0) then
					draw.SimpleText(clip2, "zerobyter_hud", ScrW() - 76, ScrH() - 60, Color(255,255,255), 	TEXT_ALIGN_CENTER)
				end
			end
		end
	end)
end