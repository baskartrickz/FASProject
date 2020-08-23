class dcrisV1BusObj
{
	fas := new chromeV1SysUtilObj
	dcrisAppMod := new dcrisV1AppMod
	
	launch()
	{
		try
		{
			this.fas.launch(this.dcrisAppMod.url, "--start-maximized")
			Sleep, 3000
			this.fas.click(this.dcrisAppMod.opendcris)
			this.fas.navWindow()
			Sleep, 2000
		}
		catch e
		{
			e := "system exception:Bot failed to launch dcris!"
			throw e
		}
	}
	login(botcredential,exchangeSheetData)
	{
		try
		{
			this.fas.write(this.dcrisAppMod.username,botcredential["dcrisuserName"])
			this.fas.write(this.dcrisAppMod.pword,botcredential["dcrisPassword"])
			aldregion := exchangeSheetData["mirrorPackage"]
			if (aldregion = "30")
			{
				this.fas.listDropDown(this.dcrisAppMod.ddlRegion,"ALD - DCRIS")
				this.fas.listDropDown(this.dcrisAppMod.ddlsession,"User A")
				this.fas.click(this.dcrisAppMod.submitButton)
				this.fas.navWindow()
				this.fas.write(this.dcrisAppMod.busoffice,"142")
			}
			else
			{
			this.fas.listDropDown(this.dcrisAppMod.ddlRegion,"Georgia - DCRIS")
			this.fas.listDropDown(this.dcrisAppMod.ddlsession,"User A")
			this.fas.click(this.dcrisAppMod.submitButton)
			this.fas.navWindow()
			this.fas.write(this.dcrisAppMod.busoffice,"665")
			}
			this.fas.KeyStroke(this.dcrisAppMod.busoffice)
			sleep 2000			
		}
		catch e
		{
			e := "system exception:Bot failed to login Dcris application"
			throw e
		}
	}
	ordspCommand(boid,bex,orderNumber)
	{
		try
		{
			this.fas.write(this.dcrisAppMod.cmdinputbox,"ORDSP")
			this.fas.write(this.dcrisAppMod.bex,bex)
			this.fas.write(this.dcrisAppMod.ordernum,orderNumber)
			this.fas.write(this.dcrisAppMod.boid,boid)
			this.fas.KeyStroke(this.dcrisAppMod.boid)
		}
		catch e
		{
			e := "system exception: Bot failed to update ordspcommand"
			throw e
		}
	}
	readStatus()
	{
		try
		{
			orderStatus := this.fas.read(this.dcrisAppMod.orderStatus,"text")
		}
		catch e
		{
			e := "system exception: Bot failed to read dcris status"
			throw e
		}
		return orderStatus
	}
	readCtrlPage()
	{
		try
		{
			ctrlpageData := {}
			customerName := this.fas.read(this.dcrisAppMod.customerName,"text")
			dueDate := this.fas.read(this.dcrisAppMod.dueDate,"text")
			workForce := this.fas.read(this.dcrisAppMod.workForce,"text")
			cbr := this.fas.read(this.dcrisAppMod.cbr,"text")
			ctrlpageData := {"customerName":customerName,"dueDate":dueDate,"workForce":workForce,"cbr":cbr}
			return ctrlpageData
		}
		catch e
		{
			e := "system exception:Bot failed to read ctrlpage details"
			throw e
		}
	}

	plmodCommand(boid,bex,orderNumber)	    
	{
		try
		{
			this.fas.write(this.dcrisAppMod.cmdplmodbox,"PLMOD")
			this.fas.write(this.dcrisAppMod.bex,bex)
			this.fas.write(this.dcrisAppMod.ordernum,orderNumber)
			this.fas.write(this.dcrisAppMod.boid,boid)
			this.fas.KeyStroke(this.dcrisAppMod.boid)
		}
		catch e
		{
			e := "system exception:Bot failed to update plmodcommand"
			throw e
		}
	}
	readfacremarks()
	{
		try
		{
			facremarksArray :=[]
			facremarks := {}
			try
			{
				Sleep 2000
				this.fas.executescript(this.dcrisAppMod.closeAlert)
			}
			
			try
			{
				tele := this.fas.read(this.dcrisAppMod.TelIorder,"value")
			}
			if (tele = "")
			{
				try
				{
					tele := this.fas.read(this.dcrisAppMod.TelCorder,"text")
				}
			}
			fac1 := this.fas.read(this.dcrisAppMod.facRemarks1,"value")
			fac2 := this.fas.read(this.dcrisAppMod.facRemarks2,"value")
			facilityRemarks := fac1 . " " . fac2
			StringMid, NID, % facilityRemarks, 13, 8
			;~ MsgBox % facilityRemarks
			sleep, 2000
			if(instr(facilityRemarks,"SEE DCRIS NOTES"))
			{
				
				this.fas.click(this.dcrisAppmod.dcrisnotes)
				this.fas.navWindow()
				Sleep, 5000
				dcrisnotesraw := this.fas.read(this.dcrisAppMod.txtNote,"Value")
				dcrisnotes := dcrisnotesraw
				
				
				if ((instr(dcrisnotes ,"Corrected Notes")) and (instr(dcrisnotes,tele)))
				{
					splitnotes := strsplit(dcrisnotes, "============================================")
					count := splitnotes.maxindex()
					counter := count
					loop % splitnotes.maxindex()
					{
											
						if (instr(splitnotes[counter],NID) and instr(splitnotes[counter],"corrected notes") and instr(splitnotes[counter],tele))
						{				
							newNotes := StrSplit(splitnotes[counter], "`n")
							Loop % newNotes.maxindex()
							{
								if (instr(newNotes[A_Index],NID))
								{
									addnotes := newNotes[A_Index+1] . newNotes[A_Index+2]
									StringReplace,final,addnotes,corrected notes,,all
									StringReplace,finaladdnotes,final,% TN,,all
									facilityRemarks := facilityRemarks . " " . finaladdnotes
								}	
							}	
						}
						counter--
					}	
				}	
				else if (instr(dcrisnotes ,"Corrected Notes"))
				{
					splitnotes := strsplit(dcrisnotes, "============================================")
					count := splitnotes.maxindex()
					counter := count
					loop % splitnotes.maxindex()
					{
						if (instr(splitnotes[counter],NID) and instr(splitnotes[counter],"corrected notes"))
						{				
							newNotes := StrSplit(splitnotes[counter], "`n")
							Loop % newNotes.maxindex()
							{
								if (instr(newNotes[A_Index],NID))
								{
									addnotes := newNotes[A_Index+1] . newNotes[A_Index+2]
									StringReplace,finaladdnotes,addnotes,corrected notes,,all
									facilityRemarks := facilityRemarks . " " . finaladdnotes
								}	
							}	
						}
						counter--
					}	
				}
				else if (instr(dcrisnotes ,tele))
				{
					splitnotes := strsplit(dcrisnotes, "============================================")
					count := splitnotes.maxindex()
					counter := count
					loop % splitnotes.maxindex()
					{
						if (instr(splitnotes[counter],NID) and instr(splitnotes[counter],tele))
						{				
							newNotes := StrSplit(splitnotes[counter], "`n")
							Loop % newNotes.maxindex()
							{
								if (instr(newNotes[A_Index],NID))
								{
									addnotes := newNotes[A_Index+1]
									StringReplace,finaladdnotes,addnotes,% tele,,all
									facilityRemarks := facilityRemarks . " " . finaladdnotes
									length := strlen(addnotes)
									if length > 190
									{
										newNotes := StrSplit(splitnotes[counter - 1], "`n")
										Loop % newNotes.maxindex()
										{
											if (instr(newNotes[A_Index],NID))
											{
												addnotes := newNotes[A_Index+1]
												facilityRemarks := facilityRemarks . " " . addnotes
											}
										}
									}	
								}	
							}	
						}
						counter--
					}	
				}
				else
				{
					splitnotes := strsplit(dcrisnotes, "============================================")
					count := splitnotes.maxindex()
					counter := count
					loop % splitnotes.maxindex()
					{
					
						if (instr(splitnotes[counter],NID))
						{	
							newNotes := StrSplit(splitnotes[counter], "`n")
							Loop % newNotes.maxindex()
							{
								if (instr(newNotes[A_Index],NID))
								{
									addnotes := newNotes[A_Index+1]
									facilityRemarks := facilityRemarks . " " . addnotes
								}	
							}	
						}
						counter--
					}	
				}
				
				this.fas.click(this.dcrisAppmod.closebutton)
				this.fas.previousWindow()
			}
			facremarks := {"facilityRemarks":facilityRemarks,"tele":tele}
			facremarksArray.push(facremarks)
			return facremarksArray
		}
		catch e
		{
			e := "system exception:Bot failed to read facilityRemarks details"	
			throw e
		}
	}
	seeNextseg(facilityRemarks)
	{
		try
		{
			if(instr(facilityRemarks, "SEE NEXT SEGMENT"))
			{
				this.fas.clear(this.dcrisAppMod.nextpage)
				this.fas.KeyStroke(this.dcrisAppMod.nextpage)	
			}
		}
		catch e
		{
			e := "system exception:Bot failed to see next segment"
			throw e
		}
	}
	sNePageDetails()
	{
		try
		{
			asocDetails := {}
			asoc :=[]
			counter := 1
			workunit := this.fas.read(this.dcrisAppmod.workunit,"text")
			while true
			{
				try
				{
					tempElement := this.dcrisAppMod.seAsoc[3] . counter
					asocData := this.fas.read(["fe","id",tempElement] ,"text")
					temp := trim(RegExReplace(asocData, "S) +", A_Space))
					temp := StrSplit(temp," ")
					asocdetail := temp[1]
					asoc.push(asocdetail)
					
					if (asocdetail = "CBR1")
					{
						cbr1 := temp[6]
					}
					if (asocdetail = "UQUAL")
					{   
						addressid := temp[6]						
					}		
					if (asocdetail = "PROFP")
					{   
						profp := "YES"
					}	
					if (asocdetail = "INWK")
					{   
						inwk := "YES"
					}	
					if (profp = "YES") or (inwk = "YES")
					{
						dcrisbill := "YES"
					}
					else
					{
						dcrisbill := "NO"
					}
					if (asocdetail = "SPLNP")
					{   
						winback := "YES"
					}
					else
					{
						winback := "NO"
					}

				}
				catch e
				{
					sleep 2000
					Snemsg := this.fas.read(this.dcrisAppmod.seMsg,"text")
			
					sleep 1000
					if (instr(sNeMsg,"LAST S&E PAGE"))
					{
						this.fas.clear(this.dcrisAppMod.nextpage)
						send {Enter}
						break
					}
					send {Enter}
					counter := 0
				}
				counter++
			}
			asocDetails := {"asoc":asoc,"cbr1":cbr1,"addressid":addressid,"winback":winback,"dcrisbill":dcrisbill,"workunit":workunit}
			return asocDetails
		}
		catch e
		{
			e := "system exception:Bot failed to read  next page details"
			throw e
		}
	}
	nextsegment()
	{
		try
		{
			try
			{
				Sleep 2000
				this.fas.executescript(this.dcrisAppMod.closeAlert)
			}
			this.fas.clear(this.dcrisAppMod.stuStatus)
			this.fas.clear(this.dcrisAppMod.loc)
			this.fas.clear(this.dcrisAppMod.nextpage)
			this.fas.write(this.dcrisAppMod.stuStatus,"20")
			this.fas.write(this.dcrisAppMod.loc,"x")
			this.fas.write(this.dcrisAppMod.nextpage,"P")
		}
		catch e
		{
			e := "system exception:Bot failed to move next segment"
			throw e
		}
	}
	lastpage()
	{
		try
		{
			try
			{
				Sleep 2000
				this.fas.executescript(this.dcrisAppMod.closeAlert)
			}
			endOfsession := this.fas.read(this.dcrisAppmod.seMsg,"text")
			return endOfsession
		}
		catch e
		{
			e := "system exception:Bot failed to check the last page data"
			throw e
		}
	}
	dcrisdispatch()
	{
		try
		{
			this.fas.clear(this.dcrisAppMod.stuStatus)
			this.fas.clear(this.dcrisAppMod.loc)
			this.fas.clear(this.dcrisAppMod.nextpage)
			this.fas.write(this.dcrisAppMod.loc,"x")
			this.fas.KeyStroke(this.dcrisAppMod.loc)
		}
		catch e
		{
			e := "system exception:Bot failed to move dispatch status"
			throw e
		}
	}
	dcrisdispatchmsg()
	{
		try
		{
		this.fas.read(this.dcrisAppmod.dispatchmsg,"text")
		}
		catch e
		{
			e := "system exception:Bot failed to read dispatch message"
			throw e
		}
	}
	dcrispending()
	{
		try
		{
			this.fas.clear(this.dcrisAppMod.stuStatus)
			this.fas.clear(this.dcrisAppMod.loc)
			this.fas.clear(this.dcrisAppMod.nextpage)
			this.fas.write(this.dcrisAppMod.stuStatus,"20")
			this.fas.write(this.dcrisAppMod.loc,"x")
			this.fas.KeyStroke(this.dcrisAppMod.loc)
		}
		catch e
		{
			e := "system exception:Bot failed to move pending status"
			throw e
		}
	}
	dcrisnotify(notifyReason)
	{
		try
		{
			this.fas.clear(this.dcrisAppMod.stuStatus)
			this.fas.clear(this.dcrisAppMod.loc)
			this.fas.clear(this.dcrisAppMod.nextpage)
			this.fas.write(this.dcrisAppMod.loc,"x")
			this.fas.write(this.dcrisAppMod.stuStatus,"40")
			sleep, 2000
			this.fas.navWindow()
			this.fas.Write(this.dcrisAppMod.notifyReason,notifyReason)
			
			this.fas.click(this.dcrisAppMod.btnSaveNClose)
			sleep, 1000
			this.fas.previousWindow()
			this.fas.KeyStroke(this.dcrisAppMod.loc)
			
		}
		catch e
		{
			e := "system exception:Bot failed to move notify status"
			throw e
		}
	}
	dcrisbillpreb()
	{
		try
		{
			this.fas.clear(this.dcrisAppMod.stuStatus)
			this.fas.clear(this.dcrisAppMod.loc)
			this.fas.clear(this.dcrisAppMod.nextpage)
			this.fas.write(this.dcrisAppMod.stuStatus,"80")
			this.fas.write(this.dcrisAppMod.loc,"x")
			this.fas.KeyStroke(this.dcrisAppMod.loc)
		}
		catch e
		{
			e := "system exception:Bot failed to move billpred status"
			throw e
		}
	}
	dcrisormod()
	{
		try
		{
			this.fas.write(this.dcrisAppMod.cmdplmodbox,"ORMOD")
			this.fas.write(this.dcrisAppMod.bex,bex)
			this.fas.write(this.dcrisAppMod.ordernum,orderNumber)
			this.fas.write(this.dcrisAppMod.boid,boid)
			this.fas.KeyStroke(this.dcrisAppMod.boid)
			this.fas.clear(this.dcrisAppMod.ormodwunit)
			this.fas.clear(this.dcrisAppMod.ormodstatus)
			this.fas.write(this.dcrisAppMod.ormodwunit,"000")
			this.fas.write(this.dcrisAppMod.ormodstatus,"20")
			this.fas.KeyStroke(this.dcrisAppMod.ormodstatus)
		}
		catch e
		{
			e := "system exception:Bot failed to update ormod command"
			throw e
		}
	}
	PendingOcDcris(ocPendingData,orderStatusforsoda,botcredential)
	{   
		try
		{
			while True
			{
				try
				{
					dcrisTele := this.fas.read(this.dcrisAppMod.TelIorder,"value")
				}
				if (dcrisTele = "")
				{
					try
					{
						dcrisTele := this.fas.read(this.dcrisAppMod.TelCorder,"text")
					}
				}
				loop % ocPendingData.maxindex()
				{
					ocTele := substr(ocPendingData[A_Index]["telephoneNumber"],4)
					if (dcrisTele = ocTele) or (dcrisTele = "")
					{
						remarks := ocPendingData[A_Index]["remarks"]
						result:= ocPendingData[A_Index]["result"]
						notifyReason := ocPendingData[A_Index]["notifyReason"]
						csoId := botcredential["csoId"]
						currentdate := A_mm . A_DD . A_Year
						ocFacilityRemarks := "ASGN" . "=" . currentdate . "/" . csoId . "/" . remarks . "/" . "OC " . result
						result := ocPendingData[A_Index]["result"]
						fac1 := this.fas.clear(this.dcrisAppMod.facRemarks1)
						fac2 := this.fas.clear(this.dcrisAppMod.facRemarks2)
						fac1 := this.fas.write(this.dcrisAppMod.facRemarks1,ocFacilityRemarks)
					}
				}
				if (orderStatusforsoda = "20")
				{
					this.dcrispending()
				}
				else if (orderStatusforsoda = "40")
				{
					this.dcrisnotify(notifyReason)
				}
				lastPagemsg := this.lastpage()
				
				if (instr(lastPagemsg, "ALL SEGMENTS HAVE BEEN VIEWED"))
				{
					break
				}
				
			}
		}
		catch e
		{
			e := "system exception:Bot failed to move pendingOC in dcris"
			throw e
		}
	}
	finaldispatch(orderStatusforsoda)
	{
		try
		{
			while true
			{
				this.dcrisdispatch()
				lastPagemsg := this.lastpage()
				if (instr(lastPagemsg, "ALL SEGMENTS HAVE BEEN VIEWED"))
				{
					break
				}
			}
		}
		catch e
		{
			e := "system exception:Bot failed to move finaldispatch"
			throw e
		}
	}
	finalbillpreb(orderStatusforsoda,workunit)
	{
		try
		{
			if (workunit != "000" )
			{
				this.dcrisormod()
			}
			while true
			{
				this.dcrisdispatch()
			
				lastPagemsg := this.lastpage()
				if (instr(lastPagemsg, "ALL SEGMENTS HAVE BEEN VIEWED"))
				{
					break
				}
			}
		}
		catch e
		{
			e := "system exception:Bot failed to move finalbillpreb status"
			throw e
		}
	}
}