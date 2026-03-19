table 50100 Marks
{
    Caption = 'Marks';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Country; Text[50])
        {
            Caption = 'Country';
        }
        field(2; Marks; Text[255])
        {
            Caption = 'Marks';
        }
    }
    keys
    {
        key(PK; Country)
        {
            Clustered = true;
        }

    }
}

table 50101 "My Temp Table"
{
    Caption = 'Marks';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Country; Text[50])
        {
            Caption = 'Country';
        }
        field(2; Marks; Text[255])
        {
            Caption = 'Marks';
        }
    }
    keys
    {
        key(PK; Country, Marks)
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Country", "Marks")
        {
        }
    }
}
