<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_to_Person_In_Charge_Request</fullName>
        <description>Notification to Person In-Charge Request</description>
        <protected>false</protected>
        <recipients>
            <field>Person_In_Charge__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/RequestNewAssignmentNotification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Make_Status_In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Make Status In-Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text</fullName>
        <field>Property_Name_Text__c</field>
        <formula>Property__r.Name</formula>
        <name>Populate Property Name Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Property Name Text</fullName>
        <actions>
            <name>Populate_Property_Name_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(Not(ISBLANK(Property__c)) &amp;&amp; ISNEW() ) || 
(Not(ISBLANK(Property__c)) &amp;&amp; ISCHANGED(Property__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Request Status</fullName>
        <actions>
            <name>Make_Status_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(CreatedDate !=  LastModifiedDate) &amp;&amp;  (PRIORVALUE(LastModifiedDate) == CreatedDate)

&amp;&amp;
TExt ( Status__c )!=&apos;Completed&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
