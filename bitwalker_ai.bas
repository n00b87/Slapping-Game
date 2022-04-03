'include "engine.bas"

MAX_BITWALKERS = 12

Dim bitwalker_init_pos[MAX_BITWALKERS, 2]

Dim bitwalker_alive[MAX_BITWALKERS]
Dim bitwalker_actor[MAX_BITWALKERS]
Dim bitwalker_action[MAX_BITWALKERS]
Dim bitwalker_action_time[MAX_BITWALKERS]
Dim bitwalker_action_lock[MAX_BITWALKERS]
Dim bitwalker_action_status[MAX_BITWALKERS]

Dim BITWALKER_ACTION_STAND_LEFT
Dim BITWALKER_ACTION_WALK_LEFT
Dim BITWALKER_ACTION_SHOOT_LEFT
Dim BITWALKER_ACTION_SLASH_LEFT

Dim BITWALKER_ACTION_STAND_RIGHT
Dim BITWALKER_ACTION_WALK_RIGHT
Dim BITWALKER_ACTION_SHOOT_RIGHT
Dim BITWALKER_ACTION_SLASH_RIGHT

Dim BITWALKER_ACTION_STUN_LEFT
Dim BITWALKER_ACTION_STUN_RIGHT

Dim BITWALKER_ACTION_WALK_LEFT2
Dim BITWALKER_ACTION_WALK_RIGHT2

Dim BITWALKER_ACTION_DEATH

BITWALKER_ACTION_WALK_LEFT = 0
BITWALKER_ACTION_STAND_LEFT = 1
BITWALKER_ACTION_SHOOT_LEFT = 2
BITWALKER_ACTION_SLASH_LEFT = 3
BITWALKER_ACTION_WALK_LEFT2 = 4

BITWALKER_ACTION_WALK_RIGHT = 5
BITWALKER_ACTION_STAND_RIGHT = 6
BITWALKER_ACTION_SHOOT_RIGHT = 7
BITWALKER_ACTION_SLASH_RIGHT = 8
BITWALKER_ACTION_WALK_RIGHT2 = 9

BITWALKER_ACTION_STUN_LEFT = 10
BITWALKER_ACTION_STUN_RIGHT = 11

BITWALKER_ACTION_DEATH = 12

Dim bitwalker_distance[MAX_BITWALKERS]

Dim MAX_BITWALKER_BULLETS
MAX_BITWALKER_BULLETS = 8

Dim bitwalker_health[MAX_BITWALKERS]
Dim bitwalker_weapon_actor[MAX_BITWALKERS, MAX_BITWALKER_BULLETS]
Dim bitwalker_weapon_speed[MAX_BITWALKERS, MAX_BITWALKER_BULLETS]
Dim bitwalker_death_actor[MAX_BITWALKERS]

Dim bitwalker_walk_speed
Dim bitwalker_bullet_attack
DIm bitwalker_bullet_speed
bitwalker_bullet_speed = 2
bitwalker_bullet_attack = 1
bitwalker_walk_speed = 2
bitwalker_travel_distance = 60

Dim bitwalker_enemy[MAX_BITWALKERS]
Dim bitwalker_start_action[MAX_BITWALKERS]
Dim bitwalker_action_time2[MAX_BITWALKERS]

Dim bitwalker_shoot_distance
Dim bitwalker_shot_wait_time
bitwalker_shot_wait_time = 1300
bitwalker_shoot_distance = 90

Dim bitwalker_stun_time[MAX_BITWALKERS]

Function AI_Init_BITWALKER(actor)
	For i = 0 to MAX_BITWALKERS-1
		If Not bitwalker_alive[i] Then
			bitwalker_alive[i] = True
			bitwalker_actor[i] = actor
			'bitwalker_action[i] = action
			Actor_Physics[actor] = True
			Actor_Weight[actor] = 5
			bitwalker_init_pos[i, 0] = Actor_X[actor]
			bitwalker_init_pos[i, 1] = Actor_Y[actor]
			'print "BitWalker: ";Actor_Name[actor]
			Select Case Sprite_Animation_Name$[ Actor_Sprite[actor], Actor_CurrentAnimation[actor] ]
			Case "STAND_LEFT"
				bitwalker_action[i] = BITWALKER_ACTION_STAND_LEFT
				bitwalker_start_action[i] = BITWALKER_ACTION_STAND_LEFT
			Case "WALK_LEFT"
				bitwalker_action[i] = BITWALKER_ACTION_WALK_LEFT
				bitwalker_start_action[i] = BITWALKER_ACTION_WALK_LEFT
			Case "STAND_RIGHT"
				bitwalker_action[i] = BITWALKER_ACTION_STAND_RIGHT
				bitwalker_start_action[i] = BITWALKER_ACTION_STAND_RIGHT
			Case "WALK_RIGHT"
				bitwalker_action[i] = BITWALKER_ACTION_WALK_RIGHT
				bitwalker_start_action[i] = BITWALKER_ACTION_WALK_RIGHT
			End Select
			
			
			bitwalker_health[i] = 12
			bitwalker_enemy[i] = -1
			
			bullet_spr = GetSpriteID("bit_missle")
			
			If bullet_spr < 0 Then
				bullet_spr = LoadSprite("bit_missle")
			End If
			
			'print "Start here"
			For n = 0 to MAX_BITWALKER_BULLETS-1
				bitwalker_weapon_actor[i, n] = NewActor("bitwalker_"+str(i)+"_bullet_"+str(n+1), bullet_spr)
				Actor_SetAnimationByName(bitwalker_weapon_actor[i, n], "RISE_LEFT")
				Actor_SetAnimationFrame(bitwalker_weapon_actor[i, n], 0)
				Actor_SetActive(bitwalker_weapon_actor[i,n], false)
				Actor_SetLayer(bitwalker_weapon_actor[i, n], 2)
				Actor_Physics[bitwalker_weapon_actor[i, n]] = False
				Actor_Persistent[ bitwalker_weapon_actor[i, n] ] = True
			Next
			
			'print "made it here"
			Actor_SetAnimationFrame(actor, 0)
			
			'If Not bitwalker_death_actor[i] Then
				'print "last"
				bitwalker_death_actor[i] = NewActor("bitwalker_"+str(i)+"_death", GetSpriteID("explosion"))
				Actor_SetLayer(bitwalker_death_actor[i], Actor_Layer[actor])
				Actor_SetActive(bitwalker_death_actor[i], false)
			'End If
			Return i
		End If
	Next
	Return -1
End Function
'0 , 26

Sub AI_BITWALKER_RunAction(gnum)
	actor = bitwalker_actor[gnum]
	
	'If Not Actor_isOnScreen(actor) Then
	'	Return
	'End If
	'wpn1 = bitwalker_weapon_actor[gnum,0]
	'wpn2 = bitwalker_weapon_actor[gnum,1]
	action = bitwalker_action[gnum]
	
	Select Case action
	Case BITWALKER_ACTION_STAND_LEFT
		If (timer - bitwalker_action_time2[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "RISE_LEFT")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = 0-bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'bitwalker_weapon_speed[gnum, i] = 0 - bitwalker_bullet_speed
					bitwalker_action_time2[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
	Case BITWALKER_ACTION_WALK_LEFT
		If timer - bitwalker_action_time[gnum] > 15 Then
			Actor_Move(actor, -1 * bitwalker_walk_speed, 0)
			bitwalker_distance[gnum] = bitwalker_distance[gnum] + 1
			bitwalker_action_time[gnum] = timer
		End If
		
		If (timer - bitwalker_action_time2[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = 0-bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'bitwalker_weapon_speed[gnum, i] = 0 - bitwalker_bullet_speed
					bitwalker_action_time2[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
	
	Case BITWALKER_ACTION_WALK_LEFT2
		If timer - bitwalker_action_time[gnum] > 15 Then
			Actor_Move(actor, bitwalker_walk_speed, 0)
			bitwalker_distance[gnum] = bitwalker_distance[gnum] + 1
			bitwalker_action_time[gnum] = timer
		End If
		
		If (timer - bitwalker_action_time2[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = 0-bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'bitwalker_weapon_speed[gnum, i] = 0 - bitwalker_bullet_speed
					bitwalker_action_time2[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
	
	Case BITWALKER_ACTION_SHOOT_LEFT
		If (timer - bitwalker_action_time[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]-8, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = 0-bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'bitwalker_weapon_speed[gnum, i] = 0 - bitwalker_bullet_speed
					bitwalker_action_time[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
	
	Case BITWALKER_ACTION_STAND_RIGHT
		'Do nothing for now
		If (timer - bitwalker_action_time2[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					'bitwalker_weapon_speed[gnum, i] = 0 - bitwalker_bullet_speed
					bitwalker_action_time2[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
	Case BITWALKER_ACTION_WALK_RIGHT
		If timer - bitwalker_action_time[gnum] > 15 Then
			Actor_Move(actor, bitwalker_walk_speed, 0)
			bitwalker_distance[gnum] = bitwalker_distance[gnum] + 1
			bitwalker_action_time[gnum] = timer
		End If
		
		If (timer - bitwalker_action_time2[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					bitwalker_weapon_speed[gnum, i] = bitwalker_bullet_speed
					bitwalker_action_time2[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
		
	Case BITWALKER_ACTION_WALK_RIGHT2
		If timer - bitwalker_action_time[gnum] > 15 Then
			Actor_Move(actor, 0-bitwalker_walk_speed, 0)
			bitwalker_distance[gnum] = bitwalker_distance[gnum] + 1
			bitwalker_action_time[gnum] = timer
		End If
		
		If (timer - bitwalker_action_time2[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					bitwalker_weapon_speed[gnum, i] = bitwalker_bullet_speed
					bitwalker_action_time2[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
	Case BITWALKER_ACTION_SHOOT_RIGHT
		If (timer - bitwalker_action_time[gnum]) > bitwalker_shot_wait_time Then
			For i = 0 to MAX_BITWALKER_BULLETS-1
				If Not Actor_Active[bitwalker_weapon_actor[gnum, i]] Then
					Actor_SetActive(bitwalker_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(bitwalker_weapon_actor[gnum, i], "MAIN")
					Actor_SetAnimationFrame(bitwalker_weapon_actor[gnum, i], 0)
					Actor_SetPosition(bitwalker_weapon_actor[gnum, i], Actor_X[actor]+16, Actor_Y[actor]-16)
					
					Actor_Jump[bitwalker_weapon_actor[gnum,i]] = bitwalker_shoot_distance + ((i MOD 2)*30)
					Actor_Force_X[bitwalker_weapon_actor[gnum,i]] = bitwalker_bullet_speed
					Actor_Force_Y[bitwalker_weapon_actor[gnum,i]] = -3
					Actor_Weight[bitwalker_weapon_actor[gnum,i]] = 4
					Actor_Physics[bitwalker_weapon_actor[gnum,i]] = True
					Actor_Physics_State[bitwalker_weapon_actor[gnum,i]] = PHYSICS_STATE_RISE
					
					bitwalker_weapon_speed[gnum, i] = bitwalker_bullet_speed
					bitwalker_action_time[gnum] = timer
					If Actor_isOnScreen(actor) Then
						PlaySound(shot_sound_3, 0, 0)
					End If
					Exit For
				End If
			Next
		End If
	Case BITWALKER_ACTION_SLASH_RIGHT
		'Actor_Move(actor, 3, 0)
		'Actor_SetPosition(wpn, Actor_X[actor], Actor_Y[actor])
	Case BITWALKER_ACTION_STUN_LEFT
		If bitwalker_distance[gnum] < 5 Then
			Actor_Move(actor, 1, 0)
			bitwalker_distance[gnum] = bitwalker_distance[gnum] + 1	
		End If
	Case BITWALKER_ACTION_STUN_RIGHT
		If bitwalker_distance[gnum] < 5 Then
			Actor_Move(actor, -1, 0)
			bitwalker_distance[gnum] = bitwalker_distance[gnum] + 1	
		End If
	Case BITWALKER_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[bitwalker_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[bitwalker_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[bitwalker_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[bitwalker_death_actor[gnum]]
	End Select
End Sub

Sub AI_BITWALKER_StartAction(gnum, action)
	Select Case action
	Case BITWALKER_ACTION_STAND_LEFT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "STAND_LFT")
		Actor_SetAnimationFrame(bitwalker_actor[gnum], 0)
		bitwalker_action_time[gnum] = timer
	Case BITWALKER_ACTION_WALK_LEFT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "WALK_LEFT")
		bitwalker_distance[gnum] = 0
	Case BITWALKER_ACTION_WALK_LEFT2
		Actor_SetAnimationByName(bitwalker_actor[gnum], "WALK_LEFT")
		bitwalker_distance[gnum] = 0
	Case BITWALKER_ACTION_SHOOT_LEFT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "STAND_LFT")
		Actor_SetAnimationFrame(bitwalker_actor[gnum], 0)
	Case BITWALKER_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(bitwalker_actor[gnum], 0)
		bitwalker_action_time[gnum] = timer
	Case BITWALKER_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "WALK_RIGHT")
		bitwalker_distance[gnum] = 0
	Case BITWALKER_ACTION_WALK_RIGHT2
		Actor_SetAnimationByName(bitwalker_actor[gnum], "WALK_RIGHT")
		bitwalker_distance[gnum] = 0
	Case BITWALKER_ACTION_SHOOT_RIGHT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(bitwalker_actor[gnum], 0)
	Case BITWALKER_ACTION_STUN_LEFT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "STUN_LEFT")
		Actor_SetAnimationFrame(bitwalker_actor[gnum], 0)
		bitwalker_action_time[gnum] = timer
		bitwalker_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case BITWALKER_ACTION_STUN_RIGHT
		Actor_SetAnimationByName(bitwalker_actor[gnum], "STUN_RIGHT")
		Actor_SetAnimationFrame(bitwalker_actor[gnum], 0)
		bitwalker_action_time[gnum] = timer
		bitwalker_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case BITWALKER_ACTION_DEATH
		Actor_SetActive(bitwalker_actor[gnum], false)
		Actor_SetActive(bitwalker_death_actor[gnum], true)
		Actor_SetAnimation(bitwalker_death_actor[gnum], 0)
		Actor_SetAnimationFrame(bitwalker_death_actor[gnum], 0)
		Actor_SetPosition(bitwalker_death_actor[gnum], Actor_X[bitwalker_actor[gnum]], Actor_Y[bitwalker_actor[gnum]])
		bitwalker_action_time[gnum] = timer
		PlaySound(3, 1, 0)
	End Select
	
	Select Case action
	Case BITWALKER_ACTION_STUN_LEFT, BITWALKER_ACTION_STUN_RIGHT
		SetImageBlendMode(Sprite_Image[Actor_Sprite[bitwalker_actor[gnum]]], BLENDMODE_ADD)
	Default
		SetImageBlendMode(Sprite_Image[Actor_Sprite[bitwalker_actor[gnum]]], BLENDMODE_BLEND)
	End Select
	
	bitwalker_action[gnum] = action
	bitwalker_action_status[gnum] = true
End Sub

Function AI_BITWALKER_ActionComplete(gnum)
	If Not bitwalker_action_status[gnum] Then
		Return True
	End If
	action = bitwalker_action[gnum]
	Select Case action
	Case BITWALKER_ACTION_STAND_LEFT
		If timer - bitwalker_action_time[gnum] > 1000 Then
			bitwalker_action_status[gnum] = False
			Return True
		End If
	Case BITWALKER_ACTION_WALK_LEFT
		If bitwalker_distance[gnum] >= bitwalker_travel_distance Then
			bitwalker_action_status[gnum] = False
			Return True
		End If
	Case BITWALKER_ACTION_WALK_LEFT2
		If bitwalker_distance[gnum] >= bitwalker_travel_distance Then
			bitwalker_action_status[gnum] = False
			Return True
		End If
	Case BITWALKER_ACTION_SHOOT_LEFT
		'If timer - bitwalker_action_time[gnum] > 2000 Then
		'	bitwalker_action_status[gnum] = False
		'	Return True
		'End If
	Case BITWALKER_ACTION_STAND_RIGHT
		If timer - bitwalker_action_time[gnum] > 1000 Then
			bitwalker_action_status[gnum] = False
			Return True
		End If
	Case BITWALKER_ACTION_WALK_RIGHT
		If bitwalker_distance[gnum] >= bitwalker_travel_distance Then
			bitwalker_action_status[gnum] = False
			Return True
		End If
	Case BITWALKER_ACTION_SHOOT_RIGHT
		'If timer - bitwalker_action_time[gnum] > 2000 Then
		'	bitwalker_action_status[gnum] = False
		'	Return True
		'End If
	Case BITWALKER_ACTION_STUN_LEFT
		If timer - bitwalker_action_time[gnum] > bitwalker_stun_time[gnum] Then
			bitwalker_action_status[gnum] = false
			Return True
		End If
	Case BITWALKER_ACTION_STUN_RIGHT
		If timer - bitwalker_action_time[gnum] > bitwalker_stun_time[gnum] Then
			bitwalker_action_status[gnum] = false
			Return True
		End If
	Case BITWALKER_ACTION_DEATH
		If Actor_AnimationEnded[bitwalker_death_actor[gnum]] Then
			bitwalker_action_status[gnum] = false
			'print "end death"
			Return True
		End If
	End Select
End Function

'walk left 20 steps
'stand left 1 sec
'walk right 20 steps
'stand right 1 sec
Dim BITWALKER_DIR_LEFT
Dim BITWALKER_DIR_RIGHT
BITWALKER_DIR_LEFT = 0
BITWALKER_DIR_RIGHT = 2
Function BITWALKER_GetDirection(gnum)
	a = bitwalker_action[gnum]
	If a = BITWALKER_ACTION_SHOOT_LEFT Or a = BITWALKER_ACTION_SLASH_LEFT Or a = BITWALKER_ACTION_STAND_LEFT Or a = BITWALKER_ACTION_WALK_LEFT Or a = BITWALKER_ACTION_STUN_LEFT Then
		Return BITWALKER_DIR_LEFT
	Else
		Return BITWALKER_DIR_RIGHT
	End If
End Function

Dim bitwalker_weapon_impact[MAX_BITWALKERS, MAX_BITWALKER_BULLETS]

Sub BITWALKER_Attack_Collision(gz_id, gnum)
	For i = 0 to MAX_BITWALKER_BULLETS-1
		bullet_actor = bitwalker_weapon_actor[gnum, i]
		
		'if bullet_actor = 0 Then
		'	print "bt = ";gnum
		'	print "bullet = ";bitwalker_weapon_actor[gnum, i]
		'end if
		
		If Actor_isActive(bullet_actor) Then
			
			Select Case Actor_Physics_State[bullet_actor]
			Case PHYSICS_STATE_FALL
				Select Case Actor_CurrentAnimation[bullet_actor]
				Case 0
					Actor_SetAnimation(bullet_actor, 1)
				Case 2
					Actor_SetAnimation(bullet_actor, 3)
				End Select
			End Select
			
			If (bitwalker_weapon_impact[gnum, i] And Actor_AnimationEnded[bullet_actor]) Then
				bitwalker_weapon_impact[gnum, i] = False
				Actor_SetActive(bullet_actor, False)
			'ElseIf (Not Actor_isOnScreen(bullet_actor)) Then
			'	bitwalker_weapon_impact[gnum, i] = False
			'	Actor_SetActive(bullet_actor, False)
			ElseIf ( Not bitwalker_weapon_impact[gnum,i] ) And Actor_NumStageCollisions[bullet_actor] > 0 Then
				If Actor_isOnScreen(bullet_actor) Then
					PlaySound(impact_sound_3, 0, 0)
				End If
				Actor_SetAnimationByName(bullet_actor, "EXPLODE")
				Actor_Physics[bullet_actor] = False
				bitwalker_weapon_impact[gnum, i] = True
			ElseIf Actor_GetCollision(gz_id, bullet_actor) And (Not Player_isStunned) And(Not bitwalker_weapon_impact[gnum,i]) Then
				Player_isStunned = True
				Player_Stun_Time = Timer
				If Graizor_Direction = GRAIZOR_DIRECTION_RIGHT Then
					Player_Current_Action = PLAYER_ACTION_STUN_RIGHT
					Player_Stun_Speed = -4
				Else
					Player_Current_Action = PLAYER_ACTION_STUN_LEFT
					Player_Stun_Speed = 4
				End If
				Actor_Jump[gz_id] = 10
				'Actor_Force_X[0] = 2
				Actor_Force_Y[gz_id] = -3
				'Actor_Momentum[0] = 2
				Actor_Weight[gz_id] = 3
				Actor_Physics_State[gz_id] = PHYSICS_STATE_RISE
				Actor_SetActive(Actor_ChildActor[gz_id], false)
				Graizor_Health = Graizor_Health - bitwalker_bullet_attack
				PlaySound(impact_sound_3, 0, 0)
				Actor_SetAnimationByName(bullet_actor, "EXPLODE")
				
				Actor_Physics[bitwalker_weapon_actor[gnum,i]] = False
				
				Actor_SetAnimationFrame(bullet_actor, 0)
				bitwalker_weapon_impact[gnum, i] = True
			'ElseIf Actor_isActive(bullet_actor) And (Not bitwalker_weapon_impact[gnum, i]) Then
				'Actor_Move(bullet_actor, bitwalker_weapon_speed[gnum, i], 0)
				'print "actor_name = "; Actor_Name[bullet_actor]
				'print "actor info:   gnum=";gnum;"      i=";i
				'print "": print ""
			End If
		End If
	Next
End Sub

Sub AI_BITWALKER(gnum, gz_id)
	actor = bitwalker_actor[gnum]
	action = bitwalker_action[gnum]
	
	'print "action = ";action
	
	If Actor_Y[actor] > Stage_End_Y Then
		bitwalker_alive[gnum] = false
		Actor_SetActive(bitwalker_actor[gnum], false)
	End If
	
	If bitwalker_health[gnum] <= 0 And bitwalker_alive[gnum] And bitwalker_action[gnum] <> BITWALKER_ACTION_DEATH Then
		'Play death animation
		AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_DEATH)
	End If
	
	BITWALKER_Attack_Collision(gz_id, gnum)
	
	'If (Not Player_isStunned) And bitwalker_alive[gnum] And action <> BITWALKER_ACTION_DEATH And (action = BITWALKER_ACTION_STAND_LEFT Or action = BITWALKER_ACTION_STAND_RIGHT Or action = BITWALKER_ACTION_SHOOT_LEFT Or action = BITWALKER_ACTION_SHOOT_RIGHT) Then
	'	If Actor_GetDistance(gz_id, actor) <= 300 Then
	'		If Actor_X[gz_id] <= Actor_X[actor] Then
	'			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_SHOOT_LEFT)
	'		Else
	'			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_SHOOT_RIGHT)
	'		End If
	'	ElseIf bitwalker_action[gnum] = BITWALKER_ACTION_SHOOT_LEFT Or bitwalker_action[gnum] = BITWALKER_ACTION_SHOOT_RIGHT Then
	'		AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_STAND_LEFT)
	'	End If
	'End If
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> BITWALKER_ACTION_STUN_LEFT and action <> BITWALKER_ACTION_STUN_RIGHT Then
		If BITWALKER_GetDirection(gnum) = BITWALKER_DIR_LEFT Then
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_STUN_LEFT)
		Else
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_STUN_RIGHT)
		End If
		bitwalker_stun_time[gnum] = 250 + add_stun_time
		bitwalker_health[gnum] = bitwalker_health[gnum] - Graizor_Sword_Attack
	ElseIf bitwalker_enemy[gnum] >= 0 Then
		If enemy_hit[bitwalker_enemy[gnum]] and action <> BITWALKER_ACTION_STUN_LEFT and action <> BITWALKER_ACTION_STUN_RIGHT Then
			If BITWALKER_GetDirection(gnum) = BITWALKER_DIR_LEFT Then
				AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_STUN_LEFT)
			Else
				AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_STUN_RIGHT)
			End If
			bitwalker_stun_time[gnum] = 100 + add_stun_time
			bitwalker_health[gnum] = bitwalker_health[gnum] - blaster_atk
		End If
	End If
	
	bitwalker_enemy[gnum] = -1
	
	AI_BITWALKER_RunAction(gnum)
	
	If AI_BITWALKER_ActionComplete(gnum) Then
		'print "change"
		Select Case action
		Case BITWALKER_ACTION_STAND_LEFT
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_STAND_LEFT)
		Case BITWALKER_ACTION_WALK_LEFT
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_WALK_LEFT2)
		Case BITWALKER_ACTION_WALK_LEFT2
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_WALK_LEFT)
		Case BITWALKER_ACTION_SHOOT_LEFT
			
		Case BITWALKER_ACTION_STAND_RIGHT
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_STAND_LEFT)
		Case BITWALKER_ACTION_WALK_RIGHT
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_WALK_RIGHT2)
		Case BITWALKER_ACTION_WALK_RIGHT2
			AI_BITWALKER_StartAction(gnum, BITWALKER_ACTION_WALK_RIGHT)
		Case BITWALKER_ACTION_SHOOT_RIGHT
			
		Case BITWALKER_ACTION_STUN_LEFT
			AI_BITWALKER_StartAction(gnum, bitwalker_start_action[gnum])
		Case BITWALKER_ACTION_STUN_RIGHT
			AI_BITWALKER_StartAction(gnum, bitwalker_start_action[gnum])
		Case BITWALKER_ACTION_DEATH
			Actor_SetActive(bitwalker_death_actor[gnum], false)
			'Actor_SetActive(bitwalker_weapon_actor[gnum], false)
			bitwalker_action[gnum] = 0
			bitwalker_alive[gnum] = false
		End Select
	End If
	
	If bitwalker_alive[gnum] Then
		enemy[num_enemies] = bitwalker_actor[gnum]
		enemy_hit[num_enemies] = False
		bitwalker_enemy[gnum] = num_enemies
		num_enemies = num_enemies + 1
	Else
		bitwalker_enemy[gnum] = -1
	End If
End Sub

Sub BITWALKER_Act(gz_id)
	For i = 0 to MAX_BITWALKERS-1
		If bitwalker_alive[i] And Actor_GetDistance(bitwalker_actor[i], gz_id) < 800 Then
			AI_BITWALKER(i, gz_id)
		ElseIf bitwalker_actor[i] >= 0 Then
			'print"": print "actor !!!!"
			BITWALKER_Attack_Collision(gz_id, i)
		End If
	Next
End Sub
