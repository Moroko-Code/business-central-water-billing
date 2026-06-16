// namespace WaterMgt.WaterMgt;
// using Microsoft.Sales.History;

// page 50120 "Water Bill Card"
// {
//     PageType = Document;
//     SourceTable = "Water Bill Header";
//     Caption = 'Water Bill';
//     ApplicationArea = All;
//     UsageCategory = Documents;

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 field("No."; Rec."No.") { ApplicationArea = All; }
//                 field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
//                 field("Customer Name"; Rec."Customer Name") { ApplicationArea = All; Editable = false; }
//                 field("Billing Month"; Rec."Billing Month") { ApplicationArea = All; }
//                 field("Billing Date"; Rec."Billing Date") { ApplicationArea = All; }
//                 field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; }
//                 field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = All; }
//                 field("Due Date"; Rec."Due Date") { ApplicationArea = All; Editable = false; }
//                 field(Posted; Rec.Posted) { ApplicationArea = All; Editable = false; }
//                 field("Posted Sales Invoice No."; Rec."Posted Sales Invoice No.") { ApplicationArea = All; Editable = false; }
//             }

//             part(Lines; "Water Bill Subform")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "Bill No." = field("No.");
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(Post)
//             {
//                 Caption = 'Post';
//                 Image = Post;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 var
//                     WaterBillPostingMgt: Codeunit "Water Billing Mgt.";
//                 begin
//                     Rec.TestField("No.");
//                     if Rec.Posted then
//                         Error('Water bill %1 is already posted with invoice %2.', Rec."No.", Rec."Posted Sales Invoice No.");
//                     WaterBillPostingMgt.PostWaterBill(Rec);
//                     CurrPage.Update(false);
//                 end;
//             }

//             action("PostedInvoices")
//             {
//                 Caption = 'Posted Invoices';
//                 Image = Invoice;
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 var
//                     SalesInvoiceHeader: Record "Sales Invoice Header";
//                 begin
//                     Rec.TestField("Posted Sales Invoice No.");

//                     SalesInvoiceHeader.SetRange("No.", Rec."Posted Sales Invoice No.");
//                     Page.Run(Page::"Posted Sales Invoice", SalesInvoiceHeader);
//                 end;
//             }
//         }

//         area(Promoted)
//         {
//             actionref(Post_Promoted; Post) { }

//             actionref(PostedInvoices_Promoted; PostedInvoices) { }
//         }
//     }
// }