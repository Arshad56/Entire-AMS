<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Amount_Paid_Local</fullName>
        <field>Amount_Paid_Local_WF__c</field>
        <formula>Amount_Paid_Local__c</formula>
        <name>Update Amount Paid (Local)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Amount Paid %28Local%29</fullName>
        <actions>
            <name>Update_Amount_Paid_Local</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Cash_Receipt__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update Amount Paid (Local) from formula field to Currency for Roll-Up on CR</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
