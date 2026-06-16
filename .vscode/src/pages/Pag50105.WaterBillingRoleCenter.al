namespace WaterMgt.WaterMgt;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Purchases.Setup;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Sales.Setup;
using Microsoft.Sales.Customer;

page 50105 "Water Billing Role Center"
{
    ApplicationArea = All;
    Caption = 'Water Billing Role Center';
    PageType = RoleCenter;
    layout
    {
        area(RoleCenter)
        {
            part(Activities; "Water Billing Activities")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(WaterBilling)
            {
                Caption = 'Water Billing';

                action(Customers)
                {
                    Caption = 'Customers';
                    ApplicationArea = All;
                    RunObject = page "Customer List";
                }
                action(MeterReadings)
                {
                    Caption = 'Meter Readings';
                    ApplicationArea = All;
                    RunObject = page "Meter Reading List";
                }
                action(PostedSalesInvoices)
                {
                    Caption = 'Posted Invoices';
                    ApplicationArea = All;
                    RunObject = page "Posted Sales Invoices";
                }
                action(SMSLogs)
                {
                    Caption = 'SMS Logs';
                    ApplicationArea = All;
                    RunObject = page "SMS Log List";
                }
                group("Setup")
                {
                    Caption = 'Setup';
                    action("Billing Setup")
                    {
                        Caption = 'Billing Setup';
                        ApplicationArea = All;
                        Image = Setup;
                        RunObject = page "Water Billing Setup";
                    }
                    action("Water Meter Setup")
                    {
                        Caption = 'Water Meter Setup';
                        ApplicationArea = All;
                        Image = Setup;
                        RunObject = page "Water Meter Worksheet";
                    }
                }
            }
            group("General Setup")
            {
                Caption = 'General Setup';
                action(GeneralLedgerSetup)
                {
                    Caption = 'General Ledger Setup';
                    ApplicationArea = All;
                    RunObject = page "General Ledger Setup";
                }
                action("Chart of Accounts")
                {
                    Caption = 'Chart of Accounts';
                    ApplicationArea = All;
                    RunObject = page "Chart of Accounts";
                }
                action("Sales & Receivables Setup")
                {
                    Caption = 'Sales & Receivables Setup';
                    ApplicationArea = All;
                    RunObject = page "Sales & Receivables Setup";
                }
                action("General Posting Setup")
                {
                    Caption = 'General Posting Setup';
                    ApplicationArea = All;
                    RunObject = page "General Posting Setup";
                }
            }
        }
        area(Creation)
        {
            action(NewCustomer)
            {
                Caption = 'New Customer';
                ApplicationArea = All;
                Image = Customer;
                RunObject = page "Customer Card";
                RunPageMode = Create;
            }
            group("New Entries")
            {
                Caption = 'Meter Reading';
                action(NewMeterReading)
                {
                    Caption = 'Meter Reading';
                    ApplicationArea = All;
                    Image = List;
                    RunObject = page "Meter Reading List";
                }
                action("Meter ledger")
                {
                    Caption = 'Meter Ledger Entry';
                    ApplicationArea = All;
                    Image = Entries;
                    RunObject = page "Meter Ledger Entries List";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';

                action(WaterUsageReport)
                {
                    Caption = 'Water Usage Report';
                    ApplicationArea = All;
                    Image = Report;
                    RunObject = report "Water Usage Report";
                }
                action("Invoice Report")
                {
                    Caption = 'Invoice Report';
                    ApplicationArea = All;
                    Image = Report;
                    //RunObject = report "Invoice Report";
                }
                action("Customer Statement")
                {
                    Caption = 'Customer Statement';
                    ApplicationArea = All;
                    Image = Report;
                    //RunObject = report "Customer Statement";
                }

            }

        }
    }
}