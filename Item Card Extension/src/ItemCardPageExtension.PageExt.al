pageextension 50210 "Item Card Page Extension" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Historical No."; Rec."Historical No.")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the historical number for this item.';
            }
            field("Vendor Description"; Rec."Vendor Description")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the vendor description for this item.';
            }
            field("Shelby No."; Rec."Shelby No.")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the Shelby number for this item.';
            }
            field("Shelby Description"; Rec."Shelby Description")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the Shelby description for this item.';
            }
            field("Historical PN"; Rec."Historical PN")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the historical part number for this item.';
            }
            field("Historical Description"; Rec."Historical Description")
            {
                ApplicationArea = All;
                Tooltip = 'Specifies the historical description for this item.';
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action("Update Historical Item Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Update Historical Item Ledger Entries';
                Image = UpdateDescription;
                ToolTip = 'Updates all existing Item Ledger Entries and Item Variants for this item with the current field values from the Item Card.';

                trigger OnAction()
                var
                    ItemLedgerEntryHelper: Codeunit "Item Ledger Entry Helper";
                    LedgerEntryCount: Integer;
                    VariantCount: Integer;
                begin
                    LedgerEntryCount := ItemLedgerEntryHelper.UpdateHistoricalItemLedgerEntries(Rec."No.");
                    VariantCount := ItemLedgerEntryHelper.UpdateHistoricalItemVariants(Rec."No.");
                    Message('Updated %1 Item Ledger Entry record(s) and %2 Item Variant record(s) for item %3.', LedgerEntryCount, VariantCount, Rec."No.");
                end;
            }
        }
    }
}
