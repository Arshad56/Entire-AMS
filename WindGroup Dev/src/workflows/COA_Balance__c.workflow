<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_COA_Balance_Name</fullName>
        <field>Name</field>
        <formula>Fiscal_Period__r.Name &amp;&quot;-&quot;&amp; COA_Master__r.Name</formula>
        <name>Update COA Balance Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Balance ID %2F Name field</fullName>
        <actions>
            <name>Update_COA_Balance_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>COA_Balance__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Concatenate Fiscal Period &amp; COA Master (Account #)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
