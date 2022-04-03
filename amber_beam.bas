'include "engine.bas"

MAX_AMBERS = 10

Dim amber_alive[MAX_AMBERS]
Dim amber_actor[MAX_AMBERS]
Dim amber_action[MAX_AMBERS]
Dim amber_action_time[MAX_AMBERS]
Dim amber_action_lock[MAX_AMBERS]
Dim amber_action_status[MAX_AMBERS]
Dim amber_atk_status[MAX_AMBERS]

Dim AMBER_ACTION_SAFE
Dim AMBER_ACTION_START
Dim AMBER_ACTION_RUN
Dim AMBER_ACTION_STOP

AMBER_ACTION_SAFE = 0
AMBER_ACTION_START = 1
AMBER_ACTION_RUN = 2
AMBER_ACTION_STOP = 3

Dim amber_health[MAX_AMBERS]

Dim amber_sound
amber_sound = -1
amber_sound_isplaying = false

Function AI_Init_Amber(actor)
	For i = 0 to MAX_AMBERS-1
		If Not amber_alive[i] Then
			amber_alive[i] = True
			amber_actor[i] = actor
			amber_action[i] = AMBER_ACTION_SAFE
			amber_action_time[i] = 0
			amber_action_lock[i] = 0
			amber_action_status[i] = 0
			
			Actor_SetLayer(actor, 2)
			'Actor_SetActive(actor, False)
			Actor_SetAnimation(actor, 0)
			
			amber_health[i] = 2
			
			Actor_SetAnimationFrame(actor, 0)
			
			Return i
		End If
	Next
	Return -1
End Function

Sub AI_Amber_RunAction(amber_num)
	actor = amber_actor[amber_num]
	action = amber_action[amber_num]
	
	Select Case action
	Case AMBER_ACTION_START
	Case AMBER_ACTION_SAFE
		
	Case AMBER_ACTION_RUN
	
	Case AMBER_ACTION_STOP
	End Select
End Sub

Sub AI_Amber_StartAction(amber_num, action)
	Select Case action
	Case AMBER_ACTION_START
		Actor_SetActive(amber_actor[amber_num], True)
		amber_action_time[amber_num] = timer
		Actor_SetAnimationByName(amber_actor[amber_num], "START")
		Actor_SetAnimationFrame(amber_actor[amber_num], 0)
		amber_atk_status[amber_num] = False
	Case AMBER_ACTION_RUN
		Actor_SetActive(amber_actor[amber_num], True)
		amber_action_time[amber_num] = timer
		Actor_SetAnimationByName(amber_actor[amber_num], "RUN")
		Actor_SetAnimationFrame(amber_actor[amber_num], 0)
		amber_atk_status[amber_num] = True
	Case AMBER_ACTION_SAFE
		amber_action_time[amber_num] = timer
		Actor_SetActive(amber_actor[amber_num], False)
		amber_atk_status[amber_num] = False
	Case AMBER_ACTION_STOP
		Actor_SetActive(amber_actor[amber_num], True)
		amber_action_time[amber_num] = timer
		Actor_SetAnimationByName(amber_actor[amber_num], "STOP")
		Actor_SetAnimationFrame(amber_actor[amber_num], 0)
		amber_atk_status[amber_num] = False
	End Select
	amber_action[amber_num] = action
	amber_action_status[amber_num] = true
End Sub

Function AI_Amber_ActionComplete(amber_num)
	action = amber_action[amber_num]
	Select Case action
	Case AMBER_ACTION_SAFE
		If timer - amber_action_time[amber_num] > 1000 Then
			amber_action_status[amber_num] = False
			'Print "SAFE"
			Return True
		End If
	Case AMBER_ACTION_START
		If Actor_AnimationEnded[amber_actor[amber_num]] Then
			'Print "START"
			amber_action_status[amber_num] = False
			Return True
		End If
	Case AMBER_ACTION_RUN
		If timer - amber_action_time[amber_num] > 4000 Then
			'Print "RUN"
			amber_action_status[amber_num] = False
			Return True
		End If
	Case AMBER_ACTION_STOP
		If Actor_AnimationEnded[amber_actor[amber_num]] Then
			'Print "STOP"
			amber_action_status[amber_num] = False
			Return True
		End If
	End Select
End Function

Sub Amber_Attack_Collision(gz_id, amber_num)
	screen_dist = ( Abs(Actor_X[amber_actor[amber_num]] - Actor_X[gz_id]) < 1280 )
	
	If Actor_GetCollision(gz_id, amber_actor[amber_num]) And (Not Player_isStunned) And amber_atk_status[amber_num] Then
		
		'If (Not amber_sound_isplaying) And screen_dist Then
		'	PlaySound(explosion_sound, 1, 0)
		'	amber_sound_isplaying = True
		'End If
		
		Player_isStunned = True
		Player_Stun_Time = Timer
		
		If Player_Action <= 15 Then
			Player_Current_Action = PLAYER_ACTION_STUN_RIGHT
			Player_Stun_Speed = -4
		Else
			Player_Current_Action = PLAYER_ACTION_STUN_LEFT
			Player_Stun_Speed = 4
		End If
		
		Actor_SetActive(Actor_ChildActor[gz_id], false)
		Graizor_Health = 0
	End If
End Sub

Sub AI_Amber(amber_num, gz_id)
	actor = amber_actor[amber_num]
	action = amber_action[amber_num]
	
	hv_gz_id = gz_id
	
	Amber_Attack_Collision(gz_id, amber_num)
	
	AI_Amber_RunAction(amber_num)
	
	If AI_Amber_ActionComplete(amber_num) Then
		'print "change"
		Select Case action
		Case AMBER_ACTION_SAFE
			AI_Amber_StartAction(amber_num, AMBER_ACTION_START)	
		Case AMBER_ACTION_START
			AI_Amber_StartAction(amber_num, AMBER_ACTION_RUN)
		Case AMBER_ACTION_RUN
			AI_Amber_StartAction(amber_num, AMBER_ACTION_STOP)
		Case AMBER_ACTION_STOP
			AI_Amber_StartAction(amber_num, AMBER_ACTION_SAFE)
		End Select
	End If
	
End Sub

Sub Amber_Act(gz)
	amber_sound_isplaying = false
	For i = 0 to MAX_AMBERS-1
		If amber_alive[i] Then
			'print i
			AI_Amber(i, gz)
		End If
	Next
End Sub
