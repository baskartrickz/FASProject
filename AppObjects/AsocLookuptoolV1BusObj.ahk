class asoclookUptoolV1BusObj
{
	asoc := new chromeV1SysUtilObj
	asocAppMod := new AsocLookUpToolV1AppMod
	launch()
	{
		try
		{
			this.asoc.launch(this.asocAppMod.url,"--start-maximized")
		}
		catch e
		{
			e := "system exception:Bot failed to lauch asoc look up Application"
			throw e
		}
	}
	lookUp(asocData)
	{
		try
		{
			this.asoc.write(this.asocAppMod.asocInputBox,asocData)
			this.asoc.click(this.asocAppMod.searchButton)
			sleep 5000
			try
			{
				asocTable := this.asoc.getAttribute(this.asocAppMod.asocTable,"innerText")
			}
			this.asoc.clear(this.asocAppMod.asocInputBox)
		}
		catch e
		{
			e := "systemexception:Bot failed to fetch asoc details in Asoc lookUp application."
			throw e
		}
		return asocTable
	}
}