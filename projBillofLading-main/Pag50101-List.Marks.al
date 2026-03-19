namespace projBillofLading.projBillofLading;

page 50101 MarksList
{
    ApplicationArea = All;
    Caption = 'Marks';
    PageType = List;
    SourceTable = Marks;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Country; Rec.Country)
                {
                    ToolTip = 'Specifies the value of the Country field.', Comment = '%';
                }
                field(Marks; Rec.Marks)
                {
                    ToolTip = 'Specifies the value of the Marks field.', Comment = '%';
                }
            }
        }
    }
}
