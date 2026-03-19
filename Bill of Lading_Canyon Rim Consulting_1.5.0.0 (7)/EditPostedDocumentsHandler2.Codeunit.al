codeunit 50111 EditPostedDocumentsHandler2
{
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure OnAfterRecordChanged(var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean);
    begin
        IsChanged:=(SalesShipmentHeader."Tractor No." <> xSalesShipmentHeader."Tractor No.") or (SalesShipmentHeader."Trailer No." <> xSalesShipmentHeader."Trailer No.") or (SalesShipmentHeader."Seal No." <> xSalesShipmentHeader."Seal No.") or (SalesShipmentHeader."Route" <> xSalesShipmentHeader."Route") or (SalesShipmentHeader."Vehicle Initials" <> xSalesShipmentHeader."Vehicle Initials") or (SalesShipmentHeader."Carrier" <> xSalesShipmentHeader."Carrier") or (SalesShipmentHeader."PO No." <> xSalesShipmentHeader."PO No.") or (SalesShipmentHeader."Pallet Count" <> xSalesShipmentHeader."Pallet Count") or (SalesShipmentHeader."Show EU Verbiage" <> xSalesShipmentHeader."Show EU Verbiage") or (SalesShipmentHeader."Additional Notes3" <> xSalesShipmentHeader."Additional Notes3") or (SalesShipmentHeader."Print VSN" <> xSalesShipmentHeader."Print VSN") or (SalesShipmentHeader.Marks_Country <> xSalesShipmentHeader.Marks_Country) or (SalesShipmentHeader."Temperature" <> xSalesShipmentHeader."Temperature") or (SalesShipmentHeader."TimeOut" <> xSalesShipmentHeader."TimeOut") or (SalesShipmentHeader."ShelbyReleaseNum" <> xSalesShipmentHeader."ShelbyReleaseNum") or (SalesShipmentHeader.PrintAPHIS <> xSalesShipmentHeader.PrintAPHIS) or (SalesShipmentHeader.PrintAPHIS_CANADA <> xSalesShipmentHeader.PrintAPHIS_CANADA) or (SalesShipmentHeader.PrintFLSA <> xSalesShipmentHeader.PrintFLSA) or (SalesShipmentHeader.PrintInedible <> xSalesShipmentHeader.PrintInedible) or (SalesShipmentHeader.PrintEV <> xSalesShipmentHeader.PrintEV) or (SalesShipmentHeader.PrintEVRemoveCanada <> xSalesShipmentHeader.PrintEVRemoveCanada) or (SalesShipmentHeader.PrintLoadLocks <> xSalesShipmentHeader.PrintLoadLocks);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure OnBeforeSalesShipmentHeaderModify(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header");
    begin
        SalesShptHeader."Tractor No.":=FromSalesShptHeader."Tractor No.";
        SalesShptHeader."Trailer No.":=FromSalesShptHeader."Trailer No.";
        SalesShptHeader."Seal No.":=FromSalesShptHeader."Seal No.";
        SalesShptHeader."Route":=FromSalesShptHeader."Route";
        SalesShptHeader."Vehicle Initials":=FromSalesShptHeader."Vehicle Initials";
        SalesShptHeader.Carrier:=FromSalesShptHeader.Carrier;
        SalesShptHeader."PO No.":=FromSalesShptHeader."PO No.";
        SalesShptHeader."Pallet Count":=FromSalesShptHeader."Pallet Count";
        SalesShptHeader."Show EU Verbiage":=FromSalesShptHeader."Show EU Verbiage";
        SalesShptHeader."Additional Notes3":=FromSalesShptHeader."Additional Notes3";
        SalesShptHeader."Print VSN":=FromSalesShptHeader."Print VSN";
        SalesShptHeader.Marks_Country:=FromSalesShptHeader.Marks_Country;
        SalesShptHeader."Temperature":=FromSalesShptHeader."Temperature";
        SalesShptHeader."TimeOut":=FromSalesShptHeader."TimeOut";
        SalesShptHeader."ShelbyReleaseNum":=FromSalesShptHeader."ShelbyReleaseNum";
        SalesShptHeader.PrintAPHIS:=FromSalesShptHeader.PrintAPHIS;
        SalesShptHeader.PrintAPHIS_CANADA:=FromSalesShptHeader.PrintAPHIS_CANADA;
        SalesShptHeader.PrintFLSA:=FromSalesShptHeader.PrintFLSA;
        SalesShptHeader.PrintInedible:=FromSalesShptHeader.PrintInedible;
        SalesShptHeader.PrintEV:=FromSalesShptHeader.PrintEV;
        SalesShptHeader.PrintEVRemoveCanada:=FromSalesShptHeader.PrintEVRemoveCanada;
        SalesShptHeader.PrintLoadLocks:=FromSalesShptHeader.PrintLoadLocks;
    end;
}
