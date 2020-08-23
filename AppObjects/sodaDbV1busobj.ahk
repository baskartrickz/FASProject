class sodaDbV1BusObj
{
	oCon := ComObjCreate("ADODB.Connection")
	sodaDbConnection(dbUserName,dbPassword)
	{
		this.oCon.ConnectionTimeout := 3 ; Allow 3 seconds to connect to the server.
		this.oCon.CursorLocation := 3 ; Use a client-side cursor server.
		this.oCon.CommandTimeout := 900 ; A generous 15 minute timeout on the actual SQL statement.
		;~ ConnectionString := "Provider=SQLNCLI11;Server=CWWDBS050D;Database=STU2;Uid=" dbUserName ";Pwd=" dbPassword ";"
		ConnectionString := "Provider=SQLNCLI11;Server=CWWDBS075;Database=STU2;Uid=" dbUserName ";Pwd=" dbPassword ";"
		try
		{
			this.oCon.Open(ConnectionString)
		}
		catch e
		{
			e := "GetOrder : Chronos DB Connection Failed"
			throw e
		}
	}
	queryExecute(query)
	{
		try
		{
			result := this.oCon.execute(query)
		}
		catch e
		{
			e := "Bot Failed to execute Soda query."
		}
		return result
	}
	closeconnection()
	{
		try
		{
			this.oCon.Close()
		}
		catch e
		{
			e := "Bot failed to close the connection"
		}
	}
	getOrderDetails(dbUserName,dbPassword,gId)
	{
		try
		{
			sodaArray := {}
			oResult := "SELECT TOP 1 a.ID,a.BOID,a.BEX,a.ORDERNUMBER,a.WORKFORCE,a.DUEDATE,a.Kinetic as KINETIC,a.BusRes,b.AdditionalNotes from STU2.dbo.soda AS a left join SODA_Logs as b on b.SodaID=a.ID where a.STATUS='BT' and b.ToStatus='BT' AND  a.EmployeeID not LIKE 'G%'AND b.AdditionalNotes like '%TN OC%' ORDER BY a.DUEDATE,a.DateWorked,b.DateLogged desc"
			this.sodaDbConnection(dbUserName,dbPassword)
			oRec := this.queryExecute(oResult)
			try
			{
				orderId := oRec.Fields(0).value
			}
			orderInfo := "human"
			if (orderId = "")
			{
				this.closeconnection()
				oResult := "SELECT TOP 1 a.ID,a.BOID,a.BEX,a.ORDERNUMBER,a.WORKFORCE,a.DUEDATE,a.Kinetic as KINETIC,a.BusRes,b.AdditionalNotesfrom STU2.dbo.soda AS a left join SODA_Logs as b on b.SodaID=a.ID where a.STATUS='BT' and b.ToStatus='BT' AND a.EmployeeID ='OCBOT' AND b.AdditionalNotes like '%TN OC BOT%' ORDER BY a.DUEDATE,a.DateWorked,b.DateLogged desc"
				this.sodaDbConnection(dbUserName,dbPassword)
				oRec := this.queryExecute(oResult)
				try
				{
					orderId := oRec.Fields(0).value
				}
				orderInfo := "Bot"
			}
			
			;~ oResult := "update STU2.dbo.SODA set EmployeeID='" gId "',datestarted=dateadd(hour,1,getdate()) WHERE ID='" orderId "' AND STATUS='BT'"
			;~ this.queryExecute(oResult)

			boid := oRec.Fields(1).value
			bex := oRec.Fields(2).value
			orderNumber := oRec.Fields(3).value
			workForce := oRec.Fields(4).value
			dueDate := oRec.Fields(5).value
			busRes := oRec.Fields(7).value
			userInput := oRec.Fields(8).value
			sodaArray := {"orderId":orderId,"boid":boid,"bex":bex,"orderNumber":orderNumber,"workForce":workForce,"dueDate":dueDate,"busRes":busRes,"userInput":userInput,"orderInfo":orderInfo}
			this.closeconnection()
		}
		catch e
		{
			throw e
		}
		return sodaArray
	}
	completeOrder(dbUserName,dbPassword,orderStatus,orderId)
	{
		try
		{
			oResult := "update STU2.dbo.soda set STATUS='"orderStatus "',DateWorked=dateadd(hour,1,getdate()),Datepending=dateadd(hour,1,getdate()) WHERE ID='"orderId "' AND STATUS='BT'"
			this.sodaDbConnection(dbUserName,dbPassword)
			this.queryExecute(oResult)
			this.closeconnection()
		}
		catch e
		{
			throw e
		}
	}
	updateOrderNotes(dbUserName,dbPassword,orderId,gid,botNotes,fromStatus,toStatus)
	{
		try
		{
			oResult := "insert into dbo.SODA_Logs (sodaid,employeeid,additionalnotes, FromStatus,ToStatus,DateLogged,DateStarted) values ('" orderId "','" gid "','" botNotes "','" fromStatus "','" toStatus "',dateadd(hour,1,getdate()))"
			this.sodaDbConnection(dbUserName,dbPassword)
			this.queryExecute(oResult)
			this.closeconnection()
		}
		catch e
		{
			throw e
		}
	}
	exceptionOrder(dbUserName,dbPassword,orderStatus,orderId)
	{
		try
		{
			oResult := "update STU2.dbo.soda set EmployeeID=NULL,STATUS='"orderStatus "',DateWorked=dateadd(hour,1,getdate()),Datepending=dateadd(hour,1,getdate()) WHERE ID='"orderId "' AND STATUS='BT'"
			this.sodaDbConnection(dbUserName,dbPassword)
			this.queryExecute(oResult)
			this.closeconnection()
		}
		catch e
		{
			throw e
		}
	}
}



