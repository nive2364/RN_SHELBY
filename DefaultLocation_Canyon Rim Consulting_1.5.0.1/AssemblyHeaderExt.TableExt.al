tableextension 50220 AssemblyHeaderExt extends "Assembly Header"
{
    fields
    {
    }
    trigger OnModify()
    var
        Item: Record Item; // Declare a variable for the Item record.
    begin
        // Debugging message to ensure the trigger is called.
        //Message('OnModify trigger called.');
        // Check if the Item record can be retrieved using the Item No. from the Assembly Header.
        if Item.Get(Rec."Item No.")then begin
            // Debugging message to confirm the Item record is found.
            //Message('Item with No. %1 found. Default Location Code: %2', Rec."Item No.", Item."Default Location");
            // Validate and set the Location Code on the Assembly Header to the Default Location from the Item.
            Rec.Validate("Location Code", Item."Default Location");
            // Debugging message to confirm the Location Code is set.
            //Message('Location Code set to %1', Rec."Location Code");
            // Save the changes to the Assembly Header record.
            Rec.Modify();
        end
        else
        begin
            // Handle the case where the Item record is not found.
            Error('Item with No. %1 not found.', Rec."Item No.");
        end;
    end;
}
