
namespace WaterMgt.WaterMgt;

page 50107 "Water Meter Worksheet"
{
    PageType = Worksheet;
    SourceTable = "Water Meter";
    Caption = 'Water Meter Worksheet';
    ApplicationArea = All;
    UsageCategory = Tasks;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Meter No."; Rec."Meter No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewMeter)
            {
                Caption = 'New Meter';
                Image = New;
                ApplicationArea = All;

                trigger OnAction()
                var
                    WaterMeter: Record "Water Meter";
                begin
                    WaterMeter.Init();
                    WaterMeter.Status := WaterMeter.Status::Active;
                    WaterMeter.Insert(true);

                    Rec.Get(WaterMeter."Meter No.");

                    Message('Meter %1 created successfully.', WaterMeter."Meter No.");
                end;
            }
        }

        area(Promoted)
        {
            actionref(NewMeter_Promoted; NewMeter) { }
        }
    }
}
