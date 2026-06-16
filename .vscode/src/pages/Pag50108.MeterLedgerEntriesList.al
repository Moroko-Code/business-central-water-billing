namespace WaterMgt.WaterMgt;

page 50108 "Meter Ledger Entries List"
{
    ApplicationArea = All;
    Caption = 'Meter Ledger Entries List';
    PageType = List;
    SourceTable = "Meter Ledger Entry";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Meter No."; Rec."Meter No.")
                {
                    ToolTip = 'Specifies the value of the Meter No. field.', Comment = '%';
                }

                field("Invoice No."; Rec."Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Invoice No. field.', Comment = '%';
                }
                field(Invoiced; Rec.Invoiced)
                {
                    ToolTip = 'Specifies the value of the Invoiced field.', Comment = '%';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.', Comment = '%';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ToolTip = 'Specifies the value of the Posted Date field.', Comment = '%';
                }
                field("Reading Date"; Rec."Reading Date")
                {
                    ToolTip = 'Specifies the value of the Reading Date field.', Comment = '%';
                }
                field("Previous Reading"; Rec."Previous Reading")
                {
                    ToolTip = 'Specifies the value of the Previous Reading field.', Comment = '%';
                }
                field("Current Reading"; Rec."Current Reading")
                {
                    ToolTip = 'Specifies the value of the Current Reading field.', Comment = '%';
                }

                field("Units Used"; Rec."Units Used")
                {
                    ToolTip = 'Specifies the value of the Units Used field.', Comment = '%';
                }
            }
        }

    }
}
