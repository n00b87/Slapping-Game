Dim MAX_LIMITS
MAX_LIMITS = 20

Dim Limit_Actor[MAX_LIMITS]
Dim Limit_Sprite[MAX_LIMITS]
Dim num_limits

Sub Init_Limits()
	num_limits = 0
End Sub

Sub Add_Limit(layer, x, y, w, h)
	n = num_limits
	num_limits = num_limits + 1
	
	Limit_Sprite[n] = NullSprite("Limit_Sprite_"+ Str(n), w, h)
	Limit_Actor[n] = NewActor("Limit_"+Str(n), Limit_Sprite[n])
	Actor_SetPosition(Limit_Actor[n], x, y)
	Actor_SetLayer(Limit_Actor[n], layer)
	Actor_SetVisible(Limit_Actor[n], False)
End Sub

Function Limit_GetCollision(actor1, actor2)
	
	For i = 0 to MAX_ACTOR_COLLISIONS-1
		If (Actor_CollisionActor[actor1, i] = actor2 And i < Actor_NumActorCollisions[actor1])  Or (Actor_CollisionActor[actor2, i] = actor1 And i < Actor_NumActorCollisions[actor2]) Then
			'Print "\nGraizor -> "; actor1; " = ";Actor_NumActorCollisions[actor1];" -- ";Actor_CollisionActor[actor1, i]
			'Print "Claw -> ";actor2; " = ";Actor_NumActorCollisions[actor2];" -- ";Actor_CollisionActor[actor2, i]
			'Print""
			Return True
		End If
	Next
	Return False
End Function

Function Get_Limit(gz_id)
	If num_limits > 0 Then
		For i = 0 to num_limits-1
			If Limit_GetCollision(gz_id, Limit_Actor[i]) Then
				Return i
			End If
		Next
	End If
	Return -1
End Function

MAX_CHECKPOINTS = 10

Dim Checkpoint[MAX_CHECKPOINTS, 2] 'x, y
Dim num_checkpoints

Sub Init_Checkpoints()
	num_checkpoints = 0
End Sub

Sub Add_Checkpoint(x, y)
	n = num_checkpoints
	num_checkpoints = n + 1
	
	Checkpoint[n, 0] = x
	Checkpoint[n, 1] = y
End Sub

Sub StartFromCheckpoint(cp)
	Graizor_Health = 8
	blaster_ammo = 30
	Actor_SetPosition(graizor, Checkpoint[cp, 0], Checkpoint[cp, 1])
	'Actor_SetAnimationByName(graizor, "stand_right")
	'Actor_SetAnimationFrame(graizor, 0)
	'Actor_SetVisible(graizor, true)
	'Actor_SetLayer(graizor, 2)
	Actor_SetAnimation(beam_sword, 0)
	Actor_SetAnimationFrame(beam_sword, 0)
	Actor_SetActive(beam_sword, False)
	'Player_Current_Action = PLAYER_ACTION_STAND_RIGHT
End Sub
