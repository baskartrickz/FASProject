mssLaunch(mss)
{
	mss.launch()
}
mssTicketSubProcess(mss,counter,chronosInputdata,duedate,m6BlindProv)
{
	try
	{
		mss.updateTicket(counter,chronosInputdata,duedate,m6BlindProv)
	}
	catch e
	{
		throw e
	}
}