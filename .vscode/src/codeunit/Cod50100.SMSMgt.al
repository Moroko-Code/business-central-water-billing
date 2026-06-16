namespace WaterMgt.WaterMgt;
using Microsoft.Sales.Customer;
using System.Reflection;

codeunit 50100 "SMS Mgt."
{
    procedure SendWeeklySMS(var MeterReading: Record "Meter Reading")
    var
        Customer: Record Customer;
        WaterSetup: Record "Water Billing Setup";
        Amount: Decimal;
        Msg: Text;
    begin
        WaterSetup.Get('SETUP');
        WaterSetup.TestField("Rate Per Unit");

        if not Customer.Get(MeterReading."Customer No.") then
            exit;

        if Customer."Phone No." = '' then
            exit;

        Amount := MeterReading."Units Used" * WaterSetup."Rate Per Unit";

        Msg := StrSubstNo(
            'Dear %1, your water usage is %2 units. Amount due is KES %3.',
            Customer.Name,
            MeterReading."Units Used",
            Amount);

        SendSMS(Customer."Phone No.", Msg);
    end;

    procedure SendSMS(PhoneNo: Text; MessageText: Text)
    var
        WaterSetup: Record "Water Billing Setup";
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Content: HttpContent;
        Headers: HttpHeaders;
        ContentHeaders: HttpHeaders;
        Body: Text;
        ResponseText: Text;
    begin
        WaterSetup.Get('SETUP');
        WaterSetup.TestField("SMS API Username");
        WaterSetup.TestField("SMS API Key");

        if PhoneNo = '' then
            exit;

        Body :=
            'username=' + UrlEncode(WaterSetup."SMS API Username") +
            '&to=' + UrlEncode(PhoneNo) +
            '&message=' + UrlEncode(MessageText);

        if WaterSetup."SMS Sender ID" <> '' then
            Body += '&from=' + UrlEncode(WaterSetup."SMS Sender ID");

        Content.WriteFrom(Body);
        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');

        Request.Method := 'POST';
        Request.SetRequestUri(WaterSetup."SMS API URL");
        Request.Content := Content;

        Request.GetHeaders(Headers);
        Headers.Add('apiKey', WaterSetup."SMS API Key");
        Headers.Add('Accept', 'application/json');

        if not Client.Send(Request, Response) then
            Error('Failed to send SMS.');

        Response.Content().ReadAs(ResponseText);

        if not Response.IsSuccessStatusCode() then
            Error('SMS failed. Status %1. Response: %2',
                Response.HttpStatusCode(),
                ResponseText);
    end;

    local procedure UrlEncode(Value: Text): Text
    var
        TypeHelper: Codeunit "Type Helper";
    begin
        exit(TypeHelper.UrlEncode(Value));
    end;
}