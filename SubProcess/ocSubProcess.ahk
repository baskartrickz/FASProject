launchOrderCorrection(orderCorrection)
{
	try
	{
		orderCorrection.launch()
	}
	catch e
	{
		throw e
	}
}
loginorderCorrection(orderCorrection,botcredential)
{
	try
	{
		orderCorrection.login(botcredential)
	}
	catch e
	{
		throw e
	}
}
orderCorrectionMain(orderCorrection,boid,bex,orderNumber,dueDate,workForce,area,counter,discrepancy,comments,telephoneNumberOc,remarks,status,notifyReason,tempIncrement)
{
	try
	{
		ocNumber := {}
		oCdetailsPending := {}
		discrepancy := discrepancy
		comments := comments
		newComments .= comments . "`n`n"
		telephoneNumber := telephoneNumberOc
		remarks := remarks
		status := status
		notifyReason := notifyReason
		if (instr(discrepancy, "[SD]"))
		{
			area := "SvcDelSMB"
		}
		else if ((discrepancy = "LSPAC/DUE DATES - [LSPAC]") or (discrepancy = "LSPAC/TELEPHONE NUMBER - [LSPAC]"))
		{
			area := "WinBack"
		}
		else if (discrepancy = "LSPAC/ADDRESS/PREMISE - [LSPAC]")
		{
			area := "UNEP-Resale-PortOut"
		}
		if (comments != "")
		{
			if (tempIncrement <= 1)
			{
				ocNumber := orderCorrection.orderCorrectionProcess(discrepancy,newComments,boid,bex,orderNumber,dueDate,workForce,area,telephoneNumber)
				oCdetailsPending := {"result":ocNumber["result"],"telephoneNumber":ocNumber["telephoneNumber"],"remarks":remarks,"status":status,"notifyReason":notifyReason}
				return oCdetailsPending
			}
			tempIncrement := 1
		}
	}
	catch e
	{
		throw e
	}
}
  