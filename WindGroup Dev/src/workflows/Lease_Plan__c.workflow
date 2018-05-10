<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Assign_Daily_RT</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Daily</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Assign Daily RT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assign_Monthly_RT</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Monthly</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Assign Monthly RT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Lease Plan Daily Record Type Assignment</fullName>
        <actions>
            <name>Assign_Daily_RT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>INCLUDES(Unit__r.Charge_Method__c , &apos;Daily Rate&apos;) &amp;&amp;  Not(Ispickval(Unit__r.Space_Type__c,&apos;Ad Panel&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lease Plan Monthly Record Type Assignment</fullName>
        <actions>
            <name>Assign_Monthly_RT</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>INCLUDES(Unit__r.Charge_Method__c,&apos;Monthly Rate - CL&apos;) || INCLUDES(Unit__r.Charge_Method__c, &apos;Monthly Rate - L&apos;) ||
Ispickval(Unit__r.Space_Type__c,&apos;Ad Panel&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
