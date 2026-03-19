namespace projBillofLading.projBillofLading;

using Microsoft.Inventory.Item;

pageextension 50103 ItemCard extends "Item Card"
{
    layout
    {

        addlast(InventoryGrp)
        {


            field("Pallet Block Count"; Rec."PalletBlockCount")
            {
                ApplicationArea = All;
                Lookup = false;
            }

        }
    }
}
