pageextension 50149 "Posted Shpt. Lines Header Flds" extends "Posted Sales Shipment Lines"
{
    layout
    {
        addlast(Control1)
        {
            field(ReqDeliveryDate; ShipmentHeader."Requested Delivery Date")
            {
                ApplicationArea = All;
                Caption = 'Requested Delivery Date';
                Editable = false;
                ToolTip = 'The requested delivery date from the shipment header.';
            }
            field(ShelbyReleaseNo; ShipmentHeader.ShelbyReleaseNum)
            {
                ApplicationArea = All;
                Caption = 'Shelby Release Number';
                Editable = false;
                ToolTip = 'The Shelby release number from the shipment header.';
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if ShipmentHeader."No." <> Rec."Document No." then ShipmentHeader.Get(Rec."Document No.");
    end;
    var ShipmentHeader: Record "Sales Shipment Header";
}
