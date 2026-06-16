table 50103 "SMS Log"
{
    Caption = 'SMS Log';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Phone No."; Text[30]) { }
        field(3; Message; Text[250]) { }
        field(4; "Sent DateTime"; DateTime) { }
        field(5; Status; Option)
        {
            OptionMembers = Pending,Sent,Failed;
        }
        field(6; Response; Text[250]) { }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
    }
}