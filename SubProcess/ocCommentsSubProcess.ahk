isPendingOc(ocDiscrepancy,table,counter)
{
	path := A_ScriptDir .  "\Config\FAS Pending OC.csv"
	pendingOc := table.ReadTable(path)
	ocScenario := StrSplit(ocDiscrepancy,"~")
	if object(ocScenario)
	{
		chronosOcInput := trim(ocScenario[1])
		ocvalue := ocScenario[2]
	}
	counterVariable := 2
	for each, details in pendingOc
	{
		tempValue := trim(pendingOc[counterVariable][2])
		if (chronosOcInput = tempValue) and (chronosOcInput != "")
		{
			MsgBox pending
			ocScenario := "pending"
			break
		}
		counterVariable++
	}
	return ocScenario
}
pendingOcLogic(ocDiscrepancy,table,counter)
{
	ocScenario := StrSplit(ocDiscrepancy,"~")
	if object(ocScenario)
	{
		chronosOcInput := trim(ocScenario[1])
		ocvalue := ocScenario[2]
	}
	
	ocOutput := {}
	path := A_ScriptDir .  "\Config\FAS Pending OC.csv"
	pendingOc := table.ReadTable(path)
	counterVariable := 2
	for each, details in pendingOc
	{
		tempValue := trim(pendingOc[counterVariable][2])
		if (chronosOcInput = tempValue)
		{
			discrepancy := pendingOc[counterVariable][1]
			comments := pendingOc[counterVariable][5]
			status := pendingOc[counterVariable][7]
			remarks := pendingOc[counterVariable][8]
			notifyReason := pendingOc[counterVariable][9]
			break
		}
		counterVariable++
	}
	
	if (discrepancy = "SD/BOID-BEX - [SD]")
	{
		comments := strReplace(comments,"[INPUT1]"," "boid)
		comments := strReplace(comments,"[INPUT2]"," "bex)
	}
	else if (ocvalue != "")
	{
		comments := strReplace(comments,"[INPUT]"," "ocvalue)
	}
	ocOutput := {"discrepancy":discrepancy,"comments":comments,"status":status,"remarks":remarks,"notifyReason":notifyReason}
	return ocOutput
}
completeOcLogic(ocDiscrepancy,table,requiredspeed,dueDate,orderNumber,len,Address,telephone,counter)
{
	ocOutput := {}
	path := A_ScriptDir .  "\Config\FAS complete OC.csv"
	fasOc := table.readTable(path)
	ocScenario := StrSplit(ocDiscrepancy,"~")
	if object(ocScenario)
	{
		chronosOcInput := trim(ocScenario[1])
		ocvalue := ocScenario[2]
		ocvalue1 := ocScenario[3]
	}
	counterVariable := 2
	loop % fasOc.maxindex() - 1
	{
		temp := trim(fasOc[counterVariable][2])
		if (chronosOcInput = temp)
		{
			discrepancy := fasoc[counterVariable][1]
			comments := fasoc[counterVariable][5]
			requiredInput := fasoc[counterVariable][6]
			break
		}
		counterVariable++
	}
	
	if (requiredInput = "speed")
	{
		comments := strreplace(comments,"(Enter speed)"," " requiredspeed)
	}
	else if (discrepancy = "SD/TELEPHONE NUMBER - [SD]")
	{
		comments := strreplace(comments,"(Enter number)"," " telephone)
	}
	
	
	else if (requiredInput= "Telephone #")
	{
		comments := strreplace(comments,"(Enter number)"," " telephone)
	}
	else if (requiredInput = "Due date")
	{
		comments := strreplace(comments,"(Enter due date)"," " dueDate)
	}
	else if (requiredInput = "Telephone # & Order details of active order")
	{
		comments := strreplace(comments,"(Enter number)"," " ocvalue)
		comments := strreplace(comments,"(Enter BOID/BEX/ORDER)"," " orderNumber)
	}
	else if (requiredInput = "Maintanance Telephone #")
	{
		comments := strreplace(comments,"(Enter Maintenance Line #)"," " ocvalue)
	}
	else if (requiredInput = "Old & New TN #")
	{
		comments := strreplace(comments,"(Enter original phone number) to (Enter new phone number)"," "telephone . " to " . ocvalue)
	}
	else if (requiredInput = "LEN")
	{
		comments := strreplace(comments,"(Enter new line equipment)"," " len)
	}
	else if (requiredInput = "Address")
	{
		comments := strreplace(comments,"(Enter Address)"," " Address)
	}
	ocOutput := {"comments":comments,"discrepancy":discrepancy,"ocvalue":ocvalue}
	return ocOutput
}