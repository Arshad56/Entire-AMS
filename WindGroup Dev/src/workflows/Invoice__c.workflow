<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CN_Refund_Approved</fullName>
        <description>CN Refund Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/CN_Refund_Approved</template>
    </alerts>
    <alerts>
        <fullName>CN_Refund_Rejected</fullName>
        <description>CN Refund Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/CN_Refund_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Generate_Invoice_Number</fullName>
        <description>Combination of Property Short Code-Invoice Auto</description>
        <field>Name</field>
        <formula>Lease__r.Property__r.Short_Code__c &amp;&quot;-&quot;&amp; IF(OR(Billing_Type__c = &quot;Debit Note&quot;,Billing_Type__c = &quot;Credit Note&quot;,Billing_Type__c = &quot;Ad-Hoc Invoice&quot;) ,&quot;RA&quot;,&quot;RI&quot;)&amp;&quot;-&quot;&amp;  Rent_Roll__r.Rent_Roll_YYYY__c &amp; Rent_Roll__r.Rent_Roll_MM__c &amp;&quot;-&quot; &amp; Invoice_Index__c</formula>
        <name>Generate Invoice Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Invoice_Refund_Status_Submitted</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Invoice Refund Status Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text_Invoice</fullName>
        <field>Property_Name_Text__c</field>
        <formula>IF(Lease__c!=null,Lease__r.Property__r.Name,Property_Name__r.Name)</formula>
        <name>Populate Property Name Text Invoice</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Approved_Amount</fullName>
        <field>Approved_Amount__c</field>
        <formula>Requested_Amount__c</formula>
        <name>Set Approved Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Foreign_RecordType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Foreign</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Foreign RecordType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Invoice_Status_as_Outstanding</fullName>
        <description>Update Invoice Status as Outstanding</description>
        <field>Status__c</field>
        <literalValue>Outstanding</literalValue>
        <name>Update Invoice Status as Outstanding</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Invoice_Status_as_Paid</fullName>
        <description>Update when Outstanding Amount is 0</description>
        <field>Status__c</field>
        <literalValue>Paid</literalValue>
        <name>Update Invoice Status as Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Local_RecordType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Local</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Local RecordType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Refund_Status_To_Approved</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Refund Status To Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Refund_Status_To_Rejected</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Refund Status To Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_as_Partially_Paid</fullName>
        <description>When invoice is partially paid i.e. Outstanding is not 0 yet</description>
        <field>Status__c</field>
        <literalValue>Partially Paid</literalValue>
        <name>Update Status as Partially Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>make_Refund_Status_Submitted</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>make Refund Status Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Generate Invoice Number</fullName>
        <actions>
            <name>Generate_Invoice_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Invoice__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Invoice__c.Billing_Type__c</field>
            <operation>notEqual</operation>
            <value>Miscellaneous</value>
        </criteriaItems>
        <description>Combination of Property Short Code-Invoice Auto</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Foreign RecordType</fullName>
        <actions>
            <name>Update_Foreign_RecordType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This works when Currency Code on Invoice is Non-MMK!</description>
        <formula>IF(AND(NOT(ISPICKVAL(Currency_Code__c,&apos;MMK&apos;)) , OR(ISNEW() , ISCHANGED(Currency_Code__c))),true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Local RecordType</fullName>
        <actions>
            <name>Update_Local_RecordType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This works when Currency Code on Invoice is &apos;MMK&apos;</description>
        <formula>IF(AND(ISPICKVAL(Currency_Code__c,&apos;MMK&apos;) , OR(ISNEW() , ISCHANGED(Currency_Code__c))),true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Property Name Text Invoice</fullName>
        <actions>
            <name>Populate_Property_Name_Text_Invoice</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISNEW(),ISCHANGED(Lease__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status as Outstanding</fullName>
        <actions>
            <name>Update_Invoice_Status_as_Outstanding</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Invoice__c.Amount_Paid__c</field>
            <operation>equals</operation>
            <value>,0</value>
        </criteriaItems>
        <description>Update Status as Outstanding when Amount Paid is 0</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status as Paid</fullName>
        <actions>
            <name>Update_Invoice_Status_as_Paid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Status as Paid when Outstanding Amount is 0</description>
        <formula>AND ( 
NOT (ISNEW()),
NOT( ISPICKVAL(Status__c, &quot;Cancelled&quot;)),
Outstanding_Amount__c = 0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status as Partially Paid</fullName>
        <actions>
            <name>Update_Status_as_Partially_Paid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Status as Partially Paid when Invoice is Partially Paid (Outstanding Amount is not 0 yet)</description>
        <formula>AND ( 
NOT (ISNEW()),
NOT( ISPICKVAL(Status__c, &quot;Cancelled&quot;)),
Outstanding_Amount__c &gt; 0, 
 Outstanding_Amount__c  &lt;  Total_Amount__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
