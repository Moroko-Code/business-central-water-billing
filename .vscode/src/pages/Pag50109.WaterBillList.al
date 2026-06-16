// namespace WaterMgt.WaterMgt;

// page 50109 "Water Bill List"
// {
//     ApplicationArea = All;
//     Caption = 'Water Bill List';
//     PageType = List;
//     SourceTable = "Water Bill Header";
//     // CardPageId = "Water Bill Card";
//     UsageCategory = Lists;

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Customer No."; Rec."Customer No.")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Customer Name"; Rec."Customer Name")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }

//                 field("Billing Date"; Rec."Billing Date")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Payment Terms Code"; Rec."Payment Terms Code")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }

//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }

//                 field("Posted Sales Invoice No."; Rec."Posted Sales Invoice No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(CreatePostAllCustomerInvoices)
//             {
//                 Caption = 'Create & Post All Customer Invoices';
//                 ApplicationArea = All;
//                 Image = PostBatch;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                 //WaterBillingMgt: Codeunit "Water Billing Mgt.";
//                 begin
//                     // WaterBillingMgt.CreateAndPostInvoicesForAllCustomers();
//                     CurrPage.Update(false);
//                 end;
//             }
//             group("Process Notifications")
//             {
//                 Caption = 'Process Notifications';

//                 action(SendWeeklyNotifications)
//                 {
//                     Caption = 'Send Weekly Notifications';
//                     ApplicationArea = All;
//                     Image = SendTo;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     trigger OnAction()
//                     var
//                     // WaterBillingMgt: Codeunit "Water Billing Mgt.";
//                     begin
//                         // WaterBillingMgt.CreateAndPostInvoicesForAllCustomers();
//                         // CurrPage.Update(false);
//                     end;

//                 }
//                 action(SendMonthlyNotifications)
//                 {
//                     Caption = 'Send Monthly Notifications';
//                     ApplicationArea = All;
//                     Image = SendTo;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     trigger OnAction()
//                     var
//                     // WaterBillingMgt: Codeunit "Water Billing Mgt.";
//                     begin
//                         // WaterBillingMgt.CreateAndPostInvoicesForAllCustomers();
//                         // CurrPage.Update(false);
//                     end;

//                 }

//             }

//         }
//     }
// }