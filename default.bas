Dim STAGE_COMPLETE



Sub Init_Default()
	'Enemy Hit
	num_enemies = 0
	
	'Guard
	For i = 0 to MAX_GUARDS-1
		guard_alive[i] = 0
		guard_actor[i] = -1
		guard_action[i] = 0
		guard_action_time[i] = 0
		guard_action_lock[i] = 0
		guard_action_status[i] = 0
		guard_distance[i] = 0
		guard_health[i] = 0
		guard_weapon_actor[i] = 0
		guard_death_actor[i] = 0
		guard_enemy[i] = 0
	Next

	guard_axe_attack = 1
	guard_walk_speed = 2
	guard_travel_distance = 20

	'Hovers
	For i = 0 to MAX_HOVERS-1
		hover_alive[i] = 0
		hover_actor[i] = -1
		hover_action[i] = 0
		hover_action_time[i] = 0
		hover_action_lock[i] = 0
		hover_action_status[i] = 0
		hover_distance[i] = 0
		hover_health[i] = 0
		hover_weapon_actor[i] = -1
		hover_death_actor[i] = 0
		hover_direction[i] = 0
		hover_ball_splash[i] = 0
		hover_ball_splash_timer[i] = 0
		hover_enemy[i] = 0
	Next

	hover_ball_attack = 1
	hover_speed = 2
	hover_travel_distance = 260
	
	If hover_sound > 0 Then
		If SoundExists(hover_sound) Then
			DeleteSound(hover_sound)
		End If
	End If

	hover_sound = -1
	hover_sound_isplaying = false
	
	'CLAW
	For i = 0 to MAX_CLAWS-1
		claw_alive[i] = 0
		claw_actor[i] = -1
		claw_action[i] = 0
		claw_action_time[i] = 0
		claw_action_lock[i] = 0
		claw_action_status[i] = 0
	Next
	

	'M1
	For i = 0 to MAX_M1S-1
		m1_alive[i] = 0
		m1_actor[i] = -1
		m1_action[i] = 0
		m1_action_time[i] = 0
		m1_action_lock[i] = 0
		m1_action_status[i] = 0
	Next
	
	m1_bullet_speed = 4
	m1_bullet_attack = 1
	m1_walk_speed = 2
	m1_travel_distance = 20
	
	'Grenguy
	For i = 0 to MAX_GRENS-1
		gren_alive[i] = 0
		gren_actor[i] = -1
		gren_action[i] = 0
		gren_action_time[i] = 0
		gren_action_lock[i] = 0
		gren_action_status[i] = 0
	Next
	
	gren_bullet_speed = 4
	gren_bullet_attack = 1
	gren_walk_speed = 2
	gren_travel_distance = 20
	
	
	'Bitwalker
	For i = 0 to MAX_BITWALKERS-1
		bitwalker_alive[i] = 0
		bitwalker_actor[i] = -1
		bitwalker_action[i] = 0
		bitwalker_action_time[i] = 0
		bitwalker_action_lock[i] = 0
		bitwalker_action_status[i] = 0
	Next
	
	bitwalker_bullet_speed = 4
	bitwalker_bullet_attack = 1
	bitwalker_walk_speed = 2
	bitwalker_travel_distance = 20
	
	'Skull Wheel
	For i = 0 to MAX_SKWS-1
		skw_alive[i] = 0
		skw_actor[i] = -1
		skw_action[i] = 0
	Next
	
	
	'Forest Boss
	boss_alive = 0
	boss_actor = 0
	boss_action = 0
	boss_action_time = 0
	boss_action_lock = 0
	boss_action_status = 0
	
	boss_distance = 0

	boss_health = 0
	boss_weapon1_actor = 0
	boss_weapon2_actor = 0
	boss_weapon3_actor = 0
	boss_weapon4_actor = 0
	boss_death_actor = 0

	boss_walk_speed = 0
	boss_weapon1_attack = 0
	boss_weapon2_attack = 0
	boss_weapon3_attack = 0
	boss_weapon4_attack = 0

	boss_stun_timer = 0

	boss_weapon1_attack = 1
	boss_weapon2_attack = 1

	boss_walk_speed = 2
	boss_travel_distance = 20

	boss_pattern = 0
	boss_step = 0
	boss_attribute1 = 0

	For i = 0 to 199
		boss_projectile1[i]
		boss_projectile1_hit[i]
	Next
	boss_projectile1_count = 0
	boss_projectile1_numActive = 0
	boss_projectile1_flag = 0
	boss_projectile1_gz_hit = 0
	boss_action_split = 0
	boss_enemy = 0
	
End Sub


Sub Reset_Default()
	'Enemy Hit
	num_enemies = 0
	
	'Guard
	For i = 0 to MAX_GUARDS-1
		If guard_actor[i] >= 0 Then
			guard_alive[i] = True
			guard_health[i] = 8
			Actor_SetActive(guard_actor[i], True)
			
			g_actor = guard_actor[i]
			g_action = GUARD_ACTION_STAND_LEFT
			Select Case Sprite_Animation_Name$[ Actor_Sprite[g_actor], Actor_CurrentAnimation[g_actor] ]
			Case "stand_right"
				g_action = GUARD_ACTION_STAND_RIGHT
			Case "walk_right"
				g_action = GUARD_ACTION_WALK_RIGHT
			Case "stand_left"
				g_action = GUARD_ACTION_STAND_LEFT
			Case "walk_left"
				g_action = GUARD_ACTION_WALK_LEFT
			End Select
			
			guard_action[i] = g_action
			
		End If
	Next

	'Hovers
	For i = 0 to MAX_HOVERS-1
		If hover_actor[i] >= 0 Then
			hover_alive[i] = 0
			hover_health[i] = 2
			hover_enemy[i] = -1
			Actor_SetActive(hover_actor[i], True)
			hover_action[i] = HOVER_ACTION_STILL
		End If
	Next

	'CLAW
	For i = 0 to MAX_CLAWS-1
		If claw_actor[i] >= 0 Then
			claw_alive[i] = True
			claw_health[i] = 4
			claw_enemy[i] = -1
			Actor_SetActive(claw_actor[i], True)
			claw_action[i] = CLAW_ACTION_STAND_LEFT
		End If
	Next
	

	'M1
	For i = 0 to MAX_M1S-1
		If m1_actor[i] >= 0 Then
			m1_alive[i] = True
			m1_health[i] = 8
			m1_enemy[i] = -1
			Actor_SetActive(m1_actor[i], True)
			Actor_SetAnimationByName(m1_actor[i], "STAND_LEFT")
			m1_action[i] = M1_ACTION_STAND_LEFT2
			
			For n = 0 to MAX_M1_BULLETS-1
				Actor_SetAnimationByName(m1_weapon_actor[i, n], "LEFT")
				Actor_SetAnimationFrame(m1_weapon_actor[i, n], 0)
				Actor_SetActive(m1_weapon_actor[i,n], false)
				Actor_SetLayer(m1_weapon_actor[i, n], 2)
				Actor_Physics[m1_weapon_actor[i, n]] = True
			Next
		End If
	Next
	
	'Grenguy
	For i = 0 to MAX_GRENS-1
		If gren_actor[i] >= 0 Then
			gren_alive[i] = True
			gren_health[i] = 12
			gren_enemy[i] = -1
			Actor_SetActive(gren_actor[i], True)
			gren_action[i] = GREN_ACTION_STAND_LEFT
		End If
	Next
	
	
	'Bitwalker
	For i = 0 to MAX_BITWALKERS-1
		If bitwalker_actor[i] >= 0 Then
			bitwalker_alive[i] = True
			bitwalker_health[i] = 12
			bitwalker_enemy[i] = -1
			Actor_SetActive(bitwalker_actor[i], True)
			
			bitwalker_action[i] = BITWALKER_ACTION_STAND_LEFT
			bitwalker_start_action[i] = BITWALKER_ACTION_STAND_LEFT
			
			For n = 0 to MAX_BITWALKER_BULLETS-1
				If bitwalker_weapon_actor[i, n] >= 0 Then
					Actor_SetAnimationByName(bitwalker_weapon_actor[i, n], "RISE_LEFT")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[i, n], 0)
					Actor_SetActive(bitwalker_weapon_actor[i,n], false)
					Actor_SetLayer(bitwalker_weapon_actor[i, n], 2)
					Actor_Physics[bitwalker_weapon_actor[i, n]] = False
					Actor_Persistent[ bitwalker_weapon_actor[i, n] ] = True
				End If
			Next
			
		End If
	Next
	
	'Skull Wheel
	For i = 0 to MAX_SKWS-1
		If skw_actor[i] >= 0 Then
			skw_alive[i] = True
			skw_health[i] = 9
			skw_enemy[i] = -1
			Actor_SetActive(skw_actor[i], True)
			skw_action[i] = SKW_ACTION_MOVE_LEFT
		End If
	Next
	
End Sub
