namespace projBillofLading.projBillofLading;

using Microsoft.Sales.History;

tableextension 50103 SalesShipmentLine extends "Sales Shipment Line"
{
    fields
    {
        field(50100; BlockCount; Integer)
        {
            Caption = 'BlockCount';
            DataClassification = ToBeClassified;
            InitValue = 48;
        }
        field(50101; FAT; Decimal)
        {
            Caption = 'FAT';
            DecimalPlaces = 2 : 2;     // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }
        field(50102; PROTEIN; Decimal)
        {
            Caption = 'PROTEIN';
            DecimalPlaces = 2 : 2;     // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }

        field(50103; MOISTURE; Decimal)
        {
            Caption = 'MOISTURE';
            DecimalPlaces = 2 : 2;     // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }
        field(50104; ASH; Decimal)
        {
            Caption = 'ASH';
            DecimalPlaces = 2 : 2;     // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }
    }
}
