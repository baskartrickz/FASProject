class BlindProvisioningV1BusObj
{
	fas := new chromeV1SysUtilObj
	blind := new BlindProvisioningV1AppMod
	
	launch()
	{
		try
		{
			this.fas.launch(this.blind.url, "--start-maximized")
		}
		catch e
		{
			e := "system exception:Bot failed to launch Blindprovisioning!"
			throw e
		}
	}
	login(botcredential)
	{
		try
		{	
			this.fas.write(this.blind.username,botcredential["csoId"])
			this.fas.write(this.blind.pass,botcredential["csoPassword"])
			this.fas.click(this.blind.login)
			Sleep, 6000
		}
		catch e
		{
			e := "system exception:Bot failed to login Blindprovisioning!"
			throw e
		}
	}

	inputform(blindprovisioninout)	
	{
		try
		{
			this.fas.click(this.blind.backtoinsertform)
			Sleep, 3000
			this.fas.write(this.blind.boid,blindprovisioninout["boid"])
			this.fas.write(this.blind.ordernumber,blindprovisioninout["ordernumber"])
			duedate := blindprovisioninout["duedate"]
			date := strsplit(duedate,"/")
			newduedate := date[1] . "/" . date[2] . "/" . "20" . date[3]
			this.fas.write(this.blind.duedate,newduedate)
			this.fas.write(this.blind.mirrordw,blindprovisioninout["mirrordW"])
			this.fas.write(this.blind.pin,blindprovisioninout["pin"])
			this.fas.write(this.blind.iptv,blindprovisioninout["iptv"])
			this.fas.write(this.blind.addressid,blindprovisioninout["addressid"])
			this.fas.write(this.blind.bex,blindprovisioninout["bex"])
			this.fas.write(this.blind.ordertype,blindprovisioninout["ordertype"])
			this.fas.write(this.blind.tn,blindprovisioninout["tn"])
			this.fas.write(this.blind.block,blindprovisioninout["block"])
			this.fas.write(this.blind.speed,blindprovisioninout["speed"])
			this.fas.write(this.blind.nbntn,blindprovisioninout["nbntn"])
			this.fas.write(this.blind.asgnnote,blindprovisioninout["asgnnote"])
			msgbox "Going to submit Blindpro"
			This.fas.click(This.blind.submitbutton)
			sleep, 2000
			This.fas.alertAccept()
		}	
	
		catch e
		{
			e := "system exception:Bot Failed to update the data in blind Provising"
			throw e
		}
	}
}