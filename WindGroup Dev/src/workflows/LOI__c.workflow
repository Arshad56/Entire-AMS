<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Property_Name_Text</fullName>
        <field>Property_Name_Text__c</field>
        <formula>Property__r.Name</formula>
        <name>Populate Property Name Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Revised_End_Date</fullName>
        <field>Original_End_Date__c</field>
        <formula>LOI_End_Date__c</formula>
        <name>Populate Revised End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Validity_Date</fullName>
        <field>LOI_Validity_Date__c</field>
        <formula>(Case(Text(LOI_Validity_Week__c ),
&apos;One Week&apos;,1,
&apos;Two Week&apos;,2,
&apos;Three Week&apos;,3,
&apos;Four Week&apos;,4,
&apos;Five Week&apos;,5,
&apos;Six Week&apos;,6,
&apos;Seven Week&apos;,7,
&apos;Eight Week&apos;,8,
&apos;Nine Week&apos;,9,
&apos;Ten Week&apos;,10,0)
*7) +  DATEVALUE( CreatedDate )</formula>
        <name>Populate Validity Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Cancelled</fullName>
        <field>LOI_Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Update Status to Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Cancel LOI in Validity Week</fullName>
        <active>true</active>
        <description>Time based. If LOI not converted till validity Date from created date then Cancel LOI</description>
        <formula>Text(LOI_Status__c ) != &apos;Converted&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Status_to_Cancelled</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>LOI__c.LOI_Validity_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Populate Validity Date</fullName>
        <actions>
            <name>Populate_Validity_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LOI__c.LOI_Validity_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update LOI Revised End Date</fullName>
        <actions>
            <name>Populate_Revised_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LOI__c.Original_End_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>to update LOI Revised end Date with Original End Date when LOI Revised End Date is blank.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
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
</Workflow>
