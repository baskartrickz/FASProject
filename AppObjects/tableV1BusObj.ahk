class tableV1BusObj
{
	ReadTable(FileOrString, Options="", ByRef Header="", ByRef RowCount="", ByRef ColCount="")
	{
		Array := [], Header := [], GroupedArray := []
		RowCount := 1, Col := 0, ColCount := 0
		For k,v in Options
			%k% := v
		If (Delimiter = "")
			Delimiter := ","
		SearchStartAt := StrLen(Delimiter) + 1
		If FileExist(FileOrString)
			FileRead, FileOrString, %FileOrString%
		Loop, Parse, FileOrString, `n, `r
		{
			Loop, Parse, A_LoopField, %Delimiter%
			{
				If !Quoted {
					Col += 1
					If (Header[Col] = "")
						Header[Col] := Col
					If (InStr(A_LoopField, """") = 1)
						Quoted := [RowCount, Header[Col]]
					Else
						Array[RowCount, Header[Col]] := A_LoopField
				}
				If Quoted {
					If (A_Index = 1) or (QuotedValue = "")
						QuotedValue .= StrReplace(A_LoopField, """""", "`r")
					Else
						QuotedValue .= Delimiter StrReplace(A_LoopField, """""", "`r")
					If InStr(QuotedValue, """", False, SearchStartAt)
						Array[Quoted[1], Quoted[2]] := StrReplace(StrReplace(QuotedValue, """"), "`r", """"), Quoted := QuotedValue := ""
				}
			}
			If Quoted
				QuotedValue .= "`n"
			Else If Headers
				Header := Array[1].Clone(), Headers := False, Array := [], Col := 0
			Else {
				If (Col > ColCount)
					ColCount := Col
				If (GroupBy != "")
					Row := Array[RowCount].Clone(), Row.Delete(GroupBy), GroupedArray[Array[RowCount, GroupBy], Floor(GroupedArray[Array[RowCount, GroupBy]].MaxIndex()) + 1] := Row
				RowCount += 1, Col := 0
			}
		}
		Return GroupBy = "" ? Array : GroupedArray
	}

	mergeTable(ByRef Table, OutputPath, Headers="")
	{
		If (Headers = "") {
			Headers := []
			For Key,ColumnName in Table[1]
				Headers[A_Index] := Key
		} Else
			Loop % Headers.MaxIndex()
				Table[0,Headers[A_Index]] := Headers[A_Index]
		For Key,Row in Table
		{
			If (A_Index > 1)
				Output .= "`r`n"
			Loop % Headers.MaxIndex()
				Output .= (A_Index = 1 ? "" : ",") (RegExMatch(Row[Headers[A_Index]], "[,`n`r""]") ? """" StrReplace(Row[Headers[A_Index]], """", """""") """" : Row[Headers[A_Index]])
		}
		Table.Delete(0)
		d := "`n"
		FileAppend, %Output%, %OutputPath%
		FileAppend, %d%, %OutputPath%
		Return ErrorLevel
	}

	WriteTable(ByRef Table, OutputPath, Headers="")
	{
		;~ FileDelete, %OutputPath%
		If (Headers = "") {
			Headers := []
			For Key,ColumnName in Table[1]
				Headers[A_Index] := Key
		} Else
			Loop % Headers.MaxIndex()
				Table[0,Headers[A_Index]] := Headers[A_Index]
		For Key,Row in Table
		{
			If (A_Index > 1)
				Output .= "`r`n"
			Loop % Headers.MaxIndex()
				Output .= (A_Index = 1 ? "" : ",") (RegExMatch(Row[Headers[A_Index]], "[,`n`r""]") ? """" StrReplace(Row[Headers[A_Index]], """", """""") """" : Row[Headers[A_Index]])
		}
		Table.Delete(0)
		FileAppend, %Output%, %OutputPath%
		Return ErrorLevel
	}

	SortTable(Input, Fields*)
	{
		Loop % Fields.MaxIndex()
		{
			SortField := Fields[Fields.MaxIndex() + 1 - A_Index]
			If IsObject(SortField)
				SortFunc := SortField[2], SortField := SortField[1]
			Else
				SortFunc := ""
			If (InStr(SortField, "~") = 1)
				SortField := SubStr(SortField, 2), Ascending := False
			Else
				Ascending := True
			Output := []
			For n,Row in Input
				Loop %n%
					If (A_Index = n) {
						Output.InsertAt(A_Index,Row)
						Break
					} Else If (SortFunc != "") {
						If Ascending {
							If (%SortFunc%(Output[A_Index,SortField], Row[SortField]) > 0) {
								Output.InsertAt(A_Index,Row)
								Break
							}
						} Else If (%SortFunc%(Output[A_Index,SortField], Row[SortField]) < 0) {
							Output.InsertAt(A_Index,Row)
							Break
						}
					} Else If Ascending {
						If (Output[A_Index,SortField] > Row[SortField]) {
							Output.InsertAt(A_Index,Row)
							Break
						}
					} Else If (Output[A_Index,SortField] < Row[SortField]) {
						Output.InsertAt(A_Index,Row)
						Break
					}
			Input := Output.Clone()
		}
		Return Input
	}
	writetext(ByRef Table, OutputPath, Headers="")
	{
		;~ FileDelete, %OutputPath%
		If (Headers = "") {
			Headers := []
			For Key,ColumnName in Table[1]
				Headers[A_Index] := Key
		} Else
			Loop % Headers.MaxIndex()
				Table[0,Headers[A_Index]] := Headers[A_Index]
		For Key,Row in Table
		{
			If (A_Index > 1)
				Output .= "`r`n"
			Loop % Headers.MaxIndex()
				Output .= (A_Index = 1 ? "" : "`t") (RegExMatch(Row[Headers[A_Index]], "[,`n`r""]") ? """" StrReplace(Row[Headers[A_Index]], """", """""") """" : Row[Headers[A_Index]])
		}
		Table.Delete(0)
		FileAppend, %Output%, %OutputPath%
		Return ErrorLevel
	}
}