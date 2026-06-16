

namespace WaterMgt.WaterMgt;

using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Posting;

codeunit 50102 "Water Billing Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure CopyBillingFieldsToPostedInvoice(
        var SalesInvHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header")
    begin
        SalesInvHeader."Billing Month" := SalesHeader."Billing Month";
        SalesInvHeader."Billing Start Date" := SalesHeader."Billing Start Date";
        SalesInvHeader."Billing End Date" := SalesHeader."Billing End Date";
        SalesInvHeader.Modify();
    end;
}


