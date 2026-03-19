pageextension 50211 "Item List Page Extension" extends "Item List"
{
    actions
    {
        addlast(processing)
        {
            action("Update All Historical Item Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Update All Historical Item Ledger Entries';
                Image = UpdateDescription;
                ToolTip = 'Updates all existing Item Ledger Entries for all items with the current field values from the Item table. This may take a few minutes for large datasets.';

                trigger OnAction()
                var
                    ItemLedgerEntryHelper: Codeunit "Item Ledger Entry Helper";
                    UpdatedCount: Integer;
                    ConfirmMsg: Label 'This will update all Item Ledger Entries for all items. This may take several minutes. Do you want to continue?';
                begin
                    if not Confirm(ConfirmMsg)then exit;
                    UpdatedCount:=ItemLedgerEntryHelper.UpdateAllHistoricalItemLedgerEntries();
                    Message('Successfully updated %1 Item Ledger Entry record(s) for all items.', UpdatedCount);
                end;
            }
        }
    }
}
