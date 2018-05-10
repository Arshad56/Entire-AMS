<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Make_Checkbox_True</fullName>
        <field>Update_Lease_Plans__c</field>
        <literalValue>1</literalValue>
        <name>Make Checkbox True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Original_End_Date_on_Lease_Unit</fullName>
        <field>Original_End_Date__c</field>
        <formula>Lease_End_Date__c</formula>
        <name>Populate Original End Date on Lease Unit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lease_Unit_End_Date</fullName>
        <description>to update Lease Unit End Date with Lease End Date when it&apos;s blank.</description>
        <field>Lease_End_Date__c</field>
        <formula>Lease_Agreement_No__r.Lease_End_Date__c</formula>
        <name>Update Lease Unit End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lease_Unit_Fit_Out_Date</fullName>
        <field>Fit_Out_Date__c</field>
        <formula>Lease_Agreement_No__r.Fit_Out_Start_Date__c</formula>
        <name>Update Lease Unit Fit Out Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lease_Unit_Horse_Power</fullName>
        <description>to update Lease Unit Horse Power</description>
        <field>Horse_Power__c</field>
        <formula>Unit__r.Horse_Power__c</formula>
        <name>Update Lease Unit Horse Power</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lease_Unit_Line_Loss</fullName>
        <description>to update Lease Unit Line Loss when it&apos;s blank.</description>
        <field>Line_Loss__c</field>
        <formula>Unit__r.Line_Loss__c</formula>
        <name>Update Lease Unit Line Loss</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lease_Unit_Start_Date</fullName>
        <description>to update Lease Unit Start Date with Lease Start Date when it&apos;s blank.</description>
        <field>Lease_Start_Date__c</field>
        <formula>Lease_Agreement_No__r.Lease_Start_Date__c</formula>
        <name>Update Lease Unit Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Rent_Free_End_Date</fullName>
        <field>Rent_Free_End_Date__c</field>
        <formula>Lease_Agreement_No__r.Rent_Free_End_Date__c</formula>
        <name>Update Rent Free End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Rent_Free_Start_Date</fullName>
        <field>Rent_Free_Start_Date__c</field>
        <formula>Lease_Agreement_No__r.Rent_Free_Start_Date__c</formula>
        <name>Update Rent Free Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_As_Vacant</fullName>
        <field>Lease_Unit_Status__c</field>
        <literalValue>Vacant</literalValue>
        <name>Update Status As Vacant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Make Checkbox True</fullName>
        <actions>
            <name>Make_Checkbox_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease_Unit__c.Update_Lease_Plans__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Update Lease Plan Checkbox on Unit</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Lease Unit End Date</fullName>
        <actions>
            <name>Update_Lease_Unit_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease_Unit__c.Lease_End_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>to update Lease Unit end date with Lease End Date when Lease Unit End Date is blank.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Lease Unit Fit Out Date</fullName>
        <actions>
            <name>Update_Lease_Unit_Fit_Out_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease_Unit__c.Fit_Out_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Lease Unit Original End Date</fullName>
        <actions>
            <name>Populate_Original_End_Date_on_Lease_Unit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease_Unit__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>On insert populate Revised End Date in Org End Date</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Lease Unit Start Date</fullName>
        <actions>
            <name>Update_Lease_Unit_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lease_Unit__c.Lease_Start_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>to update Lease Unit start date with Lease Start Date when Lease Unit Start Date is blank.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Rent Free Dates</fullName>
        <actions>
            <name>Update_Rent_Free_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Rent_Free_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Vacant Lease Unit</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Lease_Unit__c.Lease_Unit_Status__c</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Status_As_Vacant</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Lease_Unit__c.Lease_End_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
