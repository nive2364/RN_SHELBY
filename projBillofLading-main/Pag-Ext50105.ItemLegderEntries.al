namespace projBillofLading.projBillofLading;

using Microsoft.Inventory.Ledger;

pageextension 50105 ItemLegderEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter(Quantity)
        {
            field("Block Count"; Rec."BlcokCount")
            {
                ApplicationArea = All;
                Lookup = false;
            }

        }
    }
}
