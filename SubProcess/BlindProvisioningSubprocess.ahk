blindprovisionlaunch(blindprovision)
{
	try
	{
		blindprovision.launch()
	}
	catch e
	{
		e := "failed to launch blindprovision!"
		throw e
	}
}

blindprovisionlogin(blindprovision,botcredential)
{
	try
	{
		blindprovision.login(botcredential)
	}
	catch e
	{
		e := "failed to login blindprovision!"
		throw e
	}
}
blindprovisionInputForm(blindprovision,counter,snePagedetails,duedate,boid,bex,orderNumber,chronosInputdata,asocLookupdata)
{
	try
	{	
		blindprovisioninout := {}
		newpin := snePagedetails[counter]["primaryloopTreatIn"]
		bondpin := snePagedetails[counter]["bondedloopTreatIn"]
		bondedpin := StrSplit(bondpin,"/")
		pinblock :=  StrSplit(newpin,"/")
		StringLeft, ordertypecode, orderNumber, 1
		if (ordertypecode = "I")
		{
			ordertype := "Install"
		}
		else if (ordertypecode = "T")
		{
			ordertype := "Move-Cancel"
		}
		else if (ordertypecode = "C")
		{
			ordertype := "Upgrade"
		}		
		boid := boid
		ordernumber := orderNumber
		duedate := duedate
		mirrordW := chronosInputdata[counter]["mirorDW"]
		if (bondedpin ="")
		{	
			pin := pinblock[2]
		}
		else
		{
			pin := pinblock[2] . "/" . bondedpin[2]
		}
		iptv := ""
		addressid := snePagedetails[counter]["addressid"]
		if (addressid = "")
		{
			addressid := " "
		}
		bex := bex
		tn := chronosInputdata[counter]["telephone"]
		block := pinblock[1]
		facRemarksSe := snePagedetails[counter]["facilityRemarks"]
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
			Speed := strReplace(tempSpeed,"Temp Speed","")
			Speed := strReplace(tempSpeed,"ONLY QUALIFY UPTO","")
			Speed := strReplace(tempSpeed,"ONLY QUALIFIED UP TO","")
			Speed := strReplace(tempSpeed,"ONLY QUAL UPTO","")
			Speed := strReplace(tempSpeed,"ONLY QUAL UP TO","")
		}
		if (speed ="")
		{
			speed := asocLookupdata[counter]["speed"]
		}	
		nbntn := chronosInputdata[counter]["nbnTN"]
		asgnnote := chronosInputdata[counter]["mssComments"]
		if (instr(speed,"IPTV"))
		{
			iptv :="YES"
		}
		else
		{
			iptv := "NO"
		}	
		blindprovisioninout := {"boid":boid,"ordernumber":ordernumber,"duedate":duedate,"mirrordW":mirrordW,"pin":pin,"addressid":addressid,"bex":bex,"tn":tn,"block":block,"speed":speed,"nbntn":nbntn,"asgnnote":asgnnote,"ordertype":ordertype,"iptv":iptv}
		
		blindprovision.inputform(blindprovisioninout)	
	}
	catch e
	{
		e := "Failed to update the data in blind Provising tool!"
		throw e
	}	
}