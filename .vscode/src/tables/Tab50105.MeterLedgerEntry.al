table 50105 "Meter Ledger Entry"
{
    Caption = 'Meter Ledger Entry';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No."; Integer) { }
        field(2; "Meter No."; Code[20]) { TableRelation = "Water Meter"."Meter No."; }
        field(3; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(4; "Customer Name"; Text[100]) { }
        field(5; "Reading Date"; Date) { }
        field(6; "Previous Reading"; Decimal) { }
        field(7; "Current Reading"; Decimal) { }
        field(8; "Units Used"; Decimal) { }
        field(9; "Posted Date"; Date) { }
        field(10; "Posted By"; Code[50]) { }
        field(11; "Invoiced"; Boolean) { }
        field(12; "Invoice No."; Code[20]) { }
        field(13; "Posted"; Boolean) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(MeterDate; "Meter No.", "Reading Date") { }
    }
}
