pageextension 50200 "Item Card Page Extension" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Default Location"; Rec."Default Location")
            {
                ApplicationArea = All;
            }
        }
    }
}
