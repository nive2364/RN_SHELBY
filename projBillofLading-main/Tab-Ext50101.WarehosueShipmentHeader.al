namespace projBillofLading.projBillofLading;

using Microsoft.Warehouse.Document;

tableextension 50101 extendWarehosueShipmentHeader extends "Warehouse Shipment Header"
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
        field(50103; Route; Text[255])
        {
            Caption = 'Route';
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
    }
}
