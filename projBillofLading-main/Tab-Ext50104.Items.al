namespace projBillofLading.projBillofLading;

using Microsoft.Inventory.Item;

tableextension 50104 Items extends Item
{
    fields
    {
        field(50100; PalletBlockCount; Integer)
        {
            Caption = 'Pallet Block Count';
            DataClassification = ToBeClassified;
        }
    }
}
