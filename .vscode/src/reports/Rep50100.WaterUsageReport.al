namespace WaterMgt.WaterMgt;

using Microsoft.Foundation.Company;

report 50120 "Water Usage Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Water Usage Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/WaterUsageReport.rdlc';

    dataset
    {
        dataitem(MeterLedgerEntry; "Meter Ledger Entry")
        {
            RequestFilterFields = "Customer No.", "Reading Date", "Units Used";

            column(CompanyName;
            CompanyInfo.Name)
            { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(ReportTitle; ReportTitleLbl) { }
            column(UserID; UserId()) { }
            column(PrintDate; Today()) { }
            column(ReadingDateFilter; GetFilter("Reading Date")) { }
            column(CustomerFilter; GetFilter("Customer No.")) { }
            column(MeterFilter; GetFilter("Meter No.")) { }
            column(Customer_No_; "Customer No.") { }
            column(Customer_Name; "Customer Name") { }
            column(Meter_No_; "Meter No.") { }
            column(Reading_Date; "Reading Date") { }
            column(Previous_Reading; "Previous Reading") { }
            column(Current_Reading; "Current Reading") { }
            column(Units_Used; "Units Used") { }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportTitleLbl: Label 'Water Usage Report';
}