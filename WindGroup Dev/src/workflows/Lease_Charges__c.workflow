<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Base_Rent</fullName>
        <field>Base_Rent__c</field>
        <formula>Base_Rent_Calculation__c</formula>
        <name>Base Rent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Expected_Amount</fullName>
        <field>Expected_Amount__c</field>
        <formula>Expected_Charge__c</formula>
        <name>Update Expected Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Expected Amount</fullName>
        <actions>
            <name>Base_Rent</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Expected_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease_Charges__c.Active__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
