Dim Dlg_data$[256]
Dim Dlg_data_count

Sub Dlg_GetData()
	f = FreeFile
	FileOpen(f, "dlg_data.nb", TEXT_INPUT)
	s_data$ = ReadLine$(f)
	Dlg_data_count = 0
	While s_data$ <> ""
		Dlg_data$[Dlg_data_count] = s_data$
		Dlg_data_count = Dlg_data_count + 1
		s_data$ = ReadLine$(f)
	Wend
	FileClose(f)
End Sub
