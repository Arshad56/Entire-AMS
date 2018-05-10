<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Prod_Catalogue_Status</fullName>
        <field>Status__c</field>
        <literalValue>Inactive</literalValue>
        <name>Update Prod Catalogue Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Product_Name</fullName>
        <field>Product_Name__c</field>
        <formula>Name</formula>
        <name>Update Product Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Prod Catalogue Status</fullName>
        <actions>
            <name>Update_Prod_Catalogue_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Item_Catalogue__c.Expiry_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Product Name</fullName>
        <actions>
            <name>Update_Product_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Item_Catalogue__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This is used to update Update Product Name from Name field to manage Unique Name in system</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
