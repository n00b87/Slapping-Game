smith = -1
smith_current_action = 0

slap = -1

smith_steps = 0
smith_Jump_Height = 0
smith_Jump_Force = 0

smith_move_speed = 0
smith_move_distance = 0

SMITH_ACTION_STAND_LEFT = 0
SMITH_ACTION_WALK_LEFT = 1
SMITH_ACTION_SMACK_LEFT = 2
SMITH_ACTION_JUMP_LEFT = 3

SMITH_ACTION_STAND_RIGHT = 4
SMITH_ACTION_WALK_RIGHT = 5
SMITH_ACTION_SMACK_RIGHT = 6
SMITH_ACTION_JUMP_RIGHT = 7


Sub smith_init()
	smith = GetActorID("smith")
	slap = GetActorID("slap")
	
	Actor_Physics_State[smith] = PHYSICS_STATE_FALL
	Actor_Weight[smith] = 3.5
	Actor_Physics[smith] = True

	
	
	smith_Jump_Height = 40
	smith_Jump_Force = 3.5
	
	smith_move_speed = 2
	
End Sub

Sub Smith_Set_Animation()
	Select Case smith_current_action
	Case SMITH_ACTION_STAND_LEFT
		Actor_SetAnimationByName(smith, "Slap_left")
		Actor_SetAnimationByName(slap, "Slap_left")
		Actor_SetAnimationFrame(slap, 0)
		Actor_SetPosition(slap, Actor_X[smith], Actor_Y[smith])
		Actor_SyncAnimationTo(slap, smith)
		
	Case SMITH_ACTION_WALK_LEFT
		Actor_SetAnimationByName(smith, "Walk_left")
		Actor_SetPosition(slap, 1033, 10)
	
	Case SMITH_ACTION_STAND_RIGHT
		Actor_SetAnimationByName(smith, "Slap_right")
		Actor_SetAnimationByName(slap, "Slap_right")
		Actor_SetAnimationFrame(slap, 0)
		Actor_SetPosition(slap, Actor_X[smith], Actor_Y[smith])
		Actor_SyncAnimationTo(slap, smith)
		
	Case SMITH_ACTION_WALK_RIGHT
		Actor_SetAnimationByName(smith, "Walk_right")
		Actor_SetPosition(slap, 1033, 10)
	
	End Select
End Sub

Sub smith_act()
	If Actor_AnimationEnded[smith] Then
		smith_steps = smith_steps + 1
	End If
	
	smith_prev_action = smith_current_action
	
	Select Case smith_current_action
	Case SMITH_ACTION_STAND_LEFT
		If smith_steps = 3 Then
			smith_steps = 0
			smith_current_action = SMITH_ACTION_WALK_LEFT
		End If
		
	Case SMITH_ACTION_WALK_LEFT
		If smith_steps = 3 Then
			smith_steps = 0
			smith_current_action = SMITH_ACTION_STAND_RIGHT
		Else
			Actor_Move(smith, -smith_move_speed, 0)
		End If
		
	Case SMITH_ACTION_STAND_RIGHT
		If smith_steps = 3 Then
			smith_steps = 0
			smith_current_action = SMITH_ACTION_WALK_RIGHT
		End If
	
	Case SMITH_ACTION_WALK_RIGHT
		If smith_steps = 3 Then
			smith_steps = 0
			smith_current_action = SMITH_ACTION_STAND_LEFT
		Else
			Actor_Move(smith, smith_move_speed, 0)
		End If
	
	End Select
	
	If smith_prev_action = smith_current_action Then
		smith_set_animation()
	End If
	
End Sub