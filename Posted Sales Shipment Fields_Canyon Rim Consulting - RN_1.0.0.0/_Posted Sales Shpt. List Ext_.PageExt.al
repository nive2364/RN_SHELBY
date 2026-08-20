pageextension 50147 "Posted Sales Shpt. List Ext" extends "Posted Sales Shipments"
{
    layout
    {
        addlast(Control1)
        {
            field("Total Quantity Shipped"; Rec."Total Quantity Shipped")
            {
                ApplicationArea = All;
                Caption = 'Total Quantity Shipped';
                Editable = false;
                ToolTip = 'The total quantity across all shipment lines.';
            }
            field(ShelbyReleaseNum; Rec.ShelbyReleaseNum)
            {
                ApplicationArea = All;
                Caption = 'Shelby Release Number';
                Editable = false;
                ToolTip = 'The Shelby release number from the shipment header.';
            }
        }
    }
}
