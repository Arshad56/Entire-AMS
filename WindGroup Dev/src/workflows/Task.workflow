<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Creator_on_Task_Update</fullName>
        <description>Alert Creator on Task Update</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/Notification_Task_Modified_Creator</template>
    </alerts>
    <alerts>
        <fullName>Alert_PIC_on_Task_Create_Update</fullName>
        <description>Alert PIC on Task Create Update</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/Notification_Task_Assigned_PIC</template>
    </alerts>
    <alerts>
        <fullName>Send_Notification_to_PIC_on_status_Complete</fullName>
        <description>Send Notification to PIC on status Complete</description>
        <protected>false</protected>
        <recipients>
            <field>PIC_Email_Id__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Junction_Admin/Task_Completed_Notification</template>
    </alerts>
    <rules>
        <fullName>Notify Creator on update</fullName>
        <actions>
            <name>Alert_Creator_on_Task_Update</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify Creator (For Request) 
On Change Status 
On Change Action Remarks</description>
        <formula>(ISCHANGED(Status) || ISCHANGED(Action_Remarks__c) ) &amp;&amp; LEFT(WhatId, 3) == $Label.Request_Obj_ID_Prefix &amp;&amp;  !ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify PIC on Create update</fullName>
        <actions>
            <name>Alert_PIC_on_Task_Create_Update</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify PIC (On Request)
	On Create 
	On Change Description</description>
        <formula>(ISNEW() ||  ISCHANGED( Description__c ) ) &amp;&amp;   LEFT(WhatId, 3) ==  $Label.Request_Obj_ID_Prefix</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
