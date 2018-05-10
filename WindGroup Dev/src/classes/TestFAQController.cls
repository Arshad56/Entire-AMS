@isTest
public class TestFAQController {
    @isTest
    static void test(){
        FAQController obj=new FAQController();
        obj.toggleSort();
        obj.runSearch();
        obj.faq='Test';
    }
}