public with sharing class DummyLOIReportInterfaceController {
	public List<MainWrapper> mainWrapper{get;set;}
	public List<LPStructure> lpWrapper{get;set;}
	public List<Lease_Plan__c> listLP{get;set;}
	public Boolean showInterface{get;set;}
	public Decimal totalForecastAmount{get;set;}
	List<Units__c> listUnit;
	Set<String> ids;
	Integer currentYear;
	Map<Integer,String> monthMap;
	public Units__c unitUI{get;set;}
	public Lease_Plan__c leasePlanUI{get;set;}
	public String selectedYear{get;set;} 
	public List<SelectOption> getYearOptions(){
		List < SelectOption > options = new List < SelectOption > ();
		Integer tempYear = 2009;
		for(Integer i=0; i<=10;i++){
			options.add(new SelectOption(++tempYear+'', tempYear+''));
		}
        return options;
	}
	public List<SelectOption> getStatusOptions(){
		List<SelectOption> options = new List<SelectOption>();
	    Schema.DescribeFieldResult fieldResult =   Lease_Plan__c.Status__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	    options.add(new SelectOption('All','All'));     
	    for( Schema.PicklistEntry f : ple){
	      options.add(new SelectOption(f.getLabel(), f.getValue()));
	    }     
        return options;
	}
    public DummyLOIReportInterfaceController(){
    	leasePlanUI= new Lease_Plan__c();
    	unitUI = new Units__c();
    	ids = new Set<String>();
    	ids.add('a03O000000Hq0bR');
    	ids.add('a03O000000Hq0c6'); 
    	ids.add('a03O000000Hq0aj');
    	ids.add('a03O000000Hqr73');
    	ids.add('a03O000000Hqr75');
    	ids.add('a03O000000Hqr72');
    	ids.add('a03O000000HqrVX');
    	ids.add('a03O000000Hqree');
    	ids.add('a03O000000HqvIY');
    	
    	mainWrapper = new List<MainWrapper>();
    	lpWrapper = new List<LPStructure>();
    	
    	monthMap= new Map<Integer,String>();
    	monthMap.put(1,'JAN'); 
    	monthMap.put(2,'FEB');
    	monthMap.put(3,'MAR');
    	monthMap.put(4,'APR');
    	monthMap.put(5,'MAY');
    	monthMap.put(6,'JUN');
    	monthMap.put(7,'JUL');
    	monthMap.put(8,'AUG');
    	monthMap.put(9,'SEP');
    	monthMap.put(10,'OCT');
    	monthMap.put(11,'NOV');
    	monthMap.put(12,'DEC');
    	
    	selectedYear = System.Today().Year()+'';
    }
    
    public void Generate(){
    	mainWrapper = new List<MainWrapper>();
    	lpWrapper = new List<LPStructure>();
    	showInterface = false;
     	
    	if(unitUI.Property__c != null){
	    	currentYear = Integer.valueof(selectedYear);
	    	System.debug('unitUI.Property__c==>'+unitUI.Property__c);
	    	System.debug('selectedYear==>'+selectedYear);
	    	System.debug('leasePlanUI.Status__c==>'+leasePlanUI.Status__c);
	    	
	    	System.debug('unitUI==>'+unitUI);
	    	totalForecastAmount = 0;
	    	mainWrapper = new List<MainWrapper>();
	    	lpWrapper = new List<LPStructure>();
	    	
	    	date myDate = date.newInstance(currentYear, 1, 1);
	    	date endDate = date.newInstance(currentYear+2, 1, 1);
	    	System.debug('currentYear==>'+currentYear);
	    	System.debug('myDate==>'+myDate);
	    	System.debug('endDate==>'+endDate);
	    	
	    	String  soqlQueryUnit = 'select Name,Start_Date__c,End_Date__c,Property__r.Name from Units__c where CreatedDate != null ';
	    	if(unitUI.Property__c != null){
	    		soqlQueryUnit += ' And Property__c = \''+unitUI.Property__c+'\'';
	    	}
	    	if(unitUI.Level__c != null){
	    		soqlQueryUnit += ' And Level__c =  \''+unitUI.Level__c+'\'';
	    	}
	    	//listUnit =[select Name,Start_Date__c,End_Date__c,Property__r.Name from Units__c where id =: ids];
	    	System.debug('soqlQueryUnit--->'+soqlQueryUnit);
	    	listUnit = database.query(soqlQueryUnit);
	    	if(listUnit.size() > 0){
		    	String idString = '(\'';
		    	for(Units__c lu:listUnit){
		    		idString += lu.Id + '\',\'';
		    	}
		    	idString = idString.substring(0,idString.length()-2); //<--this is the bit I hate doing
				idString += ')';
		
		    	String  soqlQueryLP = 'select Start_Date__c, End_Date__c , Unit__c, Monthly_Budget__c, Status__c,Unit__r.NLA_SQF__c from Lease_Plan__c where Start_Date__c != null And End_Date__c != null';
		    	soqlQueryLP += ' And Unit__c  IN '+idString;
		    	
		    	if(leasePlanUI.Status__c != 'All'){
		    		soqlQueryLP += ' And Status__c  = \''+ leasePlanUI.Status__c +'\'';
		    	}
		    	
		    	soqlQueryLP += ' And Start_Date__c >= '+string.valueOf(myDate)+' And End_Date__c < '+string.valueOf( endDate)+' Order By Start_Date__c Asc';
		    	//listLP = [select Start_Date__c, End_Date__c , Unit__c, Monthly_Budget__c, Status__c,Unit__r.NLA_SQF__c from Lease_Plan__c where Unit__c  =: ids And Start_Date__c >=: myDate And End_Date__c <: endDate And Start_Date__c != null And End_Date__c != null Order By Start_Date__c Asc];
		    	System.debug('soqlQueryLP--->'+soqlQueryLP);
		    	listLP = database.query(soqlQueryLP);
		    	
		    	for(Integer i=1; i<=24 ; i++){
		    		LPStructure lpr= new LPStructure();
		    		date newDate = myDate;
					lpr.headerMonth = newDate.Year()+'<br/>'+monthMap.get(newDate.Month());
					myDate = myDate.addMonths(1);
		    		lpWrapper.add(lpr);
		    	}
		    	
		    	Map<Id, List<Lease_Plan__c>> listOfMPLp= new Map<Id, List<Lease_Plan__c>>();
				for(Lease_Plan__c ls: listLP){
					if(ls.Unit__r.NLA_SQF__c == null){
						ls.Unit__r.NLA_SQF__c = 0;
					}
					if(ls.Monthly_Budget__c == null){
						ls.Monthly_Budget__c = 0;
					}
					if(listOfMPLp.containsKey(ls.Unit__c)) {
						List<Lease_Plan__c> tempLpList = listOfMPLp.get(ls.Unit__c);
						tempLpList.add(ls);
						listOfMPLp.put(ls.Unit__c, tempLpList);
					} else {
						listOfMPLp.put(ls.Unit__c, new List<Lease_Plan__c> { ls });
					}
		    	}
				
		    	for(Units__c lu:listUnit){
		    		MainWrapper mw =new MainWrapper();
		    		mw.unit = lu;
		    		for(Integer i=1; i<=24 ; i++){
						LPStructure tt = new LPStructure();
						tt.cellIndex = i;
						tt.colSpan = 1;
						mw.lpstr.add(tt);
					}
		    		if(listOfMPLp.containsKey(lu.Id)){
		    			Decimal totalMnthBdgt=0;
		    			Decimal totalNLA=0;
						Integer preColSpan;
						Integer replaceIndex;
						Lease_Plan__c preLpp = new Lease_Plan__c();
						System.debug('listOfMPLp.get(lu.Id)-->'+listOfMPLp.get(lu.Id));
						Integer i = 0;
		    			for(Lease_Plan__c lpp:listOfMPLp.get(lu.Id)){
		    				i++;
		    				LPStructure str = new LPStructure();
		    				
							str.cellIndex = lpp.Start_Date__c.Month() ;
							if(lpp.Start_Date__c.year() != currentYear){
								str.cellIndex += 12;
							}
							System.debug(' lpp.Start_Date__c-->'+ lpp.Start_Date__c);
							System.debug(currentYear+'str.cellIndex-->'+str.cellIndex);
							str.leasePlan = lpp;
							str.Status = lpp.Status__c;
							str.colSpan = 1;
							replaceIndex = str.cellIndex ;
							String stdt = DateTime.newInstance(lpp.Start_Date__c.year(),lpp.Start_Date__c.month(),lpp.Start_Date__c.day()).format('d/MM/YYYY');
				    		String endt = DateTime.newInstance(lpp.End_Date__c.year(),lpp.End_Date__c.month(),lpp.End_Date__c.day()).format('d/MM/YYYY');
							String tempStr = stdt+' to '+endt + ' &#13 Mnthly Rent $ ' + lpp.Monthly_Budget__c;
							str.bgColor = (lpp.Status__c == 'Vacant') ? 'rgba(204, 0, 0, 0.57) !important' :( (lpp.Status__c == 'LOI') ? 'rgba(58, 102, 144, 0.78) !important' : ((lpp.Status__c == 'Committed') ? 'rgba(49, 148, 49, 0.75) !important' : 'rgba(229, 193, 48, 0) !important'));
							str.cellText = (lpp.Status__c == 'Vacant') ? 'Vacant' : ((lpp.Status__c == 'LOI') ? 'LOI: '+tempStr : ((lpp.Status__c == 'Committed') ? 'Lease Commited: '+tempStr : ''));
							mw.lpstr[str.cellIndex-1] = str;
						
		    				if(lpp.Unit__r.NLA_SQF__c != null){
		    					totalNLA += lpp.Unit__r.NLA_SQF__c;
		    				}	
		    				if(lpp.Monthly_Budget__c != null){
		    					totalMnthBdgt += lpp.Monthly_Budget__c;
		    				}
		    			}
		    			mw.avgNLA = totalNLA/listOfMPLp.get(lu.Id).size();
		    			mw.avgMonthBudgt = totalMnthBdgt/listOfMPLp.get(lu.Id).size();
		    		}
		    		mainWrapper.add(mw);
		    	} 
		    	Integer mainWrapSize = mainWrapper.Size();
		    	MainWrapper mmw =new MainWrapper();
		    	mmw.endTab = 1;
		    	mmw.bgColor='rgba(153, 153, 153, 0.67)';
		    	mmw.rowHeader = 'Total NLA';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 1;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Vacant NLA';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 1;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Leased NLA';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 1;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'LOI NLA';
		    	mainWrapper.add(mmw);
		    	
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mmw.bgColor='rgba(153, 153, 153, 0.67)';
		    	mmw.rowHeader = 'Total Budget';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Total Leased Amount';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Total Variance';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Total Vacant Amount';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Total Pending LOI';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Total Forecast Amount';
		    	mainWrapper.add(mmw);
		    	mmw =new MainWrapper();
		    	mmw.endTab = 2;
		    	mmw.hideRow = true;
		    	mmw.rowHeader = 'Total Approved Rent Amt';
		    	mainWrapper.add(mmw);
		    	
		    	for(MainWrapper mw:mainWrapper){
		    		if(mw.endTab != 0){
		    			for(Integer j=1; j<=24 ; j++){
							LPStructure tt = new LPStructure();
							tt.cellIndex = j;
							tt.colSpan = 1;
							mw.lpstr.add(tt);
						}
		    		}
		    	}
		    	//updateList
		    	Integer counterTemp = 0;
		    	for(MainWrapper mw:mainWrapper){
		    		if(mw.endTab == 0){
		    			Integer prevIndex;
			    		String prevVal;
			    		Integer tempCount=1;
			    		
			    		for(Integer i=0; i < mw.lpstr.size(); i++){
			    			
			    			if(mw.lpstr[i].leasePlan != null && mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c > 0 ){
			    				mainWrapper[mainWrapSize].lpstr[i].totalNLA += mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
			    				mainWrapper[mainWrapSize].totalAmount     += mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
			    				
			    				
			    				mainWrapper[mainWrapSize+5].lpstr[i].totalBudget += mw.avgMonthBudgt* mw.avgNLA;
			    				mainWrapper[mainWrapSize+5].totalAmount += mainWrapper[mainWrapSize+5].lpstr[i].totalBudget;
			    				//vacant
			    				if(mw.lpstr[i].leasePlan.Status__c == 'Vacant'){
			    					mainWrapper[mainWrapSize+1].lpstr[i].totalNLA += mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
			    					mainWrapper[mainWrapSize+8].lpstr[i].totalBudget += mw.lpstr[i].leasePlan.Monthly_Budget__c* mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
			    					mainWrapper[mainWrapSize+8].totalAmount += mainWrapper[mainWrapSize+8].lpstr[i].totalBudget;
			    				}
			    				//Lease Committed
			    				if(mw.lpstr[i].leasePlan.Status__c == 'Committed'){
				    				mainWrapper[mainWrapSize+2].lpstr[i].totalNLA += mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
				    				mainWrapper[mainWrapSize+6].lpstr[i].totalBudget += mw.lpstr[i].leasePlan.Monthly_Budget__c* mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
				    				mainWrapper[mainWrapSize+6].totalAmount += mainWrapper[mainWrapSize+6].lpstr[i].totalBudget;
			    				}
			    				
			    				mainWrapper[mainWrapSize+7].lpstr[i].totalBudget += mainWrapper[mainWrapSize+5].lpstr[i].totalBudget - mainWrapper[mainWrapSize+6].lpstr[i].totalBudget;
			    				mainWrapper[mainWrapSize+7].totalAmount += mainWrapper[mainWrapSize+7].lpstr[i].totalBudget;
			    				//LOI
			    				if(mw.lpstr[i].leasePlan.Status__c == 'LOI'){
			    					mainWrapper[mainWrapSize+3].lpstr[i].totalNLA += mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
			    					mainWrapper[mainWrapSize+9].lpstr[i].totalBudget += mw.lpstr[i].leasePlan.Monthly_Budget__c* mw.lpstr[i].leasePlan.Unit__r.NLA_SQF__c;
			    					mainWrapper[mainWrapSize+9].totalAmount += mainWrapper[mainWrapSize+9].lpstr[i].totalBudget;
			    				}
			    				totalForecastAmount += mainWrapper[mainWrapSize+5].totalAmount + mainWrapper[mainWrapSize+6].totalAmount+mainWrapper[mainWrapSize+7].totalAmount+mainWrapper[mainWrapSize+8].totalAmount+mainWrapper[mainWrapSize+9].totalAmount;
			    				System.debug('i-->'+i);
			    				//System.debug('mw.lpstr[i].totalBudget-->'+mw.lpstr[i].totalBudget);
			    			}
			    			
						
								mw.lpstr[i].colSpan = 1;
								
								Date startDatte = mw.lpstr[i].leasePlan.Start_Date__c;
								Date endDatte = mw.lpstr[i].leasePlan.End_Date__c;
								if(tempCount > 1){
									String currentStat = mw.lpstr[prevIndex].leasePlan.Status__c;
									String stdt = DateTime.newInstance(startDatte.year(),startDatte.month(),startDatte.day()).format('d/MM/YYYY');
				    				String endt = DateTime.newInstance(endDatte.year(),endDatte.month(),endDatte.day()).format('d/MM/YYYY');
				    				String LOIStr =  stdt +' to '+ endt +' Mthly Rent $ '+ mw.lpstr[prevIndex].leasePlan.Monthly_Budget__c;
									String cellText = (currentStat == 'Vacant') ? 'Vacant' : ((currentStat == 'LOI') ? 'LOI: '+LOIStr : ((currentStat == 'Committed') ? 'Lease committed: '+LOIStr : ''));
									mw.lpstr[prevIndex].cellText= cellText;
								}
								tempCount = 1;
							 
						}
						counterTemp++;
						//mainWrapper[mainWrapSize].totalAmount = 2800;
		    		}
		    	}
				for(MainWrapper mw:mainWrapper){
		    		if(mw.endTab == 1){
		    			Integer counter = 0;
		    			for(Integer i=0; i < mw.lpstr.size(); i++){
		    				if(mw.lpstr[i].totalNLA != 0){
		    					counter++;
		    					mw.totalAmount += mw.lpstr[i].totalNLA;
		    				}
		    			}
		    			if(counter != 0){
		    				mw.totalAmount /= counter;
		    			}
		    			
		    		}
		    	}
		    	showInterface = true;
	    	}else{
	    		showInterface = false;
	    		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,'No records found for selected Property.'));
	    	}
	    	
    	}else{
    		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select Property.'));
    	}
    	
    }
    public Class MainWrapper{
    	public Units__c unit{get;set;}
    	public Decimal avgMonthBudgt{get;set;}
    	public Decimal avgNLA{get;set;}
    	public Decimal totalAmount{get;set;}
    	public String bgColor{get;set;}
    	public Integer endTab{get;set;}
    	public String rowHeader{get;set;}
    	public List<LPStructure> lpstr{get;set;}
    	public Boolean hideRow{get;set;}
    	
    	public MainWrapper(){
    		unit = new Units__c();
    		avgMonthBudgt = 0;
    		avgNLA = 0;
    		endTab = 0;
    		hideRow = false;
    		lpstr = new List<LPStructure>();
    		rowHeader ='';
    		totalAmount = 0;
    		bgColor = 'rgba(229, 193, 48, 0) !important';
    	}
    }
    public Class LPStructure{
    	public Lease_Plan__c leasePlan{get;set;}
    	public String status{get;set;}
    	public String headerMonth{get;set;}
    	public Integer cellIndex{get;set;}
    	public Integer colSpan{get;set;}
    	public String bgColor{get;set;}
    	public String cellText{get;set;}
    	public Boolean removeCell{get;set;}
    	public Decimal totalNLA{get;set;}
    	public Decimal totalBudget{get;set;}
    	public Decimal recBudget{get;set;}
		
    	public LPStructure(){
    		leasePlan = new Lease_Plan__c();
    		colSpan = 1;
    		cellText = '';
    		bgColor = 'rgba(229, 193, 48, 0) !important';
    		status = '';
    		totalNLA= 0;
    		totalBudget = 0;
    	}
    }
	
    
}