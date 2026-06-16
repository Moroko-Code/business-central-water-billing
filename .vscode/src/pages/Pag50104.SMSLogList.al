namespace WaterMgt.WaterMgt;

page 50104 "SMS Log List"
{
    ApplicationArea = All;
    Caption = 'SMS Log List';
    PageType = List;
    SourceTable = "SMS Log";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { }
                field("Phone No."; Rec."Phone No.") { }
                field(Message; Rec.Message) { }
                field("Sent DateTime"; Rec."Sent DateTime") { }
                field(Status; Rec.Status) { }
                field(Response; Rec.Response) { }
            }
        }
    }
}
