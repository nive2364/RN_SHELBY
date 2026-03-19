pageextension 50211 "Item List Page Extension" extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Historical No."; Rec."Historical No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the historical number for this item.';
            }
            field("Vendor Description"; Rec."Vendor Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor description for this item.';
            }
            field("Shelby No."; Rec."Shelby No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Shelby number for this item.';
            }
            field("Shelby Description"; Rec."Shelby Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Shelby description for this item.';
            }
            field("Historical PN"; Rec."Historical PN")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the historical part number for this item.';
            }
            field("Historical Description"; Rec."Historical Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the historical description for this item.';
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action("Update All Historical Item Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Update All Historical Item Ledger Entries';
                Image = UpdateDescription;
                ToolTip = 'Updates all existing Item Ledger Entries and Item Variants for all items with the current field values from the Item table. This may take a few minutes for large datasets.';

                trigger OnAction()
                var
                    ItemLedgerEntryHelper: Codeunit "Item Ledger Entry Helper";
                    LedgerEntryCount: Integer;
                    VariantCount: Integer;
                    ConfirmMsg: Label 'This will update all Item Ledger Entries and Item Variants for all items. This may take several minutes. Do you want to continue?';
                begin
                    if not Confirm(ConfirmMsg) then
                        exit;

                    LedgerEntryCount := ItemLedgerEntryHelper.UpdateAllHistoricalItemLedgerEntries();
                    VariantCount := ItemLedgerEntryHelper.UpdateAllHistoricalItemVariants();
                    Message('Successfully updated %1 Item Ledger Entry record(s) and %2 Item Variant record(s) for all items.', LedgerEntryCount, VariantCount);
                end;
            }
        }
    }
}

