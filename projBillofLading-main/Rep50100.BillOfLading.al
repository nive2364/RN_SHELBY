namespace projBillofLading.projBillofLading;

using Microsoft.Sales.History;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;

report 50100 BillOfLading
{
    Caption = 'Bill of Lading';
    RDLCLayout = './Local/Sales/History/BillOfLading.rdlc';
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = Sorting("No.");
            RequestFilterFields = "No.";
            PrintOnlyIfDetail = True;

            column(BilltoAddress; "Bill-to Address")
            {
            }
            column(BilltoAddress2a; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoContact; "Bill-to Contact")
            {
            }
            column(BilltoContactNo; "Bill-to Contact No.")
            {
            }
            column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(BilltoCounty; "Bill-to County")
            {
            }
            column(BilltoCustomerId; "Bill-to Customer Id")
            {
            }
            column(BilltoCustomerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoName2; "Bill-to Name 2")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }
            column(CustomerId; "Customer Id")
            {
            }
            column(No; "No.")
            {
            }
            column(NoPrinted; "No. Printed")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(RequestedDeliveryDate; "Requested Delivery Date")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoAddress2; "Sell-to Address 2")
            {
            }
            column(SelltoCity; "Sell-to City")
            {
            }
            column(SelltoContact; "Sell-to Contact")
            {
            }
            column(SelltoContactNo; "Sell-to Contact No.")
            {
            }
            column(SelltoCountryRegionCode; "Sell-to Country/Region Code")
            {
            }
            column(SelltoCounty; "Sell-to County")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2; "Sell-to Customer Name 2")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoEMail; "Sell-to E-Mail")
            {
            }
            column(SelltoPhoneNo; "Sell-to Phone No.")
            {
            }
            column(SelltoPostCode; "Sell-to Post Code")
            {
            }
            column(ShipmentDate; "Shipment Date")
            {
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2a; "Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoCode; "Ship-to Code")
            {
            }
            column(ShiptoContact; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCounty; "Ship-to County")
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoName2; "Ship-to Name 2")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(ShiptoUPSZone; "Ship-to UPS Zone")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(Transaction_Type; "Transaction Type")
            {
            }
            column(No_; "No.")
            {
            }
            column(Carrier; Carrier)
            {
            }
            column(PONo; "PO No.")
            {
            }
            column(ShippingNotes; "Route")
            {
            }
            column(SealNo; "Seal No.")
            {
            }
            column(TractorNo; "Tractor No.")
            {
            }
            column(TrailerNo; "Trailer No.")
            {
            }
            column(VehicleInitials; "Vehicle Initials")
            {
            }
            column(PalletCount; "Pallet Count")
            {
            }
            column(ShowEUVerbiage; "Show EU Verbiage")
            {
            }
            column(additionalNotes; "Additional Notes3")
            {
            }
            column(Print_VSN; "Print VSN")
            {
            }
            column(PrintAPHIS; PrintAPHIS)
            {
            }
            column(PrintFLSA; PrintFLSA)
            {
            }
            column(PrintInedible; PrintInedible)
            {
            }
            column(PrintEV; PrintEV)
            {
            }
            column(PrintEVRemoveCanada; PrintEVRemoveCanada)
            {
            }
            column(PrintAPHIS_CANADA; PrintAPHIS_CANADA)
            {
            }
            column(PrintLoadLocks; PrintLoadLocks)
            {
            }
            column(PrintCOA; PrintCOA)
            {
            }
            column(Country; Marks_Country)
            {
            }
            column(Marks; Marks_text)
            {
            }
            column(Temperature; Temperature)
            {
            }
            column(TimeOut; TimeOut)
            {
            }
            column(ShelbyReleaseNum; ShelbyReleaseNum)
            {
            }
            dataitem(ItemLedgerEntry; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                column(LotNo; "Lot No.")
                {
                }
                column(Expiration_Date; "Expiration Date")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Location; "Location Code")
                {
                }
                column(BlockCount; BlcokCount)
                {
                }

                dataitem(Item; Item)
                {
                    DataItemLink = "No." = field("Item No.");
                    DataItemTableView = Sorting("No.");
                    column(ItemNo; "No.")
                    {
                    }
                    column(Description; Description)
                    {
                    }
                    column(PalletBlockCount; PalletBlockCount)
                    {
                    }
                }
            }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
