public class OCRProcessing_Controller {
	//public String respBody{get;set;}
	public List<String> responseTest{get;set;}
    public OCRProcessing_Controller(){
    	responseTest = new List<String>();
    }
    public void processImage(){
    	Document sr = [SELECT Body,Id,Name,Type FROM Document WHERE Name = 'SampleImage' Limit 1];		        
    	String b64String = EncodingUtil.base64Encode(sr.Body);				
    	String hexString = EncodingUtil.convertToHex(sr.Body);				
    	//system.debug('\n= '+b64String +'\n hex= '+hexString);	
    	string requestBody  = '{"requests": [{"image": {"content": "'+b64String+'"},"features": [{"type": "TEXT_DETECTION"}]}]}';
    	
    	Http http = new Http();
    	
    	HttpRequest  request = new HttpRequest();		        
    	request.setMethod('POST');
    	request.setEndpoint('https://vision.googleapis.com/v1/images:annotate?key=AIzaSyAJQjoA0B3mYEwvDSo7NuEFBEN7rrHxrPA');
    	
		request.setTimeout(120000);		        
    	request.setHeader('Content-Type', 'application/json');
    	//request.setHeader('content-length',requestBody.length());
    	request.setBody(requestBody);
    	
    	 
    	system.debug('\nrequest = ' + request);
    	system.debug('\n\nrequest = ' + request.getBody()+'\n\n');
    	
    	HttpResponse response = http.send(request);	
    	 	        
    	String strResponse = response.getBody();
    	//strResponse.replaceAll('\n', '<br/>');
    	
    	JSON2Apex jsonApex = JSON2Apex.parse(strResponse+'');
    	
    	responseTest = new List<String>();
    	for(JSON2Apex.cls_responses resp : jsonApex.responses){
            for(JSON2Apex.cls_textAnnotations ann:resp.textAnnotations){
            	System.debug('ann:' + ann.description);
            	
            	String tempStr = ann.description;
            	System.debug('tempStr11:' + tempStr);
            	
            	tempStr.replace('\n','<br/>');
            	System.debug('tempStr22:' + tempStr);
            	
            	responseTest.add(tempStr);
            }
            System.debug('--------------------------------');
        }
    }
    public void check(){
    	for(String tt:responseTest){
    		System.debug('tt-->'+tt);
    	}
    }
    public void detectLabel(){
    	Document sr = [SELECT Body,Id,Name,Type FROM Document WHERE Name = 'SampleImage' Limit 1];		        
    	String b64String = EncodingUtil.base64Encode(sr.Body);				
    	String hexString = EncodingUtil.convertToHex(sr.Body);				
    	//system.debug('\n= '+b64String +'\n hex= '+hexString);	
    	string requestBody  = '{"requests": [{"image": {"content": "'+b64String+'"},"features": [{"type": "LABEL_DETECTION"}]}]}';
    	
    	Http http = new Http();
    	 
    	HttpRequest  request = new HttpRequest();		        
    	request.setMethod('POST');
    	request.setEndpoint('https://vision.googleapis.com/v1/images:annotate?key=AIzaSyAJQjoA0B3mYEwvDSo7NuEFBEN7rrHxrPA');
    	
		request.setTimeout(120000);		        
    	request.setHeader('Content-Type', 'application/json');
    	//request.setHeader('content-length',requestBody.length());
    	request.setBody(requestBody);
    	
    	 
    	system.debug('\nrequest = ' + request);
    	system.debug('\n\nrequest = ' + request.getBody()+'\n\n');
    	
    	HttpResponse response = http.send(request);	
    	 	        
    	String strResponse = response.getBody();
    	//strResponse.replaceAll('\n', '<br/>');
    	
    	JSON2ApexDetect jsonApex = JSON2ApexDetect.parse(strResponse+'');
    	
    	responseTest = new List<String>();
    	for(JSON2ApexDetect.cls_responses resp : jsonApex.responses){
            for(JSON2ApexDetect.cls_labelAnnotations ann:resp.labelAnnotations){
            	System.debug('ann:' + ann.description);
            	
            	String tempStr = ann.description+' = '+ann.score;
            	System.debug('tempStr11:' + tempStr);
            	
            	tempStr.replace('\n','<br/>');
            	System.debug('tempStr22:' + tempStr);
            	
            	responseTest.add(tempStr);
            }
            System.debug('--------------------------------');
        }
    }
}