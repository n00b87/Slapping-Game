Dim boss_profile
Dim boss_hbar
Dim boss_hud_active
Dim boss_hud_health
Dim boss_hud_max_health
Dim boss_hud_current_boss

Sub Init_Boss_HBar(n, max_health)
	Select Case n
	Case 0
		boss_profile = GetFreeImage
		LoadImage(boss_profile, SPRITE_PATH$ + "boss1_profile.png")
		
		boss_hbar = GetFreeImage
		LoadImage(boss_hbar, SPRITE_PATH$ + "boss_hbar.png")
		
		boss_hud_max_health = max_health
	Case 1
		boss_profile = GetFreeImage
		LoadImage(boss_profile, SPRITE_PATH$ + "boss1_profile.png")
		
		boss_hbar = GetFreeImage
		LoadImage(boss_hbar, SPRITE_PATH$ + "boss_hbar.png")
		
		boss_hud_max_health = max_health
	End Select
End Sub

Sub Clear_Boss_HBar()
	If ImageExists(boss_profile) Then
		DeleteImage(boss_profile)
	End If
	
	If ImageExists(boss_hbar) Then
		DeleteImage(boss_hbar)
	End If
End Sub

Dim boss_hud_hbar_width
Dim boss_hud_off_x
Dim boss_hud_off_y
boss_hud_off_x = 37
boss_hud_off_y = 420
boss_hud_hbar_off_x = 80
boss_hud_hbar_off_y = 424


Sub Boss_Hud(health)
	'37, 420
	'502 x 21
	DrawImage(boss_profile, boss_hud_off_x, boss_hud_off_y)
	DrawImage(boss_hbar, boss_hud_hbar_off_x, boss_hud_hbar_off_y)
	
	boss_hud_hbar_width = (health/boss_hud_max_health) * 502
	
	SetColor(RGB(172,50,50))
	If health > 0 Then
		RectFill(boss_hud_hbar_off_x + 1, boss_hud_hbar_off_y + 1, boss_hud_hbar_width, 21)
	End If
End Sub
