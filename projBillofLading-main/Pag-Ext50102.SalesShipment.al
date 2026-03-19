// Define the namespace for the page extension
namespace projBillofLading.projBillofLading;

// Use the Microsoft.Warehouse.Document namespace for access to related objects
using Microsoft.Sales.History;

// Begin the definition of a page extension for the "Warehouse Shipment" page
pageextension 50102 extendpagePosterdSalesShipment extends "Posted Sales Shipment"
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
                field("Temperature"; Rec."Temperature")
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
                field("Print APHIS CANADA"; Rec.PrintAPHIS_CANADA)
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field("Print FLSA Statement"; Rec.PrintFLSA)
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
                field("Print EV Statement (Remove Canada)"; Rec.PrintEVRemoveCanada)
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

    actions
    {
        addfirst(Reporting)
        {
            action("Bill of Lading")
            {
                ApplicationArea = all;
                //RunObject = report BillOfLading;
                Image = Report;

                trigger OnAction()
                var
                    BillOfLadingReport: Report "BillofLading";
                    SalesShipmentHeader: Record "Sales Shipment Header";
                    ReportRun: Text;
                begin
                    SalesShipmentHeader.SetRange("No.", Rec."No.");
                    BillOfLadingReport.SetTableView(SalesShipmentHeader);
                    BillOfLadingReport.RunModal();
                end;
            }
        }
    }
}