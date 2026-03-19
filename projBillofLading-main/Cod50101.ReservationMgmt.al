namespace projBillofLading.projBillofLading;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Posting;

codeunit 50101 ReservationMgmt
{
    var
        // Variable to store the block count
        VarBlockCount: Integer;

        // Flag to indicate if modification is running
        ModifyRun: Boolean;

    // Event subscriber for updating custom field values for new insert value updated in Reservation Entry
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry', '', false, false)]
    local procedure OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification")
    Begin
        // Initialize ModifyRun to false
        ModifyRun := false;
        // Set VarBlockCount to the BlockCount from the new tracking specification
        VarBlockCount := NewTrackingSpecification."BlockCount";
    End;

    // Event subscriber for setting dates after creating reservation entry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterSetDates', '', false, false)]
    local procedure OnAfterSetDates(var ReservationEntry: Record "Reservation Entry")
    Begin
        // Set the BlockCount of the reservation entry to VarBlockCount
        ReservationEntry.BlockCount := VarBlockCount;
    End;

    // Event subscriber for creating reservation entry with extra fields
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateReservEntryExtraFields', '', false, false)]
    local procedure OnCreateReservEntryExtraFields(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification")
    Begin
        // Set the BlockCount of the insert reservation entry to the BlockCount from the new tracking specification
        InsertReservEntry.BlockCount := NewTrackingSpecification.BlockCount;
    End;

    // Event subscriber for copying tracking specification
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification")
    Begin
        // If ModifyRun is false, copy BlockCount from destination to source
        If ModifyRun = false then begin
            SourceTrackingSpec.BlockCount := DestTrkgSpec.BlockCount;
        end else begin
            // If ModifyRun is true, copy BlockCount from source to destination
            DestTrkgSpec.BlockCount := SourceTrackingSpec.BlockCount;
        end;
    End;

    // Event subscriber for registering item tracking lines before insert
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterItemTrackingLinesOnBeforeInsert', '', false, false)]
    local procedure OnRegisterItemTrackingLinesOnBeforeInsert(var TrackingSpecification: Record "Tracking Specification"; var TempTrackingSpecification: Record "Tracking Specification" temporary; SourceTrackingSpecification: Record "Tracking Specification")
    Begin
        // Set the BlockCount of the tracking specification to the BlockCount from the temporary tracking specification
        TrackingSpecification.BlockCount := TempTrackingSpecification.BlockCount;
    End;

    // Event subscriber for updating modified custom field values for new insert value updated in reservation entry
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean)
    Begin
        // Set the second element of IdenticalArray to true if the BlockCount of both reservation entries are equal
        IdenticalArray[2] := (ReservEntry1.BlockCount = ReservEntry2.BlockCount);
    End;

    // Event subscriber for moving fields after copying tracking specification
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    Begin
        // Set the BlockCount of the reservation entry to the BlockCount from the tracking specification
        ReservEntry.BlockCount := TrkgSpec.BlockCount;
    End;

    // Event subscriber for inserting setup temporary split item journal line
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure OnBeforeInsertSetupTempSplitItemJnlLine(var TempItemJournalLine: Record "Item Journal Line" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    Begin
        // Set the BlockCount of the temporary item journal line to the BlockCount from the temporary tracking specification
        TempItemJournalLine.BlockCount := TempTrackingSpecification.BlockCount;
    End;

    // Event subscriber for initializing item ledger entry after posting line
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    Begin
        // Set the BlockCount of the new item ledger entry to the BlockCount from the item journal line
        NewItemLedgEntry.BlcokCount := ItemJournalLine.BlockCount;
    End;

    // Event subscriber for validating tracking specification after lot number validation
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterValidateEvent', 'Lot No.', false, false)]
    local procedure TrackingSpecificatioOnAfterValidateEventLotNo(var Rec: Record "Tracking Specification")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
    Begin
        // Reset and set range for item ledger entry based on lot number
        ItemLedgerEntry2.Reset();
        ItemLedgerEntry2.SetRange("Lot No.", Rec."Lot No.");
        // If an item ledger entry is found, set the BlockCount of the tracking specification to the BlockCount from the item ledger entry
        If ItemLedgerEntry2.FindFirst() then begin
            Rec.BlockCount := ItemLedgerEntry2.BlcokCount;
        end;
    End;
}