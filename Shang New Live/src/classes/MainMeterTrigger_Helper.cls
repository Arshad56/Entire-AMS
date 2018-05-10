public with sharing class MainMeterTrigger_Helper {
    public static void checkDuplicateMeters(List<Electric_Meter__c> meterList){
		Set<String> meterNo = new Set<String>();
		Set<Id> mtrIds = new Set<Id>();
		Set<Id> unitIds = new Set<Id>();
		for(Electric_Meter__c mtr : meterList){
			if(mtr.Meter_No__c != null && mtr.Status__c == 'Active'){
				meterNo.add(mtr.Meter_No__c);
			}
			if(mtr.Unit__c != null ){
				unitIds.add(mtr.Unit__c);
			}
			mtrIds.add(mtr.Id);
		}
		System.debug('meterNo-->'+meterNo);
		System.debug('mtrIds-->'+mtrIds);
		
		Map<Id, Electric_Meter__c> allMeter = new Map<Id, Electric_Meter__c>([select Id, Name,Meter_Type__c, Meter_No__c,Unit__c, Unit__r.Start_Date__c, Unit__r.End_Date__c from Electric_Meter__c where (Id=: mtrIds OR Meter_No__c =: meterNo) And Status__c = 'Active' And Unit__r.Active__c = true  And (Unit__r.Start_Date__c != null OR Unit__r.End_Date__c != null)]);
		Map<Id, Units__c> unitMap = new Map<Id, Units__c>([select Id, Start_Date__c, End_Date__c, Active__c from Units__c where id =: unitIds And Active__c = true]);
		
		System.debug('unitMap-->'+unitMap);
		for(Electric_Meter__c mtrNw : meterList){
			System.debug('mtrNw-->'+mtrNw);
			if(mtrNw.Unit__c != null && mtrNw.Status__c == 'Active' && unitMap.containsKey(mtrNw.Unit__c)){
				for(Electric_Meter__c mtrOl :allMeter.values()){
					System.debug('mtrNw.Unit__c-->'+mtrNw.Unit__c);
					if(unitMap.get(mtrNw.Unit__c).Start_Date__c != null && unitMap.get(mtrNw.Unit__c).End_Date__c != null && mtrOl.Unit__r.Start_Date__c!= null && mtrOl.Unit__r.End_Date__c != null){
						System.debug('mtrOl.Id-->'+mtrOl.Id);
						System.debug('mtrOl.Meter_No__c-->'+mtrOl.Meter_No__c);
						System.debug('unitMap.get(mtrNw.Unit__c).Start_Date__c-->'+unitMap.get(mtrNw.Unit__c).Start_Date__c);
						System.debug('mtrOl.Unit__r.Start_Date__c-->'+mtrOl.Unit__r.Start_Date__c);
						System.debug('unitMap.get(mtrNw.Unit__c).End_Date__c-->'+unitMap.get(mtrNw.Unit__c).End_Date__c);
						System.debug('mtrOl.Unit__r.End_Date__c-->'+mtrOl.Unit__r.End_Date__c);
						 
						System.debug('1st-->'+(unitMap.get(mtrNw.Unit__c).Start_Date__c <= mtrOl.Unit__r.Start_Date__c && unitMap.get(mtrNw.Unit__c).End_Date__c >= mtrOl.Unit__r.Start_Date__c));
						System.debug('2nd-->'+(unitMap.get(mtrNw.Unit__c).Start_Date__c <= mtrOl.Unit__r.End_Date__c && unitMap.get(mtrNw.Unit__c).End_Date__c >= mtrOl.Unit__r.Start_Date__c));
						System.debug('3rd-->'+(unitMap.get(mtrNw.Unit__c).End_Date__c >= mtrOl.Unit__r.Start_Date__c && unitMap.get(mtrNw.Unit__c).End_Date__c <= unitMap.get(mtrNw.Unit__c).End_Date__c));
						if(mtrNw.Id != mtrOl.Id && mtrNw.Meter_No__c == mtrOl.Meter_No__c && mtrNw.Meter_Type__c == mtrOl.Meter_Type__c){
							if(unitMap.get(mtrNw.Unit__c).Start_Date__c <= mtrOl.Unit__r.Start_Date__c && unitMap.get(mtrNw.Unit__c).End_Date__c >= mtrOl.Unit__r.Start_Date__c){
								mtrNw.addError(' Meter: "'+mtrOl.Meter_No__c+'" for this duration is already active.<br/>Please click on <a target="_blank" href="/'+mtrOl.Id+'">'+mtrOl.Name+'</a> to view details.',false);
							}else if(unitMap.get(mtrNw.Unit__c).Start_Date__c <= mtrOl.Unit__r.End_Date__c && unitMap.get(mtrNw.Unit__c).End_Date__c >= mtrOl.Unit__r.Start_Date__c){
								mtrNw.addError(' Meter: "'+mtrOl.Meter_No__c+'" for this duration is already active.<br/>Please click on <a target="_blank" href="/'+mtrOl.Id+'">'+mtrOl.Name+'</a> to view details.',false);
							}else if(unitMap.get(mtrNw.Unit__c).Start_Date__c >= mtrOl.Unit__r.Start_Date__c && unitMap.get(mtrNw.Unit__c).End_Date__c <= mtrOl.Unit__r.Start_Date__c){
								mtrNw.addError(' Meter: "'+mtrOl.Meter_No__c+'" for this duration is already active.<br/>Please click on <a target="_blank" href="/'+mtrOl.Id+'">'+mtrOl.Name+'</a> to view details.',false);
							}
						}	
					}
				} 
			}
		}
		Integer i = 0;
		for(Integer j= 0; j< 10; j++){
			i=j;
		}
		i=10;
		for(Integer j= 0; j< 10; j++){
			i=j;
		}
		i=10;
	}
}