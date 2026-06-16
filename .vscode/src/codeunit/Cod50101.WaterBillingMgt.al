namespace WaterMgt.WaterMgt;

using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;
using Microsoft.Sales.History;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;

codeunit 50101 "Water Billing Mgt."
{

    procedure CreateAndPostInvoicesForAllCustomers()
    var
        MeterLedgerEntry: Record "Meter Ledger Entry";
        WaterSetup: Record "Water Billing Setup";
        LastCustomerNo: Code[20];
        PostedCount: Integer;
    begin
        WaterSetup.Get('SETUP');

        WaterSetup.TestField("Billing Month");
        WaterSetup.TestField("Billing Start Date");
        WaterSetup.TestField("Billing End Date");
        WaterSetup.TestField("Water Service Item No.");
        WaterSetup.TestField("Rate Per Unit");

        if not Confirm(
            'Create and post water invoices for billing period %1 to %2?',
            false,
            WaterSetup."Billing Start Date",
            WaterSetup."Billing End Date")
        then
            exit;

        MeterLedgerEntry.Reset();
        MeterLedgerEntry.SetCurrentKey("Customer No.", "Reading Date");
        MeterLedgerEntry.SetRange(Posted, true);
        MeterLedgerEntry.SetRange(Invoiced, false);
        MeterLedgerEntry.SetRange(
            "Reading Date",
            WaterSetup."Billing Start Date",
            WaterSetup."Billing End Date");

        if not MeterLedgerEntry.FindSet() then
            Error(
                'No meter ledger entries found for period %1 to %2. Check Posted, Invoiced, and Reading Date.',
                WaterSetup."Billing Start Date",
                WaterSetup."Billing End Date");

        repeat
            if MeterLedgerEntry."Customer No." <> LastCustomerNo then begin
                LastCustomerNo := MeterLedgerEntry."Customer No.";

                CreateAndPostSalesInvoice(LastCustomerNo, false);
                PostedCount += 1;
            end;
        until MeterLedgerEntry.Next() = 0;

        Message('%1 invoices posted.', PostedCount);

        if Confirm('Do you want to open the posted sales invoices?', false) then
            PAGE.Run(PAGE::"Posted Sales Invoices");
    end;

    procedure CreateAndPostSingleCustomerInvoice(CustomerNo: Code[20])
    var
        PostedInvoiceNo: Code[20];
    begin
        PostedInvoiceNo := CreateAndPostSalesInvoice(CustomerNo, true);
    end;

    local procedure CreateAndPostSalesInvoice(CustomerNo: Code[20]; OpenPostedInvoice: Boolean) PostedInvoiceNo: Code[20]
    var
        WaterSetup: Record "Water Billing Setup";
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TotalUnits: Decimal;
        LineNo: Integer;
        PreAssignedNo: Code[20];
    begin
        WaterSetup.Get('SETUP');

        TotalUnits := GetTotalUnitsForCustomer(CustomerNo);

        SalesHeader.Init();
        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        SalesHeader.Validate("Posting Date", WorkDate());
        SalesHeader.Validate("Document Date", WaterSetup."Billing End Date");

        SalesHeader."Billing Month" := WaterSetup."Billing Month";
        SalesHeader."Billing Start Date" := WaterSetup."Billing Start Date";
        SalesHeader."Billing End Date" := WaterSetup."Billing End Date";

        SalesHeader.Insert(true);

        if TotalUnits > 0 then
            AddWaterUsageLine(SalesHeader, LineNo, TotalUnits, WaterSetup);

        AddFlatChargeLine(SalesHeader, LineNo, WaterSetup);

        if CustomerHasOverdueBalance(CustomerNo, WaterSetup."Billing End Date") then
            AddPenaltyLine(SalesHeader, LineNo, WaterSetup);

        if LineNo = 0 then
            Error('No invoice lines created for customer %1.', CustomerNo);

        PreAssignedNo := SalesHeader."No.";

        SalesPost.Run(SalesHeader);

        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);

        if SalesInvoiceHeader.FindFirst() then
            PostedInvoiceNo := SalesInvoiceHeader."No."
        else
            PostedInvoiceNo := PreAssignedNo;

        MarkMeterLedgerEntriesAsInvoiced(CustomerNo, PostedInvoiceNo);
    end;

    local procedure GetTotalUnitsForCustomer(CustomerNo: Code[20]): Decimal
    var
        MeterLedgerEntry: Record "Meter Ledger Entry";
        WaterSetup: Record "Water Billing Setup";
        TotalUnits: Decimal;
    begin
        WaterSetup.Get('SETUP');

        MeterLedgerEntry.Reset();
        MeterLedgerEntry.SetRange("Customer No.", CustomerNo);
        MeterLedgerEntry.SetRange(Posted, true);
        MeterLedgerEntry.SetRange(Invoiced, false);
        MeterLedgerEntry.SetRange(
            "Reading Date",
            WaterSetup."Billing Start Date",
            WaterSetup."Billing End Date");

        if MeterLedgerEntry.FindSet() then
            repeat
                TotalUnits += MeterLedgerEntry."Units Used";
            until MeterLedgerEntry.Next() = 0;

        exit(TotalUnits);
    end;

    local procedure AddWaterUsageLine(
        SalesHeader: Record "Sales Header";
        var LineNo: Integer;
        TotalUnits: Decimal;
        WaterSetup: Record "Water Billing Setup")
    var
        SalesLine: Record "Sales Line";
    begin
        LineNo += 10000;

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", LineNo);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", WaterSetup."Water Service Item No.");
        SalesLine.Validate(
            Description,
            StrSubstNo(
                'Water usage %1 to %2',
                WaterSetup."Billing Start Date",
                WaterSetup."Billing End Date"));
        SalesLine.Validate(Quantity, TotalUnits);
        SalesLine.Validate("Unit Price", WaterSetup."Rate Per Unit");
        SalesLine.Insert(true);
    end;

    local procedure AddFlatChargeLine(
        SalesHeader: Record "Sales Header";
        var LineNo: Integer;
        WaterSetup: Record "Water Billing Setup")
    var
        SalesLine: Record "Sales Line";
    begin
        if WaterSetup."Flat Charge Amount" = 0 then
            exit;

        WaterSetup.TestField("Flat Charge Item No.");

        LineNo += 10000;

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", LineNo);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", WaterSetup."Flat Charge Item No.");
        SalesLine.Validate(Description, 'Monthly flat charge');
        SalesLine.Validate(Quantity, 1);
        SalesLine.Validate("Unit Price", WaterSetup."Flat Charge Amount");
        SalesLine.Insert(true);
    end;

    local procedure AddPenaltyLine(
        SalesHeader: Record "Sales Header";
        var LineNo: Integer;
        WaterSetup: Record "Water Billing Setup")
    var
        SalesLine: Record "Sales Line";
    begin
        if WaterSetup."Penalty Amount" = 0 then
            exit;

        WaterSetup.TestField("Penalty Item No.");

        LineNo += 10000;

        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", LineNo);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", WaterSetup."Penalty Item No.");
        SalesLine.Validate(Description, 'Late payment penalty');
        SalesLine.Validate(Quantity, 1);
        SalesLine.Validate("Unit Price", WaterSetup."Penalty Amount");
        SalesLine.Insert(true);
    end;

    local procedure CustomerHasOverdueBalance(CustomerNo: Code[20]; BillingEndDate: Date): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Customer No.", CustomerNo);
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetFilter("Due Date", '<%1', BillingEndDate);

        exit(not CustLedgerEntry.IsEmpty());
    end;

    local procedure MarkMeterLedgerEntriesAsInvoiced(CustomerNo: Code[20]; InvoiceNo: Code[20])
    var
        MeterLedgerEntry: Record "Meter Ledger Entry";
        WaterSetup: Record "Water Billing Setup";
    begin
        WaterSetup.Get('SETUP');

        MeterLedgerEntry.Reset();
        MeterLedgerEntry.SetRange("Customer No.", CustomerNo);
        MeterLedgerEntry.SetRange(Posted, true);
        MeterLedgerEntry.SetRange(Invoiced, false);
        MeterLedgerEntry.SetRange(
            "Reading Date",
            WaterSetup."Billing Start Date",
            WaterSetup."Billing End Date");

        if MeterLedgerEntry.FindSet() then
            repeat
                MeterLedgerEntry.Invoiced := true;
                MeterLedgerEntry."Invoice No." := InvoiceNo;
                MeterLedgerEntry.Modify(true);
            until MeterLedgerEntry.Next() = 0;
    end;

    local procedure MoveSetupToNextBillingPeriod()
    var
        WaterSetup: Record "Water Billing Setup";
        OldEndDate: Date;
    begin
        WaterSetup.Get('SETUP');

        OldEndDate := WaterSetup."Billing End Date";

        WaterSetup."Billing Start Date" := CalcDate('<+1D>', OldEndDate);
        WaterSetup."Billing End Date" := CalcDate('<+4W>', OldEndDate);
        WaterSetup."Billing Month" := CalcDate('<+1M>', WaterSetup."Billing Month");

        WaterSetup.Modify(true);
    end;
}