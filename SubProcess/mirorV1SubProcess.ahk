
mirorlaunch(miror,exchangeSheetData)
{
	try
	{
		miror.launch(exchangeSheetData)
	}
	catch e
	{
		e := "failed to launch miror!"
		throw e
	}
}
mirorlogin(miror,botcredential)
{
	try
	{	
		miror.login(botcredential)
	}
	catch e
	{
		e := "failed to login miror!"
		throw e
	}
}
mirorclose(miror)
{
	try
	{	
		miror.mirwinclose()
	}
	catch e
	{
		e := "failed to close!"
		throw e
	}
}
mirorprimaryrecord(miror,tn)
{
	try
	{	
		primaryrecord := miror.Primaryrecord(tn)
		if (instr(primaryrecord,"BONDED") or instr(primaryrecord,"BND"))
		{
			mirorRecord := "bonded"
		}
		primarymirorrecord := miror.NoteSegragation(primaryrecord)
	}
	catch e
	{
		e := "failed in mirorprimaryrecord!"
		throw e
	}
	return, [primarymirorrecord,mirorRecord]
}	
mirorbondrecord(miror,seArray)
{
	try
	{
		bondrecord := miror.Bondedrecord(seArray)
		if (bondrecord != "")
		{
	        if(instr(bondrecord,"BONDED"))
			{
				bondedmirorrecord := miror.NoteSegragation(bondrecord)
				send, {f9}
				send, {f9}
				send {Enter}
			}							
			else
			{
				bondedmirorrecord := miror.NoteSegragation(bondrecord)
			}
			
		}
	}	
	catch e
	{
		e := "failed in mirorbondrecord!"
		throw e
	}
	return bondedmirorrecord
}


;~ mirorlaunch(miror)
;~ mirorlogin(miror,uid,pass)
;~ mirorprimaryrecord(miror,tn)
;~ mirorbondrecord(miror)
;~ mirorfinalrecord(miror,primarymirorrecord,bondedmirorrecord)