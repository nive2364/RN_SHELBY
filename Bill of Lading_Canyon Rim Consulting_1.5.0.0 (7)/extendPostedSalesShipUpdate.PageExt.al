pageextension 50101 extendPostedSalesShipUpdate extends "Posted Sales Shipment - Update"
{
    layout
    {
        // Add a new section for Transportation Details
        addafter(General)
        {
            group("Transportation Details")
            {
                field("Shelby Release Number"; Rec."ShelbyReleaseNum")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Tractor No."; Rec."Tractor No.")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Trailer No."; Rec."Trailer No.")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Seal No."; Rec."Seal No.")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Shipping Notes"; Rec."Route")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Vehicle Initials"; Rec."Vehicle Initials")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Carrier"; Rec."Carrier")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Pallet Count"; Rec."Pallet Count")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Additional Notes"; Rec."Additional Notes3")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Marks"; Rec."Marks_Country")
                {
                    ApplicationArea = All;
                    Lookup = true;
                    Caption = 'Marks';
                }
                field("Temperature"; Rec."Temperature")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print VSN"; Rec."Print VSN")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print EU Verbiage"; Rec."Show EU Verbiage")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print FLSA Statement"; Rec.PrintFLSA)
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print APHIS CANADA"; Rec.PrintAPHIS_CANADA)
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print Inedible Statement"; Rec.PrintInedible)
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print EV Statement"; Rec.PrintEV)
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print EV Remove Canada Statement"; Rec.PrintEVRemoveCanada)
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print Load Locks"; Rec.PrintLoadLocks)
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Time Out"; Rec."TimeOut")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
            }
        }
    }
//SET DEFAULT VALUES
//trigger OnOpenPage()
//begin
//    Rec."Temperature" := -10;
//end;
}
