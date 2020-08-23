
class mssTicketV1BusObj
{
	__New()
	{
		This.mssticket := new chromeV1SysUtilObj
		This.mssAppMod := new mssTicketV1AppMod
	}
	launch()
	{
		try
		{
			This.mssticket.launch(This.mssAppMod.url,"--start-Maximized")
		}
		catch e 
		{
			e := "system Exception:MSS ticket application failed to launch."
			throw e
		}
	}

	updateTicket(counter,chronosInputdata,duedate,m6BlindProv)
	{
		try
		{
			MsgBox % chronosInputdata[counter]["mssErrorMessage"]
			sleep 2000
			This.mssticket.write(this.mssAppMod.errorMessage,chronosInputdata[counter]["mssErrorMessage"])
			This.mssticket.write(This.mssAppMod.errorComments,chronosInputdata[counter]["mssComments"])
			This.mssticket.write(This.mssAppMod.telephone,chronosInputdata[counter]["telephone"])
			This.mssticket.write(This.mssAppMod.hwinPsr,chronosInputdata[counter]["psr"])
			This.mssticket.write(This.mssAppMod.duedate,duedate)
			if (m6BlindProv = "Yes")
			{
				This.mssticket.click(This.mssAppMod.bpCheckbox)
			}
			msgbox "Going to submit MSS Ticket"
			This.mssticket.click(This.mssAppMod.submitButton)
			sleep , 2000
			This.mssticket.click(This.mssAppMod.clickHere)
		}
		catch e
		{
			e := "system exception: Bot failed to update data on MSS Ticket application."
			throw e
		}
	}
}
