table 50106 "Water Meter"
{
    Caption = 'Water Meter';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meter No."; Code[20])
        {
            Caption = 'Meter No.';
        }

        field(2; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Active,Inactive;
        }

        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Meter No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        WaterSetup: Record "Water Billing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Meter No." = '' then begin

            if not WaterSetup.Get('SETUP') then begin
                WaterSetup.Init();
                WaterSetup.Code := 'SETUP';
                WaterSetup.Insert();
            end;

            WaterSetup.TestField("Meter Nos.");

            "Meter No." :=
                NoSeriesMgt.GetNextNo(
                    WaterSetup."Meter Nos.",
                    WorkDate(),
                    true);

            "No. Series" := WaterSetup."Meter Nos.";
        end;
    end;
}