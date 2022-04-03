Dim boss_alive
Dim boss_actor
Dim boss_action
Dim boss_action_time
Dim boss_action_lock
Dim boss_action_status

Dim BOSS_ACTION_STAND_LEFT
Dim BOSS_ACTION_WALK_LEFT
Dim BOSS_ACTION_SHOOT_LEFT
Dim BOSS_ACTION_SLASH_LEFT
Dim BOSS_ACTION_STALL1_LEFT
Dim BOSS_ACTION_STALL2_LEFT
Dim BOSS_ACTION_SPECIAL1_LEFT
Dim BOSS_ACTION_SPECIAL2_LEFT
Dim BOSS_ACTION_SPECIAL3_LEFT

Dim BOSS_ACTION_STAND_RIGHT
Dim BOSS_ACTION_WALK_RIGHT
Dim BOSS_ACTION_SHOOT_RIGHT
Dim BOSS_ACTION_SLASH_RIGHT
Dim BOSS_ACTION_STALL1_RIGHT
Dim BOSS_ACTION_STALL2_RIGHT
Dim BOSS_ACTION_SPECIAL1_RIGHT
Dim BOSS_ACTION_SPECIAL2_RIGHT
Dim BOSS_ACTION_SPECIAL3_RIGHT


Dim BOSS_ACTION_STUN_LEFT
Dim BOSS_ACTION_STUN_RIGHT

Dim BOSS_ACTION_DEATH

BOSS_ACTION_STAND_LEFT = 0
BOSS_ACTION_WALK_LEFT = 1
BOSS_ACTION_SHOOT_LEFT = 2
BOSS_ACTION_SLASH_LEFT = 3
BOSS_ACTION_STALL1_LEFT = 4
BOSS_ACTION_STALL2_LEFT = 5
BOSS_ACTION_SPECIAL1_LEFT = 6
BOSS_ACTION_SPECIAL2_LEFT = 7
BOSS_ACTION_SPECIAL3_LEFT = 8

BOSS_ACTION_STAND_RIGHT = 9
BOSS_ACTION_WALK_RIGHT = 10
BOSS_ACTION_SHOOT_RIGHT = 11
BOSS_ACTION_SLASH_RIGHT = 12
BOSS_ACTION_STALL1_RIGHT = 13
BOSS_ACTION_STALL2_RIGHT = 14
BOSS_ACTION_SPECIAL1_RIGHT = 15
BOSS_ACTION_SPECIAL2_RIGHT = 16
BOSS_ACTION_SPECIAL3_RIGHT = 17

BOSS_ACTION_STUN_LEFT = 18
BOSS_ACTION_STUN_RIGHT = 19

BOSS_ACTION_DEATH = 20

Dim boss_distance

Dim boss_health
Dim boss_weapon1_actor
Dim boss_weapon2_actor
Dim boss_weapon3_actor
Dim boss_weapon4_actor
Dim boss_death_actor

Dim boss_walk_speed
Dim boss_weapon1_attack
Dim boss_weapon2_attack
Dim boss_weapon3_attack
Dim boss_weapon4_attack

Dim boss_stun_timer

boss_weapon1_attack = 1
boss_weapon2_attack = 1

boss_walk_speed = 2
boss_travel_distance = 20

Dim boss_pattern
Dim boss_step
Dim boss_attribute1

Dim boss_projectile1[200]
Dim boss_projectile1_hit[200]
Dim boss_projectile1_count
Dim boss_projectile1_numActive
Dim boss_projectile1_flag
Dim boss_projectile1_gz_hit

Dim boss_action_split

Dim boss_enemy

Dim boss_location[5, 2]

Dim boss_complete

Sub AI_Boss1_RunAction()
	actor = boss_actor
	wpn = boss_weapon1_actor
	action = boss_action
	
	Select Case action
	Case BOSS_ACTION_STAND_LEFT
		'Do nothing for now
	Case BOSS_ACTION_WALK_LEFT
		If timer - boss_action_time > 15 Then
			Actor_Move(actor, -1 * boss_walk_speed, 0)
			boss_distance = boss_distance + 1
			boss_action_time = timer
		End If
	Case BOSS_ACTION_SHOOT_LEFT
		'Do nothing for now
	Case BOSS_ACTION_SLASH_LEFT
		'Actor_Move(actor, -3, 0)
		'Actor_SetPosition(wpn, Actor_X[actor] - 62, Actor_Y[actor])
	Case BOSS_ACTION_STALL1_LEFT
	
	Case BOSS_ACTION_STALL2_LEFT
		If Sprite_Animation_Name$[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]] = "stretch_left" And Actor_CurrentFrame[boss_weapon1_actor] = Sprite_Animation_NumFrames[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]]-1 Then
			Actor_SetAnimationByName(boss_weapon1_actor, "retract_left")
			Actor_SetAnimationFrame(boss_weapon1_actor, 0)
		End If
	Case BOSS_ACTION_STAND_RIGHT
		'Do nothing for now
	Case BOSS_ACTION_WALK_RIGHT
		If timer - boss_action_time > 15 Then
			Actor_Move(actor, boss_walk_speed, 0)
			boss_distance = boss_distance + 1
			boss_action_time = timer
		End If
	Case BOSS_ACTION_SHOOT_RIGHT
		'Do nothing for now
	Case BOSS_ACTION_SLASH_RIGHT
		'Actor_Move(actor, 3, 0)
		'Actor_SetPosition(wpn, Actor_X[actor], Actor_Y[actor])
	
	Case BOSS_ACTION_STALL2_RIGHT
		If Sprite_Animation_Name$[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]] = "stretch_right" And Actor_CurrentFrame[boss_weapon1_actor] = Sprite_Animation_NumFrames[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]]-1 Then
			Actor_SetAnimationByName(boss_weapon1_actor, "retract_right")
			Actor_SetAnimationFrame(boss_weapon1_actor, 0)
			'PRINT "TESTING"
		End If
	
	Case BOSS_ACTION_STUN_LEFT
		If boss_distance < 5 Then
			Actor_Move(actor, 1, 0)
			boss_distance = boss_distance + 1	
		End If
	Case BOSS_ACTION_SPECIAL3_LEFT
		If boss_step = 0 Or boss_step = 2 Then
			boss_attribute1 = boss_attribute1 - 5
		Else
			boss_attribute1 = boss_attribute1 + 5
			Actor_SetPosition(GetActorID("leaves"), Actor_X[boss_actor], Actor_Y[boss_actor])
		End If
		Sprite_SetAlpha(Actor_Sprite[GetActorID("leaves")], boss_attribute1)
	Case BOSS_ACTION_STUN_RIGHT
		If boss_distance < 5 Then
			Actor_Move(actor, -1, 0)
			boss_distance = boss_distance + 1	
		End If
	Case BOSS_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[guard_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[guard_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[guard_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[guard_death_actor[gnum]]
	Case BOSS_ACTION_SPECIAL1_RIGHT
		If boss_step = 0 Or boss_step = 2 Then
			boss_attribute1 = boss_attribute1 - 5
		Else
			boss_attribute1 = boss_attribute1 + 5
			Actor_SetPosition(GetActorID("leaves"), Actor_X[boss_actor], Actor_Y[boss_actor])
		End If
		Sprite_SetAlpha(Actor_Sprite[GetActorID("leaves")], boss_attribute1)
	Case BOSS_ACTION_SPECIAL2_RIGHT
		'print "spc"
		If boss_step >= 1 Then
			'If timer - boss_action_time > 1000 And boss_projectile1_flag < 3 Then
			'	For i = boss_projectile1_flag to boss_projectile1_count - 1 step 3
			'		Actor_SetActive(boss_projectile1[i], True)
			'	Next
			'	boss_projectile1_flag = boss_projectile1_flag + 1
			'	boss_action_time = timer
			'End If
			'print "this is a test"
			bounds = GetActorID("bounds")
			'print "bounds -> ";bounds;" -- ";Actor_Active[bounds]
			
			f = 0
			
			For i = 0 to boss_projectile1_count-1
				If Actor_isActive(boss_projectile1[i]) Then
					'print "f test -> ";i
					f = f + 1
					If Actor_GetCollision(boss_projectile1[i], bounds) And Not boss_projectile1_hit[i] Then
						Actor_SetAnimationByName(boss_projectile1[i], "splash")
						boss_projectile1_hit[i] = True
					ElseIf Actor_GetCollision(boss_projectile1[i], graizor) And (Not boss_projectile1_hit[i]) Then
						Actor_SetAnimationByName(boss_projectile1[i], "splash")
						boss_projectile1_hit[i] = True
						boss_projectile1_gz_hit = True
					ElseIf boss_projectile1_hit[i] And Actor_AnimationEnded[boss_projectile1[i]] Then
						Actor_SetActive(boss_projectile1[i], False)
						boss_projectile1_hit[i] = False
					ElseIf Actor_Y[boss_projectile1[i]] > Actor_Y[bounds] Then
						Actor_SetActive(boss_projectile1[i], False)
						boss_projectile1_hit[i] = False
					ElseIf Not boss_projectile1_hit[i] Then
						Actor_Move(boss_projectile1[i], 0, 6)
					End If
				End If
			Next
			
			If Not f Then
				boss_step = 2
			End If
			
		ElseIf boss_projectile1_numActive = 10 And Actor_Y[boss_projectile1[boss_projectile1_numActive-1]] < 590 Then
			stagger = 0
			sx = 0
			sy = 0
			i = 0
			'For i = 0 to boss_projectile1_count-1
			For sy = 0 to 3
				stagger = not stagger
				For sx = 0 to 6
					'x 520 +40x
					Actor_SetActive(boss_projectile1[i], True)
					Actor_SetPosition(boss_projectile1[i], 500 + (sx*100) + (stagger * 48), 400 - sy*120)
					Actor_SetAnimation(boss_projectile1[i], 1)
					Actor_SetAnimationFrame(boss_projectile1[i], 0)
					Actor_SetLayer(boss_projectile1[i], 2)
					Actor_Physics[boss_projectile1[i]] = False
					i = i + 1
				Next
			Next
			
			boss_projectile1_flag = 0
			boss_step = 1
			boss_action_time = timer
		Else
			'print "tst: ";boss_projectile1_count;" -> ";boss_projectile1_numActive
			'print "boss timer = ";(timer - boss_action_time)
			If (timer - boss_action_time) > 100 And boss_projectile1_numActive < 10 Then
				'print "-----RTST--------"
				Actor_SetActive(boss_projectile1[boss_projectile1_numActive], True)
				Actor_SetLayer(boss_projectile1[boss_projectile1_numActive], 2)
				Actor_SetPosition(boss_projectile1[boss_projectile1_numActive], 305, 790)
				boss_projectile1_numActive = boss_projectile1_numActive + 1
				boss_action_time = timer
			End If
			
			For i = 0 to boss_projectile1_numActive
				Actor_Move(boss_projectile1[i], 0, -6)
			Next
			
		End If
	Case BOSS_ACTION_SPECIAL3_RIGHT
		If boss_step = 0 Or boss_step = 2 Then
			boss_attribute1 = boss_attribute1 - 5
		Else
			boss_attribute1 = boss_attribute1 + 5
			Actor_SetPosition(GetActorID("leaves"), Actor_X[boss_actor], Actor_Y[boss_actor])
		End If
		Sprite_SetAlpha(Actor_Sprite[GetActorID("leaves")], boss_attribute1)
	End Select
End Sub

Sub AI_Boss1_StartAction(action)
	If action = BOSS_ACTION_STALL1_RIGHT And Actor_X[graizor] < Actor_X[boss_actor] Then
		action = BOSS_ACTION_STALL1_LEFT
	ElseIf action = BOSS_ACTION_STALL1_LEFT And Actor_X[graizor] > Actor_X[boss_actor] Then
		action = BOSS_ACTION_STALL1_RIGHT
	End If
	Select Case action
	Case BOSS_ACTION_STAND_LEFT
		Actor_SetAnimationByName(boss_actor, "stand_left")
		Actor_SetAnimationFrame(boss_actor, 0)
		boss_action_time = timer
	Case BOSS_ACTION_WALK_LEFT
		Actor_SetAnimationByName(boss_actor, "walk_left")
		boss_distance = 0
	Case BOSS_ACTION_SHOOT_LEFT
		Actor_SetAnimationByName(boss_actor, "shoot_left")
		boss_action_time = timer
	Case BOSS_ACTION_SLASH_LEFT
		Actor_SetAnimationByName(boss_actor, "slash_left")
		Actor_SetAnimationFrame(boss_actor, 0)
		boss_action_time = timer
	Case BOSS_ACTION_STALL1_LEFT
		'p0
		'Print "STALL1 LEFT ";boss_pattern
		Actor_SetAnimationByName(boss_actor, "stall1_left")
		boss_action_time = timer
	Case BOSS_ACTION_STALL2_LEFT
		boss_action_time = timer
		Actor_SetAnimationByName(boss_actor, "stall2_left")
		Actor_SetAnimationFrame(boss_actor, 0)
		
		Actor_SetActive(boss_weapon1_actor, true)
		Actor_SetAnimationByName(boss_weapon1_actor, "stretch_left")
		Actor_SetAnimationFrame(boss_weapon1_actor, 0)
		Actor_SetPosition(boss_weapon1_actor, Actor_X[boss_actor]-218, Actor_Y[boss_actor]+16)
	Case BOSS_ACTION_SPECIAL3_LEFT
		Actor_SetActive(boss_actor, false)
		Actor_SetActive(GetActorID("leaves"), true)
		Actor_SetAnimation(GetActorID("leaves"), 0)
		Actor_SetAnimationFrame(GetActorID("leaves"), 0)
		Actor_SetPosition(GetActorID("leaves"), Actor_X[boss_actor], Actor_Y[boss_actor])
		'Actor_SetPosition(boss_actor, 306, 790)
		boss_action_time = timer
		boss_attribute1 = 255
		boss_step = 0
	Case BOSS_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(boss_actor, "stand_right")
		Actor_SetAnimationFrame(boss_actor, 0)
		boss_action_time = timer
	Case BOSS_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(boss_actor, "walk_right")
		boss_distance = 0
	Case BOSS_ACTION_SHOOT_RIGHT
		Actor_SetAnimationByName(boss_actor, "shoot_right")
		boss_action_time = timer
	
	Case BOSS_ACTION_SLASH_RIGHT
		'PRINT "SLASH RIGHT"
		Actor_SetAnimationByName(boss_actor, "slash_right")
		Actor_SetAnimationFrame(boss_actor, 0)
		boss_action_time = timer
		
	Case BOSS_ACTION_STALL1_RIGHT
		'p2
		'Print "STALL1_RIGHT:";boss_pattern
		Actor_SetAnimationByName(boss_actor, "stall1_right")
		boss_action_time = timer
	Case BOSS_ACTION_STALL2_RIGHT
		'PRINT "STALL2_RIGHT"
		boss_action_time = timer
		Actor_SetAnimationByName(boss_actor, "stall2_right")
		Actor_SetAnimationFrame(boss_actor, 0)
		
		Actor_SetActive(boss_weapon1_actor, true)
		Actor_SetAnimationByName(boss_weapon1_actor, "stretch_right")
		'PRINT "THIS IS A TEST"
		Actor_SetAnimationFrame(boss_weapon1_actor, 0)
		Actor_SetPosition(boss_weapon1_actor, Actor_X[boss_actor]+64, Actor_Y[boss_actor]+16)
	
	Case BOSS_ACTION_STUN_LEFT
		'Actor_SetAnimationByName(boss_actor, "stun_left")
		'Actor_SetAnimationFrame(boss_actor, 0)
		'Actor_SetActive(boss_weapon1_actor, false)
		boss_action_time = timer
		boss_distance = 0
		PlaySound(1, 0, 0)
	Case BOSS_ACTION_STUN_RIGHT
		'Actor_SetAnimationByName(boss_actor, "stun_right")
		'Actor_SetAnimationFrame(boss_actor, 0)
		'Actor_SetActive(boss_weapon1_actor, false)
		boss_action_time = timer
		boss_distance = 0
		PlaySound(1, 0, 0)
	Case BOSS_ACTION_DEATH
		Actor_SetActive(boss_actor, false)
		Actor_SetActive(boss_weapon1_actor, false)
		Actor_SetActive(boss_death_actor, true)
		Actor_SetAnimation(boss_death_actor, 0)
		Actor_SetAnimationFrame(boss_death_actor, 0)
		Actor_SetPosition(boss_death_actor, Actor_X[boss_actor], Actor_Y[boss_actor])
		boss_action_time = timer
		PlaySound(3, 1, 0)
	Case BOSS_ACTION_SPECIAL1_RIGHT
		Actor_SetActive(boss_actor, false)
		Actor_SetActive(GetActorID("leaves"), true)
		Actor_SetAnimation(GetActorID("leaves"), 0)
		Actor_SetAnimationFrame(GetActorID("leaves"), 0)
		Actor_SetPosition(GetActorID("leaves"), Actor_X[boss_actor], 950)
		Actor_SetPosition(boss_actor, 306, 790)
		boss_action_time = timer
		boss_attribute1 = 255
		boss_step = 0
	Case BOSS_ACTION_SPECIAL2_RIGHT
		'print "start 2"
		boss_action_time = timer
		boss_step = 0
		boss_pattern = 1
		Actor_SetAnimationByName(boss_actor, "stall1_right")
		Actor_SetAnimationFrame(boss_actor, 0)
		
		For i = 0 To 27
			'boss_projectile1[i] = NewActor("thorn" + str(i), GetSpriteID("thorn"))
			Actor_SetActive(boss_projectile1[i], False)
			Actor_Physics[boss_projectile1[i]] = False
			Actor_SetAnimationByName(boss_projectile1[i], "up")
			Actor_SetAnimationFrame(boss_projectile1[i], 0)
			boss_projectile1_hit[i] = false
		Next
		boss_projectile1_gz_hit = false
		
		boss_projectile1_count = 28
		boss_projectile1_numActive = 0
		
		boss_action_time = timer
	Case BOSS_ACTION_SPECIAL3_RIGHT
		Actor_SetActive(boss_actor, false)
		Actor_SetActive(GetActorID("leaves"), true)
		Actor_SetAnimation(GetActorID("leaves"), 0)
		Actor_SetAnimationFrame(GetActorID("leaves"), 0)
		Actor_SetPosition(GetActorID("leaves"), Actor_X[boss_actor], Actor_Y[boss_actor])
		'Actor_SetPosition(boss_actor, 306, 790)
		boss_action_time = timer
		boss_attribute1 = 255
	End Select
	boss_action = action
	boss_action_status = true
End Sub

Function AI_Boss1_ActionComplete()
	If Not boss_action_status Then
		Return True
	End If
	action = boss_action
	Select Case action
	Case BOSS_ACTION_STAND_LEFT
		If timer - boss_action_time > 1000 Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_WALK_LEFT
		If boss_distance >= boss_travel_distance Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_SHOOT_LEFT
		If timer - boss_action_time > 2000 Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_SLASH_LEFT
		If Actor_CurrentFrame[boss_actor] = Sprite_Animation_NumFrames[Actor_Sprite[boss_actor], Actor_CurrentAnimation[boss_actor]]-1 Then
			boss_action_status = False
			Actor_SetActive(boss_weapon1_actor, false)
			Return True
		End If
	Case BOSS_ACTION_STALL1_LEFT
		If timer - boss_action_time > 700 Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_STALL2_LEFT
		If Sprite_Animation_Name$[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]] = "retract_left" And Actor_CurrentFrame[boss_weapon1_actor] = Sprite_Animation_NumFrames[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]]-1 Then
			Actor_SetActive(boss_weapon1_actor, False)
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_SPECIAL3_LEFT
		If boss_step = 2 And boss_attribute1 <= 0 Then
			boss_action_status = false
			Return True
		ElseIf boss_step = 0 And boss_attribute1 <= 0 Then
			boss_step = 1
		ElseIf boss_step = 1 And boss_attribute1 >= 255 Then
			boss_step = 2
			Actor_SetActive(boss_actor, true)
			Actor_SetAnimationByName(boss_actor, "stall1_left")
			Actor_SetAnimationFrame(boss_actor, 0)
		End If
		
		
	Case BOSS_ACTION_STAND_RIGHT
		If timer - boss_action_time > 1000 Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_WALK_RIGHT
		If boss_distance >= boss_travel_distance Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_SHOOT_RIGHT
		If timer - boss_action_time > 2000 Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_SLASH_RIGHT
		If Actor_CurrentFrame[boss_actor] = Sprite_Animation_NumFrames[Actor_Sprite[boss_actor], Actor_CurrentAnimation[boss_actor]]-1 Then
			boss_action_status = False
			Actor_SetActive(boss_weapon1_actor, false)
			Return True
		End If
	Case BOSS_ACTION_STALL1_RIGHT
		If timer - boss_action_time > 700 Then
			boss_action_status = False
			Return True
		End If
	Case BOSS_ACTION_STALL2_RIGHT
		If Sprite_Animation_Name$[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]] = "retract_right" And Actor_CurrentFrame[boss_weapon1_actor] = Sprite_Animation_NumFrames[Actor_Sprite[boss_weapon1_actor], Actor_CurrentAnimation[boss_weapon1_actor]]-1 Then
			Actor_SetActive(boss_weapon1_actor, False)
			boss_action_status = False
			Return True
		End If
	
	Case BOSS_ACTION_DEATH
		If Actor_AnimationEnded[boss_death_actor] Then
			boss_action_status = false
			boss_complete = True
			'print "end death"
			Return True
		End If
	Case BOSS_ACTION_SPECIAL1_RIGHT
		If boss_step = 2 And boss_attribute1 <= 0 Then
			boss_action_status = false
			Return True
		ElseIf boss_step = 0 And boss_attribute1 <= 0 Then
			boss_step = 1
		ElseIf boss_step = 1 And boss_attribute1 >= 255 Then
			boss_step = 2
			Actor_SetActive(boss_actor, true)
			Actor_SetAnimationByName(boss_actor, "stall1_right")
			Actor_SetAnimationFrame(boss_actor, 0)
		End If
	Case BOSS_ACTION_SPECIAL2_RIGHT
		If boss_step = 2 Then
			boss_action_status = false
			Return True
		End If
	Case BOSS_ACTION_SPECIAL3_RIGHT
		If boss_step = 2 And boss_attribute1 <= 0 Then
			boss_action_status = false
			Return True
		ElseIf boss_step = 0 And boss_attribute1 <= 0 Then
			boss_step = 1
		ElseIf boss_step = 1 And boss_attribute1 >= 255 Then
			boss_step = 2
			Actor_SetActive(boss_actor, true)
			Actor_SetAnimationByName(boss_actor, "stall1_right")
			Actor_SetAnimationFrame(boss_actor, 0)
		End If
	End Select
End Function

'330 750

'walk left 20 steps
'stand left 1 sec
'walk right 20 steps
'stand right 1 sec
Dim BOSS_DIR_LEFT
Dim BOSS_DIR_RIGHT
BOSS_DIR_LEFT = 0
BOSS_DIR_RIGHT = 2

Function Boss_GetDirection()
	a = boss_action
	If a = BOSS_ACTION_SHOOT_LEFT Or a = BOSS_ACTION_SLASH_LEFT Or a = BOSS_ACTION_STAND_LEFT Or a = BOSS_ACTION_WALK_LEFT Or a = BOSS_ACTION_STUN_LEFT Then
		Return BOSS_DIR_LEFT
	Else
		Return BOSS_DIR_RIGHT
	End If
End Function

Dim boss_extra_hitbox 'adding an extra hitbox to the boss to force player to have to dodge behind it

Sub Boss_Attack_Collision(gz_id)
	If ( Actor_GetCollision(gz_id, boss_weapon1_actor) Or Actor_GetCollision(gz_id, boss_extra_hitbox) ) And (Not Player_isStunned) Then
		Player_isStunned = True
		Player_Stun_Time = Timer
		If Player_Action <= 15 Then
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
		Graizor_Health = Graizor_Health - boss_weapon1_attack
		PlaySound(1, 0, 0)
	ElseIf boss_projectile1_gz_hit And (Not Player_isStunned) Then
		boss_projectile1_gz_hit = False
		Player_isStunned = True
		Player_Stun_Time = Timer
		If Player_Action <= 15 Then
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
		Graizor_Health = Graizor_Health - boss_weapon1_attack
		PlaySound(1, 0, 0)
	End If
End Sub

prev_pattern = 0

Sub AI_Boss1(gz_id)
	actor = boss_actor
	action = boss_action
	
	'print "action = ";action
	
	If Actor_Y[boss_actor] > Stage_End_Y Then
		boss_alive = false
		Actor_SetActive(boss_actor, false)
	End If
	
	If boss_health <= 0 And boss_alive And boss_action <> BOSS_ACTION_DEATH Then
		'Play death animation
		'print "test"
		AI_Boss1_StartAction(BOSS_ACTION_DEATH)
	End If
	
	Boss_Attack_Collision(gz_id)
	
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> BOSS_ACTION_STUN_LEFT and action <> BOSS_ACTION_STUN_RIGHT and (timer-boss_stun_timer>250) Then
		boss_stun_timer = timer
		PlaySound(1, 0, 0)
		boss_health = boss_health - Graizor_Sword_Attack
	ElseIf boss_enemy >= 0 Then
		If enemy_hit[boss_enemy] and action <> BOSS_ACTION_STUN_LEFT and action <> BOSS_ACTION_STUN_RIGHT and (timer-boss_stun_timer>400) Then
			'boss_stun_timer = timer
			boss_health = boss_health - blaster_atk
			PlaySound(1, 0, 0)
		End If
	End If
	
	boss_enemy = 0
	
	AI_Boss1_RunAction()
	
	If AI_Boss1_ActionComplete() Then
		'print "change"
		Select Case boss_pattern
		Case 0
			Select Case action
			Case BOSS_ACTION_STAND_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_WALK_RIGHT)
			Case BOSS_ACTION_WALK_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_LEFT)
			Case BOSS_ACTION_SHOOT_LEFT
				
			Case BOSS_ACTION_SLASH_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STALL2_LEFT)
			Case BOSS_ACTION_STALL1_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_SLASH_LEFT)
			Case BOSS_ACTION_STALL2_LEFT
				boss_step = boss_step + 1
				If boss_step >= 3 Then
					boss_step = 0
					boss_pattern = 1
					prev_pattern = 0
					AI_Boss1_StartAction(BOSS_ACTION_SPECIAL1_RIGHT)
				Else
					AI_Boss1_StartAction(BOSS_ACTION_STALL1_LEFT)
				End If
			Case BOSS_ACTION_STAND_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_WALK_LEFT)
			Case BOSS_ACTION_WALK_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_RIGHT)
			Case BOSS_ACTION_SHOOT_RIGHT
				
			Case BOSS_ACTION_SLASH_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STALL2_RIGHT)
			Case BOSS_ACTION_STALL1_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_SLASH_RIGHT)
			Case BOSS_ACTION_STALL2_RIGHT
				boss_step = boss_step + 1
				If boss_step >= 3 Then
					'print "boss step = ";boss_step
					boss_step = 0
					boss_pattern = 1
					prev_pattern = 2
					
					AI_Boss1_StartAction(BOSS_ACTION_SPECIAL1_RIGHT)
				Else
					AI_Boss1_StartAction(BOSS_ACTION_STALL1_RIGHT)
				End If
			Case BOSS_ACTION_SPECIAL3_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_SLASH_LEFT)
				boss_step = 0
				'print "boss -- ";boss_pattern;" -- ";boss_step
			Case BOSS_ACTION_STUN_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_LEFT)
			Case BOSS_ACTION_STUN_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_RIGHT)
			Case BOSS_ACTION_DEATH
				Actor_SetActive(boss_death_actor, false)
				Actor_SetActive(boss_weapon1_actor, false)
				boss_action = 0
				boss_alive = false
			End Select
		Case 1
			Select Case action
			Case BOSS_ACTION_STAND_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_WALK_RIGHT)
			Case BOSS_ACTION_WALK_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_LEFT)
			Case BOSS_ACTION_SHOOT_LEFT
				
			Case BOSS_ACTION_SLASH_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STALL2_LEFT)
			Case BOSS_ACTION_STALL1_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_SLASH_LEFT)
			Case BOSS_ACTION_STALL2_LEFT
				boss_step = boss_step + 1
				If boss_step = 3 Then
					boss_step = 0
					boss_pattern = 1
					'AI_Boss1_StartAction(BOSS_ACTION_STAND_LEFT)
				Else
					AI_Boss1_StartAction(BOSS_ACTION_STALL1_LEFT)
				End If
			Case BOSS_ACTION_STAND_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_WALK_LEFT)
			Case BOSS_ACTION_WALK_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_RIGHT)
			Case BOSS_ACTION_SHOOT_RIGHT
				
			Case BOSS_ACTION_SLASH_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_RIGHT)
			Case BOSS_ACTION_STALL1_RIGHT
			
			Case BOSS_ACTION_STALL2_RIGHT
			
			Case BOSS_ACTION_STUN_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_LEFT)
			Case BOSS_ACTION_STUN_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_RIGHT)
			Case BOSS_ACTION_DEATH
				Actor_SetActive(boss_death_actor, false)
				Actor_SetActive(boss_weapon1_actor, false)
				boss_action = 0
				boss_alive = false
			Case BOSS_ACTION_SPECIAL1_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_SPECIAL2_RIGHT)
			Case BOSS_ACTION_SPECIAL2_RIGHT
				If prev_pattern = 0 Then
					boss_pattern = 2
					boss_step = 0
					Actor_SetPosition(boss_actor, 600, 950)
					AI_Boss1_StartAction(BOSS_ACTION_SPECIAL3_RIGHT)
				Else
					boss_pattern = 0
					boss_step = 0
					Actor_SetPosition(boss_actor, 800, 950)
					AI_Boss1_StartAction(BOSS_ACTION_SPECIAL3_LEFT)
				End If
			End Select
		Case 2
			Select Case action
			Case BOSS_ACTION_STAND_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_WALK_RIGHT)
			Case BOSS_ACTION_WALK_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_LEFT)
			Case BOSS_ACTION_SHOOT_LEFT
				
			Case BOSS_ACTION_SLASH_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STALL2_LEFT)
			Case BOSS_ACTION_STALL1_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_SLASH_LEFT)
			Case BOSS_ACTION_STALL2_LEFT
				boss_step = boss_step + 1
				If boss_step >= 3 Then
					boss_step = 0
					boss_pattern = 1
					prev_pattern = 2
					AI_Boss1_StartAction(BOSS_ACTION_SPECIAL1_RIGHT)
				Else
					AI_Boss1_StartAction(BOSS_ACTION_STALL1_LEFT)
				End If
			Case BOSS_ACTION_STAND_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_WALK_LEFT)
			Case BOSS_ACTION_WALK_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_RIGHT)
			Case BOSS_ACTION_SHOOT_RIGHT
				
			Case BOSS_ACTION_SLASH_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STALL2_RIGHT)
			Case BOSS_ACTION_STALL1_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_SLASH_RIGHT)
			Case BOSS_ACTION_STALL2_RIGHT
				boss_step = boss_step + 1
				If boss_step >= 3 Then
					'print "boss step = ";boss_step
					boss_step = 0
					boss_pattern = 1
					prev_pattern = 2
					
					AI_Boss1_StartAction(BOSS_ACTION_SPECIAL1_RIGHT)
				Else
					AI_Boss1_StartAction(BOSS_ACTION_STALL1_RIGHT)
				End If
			Case BOSS_ACTION_SPECIAL3_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_SLASH_RIGHT)
				boss_step = 0
			Case BOSS_ACTION_STUN_LEFT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_LEFT)
			Case BOSS_ACTION_STUN_RIGHT
				AI_Boss1_StartAction(BOSS_ACTION_STAND_RIGHT)
			Case BOSS_ACTION_DEATH
				Actor_SetActive(boss_death_actor, false)
				Actor_SetActive(boss_weapon1_actor, false)
				boss_action = 0
				boss_alive = false
			End Select
		End Select
	End If
	
	If boss_alive Then
		enemy[num_enemies] = boss_actor
		enemy_hit[num_enemies] = False
		boss_enemy = num_enemies
		num_enemies = num_enemies + 1
	End If
	
End Sub


Sub Stage1_Boss()
	LoadStage("stage1_boss.stage")
	
	boss_complete = 0
	
	Stage_Init(2)
	Graizor_Init
	
	boss_enemy = 0
	
	Terana = GetActorID("Terana")
	boss_actor = Terana
	Actor_Persistent[boss_actor] = True
	Actor_SetAnimationByName(Terana, "stand_left")
	Actor_Physics[Terana] = True
	Actor_Weight[Terana] = 5
	
	boss_extra_hitbox = NewActor("boss_extra_hitbox", NullSprite("boss_extra_hitbox", 20, 45))
	Actor_SetPosition(boss_extra_hitbox, 30, 22)
	Actor_SetLayer(boss_extra_hitbox, 2)
	Actor_Physics[boss_extra_hitbox] = False
	'Actor_SetActive(boss_extra_hitbox, False)
	
	boss_death_actor = NewActor("boss_death", GetSpriteID("explosion"))
	'boss_weapon1_actor = GetActorID("vine_whip")
	boss_weapon1_actor = NewActor("vine_whip", LoadSprite("vine_whip"))
	Actor_SetLayer(boss_weapon1_actor, 2)
	Actor_Physics[boss_weapon1_actor] = False
	
	'Print "boss_weapon = ";boss_weapon1_actor
	
	Actor_Persistent[boss_weapon1_actor] = True
	
	Actor_SetLayer(boss_death_actor, Actor_Layer[boss_actor])
	Actor_SetActive(boss_death_actor, false)
	boss_alive = True
	boss_health = 150
	
	boss_weapon2_actor = GetActorID("thorn")
	Actor_SetActive(boss_weapon2_actor, false)
	
	Actor_Physics[GetActorID("bounds")] = False

	n = Stage_Layer_Shape_Count[2] - 1
	'Stage_Layer_Shape_Type[2, n] = SHAPE_TYPE_DYNARECT
	
	AI_Boss1_StartAction(BOSS_ACTION_SLASH_LEFT)

	For i = 0 To 27
		boss_projectile1[i] = NewActor("thorn" + str(i), GetSpriteID("thorn"))
		Actor_SetActive(boss_projectile1[i], False)
		Actor_Persistent[boss_projectile1[i]] = True
		Actor_Physics[boss_projectile1[i]] = False
	Next
	
	
	'GRAIZOR POSITION
	Actor_SetPosition(graizor, 608, 950)
	
	cp = 0
	Init_Checkpoints
	Add_Checkpoint(576, 956)
	
	Init_Limits
	Add_Limit(2, 350, 1120, 2000, 32)
	
	Init_Boss_HBar(0, boss_health)

	While Not Key(K_ESCAPE)
		num_enemies = 0
		
		stage_limit = Get_Limit(graizor)
		
		If Graizor_CheckDeath Then
			If Player_Continues > 0 Then
				Player_Continues = Player_Continues -1
				StartFromCheckpoint(cp)
			Else
				Exit While
			End If
		ElseIf stage_limit >= 0 Then
			Graizor_Health = 0
			'Print "Limit = ";stage_limit
			'Actor_SetPosition(graizor, 96, 1600)
		End If
		
		If boss_complete Then
			Exit While
		End If
		
		AI_Boss1(graizor)
		'If Actor_X[boss_actor] <> Actor_X[boss_extra_hitbox] And Actor_isActive(boss_actor) Then
			Actor_SetPosition(boss_extra_hitbox, Actor_X[boss_actor] + 30, Actor_Y[boss_actor] + 22)
		'End If
		
		Player_Control(graizor)
		'Print Actor_Physics_State[1]
		
		st_x = 0
		st_y = 0
		If Actor_X[graizor] > 320 Then
			st_x = Actor_X[graizor] - 320
		End If
		
		If Actor_Y[graizor] > 240 Then
			st_y = Actor_Y[graizor] - 240
		End If
		
		
		Stage_SetOffset(st_x, st_y)
		
		
		DrawHud
		Boss_Hud(boss_health)
		
		Game_Render
		
	Wend
	
	Clear_Boss_HBar
	ClearStage(100,100)
End Sub
