<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approved_email_notification_to_the_purchase_order_owner_with_greater_amount</fullName>
        <description>Approved email notification to the purchase order owner with greater amount</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/PurchaseOrder_Amount_Approval_Process_Email_Template_For_Approved</template>
    </alerts>
    <alerts>
        <fullName>Approved_email_notification_to_the_purchase_order_owner_with_lesser_amount</fullName>
        <description>Approved email notification to the purchase order owner with lesser amount</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/PurchaseOrder_Amount_Approval_Process_Email_Template_For_Approved</template>
    </alerts>
    <alerts>
        <fullName>Hey</fullName>
        <description>Hey</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_approve_Payment</template>
    </alerts>
    <alerts>
        <fullName>Notification_mail_on_cancel_of_purchase_order_for_approval</fullName>
        <description>Notification mail on cancel of purchase order for approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_Cancel_Purchase_Order</template>
    </alerts>
    <alerts>
        <fullName>Notification_mail_on_cancel_of_purchase_order_for_approved</fullName>
        <description>Notification mail on cancel of purchase order for approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/PurchaseOrder_Cancellation_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notification_mail_on_cancel_of_purchase_order_for_rejected</fullName>
        <description>Notification mail on cancel of purchase order for rejected</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/PurchaseOrder_Cancellation_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Notification_mail_on_submission_of_purchase_order_for_approval</fullName>
        <ccEmails>Sanjay@techmatrixconsulting.com</ccEmails>
        <description>Notification mail on submission of purchase order for approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_Submit_Purchase_Order</template>
    </alerts>
    <alerts>
        <fullName>Notification_mail_on_submission_of_purchase_order_for_approval_for_greater</fullName>
        <description>Notification mail on submission of purchase order for approval for greater</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_Submit_Purchase_Order</template>
    </alerts>
    <alerts>
        <fullName>PO_Approval</fullName>
        <description>PO Approval</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_approve_PO</template>
    </alerts>
    <alerts>
        <fullName>PO_Approval1</fullName>
        <description>PO Approval1</description>
        <protected>false</protected>
        <recipients>
            <recipient>finance@wind.com.sg</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/Notification_To_approve_PO</template>
    </alerts>
    <alerts>
        <fullName>Rejection_email_notification_to_the_purchase_order_owner_with_greater_amount</fullName>
        <description>Rejection email notification to the purchase order owner with greater amount</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/PurchaseOrder_Amount_Approval_Process_Email_Template_For_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Rejection_email_notification_to_the_purchase_order_owner_with_lesser_amount</fullName>
        <description>Rejection email notification to the purchase order owner with lesser amount</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Approval_Email_Notification/PurchaseOrder_Amount_Approval_Process_Email_Template_For_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Bypass_Validation_Rule</fullName>
        <field>PO_Line_Validation_Bypass__c</field>
        <literalValue>1</literalValue>
        <name>Bypass Validation Rule</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_City</fullName>
        <field>Delivery_City__c</field>
        <formula>Company_Name__r.BillingCity</formula>
        <name>Update Address City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_Postal_Code</fullName>
        <field>Delivery_Zip_Postal_Code__c</field>
        <formula>Company_Name__r.BillingPostalCode</formula>
        <name>Update Address Postal Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_Street</fullName>
        <field>Delivery_Street__c</field>
        <formula>Company_Name__r.BillingStreet</formula>
        <name>Update Address Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Generate_PO_PDF_To_True</fullName>
        <field>Generate_PO_PDF__c</field>
        <literalValue>1</literalValue>
        <name>Update Generate PO PDF To True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Generate_PO_PDF_To_True_for_less</fullName>
        <field>Generate_PO_PDF__c</field>
        <literalValue>1</literalValue>
        <name>Update Generate PO PDF To True for less</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_PO_Validation_Bypass</fullName>
        <field>PO_Line_Validation_Bypass__c</field>
        <literalValue>0</literalValue>
        <name>Update PO Validation Bypass</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
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
        <fullName>Update_Status_To_Issued</fullName>
        <field>Status__c</field>
        <literalValue>Issued</literalValue>
        <name>Update Status To Issued</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_To_Issued_for_greater</fullName>
        <field>Status__c</field>
        <literalValue>Issued</literalValue>
        <name>Update Status To Issued for greater</name>
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
    <fieldUpdates>
        <fullName>Update_Status_To_Rejected_for_greater</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Status To Rejected for greater</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_for_amount_greater</fullName>
        <field>Status__c</field>
        <literalValue>In-Approval</literalValue>
        <name>Update Status for amount greater</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_for_amount_greater_on_appr</fullName>
        <field>Status__c</field>
        <literalValue>Issued</literalValue>
        <name>Update Status for amount greater on appr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_for_amount_greater_on_rej</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Status for amount greater on rej</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_for_amount_lesser_on_app</fullName>
        <field>Status__c</field>
        <literalValue>Issued</literalValue>
        <name>Update Status for amount lesser on app</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_for_amount_lesser_on_rej</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Status for amount lesser on rej</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Cancel_In_Approval</fullName>
        <field>Status__c</field>
        <literalValue>Cancel In-Approval</literalValue>
        <name>Update Status to Cancel In Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Cancel_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Issued</literalValue>
        <name>Update Status to Cancel Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Cancelled</fullName>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Update Status to Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Tax_Applicable_as_False</fullName>
        <field>Tax_Applicable__c</field>
        <literalValue>0</literalValue>
        <name>Update Tax Applicable as False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Tax_Applicable_as_True</fullName>
        <field>Tax_Applicable__c</field>
        <literalValue>1</literalValue>
        <name>Update Tax Applicable as True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Tax_Rate</fullName>
        <field>Tax_Rate__c</field>
        <formula>Vendor_Name__r.Tax_Rate__c</formula>
        <name>Update Tax Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_delivery_country</fullName>
        <field>Delivery_Country__c</field>
        <formula>Company_Name__r.BillingCountry</formula>
        <name>Update delivery country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Address from Company Name</fullName>
        <actions>
            <name>Update_Address_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Address_Postal_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Address_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_delivery_country</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Address from the Company Billing Address</description>
        <formula>1=1</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update PO Validation Bypass</fullName>
        <actions>
            <name>Update_PO_Validation_Bypass</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Purchase_Order__c.Status__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Purchase_Order__c.Total_Quantity__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <description>To update the PO Line Item Validation Bypass</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Tax Info from Vendor %28Tax - FALSE%29</fullName>
        <actions>
            <name>Update_Tax_Applicable_as_False</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Tax_Rate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This is used to update Tax info on PO from related Vendor</description>
        <formula>NOT (ISBLANK( Vendor_Name__c )) &amp;&amp;   Vendor_Name__r.Tax_Applicable__c  = FALSE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Tax Info from Vendor %28Tax - TRUE%29</fullName>
        <actions>
            <name>Update_Tax_Applicable_as_True</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Tax_Rate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This is used to update Tax info on PO from related Vendor</description>
        <formula>NOT (ISBLANK( Vendor_Name__c )) &amp;&amp;   Vendor_Name__r.Tax_Applicable__c  = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
