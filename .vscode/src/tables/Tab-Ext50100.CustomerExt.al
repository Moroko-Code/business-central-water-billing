namespace WaterMgt.WaterMgt;

using Microsoft.Sales.Customer;

tableextension 50100 "Customer Ext" extends Customer
{
    fields
    {
        field(50100; "Meter No."; Code[20])
        {
            Caption = 'Meter No.';
            TableRelation = "Water Meter"."Meter No.";

            trigger OnValidate()
            var
                WaterMeter: Record "Water Meter";
            begin
                if WaterMeter.Get("Meter No.") then
                    "Meter Status" := WaterMeter.Status
            end;
        }

        field(50101; "Last Meter Reading"; Decimal)
        {
            Caption = 'Last Meter Reading';
        }

        field(50102; "Meter Status"; Option)
        {
            Caption = 'Meter Status';
            OptionMembers = Active,Inactive;
            Editable = false;
        }
        field(50103; F_Name; Text[100])
        {
            Caption = 'First Name';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateCustomerName();
            end;
        }
        field(50104; M_Name; Text[100])
        {
            Caption = 'Middle Name';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateCustomerName();
            end;
        }
        field(50105; L_Name; Text[100])
        {
            Caption = 'Last Name';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateCustomerName();
            end;
        }
        field(50106; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }


    }
    local procedure UpdateCustomerName()
    begin
        Rec.Name := DelChr(F_Name + ' ' + M_Name + ' ' + L_Name, '<>');
    end;
}