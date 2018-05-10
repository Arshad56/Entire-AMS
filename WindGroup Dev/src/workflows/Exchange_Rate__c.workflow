<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Field_on_Exchange_Rate</fullName>
        <field>Duplicate_Check__c</field>
        <formula>TEXT(Currency_Code__c)+ TEXT(DATEVALUE( Start_Date_Time__c ))+ TEXT(Applicable_Function__c)</formula>
        <name>Update Field on Exchange Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Duplicate_Check</fullName>
        <actions>
            <name>Update_Field_on_Exchange_Rate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
