Dim MAX_SKULLS
MAX_SKULLS = 10

Dim skull_bomb[MAX_SKULLS]
Dim skull_bomb_sprite[MAX_SKULLS]

Dim skull_min_x[MAX_SKULLS]
Dim skull_min_y[MAX_SKULLS]

Dim skull_max_x[MAX_SKULLS]
Dim skull_max_y[MAX_SKULLS]

Dim skull_active[MAX_SKULLS]
Dim skull_action[MAX_SKULLS]

Dim skull_rise_speed[MAX_SKULLS]
Dim skull_alert_step[MAX_SKULLS]
Dim skull_alert_timer[MAX_SKULLS]

Dim SKULL_ACTION_RISE
Dim SKULL_ACTION_ALERT
Dim SKULL_ACTION_EXPLODE
Dim SKULL_ACTION_RESET

SKULL_ACTION_RESET = 0
SKULL_ACTION_RISE = 1
SKULL_ACTION_ALERT = 2
SKULL_ACTION_EXPLODE = 3

Dim skull_bomb_base_sprite

Dim num_skulls
Dim skull_activate_timer

Sub Init_Skulls()
	skull_bomb_base_sprite = LoadSprite("skull_bomb")
	num_skulls = 0
End Sub

Sub Add_Skull(x, y, max_y, layer)
	n = num_skulls
	
	skull_bomb_sprite[n] = CopySprite(skull_bomb_base_sprite)
	
	skull_bomb[n] = NewActor("skull_bomb"+str(n+1), skull_bomb_sprite[n])
	
	Actor_SetLayer(skull_bomb[n], layer)
	Actor_SetPosition(skull_bomb[n], x, max_y)
	Stage_Layer_AddActorDynaRec(skull_bomb[n], layer)
	skull_active[n] = True
	skull_action[n] = 0
	skull_min_x[n] = x
	skull_min_y[n] = y
	skull_max_x[n] = x
	skull_max_y[n] = max_y
	skull_rise_speed[n] = sign(max_y-y) * 4
	num_skulls = num_skulls + 1
End Sub

Sub Skull_Act(gz_id)
	For n = 0 to MAX_SKULLS-1
		If skull_active[n] Then
			'Print "Skull Action = ";skull_action[n]
			Select Case skull_action[n]
			Case 0
				Actor_SetPosition(skull_bomb[n], skull_min_x[n], skull_min_y[n])
				Actor_SetAnimationByName(skull_bomb[n], "MAIN")
				SetImageColorMod( Sprite_Image[Actor_Sprite[skull_bomb[n]]], -1)
				skull_action[n] = 1
				skull_alert_step[n] = 0
			Case 1
				If Actor_GetCollision(skull_bomb[n], gz_id) Then
					skull_action[n] = 2
					skull_alert_timer[n] = timer
				ElseIf Actor_Y[skull_bomb[n]] > skull_max_y[n] Then
					Actor_Move(skull_bomb[n], 0, skull_rise_speed[n])
				End If
			Case 2
				If skull_alert_step[n] < 150 And (Timer - skull_alert_timer[n] > 10) Then
					SetImageColorMod( Sprite_Image[Actor_Sprite[skull_bomb[n]]], RGB(100+ skull_alert_step[n], 100, 100))
					skull_alert_step[n] = skull_alert_step[n] + 2
					skull_alert_timer[n] = Timer
				Else
					skull_action[n] = 3
					Actor_SetAnimationByName(skull_bomb[n], "EXPLODE")
					Actor_SetAnimationFrame(skull_bomb[n], 0)
					'PlaySound(explosion_sound, 0, 0)
				End If
			Case 3
				If Actor_AnimationEnded[skull_bomb[n]] Then
					skull_action[n] = 0
				End If
				
				'If key(K_W) Then
				'	Actor_Move(skull_bomb[n], 0, -2)
				'ElseIf key(K_S) Then
				'	Actor_Move(skull_bomb[n], 0, 2)
				'End If
			End Select
		End If
	Next
End Sub
