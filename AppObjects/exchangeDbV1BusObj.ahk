class exchangeDbV1BusObj
{
	exchangeDetails(botcredential,boid,bex)
	{
		oCon := ComObjCreate("ADODB.Connection") 
		oCon.ConnectionTimeout := 3 
		oCon.CursorLocation := 3 
		oCon.CommandTimeout := 900 
		
		ConnectionString := "Provider=SQLNCLI11;Server= CWWDBS050D;Database=Exchanges;Uid=" botcredential["dbUserName"] ";Pwd=" botcredential["dbPassword"] ";"   ;server and credentials

		try
		{
			oCon.Open(ConnectionString)
			oResullt := "SELECT sState, exchange,City, BOID, BEX, NPA, NXX,block, host, MIROR_WC, MIROR_Pkg, WKFC, Rack_COE, QC, DCRIS_Region FROM Exchanges.dbo.boidbexnxx WHERE BOID=" . BOID " AND BEX=" . BEX
			
			exchangeData := oCon.execute( oResullt )
			
			state := exchangeData.Fields(0).value
			exchange := exchangeData.Fields(1).value
			city := exchangeData.Fields(2).value
			boid := exchangeData.Fields(3).value
			bex := exchangeData.Fields(4).value
			npa := exchangeData.Fields(5).value
			nxx := exchangeData.Fields(6).value
			host := exchangeData.Fields(8).value
			mirorWC := exchangeData.Fields(9).value
			mirrorPackage := exchangeData.Fields(10).value
			qc := exchangeData.Fields(13).value
			dcrisRegion := exchangeData.Fields(14).value
			
			exchangeSheetData := {"state":state,"exchange":exchange,"city":city,"boid":boid,"bex":bex,"npa":npa,"nxx":nxx,"host":host,"mirorWC":mirrorWC,"mirrorPackage":mirrorPackage,"qc":qc,"dcrisRegion":dcrisRegion}
		}
		catch e
		{
			e := "ExchangeDB_BOID_BEX : Exchange DB Excecution Failed"
			throw e
		}
		finally
		{
			oCon.Close()
		}
		return exchangeSheetData
	}
	
}