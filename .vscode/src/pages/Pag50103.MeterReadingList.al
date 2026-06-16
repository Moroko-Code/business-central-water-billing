
namespace WaterMgt.WaterMgt;
using Microsoft.Sales.Customer;

page 50103 "Meter Reading List"
{
    ApplicationArea = All;
    Caption = 'Meter Reading List';
    PageType = Worksheet;
    SourceTable = "Meter Reading";
    UsageCategory = Tasks;
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; Editable = false; }
                field("Customer No."; Rec."Customer No.") { ApplicationArea = All; }
                field("Customer Name"; Rec."Customer Name") { ApplicationArea = All; Editable = false; }
                field("Meter No."; Rec."Meter No.") { ApplicationArea = All; Editable = false; }
                field("Reading Date"; Rec."Reading Date") { ApplicationArea = All; }
                field("Previous Reading"; Rec."Previous Reading") { ApplicationArea = All; Editable = false; }
                field("Current Reading"; Rec."Current Reading") { ApplicationArea = All; }
                field("Units Used"; Rec."Units Used") { ApplicationArea = All; Editable = false; }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SuggestMeterReadings)
            {
                Caption = 'Suggest Meter Readings';
                Image = SuggestLines;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    MeterReading: Record "Meter Reading";
                    EntryNo: Integer;
                begin
                    if not Confirm('Existing unposted worksheet lines for today will be deleted and recreated. Continue?', false) then
                        exit;

                    MeterReading.Reset();
                    MeterReading.SetRange("Reading Date", WorkDate());
                    MeterReading.SetRange(Posted, false);
                    if not MeterReading.IsEmpty then
                        MeterReading.DeleteAll();

                    MeterReading.Reset();
                    if MeterReading.FindLast() then
                        EntryNo := MeterReading."Entry No.";

                    Customer.Reset();
                    Customer.SetFilter("Meter No.", '<>%1', '');
                    Customer.SetRange("Meter Status", Customer."Meter Status"::Active);

                    if Customer.FindSet() then
                        repeat
                            EntryNo += 1;

                            MeterReading.Init();
                            MeterReading."Entry No." := EntryNo;
                            MeterReading."Customer No." := Customer."No.";
                            MeterReading."Customer Name" := Customer.F_Name + ' ' + Customer.L_Name;
                            MeterReading."Meter No." := Customer."Meter No.";
                            MeterReading."Reading Date" := WorkDate();
                            MeterReading."Previous Reading" := Customer."Last Meter Reading";
                            MeterReading."Current Reading" := 0;
                            MeterReading."Units Used" := 0;
                            MeterReading.Posted := false;
                            MeterReading.Insert();
                        until Customer.Next() = 0;
                    Message('Meter reading worksheet lines created successfully.');
                end;
            }
            action(UpdateReadings)
            {
                Caption = 'Update Weekly Readings';
                Image = Save;
                ApplicationArea = All;

                trigger OnAction()
                var
                    MeterReading: Record "Meter Reading";
                    Customer: Record Customer;
                    MeterLedgerEntry: Record "Meter Ledger Entry";
                    SMSMgt: Codeunit "SMS Mgt.";
                    NewEntryNo: Integer;
                    PostedCount: Integer;
                begin
                    if not Confirm('Post all meter readings for today?', false) then
                        exit;

                    MeterLedgerEntry.Reset();
                    if MeterLedgerEntry.FindLast() then
                        NewEntryNo := MeterLedgerEntry."Entry No.";

                    MeterReading.Reset();
                    //MeterReading.SetRange("Reading Date", WorkDate());
                    MeterReading.SetRange(Posted, false);

                    if MeterReading.FindSet() then
                        repeat
                            MeterReading.TestField("Customer No.");
                            MeterReading.TestField("Meter No.");
                            MeterReading.TestField("Current Reading");

                            if MeterReading."Current Reading" < MeterReading."Previous Reading" then
                                Error(
                                    'Current Reading cannot be less than Previous Reading for customer %1.',
                                    MeterReading."Customer No.");

                            MeterReading."Units Used" := MeterReading."Current Reading" - MeterReading."Previous Reading";
                            NewEntryNo += 1;

                            MeterLedgerEntry.Init();
                            MeterLedgerEntry."Entry No." := NewEntryNo;
                            MeterLedgerEntry."Meter No." := MeterReading."Meter No.";
                            MeterLedgerEntry."Customer No." := MeterReading."Customer No.";
                            MeterLedgerEntry."Customer Name" := MeterReading."Customer Name";
                            MeterLedgerEntry."Reading Date" := MeterReading."Reading Date";
                            MeterLedgerEntry."Previous Reading" := MeterReading."Previous Reading";
                            MeterLedgerEntry."Current Reading" := MeterReading."Current Reading";
                            MeterLedgerEntry."Units Used" := MeterReading."Units Used";
                            MeterLedgerEntry."Posted Date" := WorkDate();
                            MeterLedgerEntry."Posted By" := UserId;
                            MeterLedgerEntry."Invoiced" := false;
                            MeterLedgerEntry.Posted := true;
                            MeterLedgerEntry.Insert();

                            Customer.Get(MeterReading."Customer No.");
                            Customer."Last Meter Reading" := MeterReading."Current Reading";
                            Customer.Modify();

                            // SMSMgt.SendWeeklySMS(MeterReading);
                            PostedCount += 1;
                        until MeterReading.Next() = 0;
                    MeterReading.DeleteAll();

                    Message('%1 meter readings posted successfully.', PostedCount);
                end;
            }
            action("WaterUsageReport")
            {
                Caption = 'Water Usage Report';
                Image = Report;
                ApplicationArea = All;
                RunObject = report "Water Usage Report";
            }
            action("CreateAndPostInvoice")
            {
                Caption = 'Create and Post Invoice';
                Image = PostBatch;
                ApplicationArea = All;

                trigger OnAction()
                var
                    WaterBillingMgt: Codeunit "Water Billing Mgt.";
                begin
                    WaterBillingMgt.CreateAndPostInvoicesForAllCustomers();
                    CurrPage.Update(false);
                end;
            }
            action(MeterReadingHistory)
            {
                Caption = 'Meter Reading History';
                Image = History;
                ApplicationArea = All;
                RunObject = page "Meter Ledger Entries List";
            }
        }
        area(Promoted)
        {
            actionref(SuggestMeterReadings_Promoted; SuggestMeterReadings) { }
            actionref(PostAllReadings_Promoted; UpdateReadings) { }
            actionref("water usage report_Promoted"; "WaterUsageReport") { }
            actionref(CreateAndPostInvoice_Promoted; CreateAndPostInvoice) { }
            actionref(MeterReadingHistory_Promoted; MeterReadingHistory) { }
        }
    }
}