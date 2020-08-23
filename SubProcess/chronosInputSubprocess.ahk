splitChronosData(jsonConverter,orderDetails)
{
	try
	{
		chronosInputdata := {}
		userInput := jsonConverter.Parse(orderDetails)
		i := 1
		Loop % userInput.MaxIndex()
		{
			temp := {}
			telephone := userInput[i]["TN OC"]
			mirorOldRecord := userInput[i]["OLD RECORD"]
			mirorFromRecord := userInput[i]["FROM RECORD"]

			oldTiePair :=  userInput[i]["OLD TIE PAIR"]
			ocScenario := userInput[i]["ORDER CORRECTION"]

			outOrderNumber := userInput[i]["OUT ORDER NUMBER"]
			mssErrorMessage := userInput[i]["MSS ERROR MESSAGE"]
			mssComments := userInput[i]["COMMENTS"]
			nbnTN := userInput[i]["NBN TN"]
			psr := userInput[i]["PSR"]
			mirorDW := userInput[i]["DW"]

			firstName := userInput[i]["MSS FIRST NAME"]
			middleName := userInput[i]["MSS INITIAL NAME"]
			lastName := userInput[i]["MSS LAST NAME"]
			cableTech := userInput[i]["CABLE TECH"]

			wwBoid := userInput[i]["WW BOID"]
			wwBex := userInput[i]["WW BEX"]
			wwOrderNumber := userInput[i]["WW ORDER"]
			
			primarypicIpic := userInput[i]["Racksheet primary"]["PIC/IPIC"]
			primarytelePhoneIn := userInput[i]["Racksheet primary"]["Telephone# IN"]
			primarytelePhoneOut := userInput[i]["Racksheet primary"]["Telephone# OUT"]
			primarymirorGradeIn := userInput[i]["Racksheet primary"]["Mirror Grade IN"]
			primarymirorGradeOut := userInput[i]["Racksheet primary"]["Mirror Grade OUT"]
			primaryMirrorWcIn := userInput[i]["Racksheet primary"]["Mirror WC IN"]
			primaryMirrorWcOut := userInput[i]["Racksheet primary"]["Mirror WC OUT"]
			primarycoeIn := userInput[i]["Racksheet primary"]["COE IN"]
			primarycoeOut := userInput[i]["Racksheet primary"]["COE OUT"]
			primarymdfPairIn := userInput[i]["Racksheet primary"]["MDF/Pair IN"]
			primarymdfPairOut := userInput[i]["Racksheet primary"]["MDF/Pair OUT"]
			primaryframeTiePairIn := userInput[i]["Racksheet primary"]["Frame Tie Pair#1 IN"]
			primaryframeTiePairOut := userInput[i]["Racksheet primary"]["Frame Tie Pair#1 OUT"]
			primaryloopTreatIn := userInput[i]["Racksheet primary"]["Loop Treatment#1 BLK/PIN IN"]
			primaryloopTreatOut := userInput[i]["Racksheet primary"]["Loop Treatment#1 BLK/PIN OUT"]
			primarylineEquipmentIn := userInput[i]["Racksheet primary"]["Line Equipment IN"]
			primarylineEquipmentOut := userInput[i]["Racksheet primary"]["Line Equipment OUT"]
			primarytechWillCall := userInput[i]["Racksheet primary"]["Tech Will Call"]
			
			bondedpicIpic := userInput[i]["Racksheet Bonded"]["PIC/IPIC"]
			bondedtelePhoneIn := userInput[i]["Racksheet Bonded"]["Telephone# IN"]
			bondedtelePhoneOut := userInput[i]["Racksheet Bonded"]["Telephone# OUT"]
			bondedmirorGradeIn := userInput[i]["Racksheet Bonded"]["Mirror Grade IN"]
			bondedmirorGradeOut := userInput[i]["Racksheet Bonded"]["Mirror Grade OUT"]
			bondedMirrorWcIn := userInput[i]["Racksheet Bonded"]["Mirror WC IN"]
			bondedMirrorWcOut := userInput[i]["Racksheet Bonded"]["Mirror WC OUT"]
			bondedcoeIn := userInput[i]["Racksheet Bonded"]["COE IN"]
			bondedcoeOut := userInput[i]["Racksheet Bonded"]["COE OUT"]
			bondedmdfPairIn := userInput[i]["Racksheet Bonded"]["MDF/Pair IN"]
			bondedmdfPairOut := userInput[i]["Racksheet Bonded"]["MDF/Pair OUT"]
			bondedframeTiePairIn := userInput[i]["Racksheet Bonded"]["Frame Tie Pair#1 IN"]
			bondedframeTiePairOut := userInput[i]["Racksheet Bonded"]["Frame Tie Pair#1 OUT"]
			bondedloopTreatIn := userInput[i]["Racksheet Bonded"]["Loop Treatment#1 BLK/PIN IN"]
			bondedloopTreatOut := userInput[i]["Racksheet Bonded"]["Loop Treatment#1 BLK/PIN OUT"]
			bondedlineEquipmentIn := userInput[i]["Racksheet Bonded"]["Line Equipment IN"]
			bondedlineEquipmentOut := userInput[i]["Racksheet Bonded"]["Line Equipment OUT"]
			bondedtechWillCall := userInput[i]["Racksheet Bonded"]["Tech Will Call"]
			
			temp := {"telephone":telephone,"mirorOldRecord":mirorOldRecord,"mirorFromRecord":mirorFromRecord,"oldTiePair":oldTiePair,"ocScenario":ocScenario,"outOrderNumber":outOrderNumber,"mssErrorMessage":mssErrorMessage,"mssComments":mssComments,"firstName":firstName,"middleName":middleName,"lastName":lastName,"wwBoid":wwBoid,"wwBex":wwBex,"wwOrderNumber":wwOrderNumber,"cableTech":cableTech,"nbnTN":nbnTN,"psr":psr,"primarypicIpic":primarypicIpic,"primarytelePhoneIn":primarytelePhoneIn,"primarytelePhoneOut":primarytelePhoneOut,"primarymirorGradeIn":primarymirorGradeIn,"primarymirorGradeOut":primarymirorGradeOut,"primaryMirrorWcIn":primaryMirrorWcIn,"primaryMirrorWcOut":primaryMirrorWcOut,"primarycoeIn":primarycoeIn,"primarycoeOut":primarycoeOut,"primarymdfPairIn":primarymdfPairIn,"primarymdfPairOut":primarymdfPairOut,"primaryframeTiePairIn":primaryframeTiePairIn,"primaryframeTiePairOut":primaryframeTiePairOut,"primaryloopTreatIn":primaryloopTreatIn,"primaryloopTreatOut":primaryloopTreatOut,"primarylineEquipmentIn":primarylineEquipmentIn,"primarylineEquipmentOut":primarylineEquipmentOut,"primarytechWillCall":primarytechWillCall,"bondedpicIpic":bondedpicIpic,"bondedtelePhoneIn":bondedtelePhoneIn,"bondedtelePhoneOut":bondedtelePhoneOut,"bondedmirorGradeIn":bondedmirorGradeIn,"bondedmirorGradeOut":bondedmirorGradeOut,"bondedMirrorWcIn":bondedMirrorWcIn,"bondedMirrorWcOut":bondedMirrorWcOut,"bondedcoeIn":bondedcoeIn,"bondedcoeOut":bondedcoeOut,"bondedmdfPairIn":bondedmdfPairIn,"bondedmdfPairOut":bondedmdfPairOut,"bondedframeTiePairIn":bondedframeTiePairIn,"bondedframeTiePairOut":bondedframeTiePairOut,"bondedloopTreatIn":bondedloopTreatIn,"bondedloopTreatOut":bondedloopTreatOut,"bondedlineEquipmentIn":bondedlineEquipmentIn,"bondedlineEquipmentOut":bondedlineEquipmentOut,"bondedtechWillCall":bondedtechWillCall,"mirorDW":mirorDW}

			chronosInputdata.push(temp)
			i++
		}
		return chronosInputdata
	}
	catch e
	{
		e := "system exception:Bot failed to split chronos input"
	}
}