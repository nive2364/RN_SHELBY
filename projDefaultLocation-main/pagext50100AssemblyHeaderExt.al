pageextension 50201 "AssemblyOrderExt" extends "Assembly Order"
{
    layout
    {
        addafter(Description)
        {
            field("Location"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
    }
}