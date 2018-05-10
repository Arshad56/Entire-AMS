<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Amount</fullName>
        <field>Amount__c</field>
        <formula>Estimated_GTO_Rent__c</formula>
        <name>Update Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Amount_By_POS</fullName>
        <field>Amount__c</field>
        <formula>IF(isPickVal(Lease_Unit__r.Lease_Agreement_No__r.GTO_Billed__c,&apos;By Lease Unit&apos;),Calculated_Amount_Higher_or_Sum__c  ,GTO_Rent_By_Lease__c)</formula>
        <name>Update Amount By POS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Amount_for_Non_Tiered_Utility</fullName>
        <field>Amount__c</field>
        <formula>Calculated_Utility_Non_Tiered__c</formula>
        <name>Update Amount for Non Tiered Utility</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Billed_By_to_POS_GTO</fullName>
        <description>This is to mark that billed Amount is calculated by Estimated GTO or POS GTO or Audited GTO.</description>
        <field>GTO_Rent_By__c</field>
        <literalValue>POS GTO</literalValue>
        <name>Update Billed By to POS GTO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Calculated_Amount</fullName>
        <field>Temp_Calculated_Amount__c</field>
        <formula>Calculated_Amount__c</formula>
        <name>Update Temp Calculated Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Comm_Tax_as_Blank</fullName>
        <description>This is used to update Comm Tax as Blank when on related LC &gt; Comm Tax is set to FALSE</description>
        <field>Comm_Tax__c</field>
        <name>Update Comm Tax as Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Cumulative_Tiered_Amount</fullName>
        <field>Amount__c</field>
        <formula>IF(
ISPICKVAL( Status__c,&quot;Rent Roll Generated&quot;), Amount__c,

IF( AND( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;Estimated GTO&quot;) ), Estimated_GTO_Rent__c,
IF( AND(ISPICKVAL( Lease_Charge__r.Charge_Type__c , &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;POS GTO&quot;)),
Calculated_Amount__c  , 
IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),Lease_Charge__r.Base_included__c ) , 
Calc_Cumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c + Lease_Charge__r.Base_Value__c,
IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),NOT (Lease_Charge__r.Base_included__c) ) , 
Calc_Cumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c ,
If ( Lease_Charge__r.Base_included__c , ( Calc_Cumulative_Tiered__c  + Lease_Charge__r.Base_Value__c ) * Calc_No_of_Days_Pro_Rated__c ,  
Calc_Cumulative_Tiered__c * Calc_No_of_Days_Pro_Rated__c
)))))
)</formula>
        <name>Update Cumulative Tiered Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Non_Cumulative_Tiered_Amount</fullName>
        <field>Amount__c</field>
        <formula>IF(
ISPICKVAL( Status__c,&quot;Rent Roll Generated&quot;), Amount__c,
IF( AND( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;),  ISPICKVAL( GTO_Rent_By__c, &quot;Estimated GTO&quot;)  ), Estimated_GTO_Rent__c,
IF( AND(ISPICKVAL( Lease_Charge__r.Charge_Type__c , &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;POS GTO&quot;)),
Calculated_Amount__c  , 

IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),Lease_Charge__r.Base_included__c), 
Calc_NonCumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c + Lease_Charge__r.Base_Value__c,
IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),NOT (Lease_Charge__r.Base_included__c)), 
Calc_NonCumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c ,
IF ( Lease_Charge__r.Charge__r.Base_included__c , 
( Calc_NonCumulative_Tiered__c + Lease_Charge__r.Charge__r.Base_Value__c ) * Calc_No_of_Days_Pro_Rated__c , 
Calc_NonCumulative_Tiered__c * Calc_No_of_Days_Pro_Rated__c 
)))))
)</formula>
        <name>Update Non Cumulative Tiered Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Non_Tiered_Amount</fullName>
        <field>Amount__c</field>
        <formula>IF( 
    ISPICKVAL( Status__c,&quot;Rent Roll Generated&quot;), Amount__c, 

        IF (ISPICKVAL(Lease_Charge__r.Type__c, &quot;Fixed&quot;), 
        Calculated_Amount__c * Calc_No_of_Days_Pro_Rated__c, 
            IF (AND( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),Lease_Charge__r.Base_included__c ) , 
            Calculated_Amount__c + Maintenance_Fee__c + Horse_Power__c + Lease_Charge__r.Base_Value__c , 
                IF (AND( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),NOT(Lease_Charge__r.Base_included__c)) , 
                Calculated_Amount__c + Maintenance_Fee__c + Horse_Power__c , 
                    IF( AND( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;Estimated GTO&quot;) ), Estimated_GTO_Rent__c, 
                        IF (AND(ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;POS GTO&quot;)) , 
                        Calculated_Amount__c, 
                        IF ( Lease_Charge__r.Base_included__c , 
                            (Calculated_Amount__c * Calc_No_of_Days_Pro_Rated__c ) + Lease_Charge__r.Base_Value__c , 

                                IF (ISPICKVAL(Lease_Charge__r.Type__c, &quot;By Percent&quot;), 
                                Calculated_Amount__c, 

                                Calculated_Amount__c * Calc_No_of_Days_Pro_Rated__c 
                            ) 
                        )
                    )
                )
            )
        )
    ) 
)</formula>
        <name>Update Non Tiered Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Temp_Calculated_Amount_NCTier</fullName>
        <field>Temp_Calculated_Amount__c</field>
        <formula>IF( 
ISPICKVAL( Status__c,&quot;Rent Roll Generated&quot;), Amount__c, 
IF( AND( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;Estimated GTO&quot;) ), Estimated_GTO_Rent__c, 
IF( AND(ISPICKVAL( Lease_Charge__r.Charge_Type__c , &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;POS GTO&quot;)), 
Calculated_Amount__c , 

IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),Lease_Charge__r.Base_included__c), 
Calc_NonCumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c + Lease_Charge__r.Base_Value__c, 
IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),NOT (Lease_Charge__r.Base_included__c)), 
Calc_NonCumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c , 
IF ( Lease_Charge__r.Charge__r.Base_included__c , 
( Calc_NonCumulative_Tiered__c + Lease_Charge__r.Charge__r.Base_Value__c )  , 
Calc_NonCumulative_Tiered__c  
))))) 
)</formula>
        <name>Update Temp Calculated Amount (NCTier)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Temp_Calculated_Amount_Non_Tier</fullName>
        <field>Temp_Calculated_Amount__c</field>
        <formula>IF( 
ISPICKVAL( Status__c,&quot;Rent Roll Generated&quot;), Amount__c, 

IF (ISPICKVAL(Lease_Charge__r.Type__c, &quot;Fixed&quot;), 
Calculated_Amount__c , 
IF (AND( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),Lease_Charge__r.Base_included__c ) , 
Calculated_Amount__c + Maintenance_Fee__c + Horse_Power__c + Lease_Charge__r.Base_Value__c , 
IF (AND( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),NOT(Lease_Charge__r.Base_included__c)) , 
Calculated_Amount__c + Maintenance_Fee__c + Horse_Power__c , 
IF( AND( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;Estimated GTO&quot;) ), Estimated_GTO_Rent__c, 
IF (AND(ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;POS GTO&quot;)) , 
Calculated_Amount__c, 
IF 
( Lease_Charge__r.Base_included__c , 
(Calculated_Amount__c  ) + Lease_Charge__r.Base_Value__c , 

IF (ISPICKVAL(Lease_Charge__r.Type__c, &quot;By Percent&quot;), 
Calculated_Amount__c, 

Calculated_Amount__c  
) 
)))))) 
)</formula>
        <name>Update Temp Calculated Amount (Non Tier)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Temp_Calculated_Amount_Tier</fullName>
        <field>Temp_Calculated_Amount__c</field>
        <formula>IF( 
ISPICKVAL( Status__c,&quot;Rent Roll Generated&quot;), Amount__c, 

IF( AND( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;Estimated GTO&quot;) ), Estimated_GTO_Rent__c, 
IF( AND(ISPICKVAL( Lease_Charge__r.Charge_Type__c , &quot;GTO Rent&quot;), ISPICKVAL( GTO_Rent_By__c, &quot;POS GTO&quot;)), 
Calculated_Amount__c , 
IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),Lease_Charge__r.Base_included__c ) , 
Calc_Cumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c + Lease_Charge__r.Base_Value__c, 
IF ( AND ( OR( ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Gov Meter&quot;) , ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Sub Meter&quot;)),NOT (Lease_Charge__r.Base_included__c) ) , 
Calc_Cumulative_Tiered__c + Maintenance_Fee__c + Horse_Power__c , 
If ( Lease_Charge__r.Base_included__c , ( Calc_Cumulative_Tiered__c + Lease_Charge__r.Base_Value__c )  , 
Calc_Cumulative_Tiered__c  
))))) 
)</formula>
        <name>Update Temp Calculated Amount (Tier)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Total_Utility_Units</fullName>
        <description>Used to update Total Units (Number field) from Formula field</description>
        <field>Total_Units_p__c</field>
        <formula>Total_Units__c</formula>
        <name>Update Total Utility Units</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Populate Calculated Amount</fullName>
        <actions>
            <name>Update_Calculated_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>Calculated_Amount__c !=  Temp_Calculated_Amount__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Refresh Comm Tax when on LC is False</fullName>
        <actions>
            <name>Update_Comm_Tax_as_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This W/F is used to set Comm Tax value as Blank when on related LC &gt; Comm Tax is unchecked!!</description>
        <formula>Lease_Charge__r.Commercial_Tax_Apply__c = FALSE  &amp;&amp; 
Text(Billing_Type__c) != &apos;Ad-Hoc Invoice&apos; &amp;&amp; Text(Billing_Type__c) != &apos;Debit Note&apos; &amp;&amp; 
Text(Billing_Type__c) != &apos;Credit Note&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Amount with Actual GTO Rent</fullName>
        <actions>
            <name>Update_Amount_By_POS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update amount and GTO Rent by field when actual pos transactions are uploaded</description>
        <formula>IF( 
AND( 
ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;), 
NOT(ISPICKVAL(Status__c ,&quot;Rent Roll Generated&quot;) ) ,
ISPICKVAL(GTO_Rent_By__c,&quot;POS GTO&quot;)
),
true,false 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Amount with Estimated GTO Rent</fullName>
        <actions>
            <name>Update_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update amount and GTO Rent by field when estimated pos transactions are uploaded</description>
        <formula>IF(
AND(
ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;GTO Rent&quot;),
NOT(ISPICKVAL(Status__c ,&quot;Rent Roll Generated&quot;) ),
ISPICKVAL(GTO_Rent_By__c,&quot;Estimated GTO&quot;) 				
),
true,false
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Cumulative Tiered Amount</fullName>
        <actions>
            <name>Update_Cumulative_Tiered_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Temp_Calculated_Amount_Tier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Rent_Schedules__c.Cumulative__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Rent_Schedules__c.Tiered__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Rent_Schedules__c.Billing_Type__c</field>
            <operation>notEqual</operation>
            <value>Debit Note,Credit Note,Ad-Hoc Invoice</value>
        </criteriaItems>
        <criteriaItems>
            <field>Rent_Schedules__c.Charge_Type__c</field>
            <operation>notEqual</operation>
            <value>Invoice Discount</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Non Cumulative Tiered Amount</fullName>
        <actions>
            <name>Update_Non_Cumulative_Tiered_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Temp_Calculated_Amount_NCTier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Rent_Schedules__c.Cumulative__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Rent_Schedules__c.Tiered__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Rent_Schedules__c.Billing_Type__c</field>
            <operation>notEqual</operation>
            <value>Debit Note,Credit Note,Ad-Hoc Invoice</value>
        </criteriaItems>
        <criteriaItems>
            <field>Rent_Schedules__c.Charge_Type__c</field>
            <operation>notEqual</operation>
            <value>Invoice Discount</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Non Tiered Amount</fullName>
        <actions>
            <name>Update_Non_Tiered_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Temp_Calculated_Amount_Non_Tier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF( 
AND( NOT(Tiered__c), 
     NOT (AND (
ISPICKVAL(Lease_Charge__r.Charge_Type__c, &quot;Generator&quot;)
,
ISPICKVAL(Lease_Charge__r.Type__c, &quot;Special&quot;)
               )),
TEXT (Billing_Type__c) != &quot;Ad-hoc Invoice&quot; ,
TEXT (Billing_Type__c) != &quot;Debit Note&quot; ,
TEXT (Billing_Type__c) != &quot;Credit Note&quot;,
 Charge_Type__c != &quot;Discount&quot;,
Charge_Type__c != &quot;Invoice Discount&quot;
   ), 
true, false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Total Utility Units</fullName>
        <actions>
            <name>Update_Total_Utility_Units</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Rent_Schedules__c.Total_Units__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
