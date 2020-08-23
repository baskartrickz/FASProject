Class chromeV1SysUtilObj
{ 
	wb := ComObjCreate("Selenium.ChromeDriver")
	
;if argument is empty you should pass empty value
;LAUNCH
	launch(url,addArgument := "")	
	{
		This.wb.AddArgument(addArgument)
		This.wb.Get(url)
	}              
; elementSelection is an Array, taking from appMod it should contain 5 values.
;READING VALUES
	read(elementSelection, readType)
    {
		If(elementSelection[1] = "fe")
		{
		;Using ID
			if(elementSelection[2] = "ID")
			{
				if(readType = "innertext")
				{
					readValue := This.wb.FindElementByID(elementSelection[3]).innertext
				}
				else if(readType = "value")
				{
					readValue := This.wb.FindElementByID(elementSelection[3]).value 
				}
				else if(readType = "text")
				{
					readValue := This.wb.FindElementByID(elementSelection[3]).text 
				}
				else if(readType = "innerhtml")
				{
					readValue := This.wb.FindElementByID(elementSelection[3]).innerhtml
				}
				else if(readType = "outerhtml")
				{
					readValue := This.wb.FindElementByID(elementSelection[3]).outerhtml
				}
				else
				{
					readValue := This.wb.FindElementByID(elementSelection[3])
				}
				Return readValue
			}
			
			;Using Class
			else if(elementSelection[2] = "class")
			{
				if(readType = "innertext")
				{
					readValue := This.wb.FindElementByclass(elementSelection[3]).innertext
				}
				else if(readType = "value")
				{
					readValue := This.wb.FindElementByclass(elementSelection[3]).value 
				}
				else if(readType = "text")
				{
					readValue := This.wb.FindElementByclass(elementSelection[3]).text 
				}
				else if(readType = "innerhtml")
				{
					readValue := This.wb.FindElementByclass(elementSelection[3]).innerhtml
					
				}
				else if(readType = "outerhtml")
				{
					readValue := This.wb.FindElementByclass(elementSelection[3]).outerhtml
				}
				else
				{
					readValue := This.wb.FindElementByclass(elementSelection[3])
				}
				Return readValue
			}
			
			
			;Using TagName
			
			else if(elementSelection[2] = "tagname")
			{
				if(readType = "innertext")
				{
					path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
					readValue := This.wb.FindElementByxpath(path).innertext
				}
				else if(readType = "value")
				{
					path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
					readValue := This.wb.FindElementByxpath(path).value
				}
				else if(readType = "text")
				{
					path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
					readValue := This.wb.FindElementByxpath(path).text
				}
				else if(readType = "innerhtml")
				{
					path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
					readValue := This.wb.FindElementByxpath(path).innerhtml
					
				}
				else if(readType = "outerhtml")
				{
					path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
					readValue := This.wb.FindElementByxpath(path).outerhtml
				}
				else
				{
					path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
					readValue := This.wb.FindElementByxpath(path)
				}
				Return readValue
			}
			
				;Using Xpath
			else if(elementSelection[2] = "xpath") 
			{
				if(readType = "innertext")
				{
					readValue := This.wb.FindElementByxpath(elementSelection[3]).innertext
				}
				else if(readType = "value")
				{
					readValue := This.wb.FindElementByxpath(elementSelection[3]).value 
				}
				else if(readType = "text")
				{
					readValue := This.wb.FindElementByxpath(elementSelection[3]).text 
				}
				else if(readType = "innerhtml")
				{
					readValue := This.wb.FindElementByxpath(elementSelection[3]).innerhtml
				}
				else if(readType = "outerhtml")
				{
					readValue := This.wb.FindElementByxpath(elementSelection[3]).outerhtml
				}
				else
				{
					readValue := This.wb.FindElementByxpath(elementSelection[3])
				}
				Return readValue
			}

			
			;Using Name
			else if(elementSelection[2] = "Name")
			{
				if(readType = "innertext")
				{
					readValue := This.wb.FindElementByname(elementSelection[3]).innertext
				}
				else if(readType = "value")
				{
					readValue := This.wb.FindElementByname(elementSelection[3]).value
				}
				else if(readType = "text")
				{
					readValue := This.wb.FindElementByname(elementSelection[3]).text 
				}
				else if(readType = "innerhtml")
				{
					readValue := This.wb.FindElementByname(elementSelection[3]).innerhtml
				}
				else if(readType = "outerhtml")
				{
					readValue := This.wb.FindElementByname(elementSelection[3]).outerhtml
				}
				else
				{
					readValue := This.wb.FindElementByname(elementSelection[3])
				}
				Return readValue
			}
		}
	}
	
	;GetAttribute Value
	getAttribute(elementSelection,attributeName)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				readValue := This.wb.FindElementByID(elementSelection[3]).Attribute(attributeName)
			}
			else if(elementSelection[2] = "xpath")
			{
				readValue := This.wb.findElementByxpath(elementSelection[3]).Attribute(attributeName)
			}
			else if(elementSelection[2] = "Name")
			{
				readValue := This.wb.findelementByName(elementSelection[3]).Attribute(attributeName)
			}
			else if(elementSelection[2] = "class")
			{
				readValue := This.wb.findElementByclass(elementSelection[3]).Attribute(attributeName)
			}
			else if(elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				ReadValue := This.wb.FindElementByxpath(path).Attribute(attributeName)
			}
		}
		else 
		{
		
		}
		Return readValue
	}
	
	;Radio Button Check
	checkRadioButton(elementSelection)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				readValue := This.wb.findelementByid(elementSelection[3]).isSelected()
			}
			else if(elementSelection[2] = "xpath")
			{
				readValue := This.wb.findElementByxpath(elementSelection[3]).isSelected()
			}
			else if(elementSelection[2] = "Name")
			{
				readValue := This.wb.findelementByName(elementSelection[3]).isSelected()
			}
			else if(elementSelection[2] = "class")
			{
				readValue := This.wb.findElementByclass(elementSelection[3]).isSelected()
			}
			else if(elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				readValue := This.wb.FindElementByxpath(path).isSelected()
			}
		}
		else 
		{
		
		}
		return readValue
	}
	
;WRITE VALUES
	write(elementSelection, elementValue)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				This.wb.findelementByid(elementSelection[3]).sendkeys(elementValue)
			}
			else if(elementSelection[2] = "xpath")
			{
				This.wb.findElementByxpath(elementSelection[3]).sendkeys(elementValue)
			}
			else if(elementSelection[2] = "Name")
			{
				This.wb.findelementByName(elementSelection[3]).sendkeys(elementValue)
			}
			else if(elementSelection[2] = "class")
			{
				This.wb.findElementByclass(elementSelection[3]).sendkeys(elementValue)
			}
			else if(elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				ReadValue := This.wb.FindElementByxpath(path).sendkeys(elementValue)
			}
		}
		else 
		{
		
		}
	}

;CLICK ITEM
	click(elementSelection)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				This.wb.findelementByid(elementSelection[3]).Click()
			}
			else if(elementSelection[2] = "Name")
			{
				This.wb.findElementByName(elementSelection[3]).click()
			}
			else if(elementSelection[2] = "xpath")
			{
				This.wb.findElementByxpath(elementSelection[3]).Click()
			}
			else if(elementSelection[2] = "linkText")
			{
				This.wb.findElementBylinkText(elementSelection[3]).Click()
			} 
			else if(elementSelection[2] = "class")
			{
				This.wb.findElementByclass(elementSelection[3]).Click()
			} 
			else if(elementSelection[2] = "PartialLinkText")
			{
				This.wb.findElementByPartialLinkText(evalue).click() 
			}
			else if(elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				This.wb.FindElementByxpath(path).Click()
			}
				
		}
		else 
		{

		}
	}
	
	;Select List Drop Down
	listDropDown(elementSelection, elementValue)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				This.wb.findelementByID(elementSelection[3]).click
				path := "//*[contains(text(),'" . elementValue . "')]"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "Name")
			{
				This.wb.findelementByname(elementSelection[3]).click
				path := "//*[contains(text(),'" . elementValue . "')]"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "xpath")
			{
				This.wb.findelementByxpath(elementSelection[3]).click
				path := "//*[contains(text(),'" . elementValue . "')]"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "class")
			{
				This.wb.findelementByclass(elementSelection[3]).click
				path := "//*[contains(text(),'" . elementValue . "')]"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				This.wb.findelementByxpath(path).click
				path := "//*[contains(text(),'" . elementValue . "')]"
				This.wb.findelementByxpath(path).click
			}
		}
		else
		{
		}
	}
	

;SELECT DROP DOWN
	dropDown(elementSelection, elementValue)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				This.wb.findelementByID(elementSelection[3]).sendkeys("")
				path := "//option[@value='" . elementValue . "']"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "Name")
			{
				This.wb.findelementByname(elementSelection[3]).sendkeys("")
				path := "//option[@value='" . elementValue . "']"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "xpath")
			{
				This.wb.findelementByxpath(elementSelection[3]).sendkeys("")
				path := "//option[@value='" . elementValue . "']"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "class")
			{
				This.wb.findelementByclass(elementSelection[3]).sendkeys("")
				path := "//option[@value='" . elementValue . "']"
				This.wb.findelementByxpath(path).click
			}
			else if (elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				This.wb.findelementByclass(path).sendkeys("")
				path := "//option[@value='" . elementValue . "']"
				This.wb.findelementByxpath(path).click
			}
		}
		else
		{
		}
	}

;Switch to Next Window using Navigate stage
	navWindow()
	{
		This.wb.SwitchToNextWindow
	}
	
;Switch to previous Window using Navigate stage
	previousWindow()
	{
		This.wb.SwitchToPreviousWindow
	}
	
;Double Click
	doubleClick(elementSelection)
	{
		If(elementSelection[1] = "fe")
		{	
			if  (elementSelection[2] = "ID")
			{
				path := This.wb.findElementByID(elementSelection[3])
				This.wb.Actions.Clickdouble(path).Perform
			}
			else if (elementSelection[2] = "xpath")
			{
				path := This.wb.findElementByxpath(elementSelection[3])
				This.wb.Actions.Clickdouble(path).Perform
			}
			else if (elementSelection[2] = "Name")
			{
				path := This.wb.findElementByName(elementSelection[3])
				This.wb.Actions.Clickdouble(path).Perform
			}
			else if (elementSelection[2] = "class")
			{
				path := This.wb.findElementByclass(elementSelection[3])
				This.wb.Actions.Clickdouble(path).Perform
			}
		}
		else
		{
		}
	}
	
	
	
	
	;Element Present
	elementPresent(elementSelection, timeout)
	{
		If(elementSelection[1] = "fe")
		{
			count := 1
			Loop, % timeout
			{
				try
				{
					if (Count >= timeout)
					{
						e := elementSelection[3] . "Element Not Present"
						Throw e
					}
					else
					{
						try
						{
							if(elementSelection[2] = "ID")
							{
								This.wb.findElementByID(elementSelection[3])
								break
							}
							else if (elementSelection[2] = "Name")
							{
								This.wb.findElementByName(elementSelection[3])
								break
							}
							else if (elementSelection[2] = "xpath")
							{
								This.wb.findElementByxpath(elementSelection[3])
								break
							}
							else if(elementSelection[2] = "linkText")
							{
								This.wb.findElementBylinkText(elementSelection[3])
								break
							}
						}
						catch e
						{
							sleep, 1000
							count++
						}
					}
				}
				catch e
				{
					throw exception(e, -1)
				}
			}
		}
		else
		{
		}
		return e
	}
	
	;Clear Element
	clear(elementSelection)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				This.wb.findElementByID(elementSelection[3]).Clear()
			}
			else if (elementSelection[2] = "Name")
			{
				This.wb.findElementByName(elementSelection[3]).Clear()
			}
			else if (elementSelection[2] = "xpath")
			{
				This.wb.findElementByxpath(elementSelection[3]).Clear()
			}
			else if(elementSelection[2] = "class")
			{
				This.wb.findElementByclass(elementSelection[3]).Clear()
			}
			else if(elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				This.wb.FindElementByxpath(path).Clear()
			}
		}
		else
		{
		}
	}
	
	;Alert Accept
	alertAccept()
	{
		This.wb.SwitchToalert.accept()
	}
	
	;Alert Dismiss
	alertDismiss()
	{
		This.wb.SwitchToalert.dismiss()
	}

	;Switch to Frames
	switchFrames(elementSelection)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				path := This.wb.findElementByID(elementSelection[3])
				This.wb.switchToFrame(path)
			}
			else if(elementSelection[2] = "Name")
			{
				path := This.wb.findElementByname(elementSelection[3])
				This.wb.switchToFrame(path)
			}
			else if(elementSelection[2] = "xpath")
			{
				path := This.wb.findElementByxpath(elementSelection[3])
				This.wb.switchToFrame(path)
			}
			else if(elementSelection[2] = "class")
			{
				path := This.wb.findElementByclass(elementSelection[3])
				This.wb.switchToFrame(path)
			}
		}
		else
		{
		}
	}
	
	
	;Switchtoparentframe
	switchToParentFrame()
	{
		This.wb.SwitchToDefaultContent()
	}
	
	;To pass key stroke
	
	KeyStroke(elementSelection)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				This.wb.findelementByid(elementSelection[3]).sendkeys(This.wb.keys.Enter)
			}
			else if(elementSelection[2] = "xpath")
			{
				This.wb.findElementByxpath(elementSelection[3]).sendkeys(This.wb.keys.Enter)
			}
			else if(elementSelection[2] = "Name")
			{
				This.wb.findelementByName(elementSelection[3]).sendkeys(This.wb.keys.Enter)
			}
			else if(elementSelection[2] = "class")
			{
				This.wb.findElementByclass(elementSelection[3]).sendkeys(This.wb.elementValue)
			}
			else if(elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				ReadValue := This.wb.FindElementByxpath(path).sendkeys(This.wb.keys.Enter)
			}
		}
		else 
		{
		
		}
	}
	
	tabKey(elementSelection)
	{
		If(elementSelection[1] = "fe")
		{
			if(elementSelection[2] = "ID")
			{
				This.wb.findelementByid(elementSelection[3]).sendkeys(This.wb.keys.TAB)
			}
			else if(elementSelection[2] = "xpath")
			{
				This.wb.findElementByxpath(elementSelection[3]).sendkeys(This.wb.keys.TAB)
			}
			else if(elementSelection[2] = "Name")
			{
				This.wb.findelementByName(elementSelection[3]).sendkeys(This.wb.keys.TAB)
			}
			else if(elementSelection[2] = "class")
			{
				This.wb.findElementByclass(elementSelection[3]).sendkeys(This.wb.elementValue)
			}
			else if(elementSelection[2] = "tagname")
			{
				path := "//" . elementSelection[4] "[@" . elementSelection[5] . "='" . elementSelection[3] . "']"
				ReadValue := This.wb.FindElementByxpath(path).sendkeys(This.wb.keys.TAB)
			}
		}
		else 
		{
		}
	}
	executeScript(script)
	{
		This.wb.executeScript(script)
	}
	__Delete()
	{
		This.wb.quit()
	}
}
	