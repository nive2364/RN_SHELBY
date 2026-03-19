report 50124 "Inventory Locations"
{
    DefaultLayout = RDLC; // Specifies the report layout as RDLC (client report definition)
    RDLCLayout = './Local/Inventory/Reports/InventoryLocations.rdlc'; // Path to the RDLC layout file
    ApplicationArea = All; // Makes the report accessible across all application areas
    Caption = 'Inventory Locations'; // The title of the report
    UsageCategory = ReportsAndAnalysis; // Categorizes the report under 'Reports and Analysis'
    DataAccessIntent = ReadOnly; // Specifies that the report only reads data

    dataset // Define the dataset for the report, consisting of data items and columns
    {
        dataitem(Item; Item) // Define a data item for the Item table
        {
            DataItemTableView = where(Type=const(Inventory)); // Filter the items where the type is 'Inventory'
            PrintOnlyIfDetail = true; // Print only if there is detailed information for the item
            RequestFilterFields = "No.", "Inventory Posting Group"; // Fields available for filtering

            // Define report columns and link them to relevant fields or calculations
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(STRSUBSTNO_Text003_AsOfDate_; StrSubstNo(EndDatePrefixLbl, EndDate)) // Format the "As Of Date" field
            {
            }
            column(ShowVariants; ShowVariants)
            {
            }
            column(ShowLocations; ShowLocations)
            {
            }
            column(ShowLotNos; ShowLotNos)
            {
            }
            column(ShowACY; ShowACY)
            {
            }
            column(ShowPackageNos; ShowPackageNos)
            {
            }
            column(STRSUBSTNO_Text006_Currency_Description_; StrSubstNo(CurrencyCodePrefixLbl, Currency.Description)) // Display currency description
            {
            }
            column(Item_TABLECAPTION__________ItemFilter; Item.TableCaption() + ': ' + ItemFilter) // Show item filter
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(STRSUBSTNO_Text004_InvPostingGroup_TABLECAPTION_InvPostingGroup_Code_InvPostingGroup_Description_; StrSubstNo(InvoicePostingGroupLbl, InvPostingGroup.TableCaption(), InvPostingGroup.Code, InvPostingGroup.Description)) // Format Inventory Posting Group data
            {
            }
            column(Item__Inventory_Posting_Group_; "Inventory Posting Group")
            {
            }
            column(Grouping; Grouping)
            {
            }
            column(Item__No__; "No.") // Item number field, with caption included
            {
            IncludeCaption = true;
            }
            column(Item_Description; Description) // Item description field, with caption included
            {
            IncludeCaption = true;
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure") // Base unit of measure field, with caption included
            {
            IncludeCaption = true;
            }
            column(Item__Costing_Method_; "Costing Method") // Costing method field, with caption included
            {
            IncludeCaption = true;
            }
            column(STRSUBSTNO_Text005_InvPostingGroup_TABLECAPTION_InvPostingGroup_Code_InvPostingGroup_Description_; StrSubstNo(InvoicePostingGroupTotalLbl, InvPostingGroup.TableCaption(), InvPostingGroup.Code, InvPostingGroup.Description)) // Display Inventory Posting Group total label
            {
            }
            column(Inventory_ValuationCaption; Inventory_ValuationCaptionLbl) // Inventory valuation caption
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl) // Page number caption
            {
            }
            column(InventoryValue_Control34Caption; InventoryValue_Control34CaptionLbl) // Inventory value caption
            {
            }
            column(Item_Ledger_Entry__Remaining_Quantity_Caption; "Item Ledger Entry".FieldCaption("Remaining Quantity")) // Remaining quantity field from Item Ledger Entry
            {
            }
            column(UnitCost_Control33Caption; UnitCost_Control33CaptionLbl) // Unit cost caption
            {
            }
            column(Total_Inventory_ValueCaption; Total_Inventory_ValueCaptionLbl) // Total inventory value caption
            {
            }
            column(Inventory_Posting_Group; "Inventory Posting Group") // Inventory posting group field
            {
            }
            // Define a nested data item for the Item Ledger Entry table
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No."=field("No."), // Link the Item Ledger Entry to the Item by Item No.
 "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), // Link dimensions
 "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Location Code"=field("Location Filter"), "Variant Code"=field("Variant Filter");
                DataItemTableView = sorting("Item No.", "Variant Code", "Location Code", "Lot No.", "Posting Date"); // Sort data by several fields

                trigger OnAfterGetRecord() // Trigger event after retrieving a record
                begin
                    GetOnHandInventory.AdjustItemLedgEntryToAsOfDate("Item Ledger Entry", EndDate, ShowACY, Currency); // Adjust item ledger entry based on As Of Date
                    GetOnHandInventory.UpdateBuffer("Item Ledger Entry", TempEntryBuffer, ShowVariants, ShowLocations, ShowLotNos, ShowPackageNos, LastItemNo, LastLocationCode, LastVariantCode, LastLotNo, LastPackageNo, VariantLabel, LocationLabel, IsCollecting, NoVariantLbl, NoLocationLbl); // Update buffer with the current item ledger entry
                    CurrReport.Skip(); // Skip current report generation step (to handle grouping or summing)
                end;
                trigger OnPostDataItem() // Trigger after data item has been processed
                begin
                    GetOnHandInventory.UpdateTempEntryBuffer(TempEntryBuffer, IsCollecting); // Update the temporary buffer for storing processed data
                end;
                trigger OnPreDataItem() // Trigger before retrieving data item
                begin
                    SetRange("Posting Date", 0D, EndDate); // Set date range to filter data up to the specified End Date
                    ShowLotNos:=true; // Enable showing lot numbers
                    ShowPackageNos:=true; // Enable showing package numbers
                end;
            }
            // Define another data item for the Integer table to loop through buffered data
            dataitem(BufferLoop; "Integer")
            {
                DataItemTableView = sorting(Number); // Sort by a number field

                // Define columns for the buffered data
                column(RowLabel; TempEntryBuffer.Label)
                {
                }
                column(RemainingQty; TempEntryBuffer."Remaining Quantity")
                {
                }
                column(InventoryValue; TempEntryBuffer.Value1)
                {
                }
                column(VariantCode; TempEntryBuffer."Variant Code")
                {
                }
                column(LocationCode; TempEntryBuffer."Location Code")
                {
                }
                column(LotNo; TempEntryBuffer."Lot No.")
                {
                }
                column(ExpirationDate; TempEntryBuffer."Expiration Date")
                {
                }
                column(PackageNo; TempEntryBuffer."Package No.")
                {
                }
                trigger OnAfterGetRecord() // Trigger event after each record is retrieved
                begin
                    if TempEntryBuffer.Next() <> 1 then // Check if there is more buffered data to process
 CurrReport.Break(); // Break report generation if no more data
                end;
                trigger OnPreDataItem() // Trigger before data retrieval
                begin
                    Clear(TempEntryBuffer); // Clear temporary buffer before populating
                    TempEntryBuffer.SetFilter("Item No.", '%1', Item."No."); // Set filter for item number
                    if Item."Location Filter" <> '' then TempEntryBuffer.SetFilter("Location Code", '%1', Item."Location Filter"); // Apply location filter if set
                    if Item."Variant Filter" <> '' then TempEntryBuffer.SetFilter("Variant Code", '%1', Item."Variant Filter"); // Apply variant filter if set
                    if Item."Lot No. Filter" <> '' then TempEntryBuffer.SetFilter("Lot No.", '%1', Item."Lot No. Filter");
                end;
            }
            trigger OnAfterGetRecord() // Main trigger for processing item records
            begin
                if not InvPostingGroup.Get("Inventory Posting Group")then // Try to get inventory posting group record
 Clear(InvPostingGroup); // Clear if no posting group record is found
                TempEntryBuffer.Reset(); // Reset temporary buffer
                TempEntryBuffer.DeleteAll(); // Delete all temporary buffer entries
                Progress.Update(1, Format("No.")); // Update progress with the item number
            end;
            trigger OnPreDataItem() // Trigger before retrieving item data
            begin
                SetRange("Date Filter", 0D, EndDate); // Set date range filter for the item data
                SetRange(Blocked, false); // Exclude blocked items - only include items that are not blocked
            end;
        }
    }
    requestpage // Define the request page (UI) for user input
    {
        SaveValues = true; // Saves the last entered values for the report request

        layout // Define the layout for the request page
        {
            area(content) // Define content area of the request page
            {
                group(Options) // Group the options section
                {
                    Caption = 'Options'; // Caption for the options group

                    field(AsOfDate; EndDate) // Field for the As Of Date input
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'As Of Date'; // Caption for the field
                        ToolTip = 'Specifies the valuation date.'; // Help text for the user
                        ShowMandatory = true; // Mark this field as mandatory
                    }
                }
            }
        }
        actions // Define the actions available on the request page
        {
        }
    }
    labels // Define labels used throughout the report
    {
    }
    trigger OnPostReport() // Trigger after the report has been printed
    begin
        Progress.Close(); // Close the progress dialog
    end;
    trigger OnPreReport() // Trigger before the report begins printing
    begin
        Grouping:=(Item.FieldCaption("Inventory Posting Group") = Item.CurrentKey); // Set grouping condition based on the inventory posting group
        if EndDate = 0D then // Check if an As Of Date was provided
 Error(EndDateErr); // Raise an error if no date is provided
        if ShowLocations and (not ShowVariants)then if not "Item Ledger Entry".SetCurrentKey("Item No.", "Location Code")then Error(ShowLocationAndVariantsErr, "Item Ledger Entry".TableCaption(), "Item Ledger Entry".FieldCaption("Item No."), "Item Ledger Entry".FieldCaption("Location Code")); // Error if a valid key for location and item is missing
        if Item.GetFilter("Date Filter") <> '' then Error(EndDateFilterErr, Item.FieldCaption("Date Filter"), Item.TableCaption()); // Error if a Date Filter is set instead of using As Of Date
        CompanyInformation.Get(); // Fetch company information
        ItemFilter:=Item.GetFilters(); // Get the current filters applied on the Item table
        GLSetup.Get(); // Fetch General Ledger Setup
        // Load currency data and ensure proper rounding precision is set
        Currency.SetLoadFields(Description, "Amount Rounding Precision", "Unit-Amount Rounding Precision");
        if GLSetup."Additional Reporting Currency" = '' then // If no additional reporting currency is set, disable the ACY option
 ShowACY:=false
        else
        begin
            Currency.Get(GLSetup."Additional Reporting Currency"); // Fetch additional currency details
            Currency.TestField("Amount Rounding Precision"); // Ensure rounding precision is set for amounts
            Currency.TestField("Unit-Amount Rounding Precision"); // Ensure rounding precision is set for units
        end;
        Progress.Open(Item.TableCaption() + '  #1############'); // Open the progress dialog to track report generation
    end;
    var // Define global variables used in the report
 GetOnHandInventory: Codeunit 50124; //codenunit that calculates remaining qty
    GLSetup: Record "General Ledger Setup"; // Record for General Ledger Setup
    CompanyInformation: Record "Company Information"; // Record for Company Information
    InvPostingGroup: Record "Inventory Posting Group"; // Record for Inventory Posting Group
    Currency: Record Currency; // Record for Currency
    TempEntryBuffer: Record "Item Location Lot Buffer" temporary; // Temporary buffer to hold item location/variant data
    ItemFilter: Text; // Filter applied to items
    ShowVariants: Boolean; // Boolean flag for showing variants
    ShowLocations: Boolean; // Boolean flag for showing locations
    ShowLotNos: Boolean; // Boolean flag for showing lot numbers
    ShowPackageNos: Boolean; // Boolean flag for showing package numbers
    EnablePackageNos: Boolean; // Boolean variable to control the enabled state of BreakdownByPackage
    ShowACY: Boolean; // Boolean flag for showing additional currency
    LastItemNo: Code[20]; // Holds the last processed item number
    LastLocationCode: Code[10]; // Holds the last processed location code
    LastVariantCode: Code[10]; // Holds the last processed variant code
    LastLotNo: Code[50]; // Holds the last processed lot number
    LastPackageNo: Code[50]; // Holds the last processed package number
    VariantLabel: Text[250]; // Holds the formatted label for the current variant
    LocationLabel: Text[250]; // Holds the formatted label for the current location
    IsCollecting: Boolean; // Boolean flag to indicate if data is being collected
    Progress: Dialog; // Dialog object for tracking progress
    Grouping: Boolean; // Boolean flag for grouping logic
    EndDateErr: Label 'You must enter an As Of Date.'; // Error message for missing End Date
    ShowLocationAndVariantsErr: Label 'If you want to show Locations without also showing Variants, you must add a new key to the %1 table which starts with the %2 and %3 fields.', Comment = '%1 = Item Ledger Entry table Caption; %2 = Item No. field Caption; %3 = Location Code field Caption'; // Error message for missing key when showing locations
    EndDateFilterErr: Label 'Do not set a %1 on the %2.  Use the As Of Date on the Option tab instead.', Comment = '%1 = Date Filter field Caption; %2 = Item table Caption'; // Error message for invalid Date Filter
    EndDatePrefixLbl: Label 'Quantities and Values As Of %1', Comment = '%1 = As Of Date prefix'; // Label for As Of Date
    InvoicePostingGroupLbl: Label '%1 %2 (%3)', Comment = '%1 = Invoice Posting Group table Caption; %2 = Invoice Posting Group''s Code; %3 = Invoice Posting Group''s Description'; // Label for Inventory Posting Group
    InvoicePostingGroupTotalLbl: Label '%1 %2 (%3) Total', Comment = '%1 = Invoice Posting Group table Caption; %2 = Invoice Posting Group''s Code; %3 = Invoice Posting Group''s Description'; // Label for total of Inventory Posting Group
    CurrencyCodePrefixLbl: Label 'All Inventory Values are shown in %1.', Comment = '%1 = Curreny Code'; // Label for currency code in inventory values
    NoVariantLbl: Label 'No Variant'; // Label when no variant is specified
    NoLocationLbl: Label 'No Location'; // Label when no location is specified
    Inventory_ValuationCaptionLbl: Label 'Inventory Valuation'; // Caption for inventory valuation
    CurrReport_PAGENOCaptionLbl: Label 'Page'; // Caption for page number
    InventoryValue_Control34CaptionLbl: Label 'Inventory Value'; // Caption for inventory value
    UnitCost_Control33CaptionLbl: Label 'Unit Cost'; // Caption for unit cost
    Total_Inventory_ValueCaptionLbl: Label 'Total Inventory Value'; // Caption for total inventory value
    protected var // Variables that are accessible to this report and its triggers
 EndDate: Date; // Holds the As Of Date for the report
    #if not CLEAN23
    // Obsolete event handler that is marked for removal in future versions
    [IntegrationEvent(false, false)]
    [Obsolete('The event is not used and will be removed', '23.0')]
    local procedure OnBeforeOnAfterItemGetRecord(var Item: Record Item; var SkipItem: Boolean)
    begin
    end;
#endif 
}
