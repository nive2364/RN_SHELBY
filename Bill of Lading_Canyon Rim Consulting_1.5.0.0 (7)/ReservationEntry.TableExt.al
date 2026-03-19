tableextension 50105 ReservationEntry extends "Reservation Entry"
{
    fields
    {
        field(50100; BlockCount; Integer)
        {
            Caption = 'BlockCount';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if BlockCount <= 0 then Error('Block Count must be greater than 0.');
            end;
        }
        field(50101; FAT; Decimal)
        {
            Caption = 'FAT';
            DecimalPlaces = 2: 2; // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }
        field(50102; PROTEIN; Decimal)
        {
            Caption = 'PROTEIN';
            DecimalPlaces = 2: 2; // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }
        field(50103; MOISTURE; Decimal)
        {
            Caption = 'MOISTURE';
            DecimalPlaces = 2: 2; // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }
        field(50104; ASH; Decimal)
        {
            Caption = 'ASH';
            DecimalPlaces = 2: 2; // Forces exactly 2 decimal places
            DataClassification = ToBeClassified;
        }
    }
}
