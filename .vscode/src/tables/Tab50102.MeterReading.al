
table 50102 "Meter Reading"
{
    Caption = 'Meter Reading';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            // trigger OnValidate()
            // var
            //     Customer: Record Customer;
            // begin
            //     if Customer.Get("Customer No.") then begin
            //         "Meter No." := Customer."Meter No.";
            //         "Customer Name" := Customer.Name;
            //         "Previous Reading" := Customer."Last Meter Reading";
            //     end;
            // end;
        }

        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
        }

        field(4; "Meter No."; Code[20])
        {
            Caption = 'Meter No.';
            Editable = false;
        }

        field(5; "Reading Date"; Date)
        {
            Caption = 'Reading Date';
        }

        field(6; "Previous Reading"; Decimal)
        {
            Caption = 'Previous Reading';
            Editable = false;
        }

        field(7; "Current Reading"; Decimal)
        {
            Caption = 'Current Reading';

            trigger OnValidate()
            begin
                if "Current Reading" < "Previous Reading" then
                    Error('Current Reading cannot be less than Previous Reading.');

                "Units Used" := "Current Reading" - "Previous Reading";
            end;
        }

        field(8; "Units Used"; Decimal)
        {
            Caption = 'Units Used';
            Editable = false;
        }

        field(9; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(CustomerDate; "Customer No.", "Reading Date") { }
        key(MeterDate; "Meter No.", "Reading Date") { }
    }

    trigger OnInsert()
    var
        MeterReading: Record "Meter Reading";
    begin
        if "Entry No." = 0 then begin
            MeterReading.Reset();
            if MeterReading.FindLast() then
                "Entry No." := MeterReading."Entry No." + 1
            else
                "Entry No." := 1;
        end;

        if "Reading Date" = 0D then
            "Reading Date" := WorkDate();
    end;
}