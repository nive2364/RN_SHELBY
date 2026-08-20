pageextension 50148 "Posted Sales Shipment Ext" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Total Quantity Shipped"; Rec."Total Quantity Shipped")
            {
                ApplicationArea = All;
                Caption = 'Total Quantity Shipped';
                Editable = false;
                ToolTip = 'The total quantity across all shipment lines.';
            }
        }
    }
}
