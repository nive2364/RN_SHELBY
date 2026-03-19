pageextension 50120 ExtendNavigationArea extends "Business Manager Role Center"
{
    actions
    {
        addlast(Sections)
        {
            group("Custom Reports")
            {
                action("Inventory Detail")
                {
                    RunObject = report "Inventory Detail";
                    ApplicationArea = All;
                }
                action("On Hand Inventory")
                {
                    RunObject = report "On Hand Inventory";
                    ApplicationArea = All;
                }
                action("Inventory Locations")
                {
                    RunObject = report "Inventory Locations";
                    ApplicationArea = All;
                }
                action("Inventory Count Sheet")
                {
                    RunObject = report "Inventory Count Sheet";
                    ApplicationArea = All;
                }
            }
        }
    }
}
