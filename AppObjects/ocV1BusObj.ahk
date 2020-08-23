class ocV1BusObj
{
	oc := new chromeV1SysUtilObj
	ocAppmod := new ocV1AppMod
	
	launch()
	{
		try
		{
			This.oc.launch(This.ocAppmod.url,"--start-maximized")
		}
		catch e
		{
			e := "system exception:order correction application launch failed."
			throw e
		}
	}
	login(botcredential)
	{
		try
		{
			This.oc.Write(This.ocAppmod.uName,botcredential["csoId"])
			This.oc.Write(This.ocAppmod.pword,botcredential["csoPassword"])
			This.oc.executeScript(This.ocAppmod.submitButton)
			Sleep 3000
			This.oc.switchFrames(This.ocAppmod.ocFrame)
		}
		catch e
		{
			e := "system exception:order correction application login failed."
			throw e
		}
	}
	orderCorrectionProcess(discrepancy,comments,boid,bex,orderNumber,dueDate,workForce,area,telephoneNumber)
	{
		try
		{
			This.oc.listDropDown(This.ocAppmod.discrepancyReason,discrepancy)
			This.oc.Write(This.ocAppmod.boid,boid)
			This.oc.Write(This.ocAppmod.bex,bex)
			This.oc.Write(This.ocAppmod.order,orderNumber)
			date := strsplit(duedate,"/")
			newduedate := date[1] . date[2] . "20" . date[3]
			This.oc.Write(This.ocAppmod.dueDate,newduedate)
			try
			{
				This.oc.dropDown(This.ocAppmod.workForce,workForce)
			}
			catch e
			{
				This.oc.dropDown(This.ocAppmod.workForce,"Other")
				This.oc.write(This.ocAppmod.otherWorkForce,workForce)
			}
			This.oc.write(This.ocAppmod.commentsBox,comments)
			This.oc.dropDown(This.ocAppmod.area,area)
			This.oc.Write(This.ocAppmod.telephone,telephoneNumber)

			sleep 1000
			MsgBox going to submit oc
			This.oc.executescript(This.ocAppmod.submitDiscrepancy)
			res := This.oc.Read(This.ocAppmod.getOcNumber,"text")
			x := "has"
			StringGetPos start_pos, res, %x%

			start_pos := start_pos - 7
			StringMid result, res, start_pos, 8
			result := trim(result)
		}
		catch e 
		{
			e := "system exception:Bot failed to submit order correction." 
			throw e
		}
		ocResult := {"result":result,"telephoneNumber":telephoneNumber}
		return ocResult
	}
}
