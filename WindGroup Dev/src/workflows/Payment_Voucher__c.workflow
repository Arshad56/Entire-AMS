<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PV_Refund_Approved</fullName>
        <description>PV Refund Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Payment_Voucher_Refund_Approved</template>
    </alerts>
    <alerts>
        <fullName>PV_Refund_Rejected</fullName>
        <description>PV Refund Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Payment_Voucher_Refund_Rejected</template>
    </alerts>
    <alerts>
        <fullName>PV_Void_Appproved</fullName>
        <description>PV Void Appproved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Payment_Voucher_Void_Approved</template>
    </alerts>
    <alerts>
        <fullName>PV_Void_Rejected</fullName>
        <description>PV Void Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Payment_Voucher_Void_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text_PV</fullName>
        <description>To populate Property Name Text in PV.</description>
        <field>Property_Name_Text__c</field>
        <formula>Property_Name__c</formula>
        <name>Populate Property Name Text PV</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Refunded_Amount</fullName>
        <field>Refunded_Amount__c</field>
        <formula>Refunded_Amount__c +  Outstanding_Amount__c</formula>
        <name>Refunded Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_PV_Status</fullName>
        <field>Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Update PV Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Void</fullName>
        <field>Status__c</field>
        <literalValue>Void</literalValue>
        <name>Update Status to Void</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Void</fullName>
        <field>Void__c</field>
        <literalValue>0</literalValue>
        <name>Update Void</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Property Name Text PV</fullName>
        <actions>
            <name>Populate_Property_Name_Text_PV</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>To populate Property Name Text in PV for data sharing.</description>
        <formula>OR(ISNEW(),ISCHANGED( Property_Name__c ), ISBLANK( Property_Name_Text__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
