namespace WaterMgt.WaterMgt;

using Microsoft.Sales.Receivables;

page 50109 CustomerStatementAPI
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'customerStatementAPI';
    DelayedInsert = true;
    EntityName = 'Customerstatementline';
    EntitySetName = 'Customerstatementlines';
    PageType = API;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId) { }
                field(customerNo; Rec."Customer No.") { }
                field(postingDate; Rec."Posting Date") { }
                field(documentNo; Rec."Document No.") { }
                field(description; Rec.Description) { }
                field(amount; Rec.Amount) { }
                field(remainingAmount; Rec."Remaining Amount") { }
            }
        }
    }
}
