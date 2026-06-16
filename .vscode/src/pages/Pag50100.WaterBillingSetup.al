namespace WaterMgt.WaterMgt;

page 50100 "Water Billing Setup"
{
    ApplicationArea = All;
    Caption = 'Water Billing Setup';
    PageType = Card;
    SourceTable = "Water Billing Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Rate Per Unit"; Rec."Rate Per Unit") { }
                field("Flat Charge Amount"; Rec."Flat Charge Amount")
                {
                    ToolTip = 'Specifies the value of the Flat Charge Amount field.', Comment = '%';
                }
                field("Penalty Amount"; Rec."Penalty Amount")
                {
                    ToolTip = 'Specifies the value of the Penalty Amount field.', Comment = '%';
                }
                field("Billing Month"; Rec."Billing Month")
                {
                    ToolTip = 'Specifies the value of the Billing Month field.', Comment = '%';
                }
                field("Billing Start Date"; Rec."Billing Start Date")
                {
                    ToolTip = 'Specifies the value of the Billing Start Date field.', Comment = '%';
                }
                field("Billing End Date"; Rec."Billing End Date")
                {
                    ToolTip = 'Specifies the value of the Billing End Date field.', Comment = '%';
                }
                field("Water Service Item No."; Rec."Water Service Item No.")
                {
                    ApplicationArea = All;
                }
                field("Penalty Item No."; Rec."Penalty Item No.")
                {
                    ToolTip = 'Specifies the value of the Penalty Item No. field.', Comment = '%';
                }
                field("Flat Charge Item No."; Rec."Flat Charge Item No.")
                {
                    ToolTip = 'Specifies the value of the Flat Charge Item No. field.', Comment = '%';
                }
                field("Last Billing End Date"; Rec."Last Billing End Date")
                {
                    ToolTip = 'Specifies the value of the Last Billing End Date field.', Comment = '%';
                }

                field("Send SMS After Posting"; Rec."Send SMS After Posting")
                {
                    ToolTip = 'Specifies the value of the Send SMS After Posting field.', Comment = '%';
                }
            }
            group(API)
            {
                field("SMS API URL"; Rec."SMS API URL") { }
                field("SMS API Username"; Rec."SMS API Username") { }
                field("SMS API Key"; Rec."SMS API Key") { }
                field("SMS Sender ID"; Rec."SMS Sender ID") { }
            }
            group("Number Series")
            {
                field("Meter Nos."; Rec."Meter Nos.") { }
                field("Water Bill Nos."; Rec."Water Bill Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Bill Nos.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('SETUP') then begin
            Rec.Init();
            Rec."Code" := 'SETUP';
            Rec.Insert();
        end;
    end;
}