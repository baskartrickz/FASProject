#Include mainFasmasinc.ahk
credentials := new ahkcredentials
Environment := new ahkEvir_Variables
Queue := new WorkQueue_fun
mail := new smtpMailV1SysUtilObj

mailProcess(mail,mainOrderNumber,e,credentials,Environment)
{
	machineName := A_ComputerName . "-FAS"
	cso := credentials.Get(machineName)
	winEmailID := credentials.Get_Property(machineName,"winEmailID")
	winEmailPwd := credentials.Get_Property(machineName,"winEmailPwd")
	userMail := winEmailID
	mailPassword := winEmailPwd
	mailTo := Environment.Read_Envir_Variable("fas_Mail")
	mailSubject := "FAS Bot Exception"
	machine := A_ComputerName
	mailBody := "Hi Team,`n`n" . mainOrderNumber . " Order Number has been Moved to Exception.  `n`nMachine Name: " . machine . "`n`nException Detail: " . e . "`n`n`Thanks & Regards,`nBOT"
	
	mail.smtpMail(userMail,mailPassword,mailTo,"",mailSubject,mailBody,"")
}
getCredential(credentials)
{
	machineName := A_ComputerName . "-FAS"
	cso := credentials.Get(machineName)
	csoUserName :=  cso["Get"].Username
	csoPassword := cso["Get"].Password
	dcrisUserName := credentials.Get_Property(machineName,"dcrisUserName")
	dcrisPassword := credentials.Get_Property(machineName,"dcrisPassword")
	dbUserName := credentials.Get_Property(machineName,"dbUserName")
	dbPassword := credentials.Get_Property(machineName,"dbPassword")
	botcredential := {"csoId":csoUserName,"csoPassword":csoPassword,"dcrisUserName":dcrisUserName,"dcrisPassword":dcrisPassword,"dbUserName":dbUserName,"dbPassword":dbPassword}
	return botcredential
}
chronosGetOrder(sodaDb,botcredential)
{
	try
	{
		dbUserName := botcredential["dbUserName"]
		dbPassword := botcredential["dbPassword"]
		gId := botcredential["csoId"]
		sodaDetails := sodaDb.getOrderDetails(dbUserName,dbPassword,gId)
	}
	catch e
	{
		throw e
	}
	return sodaDetails
}
chronosUpdateOrder(sodaDb,botcredential,orderId,botNotes,fromStatus,toStatus)
{
	try
	{
		dbUserName := botcredential["dbUserName"]
		dbPassword := botcredential["dbPassword"]
		gId := botcredential["csoId"]
		sodaDb.updateOrderNotes(dbUserName,dbPassword,orderId,gid,botNotes,fromStatus,toStatus)
	}
	catch e
	{
		throw e
	}
}
chronosCompleteOrder(sodaDb,botcredential,orderId,toStatus)
{
	try
	{
		dbUserName := botcredential["dbUserName"]
		dbPassword := botcredential["dbPassword"]
		gId := botcredential["csoId"]
		orderStatus := toStatus
		sodaDb.completeOrder(dbUserName,dbPassword,orderStatus,orderId)
	}
	catch e
	{
		throw e
	}
}
chronosExceptionOrder(sodaDb,botcredential,orderId,toStatus)
{
	try
	{
		dbUserName := botcredential["dbUserName"]
		dbPassword := botcredential["dbPassword"]
		gId := botcredential["csoId"]
		sodaDb.exceptionOrder(dbUserName,dbPassword,toStatus,orderId)
	}
	catch e
	{
		throw e
	}
}

splitOrderDetails(jsonConverter,orderDetails)
{
	try
	{
		chronosInputdata := splitChronosData(jsonConverter,orderDetails)
	}
	catch e
	{
		throw e
	}
	return chronosInputdata
}
launchApplication(orderCorrection,dcris,racksheet,blindprovision,lookUptool)
{
	try
	{
		launchOrderCorrection(orderCorrection)
		launchAsoclookup(lookUptool)
		dcrislaunch(dcris)
		Racksheetlaunch(racksheet)
	}
	catch e
	{
		throw e
	}
}
loginApplications(orderCorrection,dcris,racksheet,blindprovision,botcredential,exchangeSheetData)
{
	try
	{
		loginorderCorrection(orderCorrection,botcredential)
		dcrislogin(dcris,botcredential,exchangeSheetData)
		Racksheetlogin(racksheet,botcredential)
	}
	catch e
	{
		throw e
	}
}
dcrisOrdspCommandmain(dcris,boidNum,bexNum,orderNum)
{
	try
	{
		WinActivate, A-D
		ctrlpageData := dcrisOrdspCommand(dcris,boidNum,bexNum,orderNum)
	}
	catch e
	{
		throw e
	}
	return ctrlpageData
}
dcrisplmodCommandmain(dcris,boidNum,bexNum,orderNum)
{
	try
	{
		WinActivate, A-D
		dcrisplmodCommand(dcris,boidNum,bexNum,orderNum)
	}
	catch e
	{
		throw e
	}
}
dcrisMainProcess(dcris)
{
	try
	{
		WinActivate, A-D
		seArray := dcrisreadfacremarks(dcris)
	}
	catch e
	{
		throw e
	}
	return seArray
}
dcrisdispatchmain(dcris,orderStatusforsoda)
{
	WinActivate, A-D
	dcrisfinaldispatch(dcris,orderStatusforsoda)
}
dcrisbillpreb(dcris,orderStatusforsoda,workunit)
{
	WinActivate, A-D
	dcrisfinalbillpreb(dcris,orderStatusforsoda,workunit)
}	
mirorLaunchLogin(miror,exchangeSheetData,botcredential)
{
	mirorlaunch(miror,exchangeSheetData)
	mirorlogin(miror,botcredential)
}
mirorwinclose(miror)
{
	mirorclose(miror)
}	
mirormainprocess(miror,tn,exchangeSheetData,botcredential,seArray)
{
	try
	{
		mirorFinalData := {}
		primarymirorrec := mirorprimaryrecord(miror,tn)
		primarymirorrecord := primarymirorrec[1]
		mirorrecord := primarymirorrec[2]
		if (mirorrecord = "bonded")
		{
			bondedmirorrecord := mirorbondrecord(miror,seArray)
		}
		mirorFinalData := {"primarymirorrecord":primarymirorrecord,"bondedmirorrecord":bondedmirorrecord}
	}
	catch e
	{
		throw e
	}
	return mirorFinalData
}
asocLookupmainProcess(lookUptool,asocDetails)
{
	try
	{
		WinActivate, ASOC Lookup Tool
		speed := lookUpMain(lookUptool,asocDetails)
	}
	catch e
	{
		throw e
	}
	return speed
}
Racksheetselectstatemain(racksheet,exchangeSheetData,mirorFinalData,chronosInputdata,orderInfo)
{
	try
	{
		WinActivate, Racksheet Database
		Racksheetselectstate(racksheet,exchangeSheetData,mirorFinalData,chronosInputdata,orderInfo)
	}
	catch e
	{
		throw e
	}
}
mirorOldRecord(chronosInputdata,miror)
{
	try
	{
		mirorOutrecord := []
		mirorOldRecord := []
		loop % chronosInputdata.maxindex()
		{
			mirorData := {}
			mirorOldRecord := chronosInputdata[A_Index]["mirorOldRecord"]
			mirorOldRecord := StrSplit(mirorOldRecord, "BONDED SERVICE INFORMATION")
			miroroldprimaryRecord := mirorOldRecord[1]
			miroroldBondedRecord := mirorOldRecord[2]
			if (mirorOldRecord[2] != "")
			{
				miroroldprimaryRecord := miror.NoteSegragation(mirorOldRecord[1])
				miroroldBondedRecord := miror.NoteSegragation(mirorOldRecord[2])
			}
			else
			{
				miroroldBondedRecord := ""
				miroroldprimaryRecord := miror.NoteSegragation(mirorOldRecord[1])
			}
			mirorData := {"miroroldprimaryRecord":miroroldprimaryRecord,"miroroldBondedRecord":miroroldBondedRecord}
			mirorOutrecord.push(mirorData)
		}
	}
	catch e
	{
		throw e
	}
	return mirorOutrecord
}
blindProvisionLaunchLogin(blindprovision,botcredential)
{
	try
	{
		WinActivate , CSMB Tools | Blind Provisioning Tracker Tool 
		blindprovisionlaunch(blindprovision)
		blindprovisionlogin(blindprovision,botcredential)
	}
	catch e
	{
		throw e
	}
}
		
blindprovisionInput(blindprovision,counter,snePagedetails,duedate,boid,bex,ordernumber,chronosInputdata,asocLookupdata)
{
	try
	{
		WinActivate , CSMB Tools | Blind Provisioning Tracker Tool 
		blindprovisionInputForm(blindprovision,counter,snePagedetails,duedate,boid,bex,orderNumber,chronosInputdata,asocLookupdata)
	}
	catch e
	{
		throw e
	}
}
exchangeDbMainProcess(assignment,botcredential,boid,bex)
{
	
	try
	{
		exchangeSheetData := exchangeSheet(assignment,botcredential,boid,bex)
		return exchangeSheetData
	}
	catch
	{
		throw e
	}
}
mssTicketMainProcess(mss,counter,chronosInputdata,duedate,m6BlindProv)
{
	try
	{
		winactivate, Add a MSS or DRS Issue
		mssTicketSubProcess(mss,counter,chronosInputdata,duedate,m6BlindProv)
	}
	catch e
	{
		throw e
	}
}
orderCorrectionMainProcess(orderCorrection,boid,bex,orderNumber,dueDate,workForce,area,counter,discrepancy,comments,telephoneNumberOc,remarks,status,notifyReason,tempIncrement)
{
	try
	{
		WinActivate, cct.windstream.com/cstar/oc/default2.asp
		ocNumber := orderCorrectionMain(orderCorrection,boid,bex,orderNumber,dueDate,workForce,area,counter,discrepancy,comments,telephoneNumberOc,remarks,status,notifyReason,tempIncrement)
	}
	catch
	{
		throw e
	}
	return ocNumber
}
dcrisPendingOcmain(dcris,ocPendingData,orderStatusforsoda,botcredential)
{
	try
	{
		WinActivate, A-D
		dcrisPendingOc(dcris,ocPendingData,orderStatusforsoda,botcredential)
	}
	catch e
	{
		throw e
	}
}
sneCollections(chronosInputdata,npa,mirorFinalData,seArray)
{
	snePagedetails := []
	counter := 1
	Loop % chronosInputdata.maxindex()
	{
		tempdata := {}
		humanTelephone := chronosInputdata[counter]["telephone"]
		incrementer := 1
		Loop % seArray.MaxIndex()
		{
			seTele := npa . seArray[incrementer]["tele"]
			if (humanTelephone = seTele)
			{
				facilityRemarks := seArray[incrementer]["facilityRemarks"]
				asoc := seArray[incrementer]["asoc"]
				cbr := seArray[incrementer]["cbr"]
				addressid := seArray[incrementer]["addressid"]
				winback := seArray[incrementer]["winback"]
			}
			incrementer++
		}
		increment := 1
		Loop % mirorFinalData.MaxIndex()
		{
			if (humanTelephone = mirorFinalData[increment]["primarymirorrecord"]["TelephoneIN"])
			{
				primarypicIpic := mirorFinalData[increment]["primarymirorrecord"]["PICIPIC"]
				primarytelePhoneIn := mirorFinalData[increment]["primarymirorrecord"]["TelephoneIN"]
				primarymirorGradeIn := mirorFinalData[increment]["primarymirorrecord"]["MirrorGradeIN"]
				primaryMirrorWcIn := mirorFinalData[increment]["primarymirorrecord"]["MirroWCIN"]
				primarycoeIn := mirorFinalData[increment]["primarymirorrecord"]["COEIN"]
				primarymdfPairIn := mirorFinalData[increment]["primarymirorrecord"]["MDFPairIN"]
				primaryframeTiePairIn := mirorFinalData[increment]["primarymirorrecord"]["FrameTiePair1IN"]
				primaryloopTreatIn := mirorFinalData[increment]["primarymirorrecord"]["LoopTreatment1BLKPININ"]
				primarylineEquipmentIn := mirorFinalData[increment]["primarymirorrecord"]["LineEquipmentIN"]
				bondedpicIpic := mirorFinalData[increment]["bondedmirorrecord"]["PICIPIC"]
				bondedtelePhoneIn := mirorFinalData[increment]["bondedmirorrecord"]["TelephoneIN"]
				bondedmirorGradeIn := mirorFinalData[increment]["bondedmirorrecord"]["MirrorGradeIN"]
				bondedMirrorWcIn := mirorFinalData[increment]["bondedmirorrecord"]["MirroWCIN"]
				bondedcoeIn := mirorFinalData[increment]["bondedmirorrecord"]["COEIN"]
				bondedmdfPairIn := mirorFinalData[increment]["bondedmirorrecord"]["MDFPairIN"]
				bondedframeTiePairIn := mirorFinalData[increment]["bondedmirorrecord"]["FrameTiePair1IN"]
				bondedloopTreatIn := mirorFinalData[increment]["bondedmirorrecord"]["LoopTreatment1BLKPININ"]
				bondedlineEquipmentIn := mirorFinalData[increment]["bondedmirorrecord"]["LineEquipmentIN"]
			}
			increment++
		}
		tempdata := {"facilityRemarks":facilityRemarks,"asoc":asoc,"cbr":cbr,"addressid":addressid,"winback":winback,"primarypicIpic":primarypicIpic,"primarytelePhoneIn":primarytelePhoneIn,"primarymirorGradeIn":primarymirorGradeIn,"primaryMirrorWcIn":primaryMirrorWcIn,"primarycoeIn":primarycoeIn,"primarymdfPairIn":primarymdfPairIn,"primaryframeTiePairIn":primaryframeTiePairIn,"primaryframeTiePairIn":primaryframeTiePairIn,"primaryloopTreatIn":primaryloopTreatIn,"primarylineEquipmentIn":primarylineEquipmentIn,"bondedpicIpic":bondedpicIpic,"bondedmirorGradeIn":bondedmirorGradeIn,"bondedtelePhoneIn":bondedtelePhoneIn,"bondedMirrorWcIn":bondedMirrorWcIn,"bondedcoeIn":bondedcoeIn,"bondedmdfPairIn":bondedmdfPairIn,"bondedframeTiePairIn":bondedframeTiePairIn,"bondedloopTreatIn":bondedloopTreatIn,"bondedlineEquipmentIn":bondedlineEquipmentIn,"tempSpeed":tempSpeed}
		snePagedetails.push(tempdata)
		counter++
	}
	return snePagedetails
}
asocLookupcollections(chronosInputdata,lookUptool,snePagedetails)
{
	counter := 1
	asocLookupdata :=[]
	Loop % chronosInputdata.MaxIndex()
	{
		asocDetails := ""
		tempasocdata := {}
		for, key, value in snePagedetails[counter]["asoc"]
		{
			asocDetails .= value . ","
		}

		speedDetails := asocLookupmainProcess(lookUptool,asocDetails)
		speed := speedDetails[1]
		callingFeature := speedDetails[2]
		tempasocdata := {"speed":speed,"callingFeature":callingFeature}
		asocLookupdata.push(tempasocdata)
		counter++
	}
	return asocLookupdata
}
orderCorrectionCommentsCollection(chronosInputdata,table,dueDate,orderNumber,len,Address,ocScenario,temporarySpeedArray)
{
	counter := 1
	ordercorrectionData := []
	if (ocScenario = "pending")
	{
		Loop % chronosInputdata.MaxIndex()
		{
			tempocData := {}
			ocData := {}
			ocDiscrepancy := []
			orderCorrectionScenario := trim(chronosInputdata[A_Index]["ocScenario"],",")
			orderCorrectionScenario := StrSplit(orderCorrectionScenario,",")
			Loop % orderCorrectionScenario.MaxIndex()
			{
				ocDiscrepancy := orderCorrectionScenario[A_Index]
				if (ocDiscrepancy != "")
				{
					ocData := pendingOcLogic(ocDiscrepancy,table,counter)
					octelephone := chronosInputdata[counter]["telephone"]
					discrepancy := ocData["discrepancy"]
					comments := ocData["comments"]
					status := ocData["status"]
					remarks := ocData["remarks"]
					notifyReason := ocData["notifyReason"]
					tempocData := {"discrepancy":discrepancy,"comments":comments,"status":status,"remarks":remarks,"notifyReason":notifyReason,"octelephone":octelephone,"area":area}
					ordercorrectionData.push(tempocData)
				}
	        }
			counter++
		}
	}
	else
	{
		loop % chronosInputdata.MaxIndex()
		{
			tempocData := {}
			ocData := {}
			ocDiscrepancy := []
			telephone := chronosInputdata[A_Index]["telephone"]
			orderCorrectionScenario := trim(chronosInputdata[A_Index]["ocScenario"],",")
			orderCorrectionScenario := StrSplit(orderCorrectionScenario,",")
			requiredspeed := temporarySpeedArray[A_index]
			Loop % orderCorrectionScenario.MaxIndex()
			{
				ocDiscrepancy := orderCorrectionScenario[A_Index]
				
				if (ocDiscrepancy != "")
				{
					
					if (instr(ocDiscrepancy,"Telephone Number-SSRV")) or (instr(ocDiscrepancy,"Telephone Number-SD"))
					{
						ocData := completeOcLogic(ocDiscrepancy,table,requiredspeed,dueDate,orderNumber,len,Address,telephone,counter)
						telephone := ocData["ocvalue"]
						if (telephone = "")
						{
							telephone := "9999999999"
						}
						discrepancy := ocData["discrepancy"]
						comments := ocData["comments"]
						tempocData := {"discrepancy":discrepancy,"comments":comments,"telephone":telephone}
						ordercorrectionData.push(tempocData)
					}
					else
					{
						ocData := completeOcLogic(ocDiscrepancy,table,requiredspeed,dueDate,orderNumber,len,Address,telephone,counter)
						discrepancy := ocData["discrepancy"]
						comments := ocData["comments"]
						tempocData := {"discrepancy":discrepancy,"comments":comments,"telephone":telephone}
						ordercorrectionData.push(tempocData)
					}
					
				}
			}
			counter++
		}
	}
	return ordercorrectionData
}
ocPendingverification(chronosInputdata,table)
{
	counter := 1
	loop % chronosInputdata.MaxIndex()
	{
		orderCorrectionScenario := trim(chronosInputdata[counter]["ocScenario"],",")
		orderCorrectionScenario := StrSplit(orderCorrectionScenario,",")
		Loop % orderCorrectionScenario.MaxIndex()
		{
			ocDiscrepancy := orderCorrectionScenario[A_Index]
			if (ocDiscrepancy != "")
			{
				ocScenario := isPendingOc(ocDiscrepancy,table,counter)
				if (ocScenario = "pending")
				{
					break
				}
			}
		}
		if (ocScenario = "pending")
		{
			break
		}
		counter++
	}
	return ocScenario
}
tempspeedfinder(chronosInputdata,seArray)
{
	temporarySpeedArray := []
	loop % chronosInputdata.maxindex()
	{
		telephoneofse := trim(chronosInputdata[A_index]["telephone"])
		telephoneofse := SubStr(telephoneofse,4)
		Loop % seArray.maxindex()
		{
			if (seArray[A_index]["tele"] = telephoneofse)
			{
				facRemarksSe := seArray[A_index]["facilityRemarks"]
				
				if ((instr(facRemarksSe, "TEMP SPEED")) or (instr(facRemarksSe, "ONLY QUALIFY UPTO")) or (instr(facRemarksSe, "ONLY QUALIFIED UP TO")) or (instr(facRemarksSe, "ONLY QUAL UPTO")) or (instr(facRemarksSe, "ONLY QUAL UP TO")))
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
			}
		}
		temporarySpeedArray.push(tempSpeed)
	}
	return temporarySpeedArray
}
statusoforder(seArray,ocPendingData)
{
	loop % seArray.maxindex()
	{
		facilityRemarks := seArray[A_Index]["facilityRemarks"]
		dcrisbill := seArray[A_Index]["dcrisbill"]
		if (instr(facilityRemarks,"BND")) or (instr(facilityRemarks,"BONDED"))
		{
			facremark := StrSplit(facilityRemarks,"BND")
			if strlen(facremark[2]) = 0
			{
				facremark := StrSplit(facilityRemarks,"BONDED")
			}		
			
			if ((instr(facremark[1], "NO PIN CHANGE")) or (instr(facremark[1], "FULL LICT"))) and ((instr(facremark[2], "NO PIN CHANGE")) or (instr(facremark[2], "FULL LICT")))
			{ 
				if (dcrisbill = "NO" )
				{
					if (instr(facilityRemarks,"M6 Ticket #"))
					{
						orderStatusforsoda := 60
					}
					else
					{
						orderStatusforsoda := 80
					}
				}
				else 
				{
					orderStatusforsoda := 60
				}
			}
			else
			{
				orderStatusforsoda := 60
			}	
		}					
		else
		{
			if ((instr(facilityRemarks, "NO PIN CHANGE")) or (instr(facilityRemarks, "FULL LICT")))
			{ 
				if (dcrisbill = "NO")
				{
					orderStatusforsoda := 80
				}
				else 
				{
					orderStatusforsoda := 60
				}
			}
			else
			{
				orderStatusforsoda := 60
			}
		}
	}
	Loop % ocPendingData.maxindex()
	{
		reason := ocPendingData[A_Index]["status"]
		if (reason = "Pending")
		{
			orderStatusforsoda := 20
		}
		else if(reason = "Notify")
		{
			orderStatusforsoda := 40
		}
	}
	return orderStatusforsoda
}
fasMainProcess(credentials,Queue,Environment,mail)
{
	try
	{
		Global orderCorrectionSent := ""
		sodaDb := new sodaDbV1BusObj
		jsonConverter := new JSON
		orderCorrection := new ocV1BusObj
		dcris := new dcrisV1BusObj
		racksheet := new racksheetV1BusObj
		blindprovision := new BlindProvisioningV1BusObj
		miror := new mirorV1BusObj
		assignment := new exchangeDbV1BusObj
		table := new tableV1BusObj
		mss  := new mssTicketV1BusObj
		lookUptool := new asoclookUptoolV1BusObj
		
		inputOrder := {}
		;~ orderInfo := "human"
		;~ boid := "139"
		;~ bex := "1894"
		;~ orderNumber :="I57099"
		;~ area := "Residential"
		botcredential := getCredential(credentials)

		sodaDetails := chronosGetOrder(sodaDb,botcredential)
		orderInfo := sodaDetails["orderInfo"]
		boid := trim(sodaDetails["boid"])
		bex:= trim(sodaDetails["bex"])
		orderNumber := trim(sodaDetails["orderNumber"])
		area := trim(sodaDetails["busRes"])
		orderId := trim(sodaDetails["orderId"])
		
		mainOrderNumber := boid . bex . orderNumber
		
		MsgBox % mainOrderNumber
		;~ fromStatus := 20
		;~ toStatus := 60
		;~ botNotes := "order has been successfully completed"
		
		;~ chronosUpdateOrder(sodaDb,botcredential,orderId,botNotes,fromStatus,toStatus)
		;~ chronosCompleteOrder(sodaDb,botcredential,orderId,toStatus)
		;Add to queue
		inputOrder.push({"orderNumber":mainOrderNumber})
		Queue.Add_To_Queue("Facility Assignment Services",inputOrder,"","","")
		
		data := Queue.Get_Next_Item("Facility Assignment Services","","")
		Item_ID := data["Queue"].Item_ID    ; Item_ID
		Collection := data["Queue"].Collection    ; User Data
		loop % Collection.MaxIndex()
		{
			dcrisOrderNumber := Collection[A_Index]["orderNumber"]
		}
		
		if (area= "R")
		{
			area := "Residential"
		}
		else if (area = "B")
		{
			area := "Business"
		}
		orderDetails := sodaDetails["userInput"]
		Clipboard := orderDetails
		;~ FileRead, orderDetails , C:\Users\n9988154\Desktop\FASPhase2\fasinputdata.txt
		chronosInputdata := splitOrderDetails(jsonConverter,orderDetails)
		exchangeSheetData := exchangeDbMainProcess(assignment,botcredential,boid,bex)
		npa := exchangeSheetData["npa"]
		msgbox % chronosInputdata[1]["telephone"]
		npa := SubStr(chronosInputdata[1]["telephone"],1,3)
		ocScenario := ocPendingverification(chronosInputdata,table)
		counter := 	1

		launchApplication(orderCorrection,dcris,racksheet,blindprovision,lookUptool)
		loginApplications(orderCorrection,dcris,racksheet,blindprovision,botcredential,exchangeSheetData)
		ctrlpageData := dcrisOrdspCommandmain(dcris,boid,bex,orderNumber)
		workForce := trim(ctrlpageData["workForce"])
		duedate := strreplace(ctrlpageData["dueDate"],"-","/")

		dcrisplmodCommandmain(dcris,boid,bex,orderNumber)

		seArray := dcrisMainProcess(dcris)
		MsgBox % seArray.maxindex()
		tele := seArray[1]["tele"]
		customerName := ctrlpageData["customerName"]
		svcorderinfo := bex . " " . orderNumber . " " . "RDY-ASGN" . " " . tele . " " . customerName . "`n"

		if (chronosInputData[1]["wwOrderNumber"] != "")
		{
			wwCtrlpageData := []
			wwBoid := chronosInputData[1]["wwBoid"]
			wwBex := chronosInputData[1]["wwBex"]
			wwOrderNumber := chronosInputData[1]["wwOrderNumber"]
			wwCtrlpageData := dcrisOrdspCommandmain(dcris,boid,bex,orderNumber)
			svcorderinfo := svcorderinfo . wwBex . " " . wwOrderNumber . " " . "RDY-ASGN" . " " . tele . " " . wwctrlpageData["customerName"]
		}

		counter := 1
		if (orderInfo = "human")
		{
			loop % seArray.maxindex()
			{
				if (instr(seArray[counter]["facilityRemarks"], "RAC TO CO")) or (instr(seArray[counter]["facilityRemarks"],"M6 BLIND PROV")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO SAG")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO COMPLEX")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO CO&SAG")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO CO&COMPLEX"))
				{
					mirorLaunchLogin(miror,exchangeSheetData,botcredential)
					break
				}
				counter++
			}

			counter := 1
			mirorFinalData := []
			loop % seArray.maxindex()
			{
				mirorRecord := {}
				
				if (instr(seArray[counter]["facilityRemarks"], "RAC TO CO")) or (instr(seArray[counter]["facilityRemarks"],"M6 BLIND PROV")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO SAG")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO COMPLEX")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO CO&SAG")) or (instr(seArray[counter]["facilityRemarks"],"RAC TO CO&COMPLEX"))
				{
					tn := npa . seArray[counter]["tele"]
					mirorRecord := mirormainprocess(miror,tn,exchangeSheetData,botcredential,seArray)
				}
				mirorFinalData.push(mirorRecord)
				counter++
			}	

			if winexist("(A) TELNET")
			{
				mirorwinclose(miror)
			}
		}
		
		
		mirorOutrecord := mirorOldRecord(chronosInputdata,miror)
		snePagedetails := sneCollections(chronosInputdata,npa,mirorFinalData,seArray)
		asocLookupdata := asocLookupcollections(chronosInputdata,lookUptool,snePagedetails)
		Racksheetselectstatemain(racksheet,exchangeSheetData,mirorFinalData,chronosInputdata,orderInfo)
		racsheetSegmentCount := 0
		Loop % snePagedetails.MaxIndex()
		{
			facilityRemarks := snePagedetails[A_Index]["facilityRemarks"]
			if (InStr(facilityRemarks,"Rac to co") or instr(facilityRemarks,"RAC TO CO&SAG") or instr(facilityRemarks,"RAC TO COMPLEX") or instr(facilityRemarks,"RAC TO CO&COMPLEX") or instr(facilityRemarks,"RAC TO SAG"))
			{
				racsheetSegmentCount++
			}
		}
		
		counter := 1
		Loop % snePagedetails.MaxIndex()
		{
			MsgBox % snePagedetails.MaxIndex()
			facilityRemarks := snePagedetails[counter]["facilityRemarks"]
			if (InStr(facilityRemarks,"Rac to co") or instr(facilityRemarks,"RAC TO CO&SAG") or instr(facilityRemarks,"RAC TO COMPLEX") or instr(facilityRemarks,"RAC TO CO&COMPLEX") or instr(facilityRemarks,"RAC TO SAG"))
			{		
				WinActivate, Racksheet Database
				Racksheetinputform(racksheet,counter,snePagedetails,mirorOutrecord,svcorderinfo,duedate,boid,chronosInputdata,asocLookupdata,orderInfo,ctrlpageData,racsheetSegmentCount)
				racksheetSent := "yes"
			}
			counter++
		}

		counter := 1
		loop % seArray.maxindex()
		{
			if (instr(seArray[counter]["facilityRemarks"],"M6 BLIND PROV") or instr(seArray[counter]["facilityRemarks"], "M6 TICKET #"))
			{
				blindProvisionLaunchLogin(blindprovision,botcredential)
				mssLaunch(mss)
				break
			}
			counter++
		}

		counter := 1
		Loop % snePagedetails.MaxIndex()
		{
			FacRemarks := snePagedetails[counter]["facilityRemarks"]
			if (instr(FacRemarks, "M6 BLIND PROV"))
			{
				m6BlindProv := "Yes"
				blindprovisionInput(blindprovision,counter,snePagedetails,duedate,boid,bex,ordernumber,chronosInputdata,asocLookupdata)
				mssTicketMainProcess(mss,counter,chronosInputdata,duedate,m6BlindProv)
				blindProvSent := "Yes"
			}
			else if (instr(FacRemarks, "M6 TICKET #"))
			{
				m6BlindProv := "No"
				mssTicketMainProcess(mss,counter,chronosInputdata,duedate,m6BlindProv)
				mssTicketSent := "Yes"
			}
			counter++
		}
		temporarySpeedArray := tempspeedfinder(chronosInputdata,seArray)
		
		ordercorrectionData := orderCorrectionCommentsCollection(chronosInputdata,table,dueDate,orderNumber,len,Address,ocScenario,temporarySpeedArray)
		counter := 1
		tempCounter := 1
		tempIncrement := 0
		ocPendingData := []
		Loop % chronosInputdata.MaxIndex()
		{
			telephoneNumberOc := chronosInputdata[counter]["telephone"]
			ocScenarioMulti := trim(chronosInputdata[counter]["ocScenario"],",")
			ocScenarioMulti := StrSplit(ocScenarioMulti,",")
			
			Loop % ocScenarioMulti.MaxIndex()
			{
				if (ocScenarioMulti.Maxindex() <= 1)
				{
					
					discrepancy := ordercorrectionData[tempCounter]["discrepancy"]
					if ((discrepancy = "TELEPHONE NUMBER - [SSRV]") or (discrepancy = "SD/TELEPHONE NUMBER - [SD]"))
					{
						telephoneNumberOc := ordercorrectionData[tempCounter]["telephone"]
					}
					comments := ordercorrectionData[tempCounter]["comments"]
					remarks := ordercorrectionData[tempCounter]["remarks"]
					status := ordercorrectionData[tempCounter]["status"]
					notifyReason := ordercorrectionData[tempCounter]["notifyReason"]
				}
				else
				{
					discrepancy := ordercorrectionData[tempCounter]["discrepancy"]
					if ((discrepancy = "TELEPHONE NUMBER - [SSRV]") or (discrepancy = "SD/TELEPHONE NUMBER - [SD]"))
					{
						telephoneNumberOc := ordercorrectionData[tempCounter]["telephone"]
					}
					comments := ordercorrectionData[tempCounter]["comments"]
					remarks := ordercorrectionData[tempCounter]["remarks"]
					status := ordercorrectionData[tempCounter]["status"]
					notifyReason := ordercorrectionData[tempCounter]["notifyReason"]
				}
				tempCounter++
				
				
				
				loop % ocScenarioMulti.maxindex()
				{
					discrepancy := ordercorrectionData[tempCounter]["discrepancy"]
					if (instr(discrepancy, "ssrv"))
					{
						tempIncrement++
					}
				}
				
				ocNumber := orderCorrectionMainProcess(orderCorrection,boid,bex,orderNumber,dueDate,workForce,area,counter,discrepancy,comments,telephoneNumberOc,remarks,status,notifyReason,tempIncrement)
				ocPendingData.push(ocNumber)
			}
			counter++
		}
		
		orderStatusforsoda := statusoforder(seArray,ocPendingData)
		;~ MsgBox % orderCorrectionSent
		MsgBox  % orderStatusforsoda
		;~ MsgBox % racksheetSent
		;~ if ((mssTicketSent != "Yes") or (racksheetSent != "Yes") or (blindProvSent != "Yes") or (orderCorrectionSent != "Yes"))
		;~ {
			;~ e := "Business Exception:No scenarios found to work"
			;~ throw e
		;~ }
		
		if (ocScenario = "pending")
		{
			dcrisplmodCommandmain(dcris,boid,bex,orderNumber)
			
			dcrisPendingOc(dcris,ocPendingData,orderStatusforsoda,botcredential)
			
			botNotes := "Pending oc"
		}

		if (orderStatusforsoda = 80)
		{   
			workunit := seArray[1]["workunit"]
			dcrisbillpreb(dcris,orderStatusforsoda,workunit)
			botNotes := "order has been successfully completed"
		}
		else if(orderStatusforsoda = 60)
		{
			dcrisplmodCommandmain(dcris,boid,bex,orderNumber)
			dcrisdispatchmain(dcris,orderStatusforsoda)
			botNotes := "order has been successfully completed"
		}
		fromStatus := 20
		toStatus := orderStatusforsoda
		chronosUpdateOrder(sodaDb,botcredential,orderId,botNotes,fromStatus,toStatus)
		chronosCompleteOrder(sodaDb,botcredential,orderId,toStatus)
		Queue.Update_Status(Item_ID,"Completed")
		Queue.Mark_Completed(Item_ID)
	}
	catch e
	{
		MsgBox % e
		MsgBox done
		toStatus := 20
		Queue.Update_Status(Item_ID,e)
		queue.Mark_Exception(Item_ID,e)
		chronosExceptionOrder(sodaDb,botcredential,orderId,toStatus)
		mailProcess(mail,mainOrderNumber,e,credentials,Environment)
	}
}

fasMainProcess(credentials,queue,Environment,mail)
msgbox completed