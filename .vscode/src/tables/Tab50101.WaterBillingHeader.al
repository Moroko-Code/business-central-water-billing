namespace WaterMgt.WaterMgt;

using Microsoft.Sales.Customer;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.NoSeries;

table 50120 "Water Bill Header"
{
    Caption = 'Water Bill Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    BSetup.Get();
                    NoSeriesMgt.TestManual(BSetup."Water Bill Nos.");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get("Customer No.") then begin
                    "Customer Name" := Customer.Name;
                    Validate("Payment Terms Code", Customer."Payment Terms Code");
                end else begin
                    Clear("Customer Name");
                    Clear("Payment Terms Code");
                    Clear("Due Date");
                end;
            end;
        }

        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            Editable = false;
        }

        field(4; "Billing Date"; Date)
        {
            Caption = 'Billing Date';

            trigger OnValidate()
            begin
                if "Billing Date" <> 0D then begin
                    "Billing Month" := GetMonthStart("Billing Date");
                    CalculateDueDate();
                end;
            end;
        }

        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }

        field(6; "Posted Sales Invoice No."; Code[20])
        {
            Caption = 'Posted Invoice No.';
            Editable = false;
        }

        field(7; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }

        field(8; "Due Date"; Date)
        {
            Caption = 'Due Date';
            Editable = false;
        }

        field(9; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms".Code;

            trigger OnValidate()
            begin
                CalculateDueDate();
            end;
        }

        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }

        field(50; "Billing Month"; Date)
        {
            Caption = 'Billing Month';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            BSetup.Get('SETUP');
            BSetup.TestField("Water Bill Nos.");

            "No. Series" := BSetup."Water Bill Nos.";

            "No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate(), true);
        end;

        if "Billing Date" = 0D then
            Validate("Billing Date", WorkDate());

        if "Posting Date" = 0D then
            Validate("Posting Date", WorkDate());

        CalculateDueDate();
    end;

    local procedure CalculateDueDate()
    var
        PaymentTerms: Record "Payment Terms";
    begin
        if "Billing Date" = 0D then
            exit;

        if "Payment Terms Code" = '' then begin
            "Due Date" := "Billing Date";
            exit;
        end;

        if PaymentTerms.Get("Payment Terms Code") then
            "Due Date" := CalcDate(PaymentTerms."Due Date Calculation", "Billing Date");
    end;

    procedure GetMonthStart(InputDate: Date): Date
    begin
        exit(DMY2Date(1, Date2DMY(InputDate, 2), Date2DMY(InputDate, 3)));
    end;

    var
        BSetup: Record "Water Billing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}