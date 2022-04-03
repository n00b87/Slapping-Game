Dim MAX_ENERGY_CELLS
MAX_ENERGY_CELLS = 5

Dim Energy_Cell[MAX_ENERGY_CELLS]
Dim num_energy_cells

Sub Init_Energy_Cells()
	num_energy_cells = 0
End Sub

Sub Add_Energy_Cell(actor)
	Energy_Cell[num_energy_cells] = actor
	num_energy_cells = num_energy_cells + 1
End Sub

Sub Energy_Cell_Act()
	If num_energy_cells > 0 Then
		For i = 0 to num_energy_cells-1
			If Actor_isActive(Energy_Cell[i]) And Actor_GetCollision(graizor, Energy_Cell[i]) Then
				Actor_SetActive(Energy_Cell[i], False)
				blaster_ammo = blaster_ammo + 20
			End If
		Next
	End If
End Sub
