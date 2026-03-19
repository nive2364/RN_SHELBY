codeunit 50200 "Copy Default Location"
{
    // The OnRun trigger is the main entry point for the codeunit, but it is empty in this case.
    trigger OnRun()
    begin
    end;

    // Procedure to copy the Default Location from the Item to the Sales Line and Sales Header.
    procedure CopyDefaultLocationToSalesLine(var SalesLine: Record "Sales Line")
    var
        Item: Record Item; // Declare a variable for the Item record.
        SalesHeader: Record "Sales Header"; // Declare a variable for the Sales Header record.
    begin
        // Check if the Item record can be retrieved using the Item No. from the Sales Line.
        if Item.Get(SalesLine."No.") then begin
            // Validate and set the Location Code on the Sales Line to the Default Location from the Item.
            SalesLine.Validate("Location Code", Item."Default Location");

            // Check if the Sales Header record can be retrieved using the Document Type and Document No. from the Sales Line.
            if SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.") then begin
                // Validate and set the Location Code on the Sales Header to the Default Location from the Item.
                SalesHeader.Validate("Location Code", Item."Default Location");
                // Save the changes to the Sales Header record.
                SalesHeader.Modify();
            end;
        end;
    end;

    // Procedure to copy the Default Location from the Item to the Purchase Line and Purchase Header.
    procedure CopyDefaultLocationToPurchaseOrder(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    var
        Item: Record Item; // Declare a variable for the Item record.
    begin
        // Check if the Item record can be retrieved using the Item No. from the Purchase Line.
        if Item.Get(PurchaseLine."No.") then begin
            // Validate and set the Location Code on the Purchase Line to the Default Location from the Item.
            PurchaseLine.Validate("Location Code", Item."Default Location");
            // Save the changes to the Purchase Line record.
            PurchaseLine.Modify();

            // Validate and set the Location Code on the Purchase Header to the Default Location from the Item.
            PurchaseHeader.Validate("Location Code", Item."Default Location");
            // Save the changes to the Purchase Header record.
            PurchaseHeader.Modify();
        end;
    end;
}