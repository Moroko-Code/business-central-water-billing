namespace WaterMgt.WaterMgt;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;

page 50106 "Water Billing Activities"
{
    ApplicationArea = All;
    Caption = 'Water Billing Activities';
    PageType = CardPart;
    SourceTable = "Water Billing Cue";
    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                Caption = 'General';

                field("Total Customers"; Rec."Total Customers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Customer List";
                }

                field("Total Water Meters"; Rec."Total Water Meters")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Water Meter Worksheet";
                }
            }

            cuegroup(Operations)
            {
                Caption = 'Operations';

                field("Pending SMS Logs"; Rec."Pending SMS Logs")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "SMS Log List";
                }
            }

            cuegroup(Sales)
            {
                Caption = 'Sales';

                field("Sales Invoices"; Rec."Sales Invoices")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Invoice List";
                }

                field("Posted Sales Invoices"; Rec."Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Posted Sales Invoices";
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