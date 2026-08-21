codeunit 50124 GetOnHandInventory
{
    // Procedure to adjust the item ledger entry to a specific date
    procedure AdjustItemLedgEntryToAsOfDate(var ItemLedgerEntry: Record "Item Ledger Entry"; EndDate: Date; ShowACY: Boolean; Currency: Record Currency)
    var
        ItemApplicationEntry: Record "Item Application Entry";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
    begin
        // Initialize the remaining quantity to the total quantity
        ItemLedgerEntry."Remaining Quantity" := ItemLedgerEntry.Quantity;

        // Load necessary fields for ItemLedgerEntry2 and ItemApplicationEntry
        ItemLedgerEntry2.SetLoadFields("Posting Date");
        ItemApplicationEntry.SetLoadFields("Posting Date", "Outbound Item Entry No.", "Inbound Item Entry No.", "Item Ledger Entry No.", Quantity, "Cost Application", "Transferred-from Entry No.");

        // If the item ledger entry is positive
        if ItemLedgerEntry.Positive then begin
            // Set the current key and ranges for ItemApplicationEntry
            ItemApplicationEntry.SetCurrentKey("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplicationEntry.SetRange("Inbound Item Entry No.", ItemLedgerEntry."Entry No.");
            ItemApplicationEntry.SetRange("Posting Date", 0D, EndDate);
            ItemApplicationEntry.SetFilter("Outbound Item Entry No.", '<>%1', 0);
            ItemApplicationEntry.SetFilter("Item Ledger Entry No.", '<>%1', ItemLedgerEntry."Entry No.");
            // Calculate the sums and adjust the remaining quantity
            ItemApplicationEntry.CalcSums(Quantity);
            ItemLedgerEntry."Remaining Quantity" += ItemApplicationEntry.Quantity;
        end else begin
            // If the item ledger entry is negative
            ItemApplicationEntry.SetCurrentKey("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
            ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
            ItemApplicationEntry.SetRange("Outbound Item Entry No.", ItemLedgerEntry."Entry No.");
            ItemApplicationEntry.SetRange("Posting Date", 0D, EndDate);
            // Loop through the entries and adjust the remaining quantity
            if ItemApplicationEntry.Find('-') then
                repeat
                    if ItemLedgerEntry2.Get(ItemApplicationEntry."Inbound Item Entry No.") and (ItemLedgerEntry2."Posting Date" <= EndDate) then
                        ItemLedgerEntry."Remaining Quantity" := ItemLedgerEntry."Remaining Quantity" - ItemApplicationEntry.Quantity;
                until ItemApplicationEntry.Next() = 0;
        end;

        // Load necessary fields for ValueEntry
        ValueEntry.SetLoadFields("Item Ledger Entry No.", "Posting Date", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)");
        ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
        ValueEntry.SetRange("Posting Date", 0D, EndDate);

        // Calculate and round the cost amounts based on the ShowACY flag
        if ShowACY then begin
            ValueEntry.CalcSums("Cost Amount (Actual) (ACY)", "Cost Amount (Expected) (ACY)");
            ItemLedgerEntry."Cost Amount (Actual) (ACY)" := Round(ValueEntry."Cost Amount (Actual) (ACY)" + ValueEntry."Cost Amount (Expected) (ACY)", Currency."Amount Rounding Precision");
        end else begin
            ValueEntry.CalcSums("Cost Amount (Actual)", "Cost Amount (Expected)");
            ItemLedgerEntry."Cost Amount (Actual)" := Round(ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)");
        end;
    end;

    // Procedure to update the buffer with item ledger entry details
    procedure UpdateBuffer(var ItemLedgEntry: Record "Item Ledger Entry"; var TempEntryBuffer: Record "Item Location Lot Buffer" temporary; ShowVariants: Boolean; ShowLocations: Boolean; ShowLotNos: Boolean; ShowACY: Boolean; var LastItemNo: Code[20]; var LastLocationCode: Code[10]; var LastVariantCode: Code[10]; var LastLotNo: Code[50]; var LastPackageNo: Code[50]; var VariantLabel: Text[250]; var LocationLabel: Text[250]; var IsCollecting: Boolean; NoVariantLbl: Text[250]; NoLocationLbl: Text[250])
    var
        ItemVariant: Record "Item Variant";
        Location: Record Location;
        NewRow: Boolean;
    begin
        // Check if the item number has changed
        if ItemLedgEntry."Item No." <> LastItemNo then begin
            ClearLastEntry(LastItemNo, LastLocationCode, LastVariantCode);
            LastItemNo := ItemLedgEntry."Item No.";
            NewRow := true;
        end;

        // Check if variants, locations, or lot numbers should be shown
        if ShowVariants or ShowLocations or ShowLotNos then begin
            // Check if the variant code has changed
            if ItemLedgEntry."Variant Code" <> LastVariantCode then begin
                NewRow := true;
                LastVariantCode := ItemLedgEntry."Variant Code";
                ItemVariant.SetLoadFields(Description);

                // Set the variant label based on the ShowVariants flag
                if ShowVariants then
                    if (ItemLedgEntry."Variant Code" = '') or (not ItemVariant.Get(ItemLedgEntry."Item No.", ItemLedgEntry."Variant Code")) then
                        VariantLabel := NoVariantLbl
                    else
                        VariantLabel := ItemVariant.TableCaption() + ' ' + ItemLedgEntry."Variant Code" + '(' + ItemVariant.Description + ')'
                else
                    VariantLabel := '';
            end;

            // Check if the location code has changed
            if ItemLedgEntry."Location Code" <> LastLocationCode then begin
                NewRow := true;
                LastLocationCode := ItemLedgEntry."Location Code";
                Location.SetLoadFields(Name);

                // Set the location label based on the ShowLocations flag
                if ShowLocations then begin
                    if (ItemLedgEntry."Location Code" = '') or not Location.Get(ItemLedgEntry."Location Code") then
                        LocationLabel := NoLocationLbl
                    else
                        LocationLabel := Location.TableCaption() + ' ' + ItemLedgEntry."Location Code" + '(' + Location.Name + ')';
                end
                else
                    LocationLabel := '';
            end;

            // Check if the lot number has changed
            if ItemLedgEntry."Lot No." <> LastLotNo then begin
                NewRow := true;
                LastLotNo := ItemLedgEntry."Lot No.";
            end;

            // Check if the package number has changed
            if ItemLedgEntry."Package No." <> LastPackageNo then begin
                NewRow := true;
                LastPackageNo := ItemLedgEntry."Package No.";
            end;
        end;

        // If a new row is detected, update the temporary entry buffer
        if NewRow then
            UpdateTempEntryBuffer(TempEntryBuffer, IsCollecting);

        // Update the remaining quantity and value in the temporary entry buffer
        TempEntryBuffer."Remaining Quantity" += ItemLedgEntry."Remaining Quantity";

        if ShowACY then
            TempEntryBuffer.Value1 += ItemLedgEntry."Cost Amount (Actual) (ACY)"
        else
            TempEntryBuffer.Value1 += ItemLedgEntry."Cost Amount (Actual)";

        // Set the remaining fields in the temporary entry buffer
        TempEntryBuffer."Item No." := ItemLedgEntry."Item No.";
        TempEntryBuffer."Variant Code" := LastVariantCode;
        TempEntryBuffer."Location Code" := LastLocationCode;
        TempEntryBuffer."Lot No." := ItemLedgEntry."Lot No.";
        TempEntryBuffer."Expiration Date" := ItemLedgEntry."Expiration Date";
        TempEntryBuffer."Package No." := ItemLedgEntry."Package No.";
        TempEntryBuffer."Entry No." := ItemLedgEntry."Entry No.";
        TempEntryBuffer.Label := CopyStr(VariantLabel + ' ' + LocationLabel, 1, MaxStrLen(TempEntryBuffer.Label));

        IsCollecting := true;
    end;

    // Procedure to clear the last entry details
    procedure ClearLastEntry(var LastItemNo: Code[20]; var LastLocationCode: Code[10]; var LastVariantCode: Code[10])
    begin
        LastItemNo := '@@@';
        LastLocationCode := '@@@';
        LastVariantCode := '@@@';
    end;

    // Procedure to update the temporary entry buffer
    procedure UpdateTempEntryBuffer(var TempEntryBuffer: Record "Item Location Lot Buffer" temporary; var IsCollecting: Boolean)
    begin
        // Insert the buffer if collecting and there are remaining quantities or values
        if IsCollecting and ((TempEntryBuffer."Remaining Quantity" <> 0) or (TempEntryBuffer.Value1 <> 0)) then
            TempEntryBuffer.Insert();

        IsCollecting := false;
        Clear(TempEntryBuffer);
    end;
}