pageextension 50001 PageExtension50001 extends Microsoft.Sales.History."Posted Sales Shipments"
{
    layout
    {
        addafter("No.")
        {
            field("Ship-to Address20861"; Rec."Ship-to Address")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to City75402"; Rec."Ship-to City")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to County71711"; Rec."Ship-to County")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Bill-to City72731"; Rec."Bill-to City")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
