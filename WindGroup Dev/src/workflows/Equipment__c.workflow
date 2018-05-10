<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_Write_Off_Approved</fullName>
        <description>Notification Write Off Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Write_Off_Equipment_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notification_Write_Off_Rejected</fullName>
        <description>Notification Write Off Rejected</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Write_Off_Equipment_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Notification_for_Write_Off_Approval</fullName>
        <description>Notification for Write Off Approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_approve_Write_Off_Equipment</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Action</fullName>
        <field>Action__c</field>
        <literalValue>Write Off</literalValue>
        <name>Update Action</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Action_Reject</fullName>
        <field>Action__c</field>
        <literalValue>Write Off Rejected</literalValue>
        <name>Update Action Reject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Action_for_Submit</fullName>
        <field>Action__c</field>
        <literalValue>Write Off In-Approval</literalValue>
        <name>Update Action for Submit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status</fullName>
        <field>Status__c</field>
        <literalValue>Inactive</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
