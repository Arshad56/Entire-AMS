<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_LOI_checkbox</fullName>
        <field>Update_LOI_Plans__c</field>
        <literalValue>1</literalValue>
        <name>Update LOI checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Make Checkbox True</fullName>
        <actions>
            <name>Update_LOI_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LOI_Unit__c.Update_LOI_Plans__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Update Lease Plan Checkbox on Lease Unit</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
