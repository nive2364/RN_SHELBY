pageextension 50215 "Item Ledger Entry Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Historical No."; Rec."Historical No.")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the historical number for this item ledger entry.';
            }
            field("Vendor Description"; Rec."Vendor Description")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the vendor description for this item ledger entry.';
            }
            field("Shelby No."; Rec."Shelby No.")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the Shelby number for this item ledger entry.';
            }
            field("Shelby Description"; Rec."Shelby Description")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the Shelby description for this item ledger entry.';
            }
            field("Historical PN"; Rec."Historical PN")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the historical part number for this item ledger entry.';
            }
            field("Historical Description"; Rec."Historical Description")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the historical description for this item ledger entry.';
            }
        }
    }
}
