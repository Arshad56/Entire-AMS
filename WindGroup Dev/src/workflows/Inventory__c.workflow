<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_Write_Off_Approval</fullName>
        <description>Notification Write Off Approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_approve_Write_Off_Consumable</template>
    </alerts>
    <alerts>
        <fullName>Write_Off_Approved</fullName>
        <description>Write Off Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Write_Off_Consumable_Approved</template>
    </alerts>
    <alerts>
        <fullName>Write_Off_Reject</fullName>
        <description>Write Off Reject</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Write_Off_Consumable_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Status</fullName>
        <field>Status__c</field>
        <literalValue>Write Off In-Approval</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Active</fullName>
        <field>Status__c</field>
        <literalValue>Write-off Approved</literalValue>
        <name>Update Status Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Active</fullName>
        <field>Status__c</field>
        <literalValue>Active</literalValue>
        <name>Update Status to Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Write_Off_Qty</fullName>
        <field>Write_Off_Qty__c</field>
        <name>Update Inventory Write Off Qty</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Write_Off_Rmk</fullName>
        <field>Write_Off_Remark__c</field>
        <name>Update Inventory Write Off Rmk</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
