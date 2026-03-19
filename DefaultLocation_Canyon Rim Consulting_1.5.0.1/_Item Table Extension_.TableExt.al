tableextension 50200 "Item Table Extension" extends Item
{
    fields
    {
        field(50101; "Default Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }
}
