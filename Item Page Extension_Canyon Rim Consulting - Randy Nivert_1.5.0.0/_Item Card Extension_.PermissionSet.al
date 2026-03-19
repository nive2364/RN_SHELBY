permissionset 50210 "Item Card Extension"
{
    Assignable = true;
    Caption = 'Item Card Extension';
    Permissions = tabledata "Item Ledger Entry"=M,
        tabledata Item=RIMD;
}
