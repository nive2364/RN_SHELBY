codeunit 50216 "Item Ledger Entry Helper"
{
    Permissions = tabledata "Item Ledger Entry" = M,
                  tabledata "Item Variant" = M;

    var
        IsUpdatingFields: Boolean;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertItemLedgerEntry(var Rec: Record "Item Ledger Entry")
    var
        Item: Record Item;
    begin
        // Prevent recursive calls
        if IsUpdatingFields then
            exit;

        // Add error handling to prevent debug issues
        if not Item.Get(Rec."Item No.") then
            exit;

        IsUpdatingFields := true;
        UpdateItemLedgerEntryFields(Rec, Item);
        IsUpdatingFields := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyItemLedgerEntry(var Rec: Record "Item Ledger Entry")
    var
        Item: Record Item;
        FieldsChanged: Boolean;
    begin
        // Prevent recursive calls
        if IsUpdatingFields then
            exit;

        // Add error handling to prevent debug issues
        if not Item.Get(Rec."Item No.") then
            exit;

        FieldsChanged := false;

        if Rec."Historical No." <> Item."Historical No." then begin
            Rec."Historical No." := Item."Historical No.";
            FieldsChanged := true;
        end;

        if Rec."Vendor Description" <> Item."Vendor Description" then begin
            Rec."Vendor Description" := Item."Vendor Description";
            FieldsChanged := true;
        end;

        if Rec."Shelby No." <> Item."Shelby No." then begin
            Rec."Shelby No." := Item."Shelby No.";
            FieldsChanged := true;
        end;

        if Rec."Shelby Description" <> Item."Shelby Description" then begin
            Rec."Shelby Description" := Item."Shelby Description";
            FieldsChanged := true;
        end;

        if Rec."Historical PN" <> Item."Historical PN" then begin
            Rec."Historical PN" := Item."Historical PN";
            FieldsChanged := true;
        end;

        if Rec."Historical Description" <> Item."Historical Description" then begin
            Rec."Historical Description" := Item."Historical Description";
            FieldsChanged := true;
        end;

        // Only modify if fields actually changed to prevent recursive calls
        if FieldsChanged then begin
            IsUpdatingFields := true;
            UpdateItemLedgerEntryFields(Rec, Item);
            IsUpdatingFields := false;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyItem(var Rec: Record Item)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemVariant: Record "Item Variant";
        FieldsChanged: Boolean;
    begin
        // Prevent recursive calls
        if IsUpdatingFields then
            exit;

        // Find all Item Ledger Entries for this item and update them
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");

        if ItemLedgerEntry.FindSet(true) then begin
            IsUpdatingFields := true;
            repeat
                FieldsChanged := false;

                if ItemLedgerEntry."Historical No." <> Rec."Historical No." then begin
                    ItemLedgerEntry."Historical No." := Rec."Historical No.";
                    FieldsChanged := true;
                end;

                if ItemLedgerEntry."Vendor Description" <> Rec."Vendor Description" then begin
                    ItemLedgerEntry."Vendor Description" := Rec."Vendor Description";
                    FieldsChanged := true;
                end;

                if ItemLedgerEntry."Shelby No." <> Rec."Shelby No." then begin
                    ItemLedgerEntry."Shelby No." := Rec."Shelby No.";
                    FieldsChanged := true;
                end;

                if ItemLedgerEntry."Shelby Description" <> Rec."Shelby Description" then begin
                    ItemLedgerEntry."Shelby Description" := Rec."Shelby Description";
                    FieldsChanged := true;
                end;

                if ItemLedgerEntry."Historical PN" <> Rec."Historical PN" then begin
                    ItemLedgerEntry."Historical PN" := Rec."Historical PN";
                    FieldsChanged := true;
                end;

                if ItemLedgerEntry."Historical Description" <> Rec."Historical Description" then begin
                    ItemLedgerEntry."Historical Description" := Rec."Historical Description";
                    FieldsChanged := true;
                end;

                // Only modify if fields actually changed
                if FieldsChanged then
                    UpdateItemLedgerEntryFields(ItemLedgerEntry, Rec);
            until ItemLedgerEntry.Next() = 0;
            IsUpdatingFields := false;
        end;

        // Find all Item Variants for this item and update them
        ItemVariant.Reset();
        ItemVariant.SetRange("Item No.", Rec."No.");

        if ItemVariant.FindSet(true) then begin
            IsUpdatingFields := true;
            repeat
                FieldsChanged := false;

                if ItemVariant."Historical No." <> Rec."Historical No." then begin
                    ItemVariant."Historical No." := Rec."Historical No.";
                    FieldsChanged := true;
                end;

                if ItemVariant."Vendor Description" <> Rec."Vendor Description" then begin
                    ItemVariant."Vendor Description" := Rec."Vendor Description";
                    FieldsChanged := true;
                end;

                if ItemVariant."Shelby No." <> Rec."Shelby No." then begin
                    ItemVariant."Shelby No." := Rec."Shelby No.";
                    FieldsChanged := true;
                end;

                if ItemVariant."Shelby Description" <> Rec."Shelby Description" then begin
                    ItemVariant."Shelby Description" := Rec."Shelby Description";
                    FieldsChanged := true;
                end;

                if ItemVariant."Historical PN" <> Rec."Historical PN" then begin
                    ItemVariant."Historical PN" := Rec."Historical PN";
                    FieldsChanged := true;
                end;

                if ItemVariant."Historical Description" <> Rec."Historical Description" then begin
                    ItemVariant."Historical Description" := Rec."Historical Description";
                    FieldsChanged := true;
                end;

                // Only modify if fields actually changed
                if FieldsChanged then
                    UpdateItemVariantFields(ItemVariant, Rec);
            until ItemVariant.Next() = 0;
            IsUpdatingFields := false;
        end;
    end;

    local procedure UpdateItemLedgerEntryFields(var ItemLedgerEntry: Record "Item Ledger Entry"; Item: Record Item): Boolean
    var
        ItemLedgerEntryToUpdate: Record "Item Ledger Entry";
    begin
        // Use elevated permissions to modify Item Ledger Entry
        ItemLedgerEntryToUpdate := ItemLedgerEntry;
        ItemLedgerEntryToUpdate."Historical No." := Item."Historical No.";
        ItemLedgerEntryToUpdate."Vendor Description" := Item."Vendor Description";
        ItemLedgerEntryToUpdate."Shelby No." := Item."Shelby No.";
        ItemLedgerEntryToUpdate."Shelby Description" := Item."Shelby Description";
        ItemLedgerEntryToUpdate."Historical PN" := Item."Historical PN";
        ItemLedgerEntryToUpdate."Historical Description" := Item."Historical Description";

        // Modify with elevated permissions
        if ItemLedgerEntryToUpdate.Modify(true) then begin
            ItemLedgerEntry := ItemLedgerEntryToUpdate;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Variant", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertItemVariant(var Rec: Record "Item Variant")
    var
        Item: Record Item;
    begin
        // Prevent recursive calls
        if IsUpdatingFields then
            exit;

        // Add error handling to prevent debug issues
        if not Item.Get(Rec."Item No.") then
            exit;

        IsUpdatingFields := true;
        UpdateItemVariantFields(Rec, Item);
        IsUpdatingFields := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Variant", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyItemVariant(var Rec: Record "Item Variant")
    var
        Item: Record Item;
        FieldsChanged: Boolean;
    begin
        // Prevent recursive calls
        if IsUpdatingFields then
            exit;

        // Add error handling to prevent debug issues
        if not Item.Get(Rec."Item No.") then
            exit;

        FieldsChanged := false;

        if Rec."Historical No." <> Item."Historical No." then begin
            Rec."Historical No." := Item."Historical No.";
            FieldsChanged := true;
        end;

        if Rec."Vendor Description" <> Item."Vendor Description" then begin
            Rec."Vendor Description" := Item."Vendor Description";
            FieldsChanged := true;
        end;

        if Rec."Shelby No." <> Item."Shelby No." then begin
            Rec."Shelby No." := Item."Shelby No.";
            FieldsChanged := true;
        end;

        if Rec."Shelby Description" <> Item."Shelby Description" then begin
            Rec."Shelby Description" := Item."Shelby Description";
            FieldsChanged := true;
        end;

        if Rec."Historical PN" <> Item."Historical PN" then begin
            Rec."Historical PN" := Item."Historical PN";
            FieldsChanged := true;
        end;

        if Rec."Historical Description" <> Item."Historical Description" then begin
            Rec."Historical Description" := Item."Historical Description";
            FieldsChanged := true;
        end;

        // Only modify if fields actually changed to prevent recursive calls
        if FieldsChanged then begin
            IsUpdatingFields := true;
            UpdateItemVariantFields(Rec, Item);
            IsUpdatingFields := false;
        end;
    end;

    local procedure UpdateItemVariantFields(var ItemVariant: Record "Item Variant"; Item: Record Item): Boolean
    var
        ItemVariantToUpdate: Record "Item Variant";
    begin
        // Use elevated permissions to modify Item Variant
        ItemVariantToUpdate := ItemVariant;
        ItemVariantToUpdate."Historical No." := Item."Historical No.";
        ItemVariantToUpdate."Vendor Description" := Item."Vendor Description";
        ItemVariantToUpdate."Shelby No." := Item."Shelby No.";
        ItemVariantToUpdate."Shelby Description" := Item."Shelby Description";
        ItemVariantToUpdate."Historical PN" := Item."Historical PN";
        ItemVariantToUpdate."Historical Description" := Item."Historical Description";

        // Modify with elevated permissions
        if ItemVariantToUpdate.Modify(true) then begin
            ItemVariant := ItemVariantToUpdate;
            exit(true);
        end;
        exit(false);
    end;

    /// <summary>
    /// Updates all Item Ledger Entries for a specific item with the current Item field values
    /// </summary>
    /// <param name="ItemNo">The item number to update Item Ledger Entries for</param>
    /// <returns>Number of Item Ledger Entries updated</returns>
    procedure UpdateHistoricalItemLedgerEntries(ItemNo: Code[20]): Integer
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        UpdatedCount: Integer;
    begin
        if not Item.Get(ItemNo) then
            exit(0);

        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Item No.", ItemNo);

        if ItemLedgerEntry.FindSet(true) then begin
            IsUpdatingFields := true;
            repeat
                if UpdateItemLedgerEntryFields(ItemLedgerEntry, Item) then
                    UpdatedCount += 1;
            until ItemLedgerEntry.Next() = 0;
            IsUpdatingFields := false;
        end;

        exit(UpdatedCount);
    end;

    /// <summary>
    /// Updates all Item Variants for a specific item with the current Item field values
    /// </summary>
    /// <param name="ItemNo">The item number to update Item Variants for</param>
    /// <returns>Number of Item Variants updated</returns>
    procedure UpdateHistoricalItemVariants(ItemNo: Code[20]): Integer
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        UpdatedCount: Integer;
    begin
        if not Item.Get(ItemNo) then
            exit(0);

        ItemVariant.Reset();
        ItemVariant.SetRange("Item No.", ItemNo);

        if ItemVariant.FindSet(true) then begin
            IsUpdatingFields := true;
            repeat
                if UpdateItemVariantFields(ItemVariant, Item) then
                    UpdatedCount += 1;
            until ItemVariant.Next() = 0;
            IsUpdatingFields := false;
        end;

        exit(UpdatedCount);
    end;

    /// <summary>
    /// Updates all Item Ledger Entries for all items with their current Item field values
    /// </summary>
    /// <returns>Number of Item Ledger Entries updated</returns>
    procedure UpdateAllHistoricalItemLedgerEntries(): Integer
    var
        Item: Record Item;
        TotalUpdated: Integer;
    begin
        if Item.FindSet() then
            repeat
                TotalUpdated += UpdateHistoricalItemLedgerEntries(Item."No.");
            until Item.Next() = 0;

        exit(TotalUpdated);
    end;

    /// <summary>
    /// Updates all Item Variants for all items with their current Item field values
    /// </summary>
    /// <returns>Number of Item Variants updated</returns>
    procedure UpdateAllHistoricalItemVariants(): Integer
    var
        Item: Record Item;
        TotalUpdated: Integer;
    begin
        if Item.FindSet() then
            repeat
                TotalUpdated += UpdateHistoricalItemVariants(Item."No.");
            until Item.Next() = 0;

        exit(TotalUpdated);
    end;
}
