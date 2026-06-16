namespace WaterMgt.WaterMgt;

using Microsoft.Sales.Document;

tableextension 50101 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50100; "Billing Month"; Date)
        {
            Caption = 'Billing Month';
        }
        field(50101; "Billing Start Date"; Date)
        {
            Caption = 'Billing Start Date';
        }
        field(50102; "Billing End Date"; Date)
        {
            Caption = 'Billing End Date';
        }
    }
}
