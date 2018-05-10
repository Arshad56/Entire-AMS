<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_To_approve_Rent_Roll</fullName>
        <description>Notification: To approve Rent Roll</description>
        <protected>false</protected>
        <recipients>
            <recipient>wind@techmatrixconsulting.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/Notification_To_approve_Rent_Roll</template>
    </alerts>
    <alerts>
        <fullName>Notification_To_issue_Invoices</fullName>
        <description>Notification: To issue Invoices</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/Notification_To_issue_Invoices</template>
    </alerts>
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text_RentRoll</fullName>
        <field>Property_Name_Text__c</field>
        <formula>Property__r.Name</formula>
        <name>Populate Property Name Text RentRoll</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Rent Roll notification process</fullName>
        <active>false</active>
        <description>to notify Finance when Rent Roll is created.</description>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Property Name Text Rent Roll</fullName>
        <actions>
            <name>Populate_Property_Name_Text_RentRoll</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISNEW(),ISCHANGED(Property__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
