tableextension 50212 "Item Variant Table Extension" extends "Item Variant"
{
    fields
    {
        field(50210; "Historical No."; Code[20])
        {
            Caption = 'Historical No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50211; "Vendor Description"; Text[100])
        {
            Caption = 'Vendor Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50212; "Shelby No."; Code[20])
        {
            Caption = 'Shelby No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50213; "Shelby Description"; Text[100])
        {
            Caption = 'Shelby Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50214; "Historical PN"; Code[20])
        {
            Caption = 'Historical PN';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50215; "Historical Description"; Text[100])
        {
            Caption = 'Historical Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}

