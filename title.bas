
Function Title_Screen()
	Canvas(5)
	ClearCanvas()
	DrawImage(title_bkg, 0, 0)
	Update()
	WaitKey()
	Return True
End Function

Sub Victory_Screen()
	Canvas(5)
	ClearCanvas()
	DrawImage(victory_bkg, 0, 0)
	Update()
	PlaySound(victory_sfx, 0, 0)
	WaitKey()
End Sub

Sub Defeat_Screen()
	Canvas(5)
	ClearCanvas()
	DrawImage(defeat_bkg, 0, 0)
	Update()
	PlaySound(game_over_sfx, 0, 0)
	WaitKey()
End Sub

Sub End_Screen(victory)
	If victory Then
		Victory_Screen()
	Else
		Defeat_Screen()
	End If
End Sub