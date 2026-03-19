tableextension 50102 extendSalesShipmentHeader extends "Sales Shipment Header"
{
    fields
    {
        field(50100; "Trailer No."; Text[50])
        {
            Caption = 'Trailer No.';
            DataClassification = ToBeClassified;
        }
        field(50101; "Tractor No."; Text[50])
        {
            Caption = 'Tractor No.';
            DataClassification = ToBeClassified;
        }
        field(50102; "Seal No."; Text[50])
        {
            Caption = 'Seal No.';
            DataClassification = ToBeClassified;
        }
        field(50103; "Route"; Text[255])
        {
            Caption = 'Shipping Notes';
            DataClassification = ToBeClassified;
        }
        field(50104; "Vehicle Initials"; Text[50])
        {
            Caption = 'Vehicle Initials';
            DataClassification = ToBeClassified;
        }
        field(50105; "Carrier"; Text[50])
        {
            Caption = 'Carrier';
            DataClassification = ToBeClassified;
        }
        field(50106; "PO No."; Text[50])
        {
            Caption = 'PO No.';
            DataClassification = ToBeClassified;
        }
        field(50107; "Pallet Count"; Text[50])
        {
            Caption = 'Pallet Count';
            DataClassification = ToBeClassified;
        }
        field(50109; "Additional Notes"; Boolean)
        {
            Caption = 'Additional Notes';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50110; "Additional Notes2"; Boolean)
        {
            Caption = 'Additional Notes';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50111; "Additional Notes3"; Text[255])
        {
            Caption = 'Additional Notes';
            DataClassification = ToBeClassified;
        }
        field(50108; "Show EU Verbiage"; Boolean)
        {
            Caption = 'EU Statement';
            DataClassification = ToBeClassified;
        }
        field(50112; "Print VSN"; Boolean)
        {
            Caption = 'VSN';
            DataClassification = ToBeClassified;
        }
        field(50113; "Marks"; Option)
        {
            OptionMembers = Domestic, Canada, Mexico, Europe, Asia, Africa, Australia, Other;
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50114; "Marks_lookup"; code[50])
        {
            TableRelation = "Marks"."Marks";
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50117; "Marks_lookup2"; text[50])
        {
            TableRelation = "Marks"."Marks";
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50115; "Marks_Country"; text[50])
        {
            TableRelation = "Marks"."Country";
            DataClassification = ToBeClassified;
            Caption = 'Country';
            InitValue = 'DOMESTIC';
        }
        field(50116; "Marks_text"; text[255])
        {
            Caption = 'Marks';
            FieldClass = FlowField;
            CalcFormula = Lookup(Marks.Marks WHERE(Country=FIELD("Marks_Country")));
        }
        field(50118; "Temperature"; Integer)
        {
            Caption = 'Temperature';
            DataClassification = ToBeClassified;
            InitValue = -10;
        }
        field(50119; "TimeOut"; Time)
        {
            Caption = 'Time Out';
            DataClassification = ToBeClassified;
        }
        field(50120; "ShelbyReleaseNum"; Text[50])
        {
            Caption = 'Shelby Release Number';
            DataClassification = ToBeClassified;
        }
        field(50121; "PrintAPHIS"; Boolean)
        {
            Caption = 'APHIS MD BEEF';
            DataClassification = ToBeClassified;
        }
        field(50122; "PrintFLSA"; Boolean)
        {
            Caption = 'FLSA Statement';
            DataClassification = ToBeClassified;
        }
        field(50123; "PrintInedible"; Boolean)
        {
            Caption = 'Inedible Statement';
            DataClassification = ToBeClassified;
        }
        field(50124; "PrintEV"; Boolean)
        {
            Caption = 'EV Statement';
            DataClassification = ToBeClassified;
        }
        field(50125; "PrintEVRemoveCanada"; Boolean)
        {
            Caption = 'EV Statement w/o Canada';
            DataClassification = ToBeClassified;
        }
        field(50132; "PrintAPHIS_CANADA"; Boolean)
        {
            Caption = 'APHIS CANADA';
            DataClassification = ToBeClassified;
        }
        field(50126; "PrintAPHIS_LIVERS"; Boolean)
        {
            Caption = 'APHIS LIVERS';
            DataClassification = ToBeClassified;
        }
        field(50129; "PrintAPHIS_SPLEEN"; Boolean)
        {
            Caption = 'APHIS SPLEEN';
            DataClassification = ToBeClassified;
        }
        field(50127; "PrintAPHIS_LUNGS"; Boolean)
        {
            Caption = 'APHIS LUNGS';
            DataClassification = ToBeClassified;
        }
        field(50131; "PrintAPHIS_BEEF_HEARTS"; Boolean)
        {
            Caption = 'APHIS BEEF HEARTS';
            DataClassification = ToBeClassified;
        }
        field(50128; "PrintLoadLocks"; Boolean)
        {
            Caption = 'Load Locks';
            DataClassification = ToBeClassified;
        }
        field(50130; "PrintCOA"; Boolean)
        {
            Caption = 'Print COA';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        Temperature:=-10;
        Marks_Country:='DOMESTIC' end;
}
