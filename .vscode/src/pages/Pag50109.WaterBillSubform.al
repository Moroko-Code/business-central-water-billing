namespace WaterMgt.WaterMgt;

page 50121 "Water Bill Subform"
{
    PageType = ListPart;
    SourceTable = "Water Bill Line";
    Caption = 'Water Bill Lines';
    ApplicationArea = All;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Meter Ledger Entry No."; Rec."Meter Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Units Used"; Rec."Units Used")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}