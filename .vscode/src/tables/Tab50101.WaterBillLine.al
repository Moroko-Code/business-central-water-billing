namespace WaterMgt.WaterMgt;

table 50107 "Water Bill Line"
{
    Caption = 'Water Bill Line';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Bill No."; Code[20])
        {
            Caption = 'Bill No.';
            TableRelation = "Water Bill Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(4; "Units Used"; Decimal)
        {
            Caption = 'Units Used';

            trigger OnValidate()
            begin
                CalculateAmount();
            end;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(7; "Meter Ledger Entry No."; Integer)
        {
            Caption = 'Meter Ledger Entry No.';
            TableRelation = "Meter Ledger Entry"."Entry No.";

            trigger OnValidate()
            var
                MeterLedgerEntry: Record "Meter Ledger Entry";
            begin
                if MeterLedgerEntry.Get("Meter Ledger Entry No.") then begin
                    Description := StrSubstNo('Water consumption for meter %1', MeterLedgerEntry."Meter No.");
                    Validate("Units Used", MeterLedgerEntry."Units Used");
                end;
            end;
        }
    }
    keys
    {
        key(PK; "Bill No.", "Line No.")
        {
            Clustered = true;
        }
        key(MeterLedgerEntry; "Meter Ledger Entry No.")
        {
        }
    }
    local procedure CalculateAmount()
    var
        GenSetup: Record "Water Billing Setup";
    begin
        GenSetup.Get('SETUP');
        GenSetup.TestField("Rate Per Unit");
        Amount := "Units Used" * GenSetup."Rate Per Unit";
    end;
}