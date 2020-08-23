class ocV1AppMod
{
	url := "http://cct.windstream.com/cstar/oc/default.asp"
	uName := ["fe","name","uname"]
	pword := ["fe","xpath","//*[@id='login']/table/tbody/tr[2]/td[2]/input"]
	submitButton := "processMe()"
	ocFrame := ["fe","xpath","//*[@id='tab_ocEntry']"]
	enddate := ["fe","name","Date2"]
	searchbutton := ["fe","xpath","//*[@id='ext-comp-1001__ext-comp-1004']/a[2]/em/span/span"]
	ocsearchframe := ["fe","id","tab_ocSearch"]
	confirmation := ["fe","name","searchBox"]
	discrepancyReason := ["fe","name","Discrepancy_Reason"]
	boid := ["fe","name","BOID"]
	bex := ["fe","name","BEX"]
	order := ["fe","name","Onum"]
	dueDate := ["fe","name","DueDate"]
	state := ["fe","name","State"]
	workForce := ["fe","name","WKFC"]
	otherWorkForce := ["fe","name","customWKFC"]
	commentsBox := ["fe","name","EntryComments"]
	area := ["fe","name","Area"]
	sellpId := ["fe","name","DiscEID"]
	telephone := ["fe","name","TN"]
	submitDiscrepancy := "validateForm(entryform)"
	reply := ["fe","name","BillingOnly"]
	getOcNumber := ["fe","xpath","//*[@id='returnGet']/table/tbody/tr/td"]
}