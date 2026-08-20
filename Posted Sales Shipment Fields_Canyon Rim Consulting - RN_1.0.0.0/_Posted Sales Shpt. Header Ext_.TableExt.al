tableextension 50148 "Posted Sales Shpt. Header Ext" extends "Sales Shipment Header"
{
    fields
    {
        field(50148; "Total Quantity Shipped"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Shipment Line".Quantity where("Document No."=field("No.")));
            Caption = 'Total Quantity Shipped';
            Editable = false;
        }
    }
}
