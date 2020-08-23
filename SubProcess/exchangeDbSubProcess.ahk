exchangeSheet(assignment,botcredential,boid,bex)
{
	exchangeSheetData := {}
	try
	{
		exchangeSheetData := assignment.exchangeDetails(botcredential,boid,bex)
	}
	catch e
	{
		e := "system exception:Bot failed to get exchangesheetdata "
		throw e
	}
	return exchangeSheetData
}
