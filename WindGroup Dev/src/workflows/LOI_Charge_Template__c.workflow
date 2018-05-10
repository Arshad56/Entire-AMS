<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text</fullName>
        <field>Property_Name_Text__c</field>
        <formula>LOI_Unit_Template__r.Property_Lookup__r.Name</formula>
        <name>Populate Property Name Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Space_Type_Text</fullName>
        <field>Space_Type_Text__c</field>
        <formula>Text(LOI_Unit_Template__r.Unit__r.Space_Type__c)</formula>
        <name>Populate Space Type Text</name>
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
            <field>LOI_Charge_Template__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
