<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Amount</fullName>
        <description>Updating amount from item catalogue</description>
        <field>Amount__c</field>
        <formula>Product_Catalogue__r.Amount__c</formula>
        <name>Update Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Description</fullName>
        <field>Description__c</field>
        <formula>Product_Catalogue__r.Description__c</formula>
        <name>Update Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Item_Name</fullName>
        <field>Item_Name__c</field>
        <formula>Product_Catalogue__r.Name</formula>
        <name>Update Item Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Load Amount From Item Catalog</fullName>
        <actions>
            <name>Update_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Item_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Loads the amount from item Calatogue to PO Line Item if expiry date is greater than or equal to today</description>
        <formula>NOT(ISBLANK( Product_Catalogue__c ))&amp;&amp; Product_Catalogue__r.Expiry_Date__c &gt;= TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
