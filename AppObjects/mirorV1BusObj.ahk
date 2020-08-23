class mirorV1BusObj
{
	launch(exchangeSheetData)
	{
		try
		{
			run, "C:\Users\Public\Desktop\PowerTerm Pro Enterprise.lnk" ;311, 162, mir00p70.windstream.com
			mirorPackage := exchangeSheetData["mirrorPackage"] . ".windstream.com"
			WinWait, Connect
			if winexist("Connect")
			{
				ControlSetText, Edit1, % mirorPackage,Connect
				sleep 3000
				ControlClick, Button10, Connect,,Left,2
				sleep, 2000
			}
		}
		catch e
		{
			e := "system exception:Bot failed to load miror application"
			throw e
		}
	}
	login(botcredential)
	{
		try
		{
			WinMaximize, (A) TELNET, % mirorPackage, - PowerTerm Pro Enterprise Suite
			sleep , 3000
			send, % botcredential["csoId"]
			sleep 2000
			send {Enter}
			sleep 1000
			loop,100
			{
				send, !{F10}
				loginpage := Clipboard
				Clipboard := ""
				if (InStr(loginpage,"Windstream CSO Password"))
				{
					send, % botcredential["csoPassword"]
					send, {Enter}
					break
				}
				else
				{
					sleep 1000
				}
			}					
			loop 50
			{
				sleep 3000
				send, !{F10}
				Lineorder := Clipboard
				Clipboard := ""
				if (InStr(Lineorder,"Line Order Processing"))
				{
					send, LINORD
					sleep, 1000
					send, {Enter}
					break
				}
				else
				{
					sleep 1000
				}
			}
			loop 50
			{
				sleep 3000
				send, !{F10}
				modify := Clipboard
				Clipboard := ""
				if (InStr(modify,"Modify Service"))
				{
					send, MODIFY
					sleep, 1000
					send, {Enter}
					break
				}
				else
				{
					sleep 1000
				}
			}
			Sleep, 3000
			send, 1
			sleep, 2000
			send, P
		}
		catch e
		{
			e := "system exception:Bot failed to login miror application"
			throw e
		}
	}
    Primaryrecord(Tn)
    {
		try
		{
			sleep, 1000
			send , % Tn
			sleep, 2000
			send, {F12}
			sleep, 3000
			counterVariable := 0
			while True
			{
				Sleep, 2000
				Clipboard := ""
				sleep, 1000
				
				send, !{F10}
				sleep, 2000
				serviceStatus := Clipboard
				npa := SubStr(tn,1,3)
				nxx := SubStr(tn,4,3)
				linenumber := SubStr(tn,7,4)
				telephone := npa . " " . nxx . "-" . linenumber
				if ((InStr(serviceStatus,"former service")) and (InStr(serviceStatus, telephone)))
				{
					send, {F1}
				}
				else if ((InStr(serviceStatus,"active service")) and (InStr(serviceStatus, telephone)))
				{
					Clipboard := ""
					sleep 1000
					send, !{F10}
					sleep 2000
					primarymirorData := Clipboard
					break
				}
				else 
				{
					sleep 2000
					if (counterVariable = 10)
					{
						throw e
					}
					break
				}
				counterVariable++
			}
			return primarymirorData
		}
		catch e
		{
			e := "system exception:Bot failed to get primary miror data"
			throw e
		}
    }
	Bondedrecord(seArray)
	{
		try
		{
			while true
			{
				mirordata := ""
				Clipboard := ""
				sleep 2000
				send, !{F10}
				sleep, 2000
				bondedData := Clipboard
				if(instr(bondedData,"BONDED"))
				{
				   send, {F4}
				   sleep, 2000
				   send, 09
				   sleep, 2000
				   send, !{F10}
				   sleep, 2000
				   mirordata := Clipboard
				   sleep, 1000
				   send, {F9}
				   sleep, 1000
				   send, {F9}
				   sleep, 1000
				   send, {F12}
				   Clipboard := ""
				   break
				}
				else if(instr(bondeddata,"BND"))
				{					
					Clipboard := ""				
					send, !{F10}
					sleep,2000
					tieddata := Clipboard
					stringgetpos,ttn,tieddata,BND (,1,0
					sleep,2000
					Stringmid, npa, tieddata, ttn + 5, 14
					tiedTN := RegExReplace(npa, "\W", "")
					tiedtele := SubStr(tiedTN,4)			
					sleep, 3000
					loop % seArray.MaxIndex()
					{
						tn :=  seArray[A_index]["tele"]
						if (tn = tiedtele)
						{
							bndstatus := "miror matching"
						}
					}
					if (bndstatus != "miror matching")
					{
					
						send % tiedTN
						sleep, 2000
						send {enter}
						sleep, 3000
						clipboard := ""
						send, !{F10}
						sleep, 3000
						mirordata := clipboard
						Clipboard := ""
					}
					break
				}
				else
				{
					sleep, 1000
					break
				}
			}
			if (bndstatus != "miror matching" )
			{
				return mirordata
			}
		}
		catch e
		{
			e := "system exception:Bot failed to get bonded miror data"
			throw e
		}
	}
	NoteSegragation(mirorrecord)    
	{	
		try
		{
			mirorrecordarr := {}
			out := mirorrecord
			out := StrSplit(out,"`n")
			loop % out.maxindex()
			{
				val :=  out[A_Index]
				val := trim(RegExReplace(val, "S) +", A_Space))
				if (instr(val,"wc") and InStr(val,"area"))
				{
					wc := StrSplit(val,A_Space)
					loop % wc.Maxindex()
					{
						if (wc[A_index] = "wc")
						{
							MirroWCIN := wc[A_Index + 1]
						}
					}
				}
				else if (instr(val,"pic") and InStr(val,"ipic"))
				{
					picIpic := StrSplit(val,A_Space)
					loop % picIpic.MaxIndex()
					{
						if (picIpic[A_Index] = "pic")
						{
							pic1 := picIpic[A_Index + 1]
						}
						else if (picIpic[A_Index] = "ipic")
						{
							ipic := picIpic[A_Index + 1]
						}
					}
					PICIPIC := pic1 . "/" . ipic
				}
				else if(instr(val,"telephone") and InStr(val,"coe"))
				{
					tn := StrSplit(val,A_Space)
					loop % tn.maxindex()
					{
						if (tn[A_index] = "telephone")
						{
							newTn := tn[A_index + 1] . tn[A_index + 2]
							TelephoneIN := strReplace(newTn,"-","")
						}
						else if (tn[A_index] = "coe")
						{
							COEIN := tn[A_index + 1]
						}
						 else if (tn[A_index] = "grade")
						{

							MirrorGradeIN := tn[A_index + 1]
						}
						
					}
					
				}
				else if (instr(val,"adw") and InStr(val,"bdw"))
				{
					mirorDw := StrSplit(val,A_Space)
					loop % mirorDw.maxindex()
						
					{
						if (mirorDw[A_Index] = "adw")
						{
							adw := mirorDw[A_index + 1]
						}
						else if (mirorDw[A_Index] = "bdw")
						{
							bdw := mirorDw[A_index + 1]
						}
					}
				}
				else if (instr(val,"tie") and InStr(val,"pair"))
				{
					tiepair := StrSplit(val,A_Space)
					loop % tiepair.maxindex()
					{
						if (tiepair[A_Index] = "tie")
						{
							tie := tiepair[A_index + 1]
						}
						else if(tiepair[A_Index] = "pair")
						{
							pair := tiepair[A_index + 1]
						}
						else
						{
							temporary := tiepair[A_Index]
							orgVal := orgVal . " " . temporary
							orgVal := strReplace(orgVal,tie . " " . pair)
						}
					}
					FrameTiePair1IN := tie . "/" . pair . " " . orgval
				}
				else if (instr(val,"mdf") and InStr(val,"bp"))
				{
					mdf := StrSplit(val,A_Space)
					loop % mdf.maxindex()
					{
						if (mdf[A_Index] = "mdf")
						{
							newMdf := mdf[A_index + 1] "/" mdf[A_index + 3]
						}
						else if (mdf[A_Index] = "bp")
						{
							mdfBp := mdf[A_index + 1]
						}
						else if (mdf[A_Index] = "zn")
						{
							mdfZone := mdf[A_index + 1] " " mdf[A_index + 2] " "  mdf[A_index + 3]
						}
					}
					if (mdfZone != "")
					{
						mdfZone := "zn " . mdfZone
					}
					MDFPairIN := newMdf . " " . mdfBp . " " .  mdfZone
				}
				else if (instr(val,"lt type") or instr(val,"lt ty"))
				{
					if (instr(val,"number") or instr(val,"nbr"))
					{
						pin := StrSplit(val,A_Space)
						loop % pin.maxindex()
						{
							if (pin[A_Index] = "type" or pin[A_Index] = "ty")
							{
								newpin := pin[A_index + 1] "/" pin[A_index + 3]
							}
							else if (pin[A_Index] = "zn")
							{
								pinZone := pin[A_index + 1] " " pin[A_index + 2] " "  pin[A_index + 3]
							}
						}
						if (pinZone != "")
						{
							pinZone := "zn " . pinZone
						}
						LoopTreatment1BLKPININ :=  newpin . " " . pinZone
					}
				}
				else if (instr(val,"lci") and instr(val,"lc bay"))
				{
					len := StrSplit(val,A_Space)
					loop % len.maxindex()
					{
						if (len[A_index] = "bay")
						{
							LineEquipmentIN := len[A_index + 1] "/" len[A_index + 3] "/" len[A_index + 5] 
							if (len[A_index + 6]  = "lci")
							{
								if (len[A_index + 7] != "rc")
								{
									LineEquipmentIN := LineEquipmentIN . "/" len[A_index + 7]
								}
							}
						}
						else if (len[A_Index] = "zn")
						{
							lenZone := pin[A_index + 1] " " pin[A_index + 2] " "  pin[A_index + 3]
						}
					}
					LineEquipmentIN := LineEquipmentIN . " " . lenZone
				}
				val := ""
			}

			mirorrecordarr := {"MirroWCIN":MirroWCIN,"PICIPIC":PICIPIC,"TelephoneIN":TelephoneIN,"COEIN":COEIN,"MirrorGradeIN":MirrorGradeIN,"adw":adw,"bdw":bdw,"FrameTiePair1IN":FrameTiePair1IN,"MDFPairIN":MDFPairIN,"LoopTreatment1BLKPININ":LoopTreatment1BLKPININ,"LineEquipmentIN":LineEquipmentIN,"newlen":newlen,"newpin":newpin}
			return mirorrecordarr
		}
		catch e
		{
			e := "system exception:Bot failed in NoteSegragation"
			throw e
		}
	}
	mirwinclose()
	{
		try
		{
			WinActivate, (A) TELNET
			loop,10
			{
				send, !{F10}
				logoutpage := Clipboard
				if (InStr(logoutpage,"Exit Miror"))
				{
					send, E
					sleep 1000
					send, {Enter}
					sleep 2000
					WinClose, (A) TELNET
					break
				}
				else
				{
					send, {F9}
					sleep, 1000
				}
			}
		}
		catch e
		{
			e := "system exception:Bot failed to close miror application"
			throw e
		}
	}		
}

