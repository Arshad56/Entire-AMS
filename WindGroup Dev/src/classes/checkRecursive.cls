public Class checkRecursive{
	@TestVisible private static boolean run = true;
	private static boolean runForCalPercent = true;
	
	private static boolean runDeposit = true;
    public static boolean runDepositOnce(){
    if(runDeposit){
     runDeposit=false;
     return true;
    }else{
        return runDeposit;
    }
    }
    public static boolean runDepositAlready(){
    	System.debug('runDeposit-->'+runDeposit);
    	return runDeposit;
    }
 	public static boolean runOnce(){
 		System.debug('run-->'+run);
 		if(run){
			run=false;
			return true;
 		}else{
			return run;
 		}
 	}
 	public static boolean runAlready(){
 		run=true;
		return false;
 	}
 	public static boolean makeRunTrue(){
 		System.debug('runTT-->'+run);
 		run=true;
		return true;
 	}
 	
}