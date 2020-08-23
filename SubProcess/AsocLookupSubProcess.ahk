launchAsoclookup(lookUptool)
{
	try
	{
		lookUptool.launch()
	}
	catch e
	{
		throw e
	}
}
lookUpMain(lookUptool,asocData)
{
	try
	{
		asocTable := lookUptool.lookUp(asocData)
		speedDetail := readLookUpdetails(asocTable)
	}
	catch e 
	{
		throw e
	}
	return speedDetail
}
readLookUpdetails(asocTable)
{
	newAsocs := StrSplit(asocTable,"`n")
	for new, lineItem in newAsocs
	{
		features := []
		features := StrSplit(lineItem,"`t")
		if (trim(features[3]) = "ADSL")
		{
			newSpeeddata := trim(features[5])
			if (newSpeeddata != "")
			{
				speedDetail := newSpeeddata
			}
			
			if(InStr(speedDetail,"RANGE")>0 or InStr(speedDetail,"M")>0 or InStr(speedDetail,"GB")>0 or InStr(speedDetail,"BEST EFFORT")>0)
			{
				if(InStr(speedDetail,"1 Gbps Range")>0)
				{
					speedDetail := "1 Gbps Range 800Mb-1000Mb"
				}
				else if (InStr(speedDetail,"500Mb Range")>0)
				{
					speedDetail := "500Mb Range 451Mb-799Mb"
				}
				else if (InStr(speedDetail,"400Mb Range")>0)
				{
					speedDetail := "400Mb Range 376Mb-450Mb"
				}
				else if (InStr(speedDetail,"300Mb Range")>0)
				{	
					speedDetail := "300Mb Range 251Mb-375Mb"
				}
				else if (InStr(speedDetail,"200Mb Range")>0)
				{
					speedDetail := "200Mb Range 126Mb-250Mb"
				}
				else if (InStr(speedDetail,"100Mb Range")>0)
				{
					speedDetail := "100Mb Range 73Mb-125Mb"
				}
				else if (InStr(speedDetail,"50Mb Range")>0)
				{	
					speedDetail := "50Mb Range 37Mb-72Mb"
				}
				else if (InStr(speedDetail,"25Mb Range")>0)
				{	
					speedDetail := "25Mb Range 25Mb-36Mb"
				}
				else if (InStr(speedDetail,"1.1MB")>0)
				{
					StringReplace, speedDetail, speedDetail, 1.1Mb, 1Mb
				}
				else if (InStr(speedDetail,"1.2Mb")>0)
				{
					StringReplace, speedDetail, speedDetail, 1.2Mb, 1Mb
				}
				else if (InStr(speedDetail,"2.1Mb")>0)
				{
					StringReplace, speedDetail, speedDetail, 2.1Mb, 2Mb
				}
				StringReplace, speedDetail, speedDetail, MB, Mb, All
				StringReplace, speedDetail, speedDetail, GB, Gb, All
				StringReplace, speedDetail, speedDetail, RANGE, Range, All
			}
		}
		else if (trim(features[2]) ="feature")
		{
			if ((trim(features[3]) != "ADSL") and (trim(features[3]) != "N/A"))
			{
				callingFeature := "present"
 			}
		}
	}
	MsgBox % speedDetail
	return, [speedDetail,callingFeature]
	
}


;~ asocDetails := {"asoc":["SELLP","SELLA","TXJUR","PIC","IPIC","CSGMT","EMADR","CBR1","TXTIN","KINV3","RVP2","ATAVP","NOVM","PROVR","KR100","KN22","AMOD2","PROFP","PRFCR","OMCID","SECU3","CRANK"]}



;~ launchAsoclookup(lookUptool)
;~ speed := lookUpMain(lookUptool,asocDetails)

;~ MsgBox % speed[1] . " " . speed[2]