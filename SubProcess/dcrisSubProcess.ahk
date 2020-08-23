dcrislaunch(dcris)
{
	try
	{	dcris.launch()
	}
		
	catch e
	{
		e := "system exception:Bot failed to launch dcris application!"
		
		
		throw e
	}
}	
dcrislogin(dcris,botcredential,exchangeSheetData)
{
	try
	{	
		dcris.login(botcredential,exchangeSheetData)
	}
	catch e
	{
		e := "system exception:Bot failed to login dcris appliction!"
		throw e
	}
}
dcrisPendingOcnotes(dcris,chronosInputdata,ocnotes,boid,bex,ordernumber,ocstatus)
{
	try
	{
		dcris.dcrisPendingOc(chronosInputdata,ocnotes,boid,bex,ordernumber,ocstatus)
	}
	catch e
	{
		e := "system exception:Bot Failed to update the data in dcris!"
		throw e
	}
}	
dcrisOrdspCommand(dcris,boid,bex,orderNumber)
{
	try
	{	
		dcris.ordspCommand(boid,bex,orderNumber)
		orderStatus := dcris.readStatus()
		if (orderStatus != "RDY-ASGN")
		{
			e := "system exception:Bot Failed to find Rdy-asgn status in dcris!"
			throw e
		}
		ctrlpageData := dcris.readCtrlPage()
		return ctrlpageData
	}
	catch e
	{
		throw e
	}
}	
dcrisplmodCommand(dcris,boid,bex,orderNumber)
{
	try
	{	
		dcris.plmodCommand(boid,bex,orderNumber)
	}
	catch e
	{
		e := "system exception:Bot Failed to move plmod status in dcris!"
		throw e
	}
}	
dcrisreadfacremarks(dcris)
{
	try
	{	
		seArray := []
		dcris.nextsegment()
		while True
		{
			segmentArray := {}
			facremarksArray := dcris.readfacremarks()
			facilityRemarks := facremarksArray[1]["facilityRemarks"]
			tele := facremarksArray[1]["tele"]
			asocdetails := dcris.sNePageDetails()
			asoc := asocdetails["asoc"]
			cbr := asocdetails["cbr1"]
			addressid :=asocdetails["addressid"]	
			winback := asocdetails["winback"]
			dcrisbill:= asocdetails["dcrisbill"]
			workunit := asocdetails["workunit"]
			lastpagemsg := dcris.lastpage()
			sleep 1000
			if (instr(lastpagemsg,"MORE S&E ITEMS FOR SAME TEL")) 
			{
				dcris.nextsegment()
			}
			if (instr(lastpagemsg,"LAST S&E PAGE, ENTER P FOR FIRST PAGE"))
			{
				dcris.nextsegment()
				lastpagemsg := dcris.lastpage()
				if (instr(lastpagemsg, "ALL SEGMENTS HAVE BEEN VIEWED"))
				{
					segmentarray := {"facilityRemarks":facilityRemarks,"asoc":asoc,"tele":tele,"cbr":cbr,"addressid":addressid,"winback":winback,"dcrisbill":dcrisbill,"workunit":workunit}
					seArray.push(segmentarray)
					break
				}
			}
			segmentarray := {"facilityRemarks":facilityRemarks,"asoc":asoc,"tele":tele,"cbr":cbr,"addressid":addressid,"winback":winback,"dcrisbill":dcrisbill,"workunit":workunit}
			seArray.push(segmentarray)
			if (instr(lastpagemsg, "ALL SEGMENTS HAVE BEEN VIEWED"))
			{
				break
			}
		}
		return seArray
	}
	catch e
	{
		e := "system exception:Bot Failed to read remarks in dcris!"
		throw e
	}
}		
dcrisPendingOc(dcris,ocPendingData,orderStatusforsoda,botcredential)
{
	try
	{
		dcris.PendingOcDcris(ocPendingData,orderStatusforsoda,botcredential)
	}
	catch e
	{
		e := "system exception:Bot Failed to move pending status in dcris!"
		throw e
	}
}
dcrisfinalbillpreb(dcris,orderStatusforsoda,workunit)
{
	try
	{
		dcris.finalbillpreb(orderStatusforsoda,workunit)
	}
	catch e
	{
		e := "system exception:Bot Failed to move billpreb status in dcris!"
		throw e
	}
}
dcrisfinaldispatch(dcris,orderStatusforsoda)
{
	try
	{
	    dcris.finaldispatch(orderStatusforsoda)
    }
	catch e
	{ 
		e := "system exception:Bot Failed to move dispatch status in dcris!"
		throw e
	}
}
	