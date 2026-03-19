pageextension 50104 ItemTrackingLines extends "Item Tracking Lines"
{
    layout
    {
        addafter("Quantity (Base)")
        {
            field("Block Count"; Rec.BlockCount)
            {
                ApplicationArea = All;
                Lookup = false;
                ShowMandatory = true;
            }
        }
    }
//trigger OnQueryClosePage(CloseAction: Action): Boolean
//begin
//  if Rec.BlockCount <= 0 then
//    Error('Block Count must be greater than 0.');
//end;
}
