table 50104 "Water Billing Cue"
{
    Caption = 'Water Billing Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[10]) { }

        field(2; "Total Customers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer);
        }

        field(3; "Total Water Meters"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Water Meter");
        }

        // field(4; "Pending Tracking SMS"; Integer)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = count("Meter Reading" where("Tracking SMS Sent" = const(false)));
        // }

        // field(5; "Pending Monthly Billing"; Integer)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = count("Meter Reading" where("Monthly Invoice Created" = const(false)));
        // }

        field(6; "Pending SMS Logs"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("SMS Log" where(Status = const(Pending)));
        }

        field(7; "Sales Invoices"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice)));
        }

        field(8; "Posted Sales Invoices"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header");
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}