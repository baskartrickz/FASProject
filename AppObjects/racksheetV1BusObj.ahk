class racksheetV1BusObj
{
	fas := new chromeV1SysUtilObj
	racAppmod := new racksheetV1Appmod
	launch()
    {
        try
		{
		    This.fas.launch(This.racAppmod.url,"--start-maximized")
            
		}
		catch e
		{
			e := "System exception: BOT failed to launch racsheet!"
			throw e
		}
	}
	login(botcredential)
	{ 
		try 
		{
			This.fas.Write(This.racAppmod.uname,botcredential["csoId"])
		    This.fas.Write(This.racAppmod.pword,botcredential["csoPassword"])
            This.fas.click(This.racAppmod.submitButton)
		}
		catch e
		{
			e := "System exception: BOT failed to login racsheet!"
			throw e
		}
		
	}

    selectstate(newexchange,racksheetState)
    {
		try
		{
			sleep 3000
			This.fas.switchFrames(This.racAppmod.stateFrame)
            This.fas.click(This.racAppmod.submitForm)
		    sleep 2000
			This.fas.switchToParentFrame()
            This.fas.switchFrames(This.racAppmod.selectStateFrame)
            This.fas.listDropDown(This.racAppmod.racstate,racksheetState)
			This.fas.write(This.racAppmod.raccity,newexchange)
            
		}
		catch e
		{
			e := "System exception: BOT failed to selectstate in racsheet!"
			throw e
		}
    }
    primaryinputform(racksheetPrimaryData)
    {
        try
		{
			This.fas.clear(This.racAppmod.duedate)
			This.fas.clear(This.racAppmod.svcOrder)
			This.fas.clear(This.racAppmod.picIpic)
			This.fas.clear(This.racAppmod.TeleNumIn)
			This.fas.clear(This.racAppmod.TeleNumOut)
			This.fas.clear(This.racAppmod.GradeIn)
            This.fas.clear(This.racAppmod.GradeOUT)
            This.fas.clear(This.racAppmod.WirecenterIn)
            This.fas.clear(This.racAppmod.WirecenterOut)
            This.fas.clear(This.racAppmod.CoeIn)
			This.fas.clear(This.racAppmod.CoeOut)
            This.fas.clear(This.racAppmod.FeatureIn)
			This.fas.clear(This.racAppmod.FeatureOut)
		    This.fas.clear(This.racAppmod.MDFPairIn)
            This.fas.clear(This.racAppmod.MDFPairOut)
			This.fas.clear(This.racAppmod.FramePairIn)
			This.fas.clear(This.racAppmod.FramePairOut)
            This.fas.clear(This.racAppmod.BlockPinIn)
            This.fas.clear(This.racAppmod.BlockPinOut)
            This.fas.clear(This.racAppmod.LineEquIn)
            This.fas.clear(This.racAppmod.LineEquOut)
            This.fas.clear(This.racAppmod.Comment)
			This.fas.write(This.racAppmod.svcOrder,racksheetPrimaryData["svcorderinfo"])
            This.fas.write(This.racAppmod.picIpic,racksheetPrimaryData["primarypicIpic"])
			This.fas.write(This.racAppmod.boid,racksheetPrimaryData["boid"])
            This.fas.write(This.racAppmod.duedate,racksheetPrimaryData["duedate"])
            This.fas.write(This.racAppmod.winback,racksheetPrimaryData["winback"])
            This.fas.write(This.racAppmod.techcall,racksheetPrimaryData["primarytechWillCall"])
            This.fas.dropdown(This.racAppmod.dcrisstatus,"YES")
			This.fas.write(This.racAppmod.TeleNumIn,racksheetPrimaryData["primarytelePhoneIn"])
			This.fas.write(This.racAppmod.TeleNumOut,racksheetPrimaryData["primarytelePhoneOut"])
			This.fas.write(This.racAppmod.GradeIn,racksheetPrimaryData["primarymirorGradeIn"])
            This.fas.write(This.racAppmod.GradeOUT,racksheetPrimaryData["primarymirorGradeOut"])
            This.fas.write(This.racAppmod.WirecenterIn,racksheetPrimaryData["primaryMirrorWcIn"])
            This.fas.write(This.racAppmod.WirecenterOut,racksheetPrimaryData["primaryMirrorWcOut"])
            This.fas.write(This.racAppmod.CoeIn,racksheetPrimaryData["primarycoeIn"])
			This.fas.write(This.racAppmod.CoeOut,racksheetPrimaryData["primarycoeOut"])
            This.fas.write(This.racAppmod.FeatureIn,racksheetPrimaryData["primaryFeatureIn"])
			This.fas.write(This.racAppmod.FeatureOut,racksheetPrimaryData["primaryFeatureOut"])
		    This.fas.write(This.racAppmod.MDFPairIn,racksheetPrimaryData["primarymdfPairIn"])
            This.fas.write(This.racAppmod.MDFPairOut,racksheetPrimaryData["primarymdfPairOut"])
			This.fas.write(This.racAppmod.FramePairIn,racksheetPrimaryData["primaryframeTiePairIn"])
			This.fas.write(This.racAppmod.FramePairOut,racksheetPrimaryData["primaryframeTiePairOut"])
            This.fas.write(This.racAppmod.BlockPinIn,racksheetPrimaryData["primaryloopTreatIn"])
            This.fas.write(This.racAppmod.BlockPinOut,racksheetPrimaryData["primaryloopTreatOut"])
            This.fas.write(This.racAppmod.LineEquIn,racksheetPrimaryData["primarylineEquipmentIn"])
            This.fas.write(This.racAppmod.LineEquOut,racksheetPrimaryData["primarylineEquipmentOut"])
            This.fas.write(This.racAppmod.Comment,racksheetPrimaryData["facRemarks"])
            This.fas.write(This.racAppmod.sendCo,racksheetPrimaryData["racco"])
            This.fas.write(This.racAppmod.sendsag,racksheetPrimaryData["racsag"])
            This.fas.write(This.racAppmod.sendcomplex,racksheetPrimaryData["raccomplex"])
		
		}
		catch e
		{
			e := "System exception: BOT failed to update racksheet information."
			throw e
		}
    }
	bondedinputform(racksheetBondedData)
    {
        try
		{
			This.fas.clear(This.racAppmod.picIpic)
			This.fas.clear(This.racAppmod.TeleNumIn)
			This.fas.clear(This.racAppmod.TeleNumOut)
			This.fas.clear(This.racAppmod.GradeIn)
            This.fas.clear(This.racAppmod.GradeOUT)
            This.fas.clear(This.racAppmod.WirecenterIn)
            This.fas.clear(This.racAppmod.WirecenterOut)
            This.fas.clear(This.racAppmod.CoeIn)
			This.fas.clear(This.racAppmod.CoeOut)
            This.fas.clear(This.racAppmod.FeatureIn)
			This.fas.clear(This.racAppmod.FeatureOut)
		    This.fas.clear(This.racAppmod.MDFPairIn)
            This.fas.clear(This.racAppmod.MDFPairOut)
			This.fas.clear(This.racAppmod.FramePairIn)
			This.fas.clear(This.racAppmod.FramePairOut)
            This.fas.clear(This.racAppmod.BlockPinIn)
            This.fas.clear(This.racAppmod.BlockPinOut)
            This.fas.clear(This.racAppmod.LineEquIn)
            This.fas.clear(This.racAppmod.LineEquOut)
            This.fas.clear(This.racAppmod.Comment)
		    This.fas.write(This.racAppmod.picIpic,racksheetBondedData["bondedpicIpic"])
            This.fas.write(This.racAppmod.winback,racksheetBondedData["winback"])
            This.fas.write(This.racAppmod.techcall,racksheetBondedData["bondedtechWillCall"])
            This.fas.dropdown(This.racAppmod.dcrisstatus,"YES")
			This.fas.write(This.racAppmod.TeleNumIn,racksheetBondedData["bondedtelePhoneIn"])
			This.fas.write(This.racAppmod.TeleNumOut,racksheetBondedData["bondedtelePhoneOut"])
			This.fas.write(This.racAppmod.GradeIn,racksheetBondedData["bondedmirorGradeIn"])
            This.fas.write(This.racAppmod.GradeOUT,racksheetBondedData["bondedmirorGradeOut"])
            This.fas.write(This.racAppmod.WirecenterIn,racksheetBondedData["bondedMirrorWcIn"])
            This.fas.write(This.racAppmod.WirecenterOut,racksheetBondedData["bondedMirrorWcOut"])
            This.fas.write(This.racAppmod.CoeIn,racksheetBondedData["bondedcoeIn"])
			This.fas.write(This.racAppmod.CoeOut,racksheetBondedData["bondedcoeOut"])
            This.fas.write(This.racAppmod.FeatureIn,racksheetBondedData["bondedFeatureIn"])
			This.fas.write(This.racAppmod.FeatureOut,racksheetBondedData["bondedFeatureout"])
		    This.fas.write(This.racAppmod.MDFPairIn,racksheetBondedData["bondedmdfPairIn"])
            This.fas.write(This.racAppmod.MDFPairOut,racksheetBondedData["bondedmdfPairOut"])
			This.fas.write(This.racAppmod.FramePairIn,racksheetBondedData["bondedframeTiePairIn"])
			This.fas.write(This.racAppmod.FramePairOut,racksheetBondedData["bondedframeTiePairOut"])
            This.fas.write(This.racAppmod.BlockPinIn,racksheetBondedData["bondedloopTreatIn"])
            This.fas.write(This.racAppmod.BlockPinOut,racksheetBondedData["bondedloopTreatOut"])
            This.fas.write(This.racAppmod.LineEquIn,racksheetBondedData["bondedlineEquipmentIn"])
            This.fas.write(This.racAppmod.LineEquOut,racksheetBondedData["bondedlineEquipmentOut"])
            This.fas.write(This.racAppmod.Comment,racksheetBondedData["facRemarks"])
            This.fas.write(This.racAppmod.sendco,racksheetBondedData["racco"])
            This.fas.write(This.racAppmod.sendsag,racksheetBondedData["racsag"])
            This.fas.write(This.racAppmod.sendcomplex,racksheetBondedData["raccomplex"])		
		}
		catch e
		{
			e := "System exception: BOT failed to update racksheet information."
			throw e
		}
    }
	lastseg()
	{
		try
		{
			This.fas.click(This.racAppmod.lastSeg)
		}
		catch e
		{
			e := "System exception: BOT failed to click lastseg"
			throw e
		}
	}
	lastsubmitbutton()
	{
		try
		{
			This.fas.click(This.racAppmod.lastSubmitButton)
		}
		catch e
		{
			e := "System exception: BOT failed to click Lastsubmitbutton"
			throw e
		}
	}
	rachsheetFinalSubmit()
	{
		try
		{
			This.fas.click(This.racAppmod.clickHere)
			sleep 2000
			try
			{
				This.fas.switchToParentFrame()
				sleep, 200
				this.fas.switchframes(This.racAppmod.racksheetFrame)
				sleep 500
				This.fas.click(This.racAppmod.racksheetSubmit)
			}
		}
		catch e
		{
			MsgBox % e.Message
		}
	}
	
}
