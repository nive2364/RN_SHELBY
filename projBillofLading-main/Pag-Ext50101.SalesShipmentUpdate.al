namespace projBillofLading.projBillofLading;

using Microsoft.Sales.History;

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
codeunit 50111 EditPostedDocumentsHandler2
{
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure OnAfterRecordChanged(var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean);
    begin
        IsChanged := (SalesShipmentHeader."Tractor No." <> xSalesShipmentHeader."Tractor No.") or
                     (SalesShipmentHeader."Trailer No." <> xSalesShipmentHeader."Trailer No.") or
                     (SalesShipmentHeader."Seal No." <> xSalesShipmentHeader."Seal No.") or
                     (SalesShipmentHeader."Route" <> xSalesShipmentHeader."Route") or
                     (SalesShipmentHeader."Vehicle Initials" <> xSalesShipmentHeader."Vehicle Initials") or
                     (SalesShipmentHeader."Carrier" <> xSalesShipmentHeader."Carrier") or
                     (SalesShipmentHeader."PO No." <> xSalesShipmentHeader."PO No.") or
                     (SalesShipmentHeader."Pallet Count" <> xSalesShipmentHeader."Pallet Count") or
                     (SalesShipmentHeader."Show EU Verbiage" <> xSalesShipmentHeader."Show EU Verbiage") or
                     (SalesShipmentHeader."Additional Notes3" <> xSalesShipmentHeader."Additional Notes3") or
                     (SalesShipmentHeader."Print VSN" <> xSalesShipmentHeader."Print VSN") or
                     (SalesShipmentHeader.Marks_Country <> xSalesShipmentHeader.Marks_Country) or
                     (SalesShipmentHeader."Temperature" <> xSalesShipmentHeader."Temperature") or
                     (SalesShipmentHeader."TimeOut" <> xSalesShipmentHeader."TimeOut") or
                     (SalesShipmentHeader."ShelbyReleaseNum" <> xSalesShipmentHeader."ShelbyReleaseNum") or
                     (SalesShipmentHeader.PrintAPHIS <> xSalesShipmentHeader.PrintAPHIS) or
                     (SalesShipmentHeader.PrintAPHIS_CANADA <> xSalesShipmentHeader.PrintAPHIS_CANADA) or
                     (SalesShipmentHeader.PrintFLSA <> xSalesShipmentHeader.PrintFLSA) or
                     (SalesShipmentHeader.PrintInedible <> xSalesShipmentHeader.PrintInedible) or
                     (SalesShipmentHeader.PrintEV <> xSalesShipmentHeader.PrintEV) or
                     (SalesShipmentHeader.PrintEVRemoveCanada <> xSalesShipmentHeader.PrintEVRemoveCanada) or
                     (SalesShipmentHeader.PrintLoadLocks <> xSalesShipmentHeader.PrintLoadLocks);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure OnBeforeSalesShipmentHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header");
    begin
        SalesShptHeader."Tractor No." := FromSalesShptHeader."Tractor No.";
        SalesShptHeader."Trailer No." := FromSalesShptHeader."Trailer No.";
        SalesShptHeader."Seal No." := FromSalesShptHeader."Seal No.";
        SalesShptHeader."Route" := FromSalesShptHeader."Route";
        SalesShptHeader."Vehicle Initials" := FromSalesShptHeader."Vehicle Initials";
        SalesShptHeader.Carrier := FromSalesShptHeader.Carrier;
        SalesShptHeader."PO No." := FromSalesShptHeader."PO No.";
        SalesShptHeader."Pallet Count" := FromSalesShptHeader."Pallet Count";
        SalesShptHeader."Show EU Verbiage" := FromSalesShptHeader."Show EU Verbiage";
        SalesShptHeader."Additional Notes3" := FromSalesShptHeader."Additional Notes3";
        SalesShptHeader."Print VSN" := FromSalesShptHeader."Print VSN";
        SalesShptHeader.Marks_Country := FromSalesShptHeader.Marks_Country;
        SalesShptHeader."Temperature" := FromSalesShptHeader."Temperature";
        SalesShptHeader."TimeOut" := FromSalesShptHeader."TimeOut";
        SalesShptHeader."ShelbyReleaseNum" := FromSalesShptHeader."ShelbyReleaseNum";
        SalesShptHeader.PrintAPHIS := FromSalesShptHeader.PrintAPHIS;
        SalesShptHeader.PrintAPHIS_CANADA := FromSalesShptHeader.PrintAPHIS_CANADA;
        SalesShptHeader.PrintFLSA := FromSalesShptHeader.PrintFLSA;
        SalesShptHeader.PrintInedible := FromSalesShptHeader.PrintInedible;
        SalesShptHeader.PrintEV := FromSalesShptHeader.PrintEV;
        SalesShptHeader.PrintEVRemoveCanada := FromSalesShptHeader.PrintEVRemoveCanada;
        SalesShptHeader.PrintLoadLocks := FromSalesShptHeader.PrintLoadLocks;
    end;


}