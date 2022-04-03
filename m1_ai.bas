'include "engine.bas"

MAX_M1S = 10

Dim m1_init_pos[MAX_M1S, 2]

Dim m1_alive[MAX_M1S]
Dim m1_actor[MAX_M1S]
Dim m1_action[MAX_M1S]
Dim m1_action_time[MAX_M1S]
Dim m1_action_lock[MAX_M1S]
Dim m1_action_status[MAX_M1S]

Dim M1_ACTION_STAND_LEFT
Dim M1_ACTION_WALK_LEFT
Dim M1_ACTION_SHOOT_LEFT
Dim M1_ACTION_SLASH_LEFT

Dim M1_ACTION_STAND_RIGHT
Dim M1_ACTION_WALK_RIGHT
Dim M1_ACTION_SHOOT_RIGHT
Dim M1_ACTION_SLASH_RIGHT

Dim M1_ACTION_STUN_LEFT
Dim M1_ACTION_STUN_RIGHT

Dim M1_ACTION_DEATH

M1_ACTION_WALK_LEFT = 0
M1_ACTION_STAND_LEFT = 1
M1_ACTION_SHOOT_LEFT = 2
M1_ACTION_SLASH_LEFT = 3

M1_ACTION_WALK_RIGHT = 4
M1_ACTION_STAND_RIGHT = 5
M1_ACTION_SHOOT_RIGHT = 6
M1_ACTION_SLASH_RIGHT = 7

M1_ACTION_STUN_LEFT = 8
M1_ACTION_STUN_RIGHT = 9

M1_ACTION_DEATH = 10

Dim M1_ACTION_STAND_LEFT2
Dim M1_ACTION_STAND_RIGHT2

M1_ACTION_STAND_LEFT2 = 11
M1_ACTION_STAND_RIGHT2 = 12

Dim m1_distance[MAX_M1S]

Dim MAX_M1_BULLETS
MAX_M1_BULLETS = 8

Dim m1_health[MAX_M1S]
Dim m1_weapon_actor[MAX_M1S, MAX_M1_BULLETS]
Dim m1_weapon_speed[MAX_M1S, MAX_M1_BULLETS]
Dim m1_death_actor[MAX_M1S]

Dim m1_walk_speed
Dim m1_bullet_attack
DIm m1_bullet_speed
m1_bullet_speed = 4
m1_bullet_attack = 1
m1_walk_speed = 2
m1_travel_distance = 20

Dim m1_enemy[MAX_M1S]

Dim m1_start_action[MAX_M1S]

Dim m1_stun_time[MAX_M1S]

Dim m1_shoot_delay
m1_shoot_delay = 300

Dim m1_shoot_step[MAX_M1S]
Dim m1_shoot_reset_timer[MAX_M1S]
Dim m1_reset_delay
m1_reset_delay = 1500

Function AI_Init_M1(actor, action)
	For i = 0 to MAX_M1S-1
		If Not m1_alive[i] Then
			m1_alive[i] = True
			m1_actor[i] = actor
			m1_action[i] = action
			Actor_Physics[actor] = True
			Actor_Weight[actor] = 5
			
			m1_init_pos[i, 0] = Actor_X[actor]
			m1_init_pos[i, 1] = Actor_Y[actor]
			
			Select Case action
			Case M1_ACTION_STAND_LEFT
				Actor_SetAnimationByName(actor, "STAND_LEFT")
			Case M1_ACTION_WALK_LEFT
				Actor_SetAnimationByName(actor, "WALK_LEFT")
			Case M1_ACTION_SHOOT_LEFT
				Actor_SetAnimationByName(actor, "STAND_LEFT")
			Case M1_ACTION_SLASH_LEFT
				Actor_SetAnimationByName(actor, "STAND_LEFT")
			Case M1_ACTION_STAND_LEFT2
				Actor_SetAnimationByName(actor, "STAND_LEFT")
				m1_start_action[i] = action
			Case M1_ACTION_STAND_RIGHT2
				Actor_SetAnimationByName(actor, "STAND_RIGHT")
				m1_start_action[i] = action
			End Select
			
			m1_shoot_step[i] = 0
			m1_shoot_reset_timer[i] = 0
			
			m1_health[i] = 8
			m1_enemy[i] = -1
			
			bullet_spr = GetSpriteID("m1_missle")
			
			If bullet_spr < 0 Then
				bullet_spr = LoadSprite("m1_missle")
				'print "bullet = ";bullet_spr
			End If
			
			'print "Start here"
			For n = 0 to MAX_M1_BULLETS-1
				m1_weapon_actor[i, n] = NewActor("m1_"+str(i)+"_bullet_0"+str(n+1), bullet_spr)
				Actor_SetAnimationByName(m1_weapon_actor[i, N], "LEFT")
				Actor_SetAnimationFrame(m1_weapon_actor[i, n], 0)
				Actor_SetActive(m1_weapon_actor[i,n], false)
				Actor_SetLayer(m1_weapon_actor[i, n], 2)
				Actor_Physics[m1_weapon_actor[i, n]] = True
			Next
			'print "made it here"
			Actor_SetAnimationFrame(actor, 0)
			
			'If Not m1_death_actor[i] Then
				'print "last"
				m1_death_actor[i] = NewActor("m1_"+str(i)+"_death", GetSpriteID("explosion"))
				Actor_SetLayer(m1_death_actor[i], Actor_Layer[actor])
				Actor_SetActive(m1_death_actor[i], false)
			'End If
			Return i
		End If
	Next
	Return -1
End Function
'0 , 26
Sub AI_M1_RunAction(gnum)
	actor = m1_actor[gnum]
	'wpn1 = m1_weapon_actor[gnum,0]
	'wpn2 = m1_weapon_actor[gnum,1]
	action = m1_action[gnum]
	
	If Not Actor_isOnScreen(actor) Then
		Return
	End If
	
	Select Case action
	Case M1_ACTION_STAND_LEFT
		'Do nothing for now
	Case M1_ACTION_WALK_LEFT
		If timer - m1_action_time[gnum] > 15 Then
			Actor_Move(actor, -1 * m1_walk_speed, 0)
			m1_distance[gnum] = m1_distance[gnum] + 1
			m1_action_time[gnum] = timer
		End If
	Case M1_ACTION_SHOOT_LEFT
		If m1_shoot_step[gnum] = 3 Then
			m1_shoot_step[gnum] = 4
			m1_shoot_reset_timer[gnum] = Timer
		ElseIf m1_shoot_step[gnum] = 4 Then
			If (Timer - m1_shoot_reset_timer[gnum]) > m1_reset_delay Then
				m1_shoot_step[gnum] = 0
				'Print "RESET"
			End If
		ElseIf (timer - m1_action_time[gnum]) > m1_shoot_delay Then
			For i = 0 to MAX_M1_BULLETS-1
				If Not Actor_Active[m1_weapon_actor[gnum, i]] Then
					Actor_SetActive(m1_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(m1_weapon_actor[gnum, i], "LEFT")
					Actor_SetAnimationFrame(m1_weapon_actor[gnum, i], 0)
					Actor_SetPosition(m1_weapon_actor[gnum, i], Actor_X[actor]-32, Actor_Y[actor])
					m1_weapon_speed[gnum, i] = 0 - m1_bullet_speed
					m1_action_time[gnum] = timer
					PlaySound(shot_sound_2, 0, 0)
					m1_shoot_step[gnum] = m1_shoot_step[gnum] + 1
					Exit For
				End If
			Next
		End If
	Case M1_ACTION_STAND_LEFT2
		If m1_shoot_step[gnum] = 3 Then
			m1_shoot_step[gnum] = 4
			m1_shoot_reset_timer[gnum] = Timer
		ElseIf m1_shoot_step[gnum] = 4 Then
			If (Timer - m1_shoot_reset_timer[gnum]) > m1_reset_delay Then
				m1_shoot_step[gnum] = 0
				'Print "RESET"
			End If
		ElseIf (timer - m1_action_time[gnum]) > m1_shoot_delay Then
			For i = 0 to MAX_M1_BULLETS-1
				If Not Actor_Active[m1_weapon_actor[gnum, i]] Then
					Actor_SetActive(m1_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(m1_weapon_actor[gnum, i], "LEFT")
					Actor_SetAnimationFrame(m1_weapon_actor[gnum, i], 0)
					Actor_SetPosition(m1_weapon_actor[gnum, i], Actor_X[actor]-32, Actor_Y[actor])
					m1_weapon_speed[gnum, i] = 0 - m1_bullet_speed
					m1_action_time[gnum] = timer
					PlaySound(shot_sound_2, 0, 0)
					m1_shoot_step[gnum] = m1_shoot_step[gnum] + 1
					Exit For
				End If
			Next
		End If
	Case M1_ACTION_SLASH_LEFT
		'Actor_Move(actor, -3, 0)
		'Actor_SetPosition(wpn, Actor_X[actor] - 62, Actor_Y[actor])
	Case M1_ACTION_STAND_RIGHT
		'Do nothing for now
	Case M1_ACTION_WALK_RIGHT
		If timer - m1_action_time[gnum] > 15 Then
			Actor_Move(actor, m1_walk_speed, 0)
			m1_distance[gnum] = m1_distance[gnum] + 1
			m1_action_time[gnum] = timer
		End If
	Case M1_ACTION_SHOOT_RIGHT
		If m1_shoot_step[gnum] = 3 Then
			m1_shoot_step[gnum] = 4
			m1_shoot_reset_timer[gnum] = Timer
		ElseIf m1_shoot_step[gnum] = 4 Then
			If (Timer - m1_shoot_reset_timer[gnum]) > m1_reset_delay Then
				m1_shoot_step[gnum] = 0
				'Print "RESET"
			End If
		ElseIf (timer - m1_action_time[gnum]) > m1_shoot_delay Then
			For i = 0 to MAX_M1_BULLETS-1
				If Not Actor_Active[m1_weapon_actor[gnum, i]] Then
					Actor_SetActive(m1_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(m1_weapon_actor[gnum, i], "RIGHT")
					Actor_SetAnimationFrame(m1_weapon_actor[gnum, i], 0)
					Actor_SetPosition(m1_weapon_actor[gnum, i], Actor_X[actor]+32, Actor_Y[actor])
					m1_weapon_speed[gnum, i] = m1_bullet_speed
					m1_action_time[gnum] = timer
					PlaySound(shot_sound_2, 0, 0)
					m1_shoot_step[gnum] = m1_shoot_step[gnum] + 1
					Exit For
				End If
			Next
		End If
	Case M1_ACTION_STAND_RIGHT2
		If m1_shoot_step[gnum] = 3 Then
			m1_shoot_step[gnum] = 4
			m1_shoot_reset_timer[gnum] = Timer
		ElseIf m1_shoot_step[gnum] = 4 Then
			If (Timer - m1_shoot_reset_timer[gnum]) > m1_reset_delay Then
				m1_shoot_step[gnum] = 0
				'Print "RESET"
			End If
		ElseIf (timer - m1_action_time[gnum]) > m1_shoot_delay Then
			For i = 0 to MAX_M1_BULLETS-1
				If Not Actor_Active[m1_weapon_actor[gnum, i]] Then
					Actor_SetActive(m1_weapon_actor[gnum, i], true)
					Actor_SetAnimationByName(m1_weapon_actor[gnum, i], "RIGHT")
					Actor_SetAnimationFrame(m1_weapon_actor[gnum, i], 0)
					Actor_SetPosition(m1_weapon_actor[gnum, i], Actor_X[actor]+32, Actor_Y[actor])
					m1_weapon_speed[gnum, i] = m1_bullet_speed
					m1_action_time[gnum] = timer
					PlaySound(shot_sound_2, 0, 0)
					m1_shoot_step[gnum] = m1_shoot_step[gnum] + 1
					Exit For
				End If
			Next
		End If
	Case M1_ACTION_SLASH_RIGHT
		'Actor_Move(actor, 3, 0)
		'Actor_SetPosition(wpn, Actor_X[actor], Actor_Y[actor])
	Case M1_ACTION_STUN_LEFT
		If m1_distance[gnum] < 5 Then
			Actor_Move(actor, 1, 0)
			m1_distance[gnum] = m1_distance[gnum] + 1	
		End If
	Case M1_ACTION_STUN_RIGHT
		If m1_distance[gnum] < 5 Then
			Actor_Move(actor, -1, 0)
			m1_distance[gnum] = m1_distance[gnum] + 1	
		End If
	Case M1_ACTION_DEATH
		'print "animation = ";Actor_CurrentAnimation[m1_death_actor[gnum]]
		'print "num aframes = ";Sprite_Animation_NumFrames[ Actor_Sprite[m1_death_actor[gnum]], 0]
		'print "cframe = ";Actor_CurrentFrameTime[m1_death_actor[gnum]]
		'print "cdelay = ";Actor_CurrentFrameDelay[m1_death_actor[gnum]]
	End Select
End Sub

Sub AI_M1_StartAction(gnum, action)
	Select Case action
	Case M1_ACTION_STAND_LEFT
		Actor_SetAnimationByName(m1_actor[gnum], "STAND_LEFT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
		m1_action_time[gnum] = timer
	Case M1_ACTION_WALK_LEFT
		Actor_SetAnimationByName(m1_actor[gnum], "WALK_LEFT")
		m1_distance[gnum] = 0
	Case M1_ACTION_SHOOT_LEFT
		Actor_SetAnimationByName(m1_actor[gnum], "STAND_LEFT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
	Case M1_ACTION_STAND_LEFT2
		Actor_SetAnimationByName(m1_actor[gnum], "STAND_LEFT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
	Case M1_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(m1_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
		m1_action_time[gnum] = timer
	Case M1_ACTION_STAND_RIGHT2
		Actor_SetAnimationByName(m1_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
		m1_action_time[gnum] = timer
	Case M1_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(m1_actor[gnum], "WALK_RIGHT")
		m1_distance[gnum] = 0
	Case M1_ACTION_SHOOT_RIGHT
		Actor_SetAnimationByName(m1_actor[gnum], "STAND_RIGHT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
	Case M1_ACTION_STUN_LEFT
		Actor_SetAnimationByName(m1_actor[gnum], "STUN_LEFT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
		m1_action_time[gnum] = timer
		m1_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case M1_ACTION_STUN_RIGHT
		Actor_SetAnimationByName(m1_actor[gnum], "STUN_RIGHT")
		Actor_SetAnimationFrame(m1_actor[gnum], 0)
		m1_action_time[gnum] = timer
		m1_distance[gnum] = 0
		PlaySound(1, 0, 0)
	Case M1_ACTION_DEATH
		Actor_SetActive(m1_actor[gnum], false)
		Actor_SetActive(m1_death_actor[gnum], true)
		Actor_SetAnimation(m1_death_actor[gnum], 0)
		Actor_SetAnimationFrame(m1_death_actor[gnum], 0)
		Actor_SetPosition(m1_death_actor[gnum], Actor_X[m1_actor[gnum]], Actor_Y[m1_actor[gnum]])
		m1_action_time[gnum] = timer
		PlaySound(3, 1, 0)
	End Select
	m1_action[gnum] = action
	m1_action_status[gnum] = true
End Sub

Function AI_M1_ActionComplete(gnum)
	If Not m1_action_status[gnum] Then
		Return True
	End If
	action = m1_action[gnum]
	Select Case action
	Case M1_ACTION_STAND_LEFT
		If timer - m1_action_time[gnum] > 1000 Then
			m1_action_status[gnum] = False
			Return True
		End If
	Case M1_ACTION_WALK_LEFT
		If m1_distance[gnum] >= m1_travel_distance Then
			m1_action_status[gnum] = False
			Return True
		End If
	Case M1_ACTION_SHOOT_LEFT
		'If timer - m1_action_time[gnum] > 2000 Then
		'	m1_action_status[gnum] = False
		'	Return True
		'End If
	Case M1_ACTION_STAND_LEFT2
	
	Case M1_ACTION_STAND_RIGHT
		If timer - m1_action_time[gnum] > 1000 Then
			m1_action_status[gnum] = False
			Return True
		End If
	Case M1_ACTION_WALK_RIGHT
		If m1_distance[gnum] >= m1_travel_distance Then
			m1_action_status[gnum] = False
			Return True
		End If
	Case M1_ACTION_SHOOT_RIGHT
		'If timer - m1_action_time[gnum] > 2000 Then
		'	m1_action_status[gnum] = False
		'	Return True
		'End If
	Case M1_ACTION_STUN_LEFT
		If timer - m1_action_time[gnum] > m1_stun_time[gnum] Then
			m1_action_status[gnum] = false
			Return True
		End If
	Case M1_ACTION_STUN_RIGHT
		If timer - m1_action_time[gnum] > m1_stun_time[gnum] Then
			m1_action_status[gnum] = false
			Return True
		End If
	Case M1_ACTION_DEATH
		If Actor_AnimationEnded[m1_death_actor[gnum]] Then
			m1_action_status[gnum] = false
			'print "end death"
			Return True
		End If
	End Select
End Function

'walk left 20 steps
'stand left 1 sec
'walk right 20 steps
'stand right 1 sec
Dim M1_DIR_LEFT
Dim M1_DIR_RIGHT
M1_DIR_LEFT = 0
M1_DIR_RIGHT = 2
Function M1_GetDirection(gnum)
	a = m1_action[gnum]
	If a = M1_ACTION_SHOOT_LEFT Or a = M1_ACTION_SLASH_LEFT Or a = M1_ACTION_STAND_LEFT Or a = M1_ACTION_WALK_LEFT Or a = M1_ACTION_STUN_LEFT Then
		Return M1_DIR_LEFT
	Else
		Return M1_DIR_RIGHT
	End If
End Function

Dim m1_weapon_impact[MAX_M1S, MAX_M1_BULLETS]

Sub M1_Attack_Collision(gz_id, gnum)
	For i = 0 to MAX_M1_BULLETS-1
		bullet_actor = m1_weapon_actor[gnum, i]
		If Actor_isActive(bullet_actor) Then
			If (m1_weapon_impact[gnum, i] And Actor_AnimationEnded[bullet_actor]) Or (Not Actor_isOnScreen(bullet_actor)) Then
				m1_weapon_impact[gnum, i] = False
				Actor_SetActive(bullet_actor, False)
			ElseIf Actor_NumStageCollisions[bullet_actor] > 0 Then
				Actor_SetAnimationByName(bullet_actor, "EXPLODE")
				Actor_SetAnimationFrame(bullet_actor, 0)
				m1_weapon_impact[gnum, i] = True
			ElseIf Actor_GetCollision(gz_id, bullet_actor) And (Not Player_isStunned) And(Not m1_weapon_impact[gnum,i]) Then
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
				Graizor_Health = Graizor_Health - m1_bullet_attack
				PlaySound(impact_sound_2, 0, 0)
				Actor_SetAnimationByName(bullet_actor, "EXPLODE")
				Actor_SetAnimationFrame(bullet_actor, 0)
				m1_weapon_impact[gnum, i] = True
			ElseIf Actor_isActive(bullet_actor) And (Not m1_weapon_impact[gnum, i]) Then
				Actor_Move(bullet_actor, m1_weapon_speed[gnum, i], 0)
				'print "actor_name = "; Actor_Name[bullet_actor]
				'print "actor info:   gnum=";gnum;"      i=";i
				'print "": print ""
			End If
		End If
	Next
End Sub

Sub AI_M1(gnum, gz_id)
	actor = m1_actor[gnum]
	action = m1_action[gnum]
	
	
	'print "action = ";action
	
	If Actor_Y[actor] > Stage_End_Y Then
		m1_alive[gnum] = false
		Actor_SetActive(m1_actor[gnum], false)
	End If
	
	If m1_health[gnum] <= 0 And m1_alive[gnum] And m1_action[gnum] <> M1_ACTION_DEATH Then
		'Play death animation
		AI_M1_StartAction(gnum, M1_ACTION_DEATH)
	End If
	
	M1_Attack_Collision(gz_id, gnum)
	
	If (Not Player_isStunned) And m1_alive[gnum] And action <> M1_ACTION_DEATH And (action = M1_ACTION_STAND_LEFT Or action = M1_ACTION_STAND_RIGHT Or action = M1_ACTION_SHOOT_LEFT Or action = M1_ACTION_SHOOT_RIGHT) Then
		If Actor_GetDistance(gz_id, actor) <= 300 Then
			If m1_start_action[gnum] = 0 Then
				If Actor_X[gz_id] <= Actor_X[actor] Then
					AI_M1_StartAction(gnum, M1_ACTION_SHOOT_LEFT)
				Else
					AI_M1_StartAction(gnum, M1_ACTION_SHOOT_RIGHT)
				End If
			End If
		ElseIf (m1_action[gnum] = M1_ACTION_SHOOT_LEFT Or m1_action[gnum] = M1_ACTION_SHOOT_RIGHT) And (m1_start_action[gnum] = 0) Then
			AI_M1_StartAction(gnum, M1_ACTION_STAND_LEFT)
		End If
	End If
	
	If Actor_GetCollision(Actor_ChildActor[gz_id], actor) and action <> M1_ACTION_STUN_LEFT and action <> M1_ACTION_STUN_RIGHT Then
		If M1_GetDirection(gnum) = M1_DIR_LEFT Then
			AI_M1_StartAction(gnum, M1_ACTION_STUN_LEFT)
		Else
			AI_M1_StartAction(gnum, M1_ACTION_STUN_RIGHT)
		End If
		m1_stun_time[gnum] = 250 + add_stun_time
		m1_health[gnum] = m1_health[gnum] - Graizor_Sword_Attack
	ElseIf m1_enemy[gnum] >= 0 Then
		If enemy_hit[m1_enemy[gnum]] and action <> M1_ACTION_STUN_LEFT and action <> M1_ACTION_STUN_RIGHT Then
			If M1_GetDirection(gnum) = M1_DIR_LEFT Then
				AI_M1_StartAction(gnum, M1_ACTION_STUN_LEFT)
			Else
				AI_M1_StartAction(gnum, M1_ACTION_STUN_RIGHT)
			End If
			m1_stun_time[gnum] = 250 + add_stun_time
			m1_health[gnum] = m1_health[gnum] - blaster_atk
		End If
	End If
	
	m1_enemy[gnum] = -1
	
	AI_M1_RunAction(gnum)
	
	If AI_M1_ActionComplete(gnum) Then
		'print "change"
		Select Case action
		Case M1_ACTION_STAND_LEFT
			AI_M1_StartAction(gnum, M1_ACTION_WALK_RIGHT)
		Case M1_ACTION_WALK_LEFT
			AI_M1_StartAction(gnum, M1_ACTION_STAND_LEFT)
		Case M1_ACTION_SHOOT_LEFT
		
		Case M1_ACTION_STAND_LEFT2
		
		Case M1_ACTION_STAND_RIGHT
			AI_M1_StartAction(gnum, M1_ACTION_WALK_LEFT)
		Case M1_ACTION_WALK_RIGHT
			AI_M1_StartAction(gnum, M1_ACTION_STAND_RIGHT)
		Case M1_ACTION_SHOOT_RIGHT
			
		Case M1_ACTION_STUN_LEFT
			If m1_start_action[gnum] <> 0 Then
				AI_M1_StartAction(gnum, m1_start_action[gnum])
			Else
				AI_M1_StartAction(gnum, M1_ACTION_STAND_LEFT)
			End If
		Case M1_ACTION_STUN_RIGHT
			If m1_start_action[gnum] <> 0 Then
				AI_M1_StartAction(gnum, m1_start_action[gnum])
			Else
				AI_M1_StartAction(gnum, M1_ACTION_STAND_RIGHT)
			End If
		Case M1_ACTION_DEATH
			Actor_SetActive(m1_death_actor[gnum], false)
			'Actor_SetActive(m1_weapon_actor[gnum], false)
			m1_action[gnum] = 0
			m1_alive[gnum] = false
		End Select
	End If
	
	If m1_alive[gnum] Then
		enemy[num_enemies] = m1_actor[gnum]
		enemy_hit[num_enemies] = False
		m1_enemy[gnum] = num_enemies
		num_enemies = num_enemies + 1
	Else
		m1_enemy[gnum] = -1
	End If
End Sub

Sub M1_Act(gz_id)
	For i = 0 to MAX_M1S-1
		If m1_alive[i] Then
			AI_M1(i, gz_id)
		ElseIf m1_actor[i] >= 0 Then
			'Print "M1[";i;"] is dead"
			'print"": print "actor !!!!"
			M1_Attack_Collision(gz_id, i)
		End If
	Next
End Sub
