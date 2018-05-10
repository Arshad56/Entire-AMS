<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text</fullName>
        <field>Property_Name_Text__c</field>
        <formula>Property_Lookup__r.Name</formula>
        <name>Populate Property Name Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Space_Type_Text</fullName>
        <field>Space_Type_Text__c</field>
        <formula>Text(Unit__r.Space_Type__c )</formula>
        <name>Populate Space Type Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_LOI_Unit_End_Date</fullName>
        <field>End_Date__c</field>
        <formula>Unit__r.End_Date__c</formula>
        <name>Update LOI Unit End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_LOI_Unit_Start_Date</fullName>
        <field>Start_Date__c</field>
        <formula>Unit__r.Start_Date__c</formula>
        <name>Update LOI Unit Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Property Name And Space Type Text</fullName>
        <actions>
            <name>Populate_Property_Name_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Space_Type_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LOI_Unit_Template__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update LOI Unit End Date</fullName>
        <actions>
            <name>Update_LOI_Unit_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LOI_Unit_Template__c.End_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>This is used to update End Date from Lease End Date (Provided End Date is Blank)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update LOI Unit Start Date</fullName>
        <actions>
            <name>Update_LOI_Unit_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LOI_Unit_Template__c.Start_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>This is used to update Start Date from Lease Start Date (Provided Start Date is Blank)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
