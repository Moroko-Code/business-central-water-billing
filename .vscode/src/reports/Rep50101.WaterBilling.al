namespace WaterMgt.WaterMgt;

using Microsoft.Sales.History;
using Microsoft.Foundation.Company;

report 50101 WaterBilling
{
    ApplicationArea = All;
    Caption = 'WaterBilling';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/WaterBilling.rdlc';

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(CustomerFullName; CustomerFullName) { }
            column(Sell_to_Phone_No_; "Sell-to Phone No.") { }
            column(Sell_to_Address; "Sell-to Address") { }

            dataitem(SalesInvLine; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = filter(Item | "G/L Account"));

                column(Billing_Start_Date; Format(SalesInvoiceHeader."Billing Start Date", 0, '<Day,2>-<Month Text,3>-<Year4>')) { }
                column(Billing_End_Date; Format(SalesInvoiceHeader."Billing End Date", 0, '<Day,2>-<Month Text,3>-<Year4>')) { }
                column(DueDate; Format(SalesInvoiceHeader."Due Date", 0, '<Day,2>-<Month Text,3>-<Year4>')) { }
                column(CurrentReading; CurrentReading) { }
                column(PreviousReading; PreviousReading) { }
                column(UnitsUsed; Quantity) { }
                column(UnitPrice; "Unit Price") { }
                column(Amount; Amount) { }
            }

            trigger OnAfterGetRecord()
            var
                MeterLedgerEntry: Record "Meter Ledger Entry";
            begin
                Clear(CurrentReading);
                Clear(PreviousReading);

                MeterLedgerEntry.Reset();
                MeterLedgerEntry.SetRange("Invoice No.", "No.");
                MeterLedgerEntry.SetRange(Invoiced, true);

                if MeterLedgerEntry.FindFirst() then begin
                    PreviousReading := MeterLedgerEntry."Previous Reading";
                    CurrentReading := MeterLedgerEntry."Current Reading";
                    CustomerFullName := MeterLedgerEntry."Customer Name";
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CustomerFullName: Text[250];
        CurrentReading: Decimal;
        PreviousReading: Decimal;
}