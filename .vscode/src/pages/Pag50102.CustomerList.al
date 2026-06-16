namespace WaterMgt.WaterMgt;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.Receivables;

page 50102 "Customer List"
{

    PageType = List;
    SourceTable = Customer;
    Caption = 'Customers List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "customer Card";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field(F_Name; Rec.F_Name)
                {
                    ApplicationArea = All;
                }
                field(M_Name; Rec.M_Name)
                {
                    ApplicationArea = All;
                }
                field(L_Name; Rec.L_Name)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;

                }

                field("Meter No."; Rec."Meter No.")
                {
                    ApplicationArea = All;
                }

                field("Meter Status"; Rec."Meter Status")
                {
                    ApplicationArea = All;
                }
                field("Last Meter Reading"; Rec."Last Meter Reading")
                {
                    ApplicationArea = All;
                }

                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }

                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }

                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
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
        }
    }
}