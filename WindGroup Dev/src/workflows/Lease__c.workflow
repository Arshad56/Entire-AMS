<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Generate_Lease_Agreement_No</fullName>
        <description>Combination of Property Short Code-Invoice Auto</description>
        <field>Name</field>
        <formula>Property__r.Short_Code__c  &amp;&quot;-&quot;&amp; &quot;LA&quot; &amp;&quot;-&quot;&amp;  Created_Year__c  &amp; Created_Month__c &amp;&quot;-&quot;&amp; Lease_Index__c</formula>
        <name>Generate Lease Agreement No</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
    <fieldUpdates>
        <fullName>Update_Lease_Revised_End_Date</fullName>
        <field>Original_End_Date__c</field>
        <formula>Lease_End_Date__c</formula>
        <name>Update Lease Revised End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Expired</fullName>
        <field>Lease_Status__c</field>
        <literalValue>Expired</literalValue>
        <name>Update Status Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Expired1</fullName>
        <field>Lease_Status__c</field>
        <literalValue>Expired</literalValue>
        <name>Update Status Expired</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Expire</fullName>
        <field>Lease_Status__c</field>
        <literalValue>Expired</literalValue>
        <name>Update Status to Expire</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updated_Stage_to_LA_Approved</fullName>
        <field>Stage__c</field>
        <literalValue>LA Approval</literalValue>
        <name>Updated Stage to LA Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updated_Stage_to_LOI_Approved</fullName>
        <field>Stage__c</field>
        <literalValue>LOI Approved</literalValue>
        <name>Updated Stage to LOI Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Expire Lease</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Lease__c.Lease_Status__c</field>
            <operation>equals</operation>
            <value>New,Extended</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Status_to_Expire</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Lease__c.Lease_End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Generate Lease Agreement No</fullName>
        <actions>
            <name>Generate_Lease_Agreement_No</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Combination of Property Short Code-Lease Auto</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Lease Revised End Date</fullName>
        <actions>
            <name>Update_Lease_Revised_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease__c.Original_End_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>to update Lease Revised end Date with Original End Date when Lease Revised End Date is blank.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Lease status Expired</fullName>
        <active>true</active>
        <description>When date crosses Revision Date makes status Expired</description>
        <formula>Not(ISBLANK(Original_End_Date__c)) &amp;&amp; (Original_End_Date__c  &gt; Lease_End_Date__c ) &amp;&amp;   ISPICKVAL( Lease_Status__c , &quot;New&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Status_Expired1</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Lease__c.Original_End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Property Name Text</fullName>
        <actions>
            <name>Populate_Property_Name_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>(Not(ISBLANK(Property__c)) &amp;&amp; ISNEW() ) || 
(Not(ISBLANK(Property__c)) &amp;&amp; ISCHANGED(Property__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
