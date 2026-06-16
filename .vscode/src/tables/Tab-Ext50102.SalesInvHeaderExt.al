namespace WaterMgt.WaterMgt;

using Microsoft.Sales.History;

tableextension 50102 "Sales Inv Header Ext" extends "Sales Invoice Header"
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