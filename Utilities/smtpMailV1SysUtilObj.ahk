class smtpMailV1SysUtilObj
{
	__New()
	{
		This.pmsg := ComObjCreate("CDO.Message")
	}
	smtpMail(userName,passWord,toMail,ccMail,subject,bodyText,attachment)
	{
		
		This.pmsg.From := userName
		This.pmsg.To := toMail
		This.pmsg.CC := ccMail
		This.pmsg.Subject := subject
		This.pmsg.TextBody := bodyText
		sAttach := attachment
		fields := Object()
		fields.smtpserver := "Dell903.windstream.com" 
		fields.smtpserverport := 25
		fields.smtpusessl := false
		fields.sendusing := 2
		fields.smtpauthenticate := 1
		fields.sendusername := userName
		fields.sendpassword := passWord
		fields.smtpconnectiontimeout := 60
		schema := "http://schemas.microsoft.com/cdo/configuration/"

		pfld := This.pmsg.Configuration.Fields
		For field,value in fields
		{
			pfld.Item(schema . field) := value
		}
		pfld.Update()
		if IsObject(sAttach)
		{
			for key, FileName in sAttach
			{
				This.pmsg.AddAttachment(FileName)
			}
		}
		else if (sAttach != "")
		{
			 This.pmsg.AddAttachment(sAttach)
		}
		try
		{
			This.pmsg.Send()
		}
		catch e
		{
			Msgbox,1, Error Message ,% e.message,4
		}
	}
}


