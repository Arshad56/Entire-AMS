<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Tenant_Id_Base_on_Cash_Receipt</fullName>
        <description>Update Tenant Id Base on Cash Receipt</description>
        <field>Tenant_Id__c</field>
        <formula>Cash_Receipt__r.Tenant__c</formula>
        <name>Update Tenant Id Base on Cash Receipt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Tenant_Id_Base_on_Deposit</fullName>
        <description>Update Tenant Id Base on Deposit</description>
        <field>Tenant_Id__c</field>
        <formula>Deposit__r.Tenant__c</formula>
        <name>Update Tenant Id Base on Deposit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Tenant_Id_Base_on_Invoice</fullName>
        <description>Update Tenant Id Base on Invoice</description>
        <field>Tenant_Id__c</field>
        <formula>Invoice__r.Tenant__c</formula>
        <name>Update Tenant Id Base on Invoice</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Tenant_Id_Base_on_Payment_Voucher</fullName>
        <description>Update Tenant Id Base on Payment Voucher</description>
        <field>Tenant_Id__c</field>
        <formula>Payment_Voucher__r.Tenant_Id__c</formula>
        <name>Update Tenant Id Base on Payment Voucher</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Update Cash Receipt Journal Voucher</fullName>
        <actions>
            <name>Update_Tenant_Id_Base_on_Cash_Receipt</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Cash Receipt Journal Voucher</description>
        <formula>Cash_Receipt__c != null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Deposit Journal Voucher</fullName>
        <actions>
            <name>Update_Tenant_Id_Base_on_Deposit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Deposit Journal Voucher</description>
        <formula>Deposit__c != null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Invoice Journal Voucher</fullName>
        <actions>
            <name>Update_Tenant_Id_Base_on_Invoice</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Journal Voucher Tenant Id</description>
        <formula>Invoice__c != null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Payment Voucher Journal Voucher</fullName>
        <actions>
            <name>Update_Tenant_Id_Base_on_Payment_Voucher</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Payment Voucher Journal Voucher</description>
        <formula>Payment_Voucher__c != null</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
