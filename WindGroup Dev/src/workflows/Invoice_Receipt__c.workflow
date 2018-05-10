<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification_mail_on_submission_of_IR_Payment_Approved</fullName>
        <description>Notification mail on submission of IR Payment Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Payment_Approval_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notification_mail_on_submission_of_IR_Payment_for_approval</fullName>
        <description>Notification mail on submission of IR Payment for approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_approve_Payment</template>
    </alerts>
    <alerts>
        <fullName>Notification_mail_on_submission_of_IR_Payment_for_rejected</fullName>
        <description>Notification mail on submission of IR Payment for rejected</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Payment_Approval_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Status</fullName>
        <field>Status__c</field>
        <literalValue>In-Approval</literalValue>
        <name>Update Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_To_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Status To Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_To_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Status To Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
