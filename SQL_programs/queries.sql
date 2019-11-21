-- Database queries for testing, etc.

SELECT Manufac_Name, Mod_Name, Mod_Type, Mod_Price
FROM Model
JOIN Manufacturer ON Model.Mod_Manufac = Manufacturer.Manufac_ID;


SELECT Model.Mod_ID, Mod_NumStock, Vendor_Name, Vendor_ZIP, Vendor_Stock, Manufac_Name,
		Mod_Name, Mod_Type, Mod_Price, Mod_Skill, Mod_BattCell, Mod_LastStock
FROM Model
JOIN Stock_ID ON Stock_ID.Mod_ID = Model.Mod_ID
JOIN Vendor ON Vendor.Vendor_ID = Stock_ID.Vendor_ID
JOIN Manufacturer ON Model.Mod_Manufac = Manufacturer.Manufac_ID;


SELECT Customer.Customer_ID, Customer_First, Customer_Last, Customer_Phone,
		Purchase_ID, Model.Mod_ID, Quantity, Purchase_Date, Mod_Name
FROM Customer
JOIN Purchase on Purchase.Customer_ID = Customer.Customer_ID
JOIN Model on Model.Mod_ID = Purchase.Mod_ID
