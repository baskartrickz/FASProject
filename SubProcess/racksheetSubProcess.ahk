Racksheetlaunch(racksheet)
{
	try
	{
		racksheet.launch()
	}
	catch e
	{
		e := "System exception: BOT failed to launch racsheet!"
		throw e
	}
}	
Racksheetlogin(racksheet,botcredential)
{
	try
	{	
		racksheet.login(botcredential)
	}
	catch e
	{
		e := "System exception: BOT failed to login racsheet!"
		throw e
	}
}
Racksheetselectstate(racksheet,exchangeSheetData,mirorFinalData,chronosInputdata,orderInfo)
{
	try
	{
		states := {}
		states := {"KY":"Kentucky","AL":"Alabama","AR":"Arkansas","FL":"Florida","GA":"Georgia","IA":"Iowa","MN":"Minnesota","MS":"Mississippi","MO":"Missouri","NE":"Nebraska","NY":"New York","NM":"New Mexico","NC":"North Carolina","OH":"Ohio","OK":"Oklahoma","PA":"Pennsylvania","SC":"South Carolina","TX":"Texas"}
		for key, statename in states
		{
			if (key = exchangeSheetData["state"])
			{
				racksheetState := statename
			}
		}
		if (orderInfo = "human")
		{
			Loop % mirorFinalData.MaxIndex()
			{
				MirrorWcIn := trim(mirorFinalData[A_Index]["primarymirorrecord"]["MirroWCIN"])
				if (MirrorWcIn != "")
				{
					break
				}
			}
		}
		else
		{
			Loop % chronosInputdata.MaxIndex()
			{
				MirrorWcIn := trim(chronosInputdata[A_Index]["primaryMirrorWcIn"])
				if (MirrorWcIn != "")
				{
					break
				}
			}
		}
		mirorwc := MirrorWcIn
		exchange := exchangeSheetData["exchange"]
		newexchange := exchangeVerification(exchange,mirorwc)
		if (newexchange = "")
		{
			newexchange := exchange
		}
		racksheet.selectstate(newexchange,racksheetState)		
	}
	catch e
	{
		e := "System exception: BOT failed to selectstate in racsheet!"
		throw e
	}
}
exchangeVerification(exchange,mirorwc)
{
	if (exchange = "Lincoln")
	{
		exchange := "Lincoln - " . mirorwc
	}
	else if (exchange = "Lexington Main")
	{
		mirorWireCenter := {"LXTE":"Lexington East","LXEK":"Lexington Elkhorn","LXTL":"Lexington Lakeside","LXTM":"Lexington Main","LXTN":"Lexington North","LXTS":"Lexington South","LXSE":"Lexington Southeast"}
		for key, wc in mirorWireCenter
		{
			if (key = mirorwc)
			{
				exchange := wc
			}
		}
	}
	else if (exchange = "Hobbs North")
	{
		if (mirorWc = "HBBN")
		{
			exchange := "Hobbs North"
		}
		else if (mirorWc = "HBBS")
		{
			exchange := "Hobbs Main"
		}
	}
	else if (exchange = "Charlotte")
	{
		if (mirorWc = "CHAR")
		{
			exchange := "Charlotte"
		}
		else if (mirorWc = "GAST")
		{
			exchange := "Gastonia"
		}
		else if (mirorWc = "DAVI")
		{
			exchange := "Davidson"
		}
		else if (mirorWc = "HUNT")
		{
			exchange := "Huntersville"
		}
		else if (mirorWc = "LOCU")
		{
			exchange := "Locust"
		}
		else if (mirorWc = "LWLL")
		{
			exchange := "Lowell"
		}
		else if (mirorWc = "MTHO")
		{
			exchange := "Mount Holly"
		}
		else if (mirorWc = "SALI")
		{
			exchange := "Salisbury"
		}
	}
	else if (exchange = "Elyria")
	{
		if (mirorWc = "ABBE")
		{
			exchange := "Abbe"
		}
		else if (mirorWc = "ELYR")
		{
			exchange := "Elyria"
		}
		else if (mirorWc = "NRTH")
		{
			exchange := "Elyria North"
		}
		else if (mirorWc = "ELSO")
		{
			exchange := "Elyria South"
		}
		else if (mirorWc = "LGRN")
		{
			exchange := "LaGrange"
		}
		else if (mirorWc = "NRVL")
		{
			exchange := "North Ridgeville"
		}
		
	}
	else if (exchange = "Elyria")
	{
		if (mirorWc = "WYMN")
		{
			exchange := "Ashtabula"
		}
		else if (mirorWc = "WDLD")
		{
			exchange := "Woodland"
		}
	}
	else if (exchange = "Newark North")
	{
		if (mirorWc = "HETH")
		{
			exchange := "Heath"
		}
		else if (mirorWc = "NWRK")
		{
			exchange := "Newark"
		}
		else if (mirorWc = "NWNO")
		{
			exchange := "Newark North"
		}
		else if (mirorWc = "NWSO")
		{
			exchange := "Newark South"
		}
		else if (mirorWc = "WEST")
		{
			exchange := "Newark West"
		}
	}
	else if (exchange = "Broken Arrow West")
	{
		if (mirorWc = "BRRE")
		{
			exchange := "Broken Arrow East"
		}
		else if (mirorWc = "BRRM")
		{
			exchange := "Broken Arrow Main"
		}
		else if (mirorWc = "BRRN")
		{
			exchange := "Broken Arrow North"
		}
		else if (mirorWc = "BRRS")
		{
			exchange := "Broken Arrow South"
		}
		else if (mirorWc = "BRRW")
		{
			exchange := "Broken Arrow West"
		}
	}
	else if (exchange = "Lexington/North Augusta")
	{
		exchange := "Lexington"
	}
	else if (exchange = "Texarkana Main")
	{
		if (mirorWc = "TXRK")
		{
			exchange := "Texarkana Main"
		}
		else if (mirorWc = "TXRW")
		{
			exchange := "Texarkana West"
		}
	}
}
Racksheetinputform(racksheet,counter,snePagedetails,mirorOutrecord,svcorderinfo,duedate,boid,chronosInputdata,asocLookupdata,orderInfo,ctrlpageData,racsheetSegmentCount)
{
	racksheetPrimaryData := {}
	racksheetBondedData := {}
	if (orderInfo = "human")
	{
		svcorderinfo := svcorderinfo
		duedate := duedate
		boid := boid
		cbr1 := trim(snePagedetails[counter]["cbr"])
		if (cbr1 = "")
		{
			cbr1 := trim(ctrlpageData["cbr"])
			if (cbr1 = "")
			{
				cbr1 := 9999999999
			}
		}
		winback := snePagedetails[counter]["winback"]
		tempspeed := snePagedetails[counter]["tempSpeed"]
	
		primarypicIpic := snePagedetails[counter]["primarypicIpic"]
		primarytelePhoneIn := snePagedetails[counter]["primarytelePhoneIn"]
		primarytelePhoneOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["TelephoneIN"]
		primarymirorGradeIn := snePagedetails[counter]["primarymirorGradeIn"]
		primarymirorGradeOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["MirrorGradeIN"]
		primaryMirrorWcIn := snePagedetails[counter]["primaryMirrorWcIn"]
		primaryMirrorWcOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["MirroWCIN"]
		primarycoeIn := snePagedetails[counter]["primarycoeIn"]
		primarycoeOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["COEIN"]
		primarymdfPairIn := snePagedetails[counter]["primarymdfPairIn"]
		primarymdfPairOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["MDFPairIN"]
		primaryframeTiePairIn := snePagedetails[counter]["primaryframeTiePairIn"]
		primaryframeTiePairOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["FrameTiePair1IN"]
		primaryloopTreatIn := snePagedetails[counter]["primaryloopTreatIn"]
		primaryloopTreatOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["LoopTreatment1BLKPININ"]
		primarylineEquipmentIn := snePagedetails[counter]["primarylineEquipmentIn"]
		primarylineEquipmentOut := mirorOutrecord[counter]["miroroldprimaryRecord"]["LineEquipmentIN"]
		
		facRemarksSe := snePagedetails[counter]["facilityRemarks"]
		facilityRemarks := snePagedetails[counter]["facilityRemarks"]
		facremark := StrSplit(facilityRemarks,"/BND")
		if strlen(facremark[2])=0
		{
			facremark := StrSplit(facilityRemarks,"/BONDED")
		}
		
		if(instr(facremark[1],"RAC TO CO/TECH WILL CALL") or winback ="YES")
		{
			primarytechWillCall := "YES"
		}
		else
		{
			primarytechWillCall := "NO"
		}
		
		if(instr(facremark[2],"RAC TO CO/TECH WILL CALL") or winback ="YES")
		{
			bondedtechWillCall := "YES"
		}
		else
		{
			bondedtechWillCall := "NO"
		}
		
		if ((instr(facRemarksSe, "TEMP SPEED")) or (instr(facRemarksSe, "ONLY QUALIFY UPTO")) or (instr(facRemarksSe, "ONLY QUALIFIED UP TO")) or (instr(facRemarksSe, "ONLY QUAL UPTO"))	or (instr(facRemarksSe, "ONLY QUAL UP TO")))
		{
			if (instr(facRemarksSe, "TEMP SPEED"))
			{
				StringGetPos, position1 , facRemarksSe, TEMP SPEED , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUALIFY UPTO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUALIFY UPTO , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUALIFIED UP TO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUALIFIED UP TO , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUAL UPTO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUAL UPTO , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUAL UP TO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUAL UP TO , , 1
			}
			
			if (instr(facRemarksSe, "IPTV"))
			{
				StringGetPos, position2 , facRemarksSe, IPTV , L1, position1
				position2 := position2 + 1
			}
			else if(instr(facRemarksSe, "Internet Access"))
			{
				StringGetPos, position2 , facRemarksSe, Internet Access , L1, position1
				position2 := position2 + 11
			}
			else if(instr(facRemarksSe, "EXTENDED REACH"))
			{
				StringGetPos, position2 , facRemarksSe, EXTENDED REACH , L1, position1
				position2 := position2 + 11
			}
			else if(instr(facRemarksSe, "Best Effort"))
			{
				StringGetPos, position2 , facRemarksSe, Best Effort , L1, position1
				position2 := position2 + 9
			}
			else if (instr(facRemarksSe, "0k ")) or (instr(facRemarksSe, "1k ")) or (instr(facRemarksSe, "2k ")) or (instr(facRemarksSe, "3k ")) or (instr(facRemarksSe, "4k ")) or (instr(facRemarksSe, "5k ")) or (instr(facRemarksSe, "6k ")) or (instr(facRemarksSe, "7k ")) or (instr(facRemarksSe, "8k ")) or (instr(facRemarksSe, "9k "))
			{
				kb :=[]
		
				kb := ["0k ","1k ","2k ","3k ","4k ","5k ","6k ","7k ","8k ","9k "]
				;~ kb.push(kb1)
				while true
				{
					kvalue := kb[a_Index]
					StringGetPos, position2 , facRemarksSe, %kvalue% , L2, position1
					if (position2 = -1)
					{
						StringGetPos, position2 , facRemarksSe, %kvalue% , L1, position1
					}
					if (position2 != -1)
					{
					break
					}
				}
			}
			else
			{
				StringGetPos, position2 , facRemarksSe, mb , L3, position1	
				if (position2 = -1)
				{
					StringGetPos, position2 , facRemarksSe, mb , L2, position1	
				}
				if (position2 = -1)
				{ 
					StringGetPos, position2 , facRemarksSe, mb , L1, position1
				}
			}
			poscount := position2 - position1
			StringMid, tempSpeed, facRemarksSe, position1 + 1 , poscount + 3, 
			tempSpeed := strReplace(tempSpeed,"Temp Speed","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUALIFY UPTO","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUALIFIED UP TO","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUAL UPTO","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUAL UP TO","")
		}
			
		facRemarks := snePagedetails[counter]["facilityRemarks"] . "`n" . "ISP= WINDSTREAM" . "`n" . "SPEEED= " . tempspeed . "`n" . "CBR=" . cbr1
		
		if (tempSpeed = "")
		{
			tempSpeed := asocLookupdata[counter]["speed"]
			if (tempSpeed ="")
			{
				facRemarks := snePagedetails[counter]["facilityRemarks"] . "`n"  "CBR=" . cbr1
			}
			else
			{
				facRemarks := snePagedetails[counter]["facilityRemarks"] . "`n" . "ISP= WINDSTREAM" . "`n" . "SPEEED= " . tempspeed . "`n" . "CBR=" . cbr1
			}
		}
		
		if (asocLookupdata[counter]["callingFeature"] = "present")
		{
			FeatureIn := "YES"
			FeatureOut := "NO"
		}
		else
		{
			FeatureIn := "NO"
			FeatureOut := "NO"
		}
		if (instr(facRemarks, "RAC TO CO"))
		{
			racco := "YES"
			racsag := "NO"
			raccomplex := "NO"			
		}
		else if(instr(facRemarks, "RAC TO SAG"))
		{
			racco := "NO"
			racsag := "YES"
			raccomplex := "NO"
		}
		else if(instr(facRemarks, "RAC TO COMPLEX"))
		{
			racco := "NO"
			racsag := "NO"
			raccomplex := "YES"			
		}
		else if(instr(facRemarks, "RAC TO CO&SAG"))
		{
			racco := "YES"
			racsag := "YES"
			raccomplex := "NO"			
		}
		else if(instr(facRemarks, "RAC TO CO&COMPLEX"))
		{
			racco := "YES"
			racsag := "NO"
			raccomplex := "YES"				
		}

		bondedpicIpic := snePagedetails[counter]["bondedpicIpic"]
		bondedtelePhoneIn := snePagedetails[counter]["bondedtelePhoneIn"]
		bondedtelePhoneOut := mirorOutrecord[counter]["miroroldBondedRecord"]["TelephoneIN"]
		bondedmirorGradeIn := "BD"
		bondedmirorGradeOut := mirorOutrecord[counter]["miroroldBondedRecord"]["MirrorGradeIN"]
		bondedMirrorWcIn := snePagedetails[counter]["bondedMirrorWcIn"]
		bondedMirrorWcOut := mirorOutrecord[counter]["miroroldBondedRecord"]["MirroWCIN"]
		bondedcoeIn := snePagedetails[counter]["bondedcoeIn"]
		bondedcoeOut := mirorOutrecord[counter]["miroroldBondedRecord"]["COEIN"]
		bondedmdfPairIn := snePagedetails[counter]["bondedmdfPairIn"]
		bondedmdfPairOut := mirorOutrecord[counter]["miroroldBondedRecord"]["MDFPairIN"]
		bondedframeTiePairIn := snePagedetails[counter]["bondedframeTiePairIn"]
		bondedframeTiePairOut := mirorOutrecord[counter]["miroroldBondedRecord"]["FrameTiePair1IN"]
		bondedloopTreatIn := snePagedetails[counter]["bondedloopTreatIn"]
		bondedloopTreatOut := mirorOutrecord[counter]["miroroldBondedRecord"]["LoopTreatment1BLKPININ"]
		bondedlineEquipmentIn := snePagedetails[counter]["bondedlineEquipmentIn"]
		bondedlineEquipmentOut := mirorOutrecord[counter]["miroroldBondedRecord"]["LineEquipmentIN"]
		
	}
	else 
	{
		
		svcorderinfo := svcorderinfo
		duedate := duedate
		boid := boid
		cbr1 := trim(snePagedetails[counter]["cbr"])
		if (cbr1 = "")
		{
			cbr1 := trim(ctrlpageData["cbr"])
			if (cbr1 = "")
			{
				cbr1 := 9999999999
			}
		}
		winback := snePagedetails[counter]["winback"]
		primarypicIpic := chronosInputdata[counter]["primarypicIpic"]
		primarytelePhoneIn := chronosInputdata[counter]["primarytelePhoneIn"]
		primarytelePhoneOut := chronosInputdata[counter]["primarytelePhoneOut"]
		primarymirorGradeIn := chronosInputdata[counter]["primarymirorGradeIn"]
		primarymirorGradeOut := chronosInputdata[counter]["primarymirorGradeOut"]
		primaryMirrorWcIn := chronosInputdata[counter]["primaryMirrorWcIn"]
		primaryMirrorWcOut := chronosInputdata[counter]["primaryMirrorWcOut"]
		primarycoeIn := chronosInputdata[counter]["primarycoeIn"]
		primarycoeOut := chronosInputdata[counter]["primarycoeOut"]
		primarymdfPairIn := chronosInputdata[counter]["primarymdfPairIn"]
		primarymdfPairOut := chronosInputdata[counter]["primarymdfPairOut"]
		primaryframeTiePairIn := chronosInputdata[counter]["primaryframeTiePairIn"]
		primaryframeTiePairOut := chronosInputdata[counter]["primaryframeTiePairOut"]
		primaryloopTreatIn := chronosInputdata[counter]["primaryloopTreatIn"]
		primaryloopTreatOut := chronosInputdata[counter]["primaryloopTreatOut"]
		primarylineEquipmentIn := chronosInputdata[counter]["primarylineEquipmentIn"]
		primarylineEquipmentOut := chronosInputdata[counter]["primarylineEquipmentOut"]
		facRemarksSe := snePagedetails[counter]["facilityRemarks"]
		facilityRemarks := snePagedetails[counter]["facilityRemarks"]
		facremark := StrSplit(facilityRemarks,"/BND")
		if strlen(facremark[2])=0
		{
			facremark := StrSplit(facilityRemarks,"/BONDED")
		}

		if(instr(facremark[1],"RAC TO CO/TECH WILL CALL") or winback ="YES")
		{
			primarytechWillCall := "YES"
		}
		else
		{
			primarytechWillCall := "NO"
		}
		
		if(instr(facremark[2],"RAC TO CO/TECH WILL CALL") or winback ="YES")
		{
			bondedtechWillCall := "YES"
		}
		else
		{
			bondedtechWillCall := "NO"
		}
		
		if ((instr(facRemarksSe, "TEMP SPEED")) or (instr(facRemarksSe, "ONLY QUALIFY UPTO")) or (instr(facRemarksSe, "ONLY QUALIFIED UP TO")) or (instr(facRemarksSe, "ONLY QUAL UPTO"))	or (instr(facRemarksSe, "ONLY QUAL UP TO")))
		{
			if (instr(facRemarksSe, "TEMP SPEED"))
			{
				StringGetPos, position1 , facRemarksSe, TEMP SPEED , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUALIFY UPTO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUALIFY UPTO , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUALIFIED UP TO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUALIFIED UP TO , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUAL UPTO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUAL UPTO , , 1
			}
			else if (instr(facRemarksSe, "ONLY QUAL UP TO"))
			{
				StringGetPos, position1, facRemarksSe, ONLY QUAL UP TO , , 1
			}
			
			if (instr(facRemarksSe, "IPTV"))
			{
				StringGetPos, position2 , facRemarksSe, IPTV , L1, position1
				position2 := position2 + 1
			}
			else if(instr(facRemarksSe, "Internet Access"))
			{
				StringGetPos, position2 , facRemarksSe, Internet Access , L1, position1
				position2 := position2 + 11
			}
			else if(instr(facRemarksSe, "EXTENDED REACH"))
			{
				StringGetPos, position2 , facRemarksSe, EXTENDED REACH , L1, position1
				position2 := position2 + 11
			}
			else if(instr(facRemarksSe, "Best Effort"))
			{
				StringGetPos, position2 , facRemarksSe, Best Effort , L1, position1
				position2 := position2 + 9
			}
			else if (instr(facRemarksSe, "0k ")) or (instr(facRemarksSe, "1k ")) or (instr(facRemarksSe, "2k ")) or (instr(facRemarksSe, "3k ")) or (instr(facRemarksSe, "4k ")) or (instr(facRemarksSe, "5k ")) or (instr(facRemarksSe, "6k ")) or (instr(facRemarksSe, "7k ")) or (instr(facRemarksSe, "8k ")) or (instr(facRemarksSe, "9k "))
			{
				kb :=[]
		
				kb := ["0k ","1k ","2k ","3k ","4k ","5k ","6k ","7k ","8k ","9k "]
				;~ kb.push(kb1)
				while true
				{
					kvalue := kb[a_Index]
					StringGetPos, position2 , facRemarksSe, %kvalue% , L2, position1
					if (position2 = -1)
					{
						StringGetPos, position2 , facRemarksSe, %kvalue% , L1, position1
					}
					if (position2 != -1)
					{
					break
					}
				}
			}
			else
			{
				StringGetPos, position2 , facRemarksSe, mb , L3, position1	
				if (position2 = -1)
				{
					StringGetPos, position2 , facRemarksSe, mb , L2, position1	
				}
				if (position2 = -1)
				{ 
					StringGetPos, position2 , facRemarksSe, mb , L1, position1
				}
			}
			poscount := position2 - position1
			StringMid, tempSpeed, facRemarksSe, position1 + 1 , poscount + 3, 
			tempSpeed := strReplace(tempSpeed,"Temp Speed","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUALIFY UPTO","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUALIFIED UP TO","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUAL UPTO","")
			tempSpeed := strReplace(tempSpeed,"ONLY QUAL UP TO","")
		}
		 
			facRemarks := snePagedetails[counter]["facilityRemarks"] . "`n" . "ISP= WINDSTREAM" . "`n" . "SPEEED= " . tempspeed . "`n" . "CBR=" . cbr1
			
		if (tempSpeed = "")
		{
			tempSpeed := asocLookupdata[counter]["speed"]
			if (tempSpeed ="")
			{
				facRemarks := snePagedetails[counter]["facilityRemarks"] . "`n"  "CBR=" . cbr1
			}
			else
			{
				facRemarks := snePagedetails[counter]["facilityRemarks"] . "`n" . "ISP= WINDSTREAM" . "`n" . "SPEEED= " . tempspeed . "`n" . "CBR=" . cbr1
			}
		}
		
		if (asocLookupdata[counter]["callingFeature"] = "present")
		{
			FeatureIn := "YES"
			FeatureOut := "NO"
		}
		else
		{
			FeatureIn = "NO"
			FeatureOut = "NO"
		}
		if (instr(facRemarks, "RAC TO CO"))
		{
			racco := "YES"
			racsag := "NO"
			raccomplex := "NO"			
		}
		else if(instr(facRemarks, "RAC TO SAG"))
		{
			racco := "NO"
			racsag := "YES"
			raccomplex := "NO"
		}
		else if(instr(facRemarks, "RAC TO COMPLEX"))
		{
			racco := "NO"
			racsag := "NO"
			raccomplex := "YES"			
		}
		else if(instr(facRemarks, "RAC TO CO&SAG"))
		{
			racco := "YES"
			racsag := "YES"
			raccomplex := "NO"			
		}
		else if(instr(facRemarks, "RAC TO CO&COMPLEX"))
		{
			racco := "YES"
			racsag := "NO"
			raccomplex := "YES"				
		}
	
		bondedpicIpic := chronosInputdata[counter]["bondedpicIpic"]
		bondedtelePhoneIn := chronosInputdata[counter]["bondedtelePhoneIn"]
		bondedtelePhoneOut := chronosInputdata[counter]["bondedtelePhoneOut"]
		bondedmirorGradeIn := "BD"
		bondedmirorGradeOut := chronosInputdata[counter]["bondedmirorGradeOut"]
		bondedMirrorWcIn := chronosInputdata[counter]["bondedMirrorWcIn"]
		bondedMirrorWcOut := chronosInputdata[counter]["bondedMirrorWcOut"]
		bondedcoeIn := chronosInputdata[counter]["bondedcoeIn"]
		bondedcoeOut := chronosInputdata[counter]["bondedcoeOut"]
		bondedmdfPairIn := chronosInputdata[counter]["bondedmdfPairIn"]
		bondedmdfPairOut := chronosInputdata[counter]["bondedmdfPairOut"]
		bondedframeTiePairIn := chronosInputdata[counter]["bondedframeTiePairIn"]
		bondedframeTiePairOut := chronosInputdata[counter]["bondedframeTiePairOut"]
		bondedloopTreatIn := chronosInputdata[counter]["bondedloopTreatIn"]
		bondedloopTreatOut := chronosInputdata[counter]["bondedloopTreatOut"]
		bondedlineEquipmentIn := chronosInputdata[counter]["bondedlineEquipmentIn"]
		bondedlineEquipmentOut := chronosInputdata[counter]["bondedlineEquipmentOut"]

	}

	racksheetPrimaryData := {"svcorderinfo":svcorderinfo,"duedate":duedate,"boid":boid,"cbr1":cbr1,"primarypicIpic":primarypicIpic,"primarytelePhoneIn":primarytelePhoneIn,"primarytelePhoneOut":primarytelePhoneOut,"primarymirorGradeIn":primarymirorGradeIn,"primarymirorGradeOut":primarymirorGradeOut,"primaryMirrorWcIn":primaryMirrorWcIn,"primaryMirrorWcOut":primaryMirrorWcOut,"primarycoeIn":primarycoeIn,"primarycoeOut":primarycoeOut,"primarymdfPairIn":primarymdfPairIn,"primarymdfPairOut":primarymdfPairOut,"primaryframeTiePairIn":primaryframeTiePairIn,"primaryframeTiePairOut":primaryframeTiePairOut,"primaryloopTreatIn":primaryloopTreatIn,"primaryloopTreatOut":primaryloopTreatOut,"primarylineEquipmentIn":primarylineEquipmentIn,"primarylineEquipmentOut":primarylineEquipmentOut,"primarynewLen":primarynewLen,"facRemarks":facRemarks,"speed":tempspeed,"primarytechWillCall":primarytechWillCall,"primaryFeatureIn":FeatureIn,"primaryFeatureOut":FeatureOut,"winback":winback,"racco":racco,"racsag":racsag,"raccomplex":raccomplex}
	
	
	racksheetBondedData := {"bondedpicIpic":bondedpicIpic,"bondedtelePhoneIn":bondedtelePhoneIn,"bondedtelePhoneOut":bondedtelePhoneOut,"bondedmirorGradeIn":bondedmirorGradeIn,"bondedmirorGradeOut":bondedmirorGradeOut,"bondedMirrorWcIn":bondedMirrorWcIn,"bondedMirrorWcOut":bondedMirrorWcOut,"bondedcoeIn":bondedcoeIn,"bondedcoeOut":bondedcoeOut,"bondedmdfPairIn":bondedmdfPairIn,"bondedmdfPairOut":bondedmdfPairOut,"bondedframeTiePairIn":bondedframeTiePairIn,"bondedframeTiePairOut":bondedframeTiePairOut,"bondedloopTreatIn":bondedloopTreatIn,"bondedloopTreatOut":bondedloopTreatOut,"bondedlineEquipmentIn":bondedlineEquipmentIn,"bondedlineEquipmentOut":bondedlineEquipmentOut,"bondednewLen":bondednewLen,"cbr1":cbr1,"facRemarks":facRemarks,"speed":tempspeed,"bondedtechWillCall":bondedtechWillCall,"bondedFeatureIn":FeatureIn,"bondedFeatureout":FeatureOut,"winback":winback,"racco":racco,"racsag":racsag,"raccomplex":raccomplex}

	
	try
	{
		racksheet.primaryinputform(racksheetPrimaryData)
		if (bondedmdfPairIn != "")
		{
			Racksheetlastsubmitbutton(racksheet)
			sleep, 5000
			racksheet.bondedinputform(racksheetBondedData)
			if (racsheetSegmentCount = counter)
			{
				try
				{
					Racksheetlastseg(racksheet)
				}
				MsgBox last segment
				Racksheetlastsubmitbutton(racksheet)
				racksheet.rachsheetFinalSubmit()
			}
		}
		else
		{
			if (racsheetSegmentCount = counter)
			{
				MsgBox last segment
				try
				{
					Racksheetlastseg(racksheet)
					Racksheetlastsubmitbutton(racksheet)
					racksheet.rachsheetFinalSubmit()
				}
			}
			try
			{
				Racksheetlastsubmitbutton(racksheet)
			}
			
		}
	}
	catch e
	{
		e := "System exception: BOT failed to update racksheet information."
		throw e
	}
}
Racksheetlastseg(racksheet)
{
	try
	{
		racksheet.lastseg()
	}
	catch e
	{
		e := "System exception: BOT failed to click lastseg in racksheet"
		throw e
	}
}
Racksheetlastsubmitbutton(racksheet)
{
	try
	{
		racksheet.lastsubmitbutton()
	}
	catch e
	{
		e := "System exception: BOT failed to click Lastsubmitbutton in racksheet"
		throw e
	}
}
