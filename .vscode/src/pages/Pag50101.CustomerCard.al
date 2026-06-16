namespace WaterMgt.WaterMgt;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.Receivables;

page 50101 "Customer Card"
{
    PageType = Card;
    SourceTable = Customer;
    Caption = 'Customer Card';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(F_Name; Rec.F_Name)
                {
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field(M_Name; Rec.M_Name)
                {
                    ToolTip = 'Specifies the value of the Middle Name field.', Comment = '%';
                }
                field(L_Name; Rec.L_Name)
                {
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field(Address; Rec.Address) { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
            }

            group("Billing")
            {
                field("Meter No."; Rec."Meter No.") { ApplicationArea = All; }
                field("Meter Status"; Rec."Meter Status") { ApplicationArea = All; }
                field("Last Meter Reading"; Rec."Last Meter Reading")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
            }

            group("Posting Setup")
            {
                field("Customer Posting Group"; Rec."Customer Posting Group") { ApplicationArea = All; }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group") { ApplicationArea = All; }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group") { ApplicationArea = All; }
            }

            group(Payment)
            {
                field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = All; }
                field("Payment Method Code"; Rec."Payment Method Code") { ApplicationArea = All; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; }
            }
        }

        area(FactBoxes)
        {
            part(CustomerStatisticsFactBox; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Water Billing")
            {
                Caption = 'Water Billing';

                action(MeterReadingWorksheet)
                {
                    Caption = 'Meter Reading Worksheet';
                    Image = Worksheet;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Page.Run(Page::"Meter Reading List", Rec);
                    end;
                }
            }

            group(Reports)
            {
                Caption = 'Reports';

                action(MeterLedgerReport)
                {
                    Caption = 'Meter Ledger Report';
                    Image = Report;
                    ApplicationArea = All;

                    // trigger OnAction()
                    // var
                    //     MeterLedgerEntry: Record "Meter Ledger Entry";
                    // begin
                    //     MeterLedgerEntry.SetRange("Customer No.", Rec."No.");
                    //     Report.RunModal(Report::"Meter Ledger Report", true, true, MeterLedgerEntry);
                    // end;
                }

                action(CustomerWaterBalanceReport)
                {
                    Caption = 'Customer Water Balance';
                    Image = Report;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Customer: Record Customer;
                    begin
                        Customer.SetRange("No.", Rec."No.");
                        Report.RunModal(Report::"Customer Statement", true, true, Customer);
                    end;
                }

                action(MonthlyConsumptionReport)
                {
                    Caption = 'Monthly Consumption';
                    Image = Report;
                    ApplicationArea = All;

                    // trigger OnAction()
                    // var
                    //     MeterLedgerEntry: Record "Meter Ledger Entry";
                    // begin
                    //     MeterLedgerEntry.SetRange("Customer No.", Rec."No.");
                    //     Report.RunModal(Report::"Monthly Consumption Report", true, true, MeterLedgerEntry);
                    // end;
                }
            }
        }

        area(Navigation)
        {
            action(CustomerLedgerEntries)
            {
                Caption = 'Customer Ledger Entries';
                Image = LedgerEntries;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                begin
                    CustLedgerEntry.SetRange("Customer No.", Rec."No.");
                    Page.Run(Page::"Customer Ledger Entries", CustLedgerEntry);
                end;
            }

            action(SalesInvoices)
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                    Page.Run(Page::"Sales Invoice List", SalesHeader);
                end;
            }

            action(MeterLedgerEntries)
            {
                Caption = 'Meter Ledger Entries';
                Image = Entries;
                ApplicationArea = All;

                // trigger OnAction()
                // var
                //     MeterLedgerEntry: Record "Meter Ledger Entry";
                // begin
                //     MeterLedgerEntry.SetRange("Customer No.", Rec."No.");
                //     Page.Run(Page::"Meter Ledger Entries", MeterLedgerEntry);
                // end;
            }
        }

        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(MeterReadingWorksheet_Promoted; MeterReadingWorksheet) { }

            }

            group(Category_Report)
            {
                Caption = 'Reports';

                actionref(MeterLedgerReport_Promoted; MeterLedgerReport) { }
                actionref(CustomerWaterBalanceReport_Promoted; CustomerWaterBalanceReport) { }
                actionref(MonthlyConsumptionReport_Promoted; MonthlyConsumptionReport) { }
            }

            group(Category_Navigate)
            {
                Caption = 'Navigate';

                actionref(CustomerLedgerEntries_Promoted; CustomerLedgerEntries) { }
                actionref(SalesInvoices_Promoted; SalesInvoices) { }
                actionref(MeterLedgerEntries_Promoted; MeterLedgerEntries) { }
            }
        }
    }
}