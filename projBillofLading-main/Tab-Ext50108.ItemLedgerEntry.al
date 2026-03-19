namespace projBillofLading.projBillofLading;

using Microsoft.Inventory.Ledger;

tableextension 50108 ItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50100; BlcokCount; Integer)
        {
            Caption = 'Block Count';
            DataClassification = ToBeClassified;
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
