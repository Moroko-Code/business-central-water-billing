table 50100 "Water Billing Setup"
{
    Caption = 'Water Billing Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }

        field(2; "Water Revenue G/L Account"; Code[20])
        {
            Caption = 'Water Revenue G/L Account';
            TableRelation = "G/L Account"."No.";
        }

        field(3; "Rate Per Unit"; Decimal)
        {
            Caption = 'Rate Per Unit';
            DecimalPlaces = 0 : 5;
        }

        field(4; "SMS API URL"; Text[250])
        {
            Caption = 'SMS API URL';
        }

        field(5; "SMS API Username"; Text[50])
        {
            Caption = 'SMS API Username';
        }

        field(6; "SMS API Key"; Text[250])
        {
            Caption = 'SMS API Key';
        }

        field(7; "SMS Sender ID"; Text[50])
        {
            Caption = 'SMS Sender ID';
        }

        field(8; "Meter Nos."; Code[20])
        {
            Caption = 'Meter Nos.';
            TableRelation = "No. Series";
        }

        field(9; "Water Service Item No."; Code[20])
        {
            Caption = 'Water Service Item No.';
            TableRelation = Item."No.";
        }

        field(10; "Water Bill Nos."; Code[20])
        {
            Caption = 'Invoice Bill Nos.';
            TableRelation = "No. Series";
        }

        field(11; "Billing Month"; Date)
        {
            Caption = 'Billing Month';
        }

        field(12; "Billing Start Date"; Date)
        {
            Caption = 'Billing Start Date';
        }

        field(13; "Billing End Date"; Date)
        {
            Caption = 'Billing End Date';
        }

        field(14; "Flat Charge Item No."; Code[20])
        {
            Caption = 'Flat Charge Item No.';
            TableRelation = Item."No.";
        }

        field(15; "Flat Charge Amount"; Decimal)
        {
            Caption = 'Flat Charge Amount';
            DecimalPlaces = 0 : 5;
        }

        field(16; "Penalty Item No."; Code[20])
        {
            Caption = 'Penalty Item No.';
            TableRelation = Item."No.";
        }

        field(17; "Penalty Amount"; Decimal)
        {
            Caption = 'Penalty Amount';
            DecimalPlaces = 0 : 5;
        }

        field(19; "Last Billing End Date"; Date)
        {
            Caption = 'Last Billing End Date';
            Editable = false;
        }

        field(21; "Send SMS After Posting"; Boolean)
        {
            Caption = 'Send SMS After Posting';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}