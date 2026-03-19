pageextension 50106 PostedItemTrackingLines extends "Posted Item Tracking Lines"
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
