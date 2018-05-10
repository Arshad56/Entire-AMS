<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DP_Refund_Approved</fullName>
        <description>DP Refund Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Deposit_Refund_Approved</template>
    </alerts>
    <alerts>
        <fullName>DP_Refund_Rejected</fullName>
        <description>DP Refund Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Deposit_Refund_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Make_Refund_Status_Rejected</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Make Refund Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Make_Status_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Make Status Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Make_status_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Make status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Make_status_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Make status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text</fullName>
        <field>Property_Name_Text__c</field>
        <formula>if(Lease__r.Property__r.Name !=null ,Lease__r.Property__r.Name
,LOI__r.Property__r.Name)</formula>
        <name>Populate Property Name Text</name>
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
        <fullName>Update_Deposit_Description</fullName>
        <field>Description__c</field>
        <formula>&apos;Refundable &apos;+ Text(Deposit_Type__c) +&apos; Deposit&apos;</formula>
        <name>Update Deposit Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Deposit_Status_as_Outstanding</fullName>
        <description>Update Deposit Status as Outstanding</description>
        <field>Status__c</field>
        <literalValue>Outstanding</literalValue>
        <name>Update Deposit Status as Outstanding</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Deposit_Status_as_Paid</fullName>
        <description>Update Deposit Status as Paid</description>
        <field>Status__c</field>
        <literalValue>Paid</literalValue>
        <name>Update Deposit Status as Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Deposit_Status_as_Partially_Paid</fullName>
        <description>Update Deposit Status as Partially Paid</description>
        <field>Status__c</field>
        <literalValue>Partially Paid</literalValue>
        <name>Update Deposit Status as Partially Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>make_Refund_Status_Approved</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>make Refund Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>make_Refund_Status_Submitted</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Requested</literalValue>
        <name>make Refund Status Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>make_Refund_Status_To_Approved</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>make Refund Status To Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>make_Refund_Status_To_Rejected</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>make Refund Status To Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>make_Refund_Status_To_Requested</fullName>
        <field>Refund_Status__c</field>
        <literalValue>Requested</literalValue>
        <name>make Refund Status To Requested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Description On Create</fullName>
        <actions>
            <name>Update_Deposit_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deposit__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Deposit Status as Paid</fullName>
        <actions>
            <name>Update_Deposit_Status_as_Paid</name>
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
        <fullName>Update Deposit Status as Partially Paid</fullName>
        <actions>
            <name>Update_Deposit_Status_as_Partially_Paid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Status as Partially Paid when Outstanding Amount is not 0 yet.</description>
        <formula>AND ( 
NOT (ISNEW()), 
NOT( ISPICKVAL(Status__c, &quot;Cancelled&quot;)), 
Outstanding_Amount__c &gt; 0, 
Outstanding_Amount__c &lt;  Deposit_Amount__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Property Name Text</fullName>
        <actions>
            <name>Populate_Property_Name_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Property_Name_Text__c == null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status as Outstanding</fullName>
        <actions>
            <name>Update_Deposit_Status_as_Outstanding</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Deposit__c.Amount_Paid__c</field>
            <operation>equals</operation>
            <value>,0</value>
        </criteriaItems>
        <description>Update Status as Outstanding when Amount Paid is 0</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
