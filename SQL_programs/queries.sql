-- Database queries as samples for testing, analysis, etc.

-- Overview of models
SELECT Model.Mod_ID, Mod_NumStock, Vendor_Name, Vendor_ZIP, Vendor_Stock, Manufac_Name,
		Mod_Name, Mod_Type, Mod_Price, Mod_Skill, Mod_LastStock
FROM Model
JOIN Stock_ID ON Stock_ID.Mod_ID = Model.Mod_ID
JOIN Vendor ON Vendor.Vendor_ID = Stock_ID.Vendor_ID
JOIN Manufacturer ON Model.Mod_Manufac = Manufacturer.Manufac_ID;


-- Overview of Customers / Purchases
SELECT Customer.Customer_ID, Customer_First, Customer_Last, Customer_Phone,
		Purchase_ID, Model.Mod_ID, Quantity, Purchase_Date, Mod_Name
FROM Customer
JOIN Purchase on Purchase.Customer_ID = Customer.Customer_ID
JOIN Model on Model.Mod_ID = Purchase.Mod_ID;


-- Pilot selection of model characteristics
SELECT Mod_Name, Mod_Type, Mod_Price, Mod_Skill, Mod_FieldReq
FROM Model
WHERE Mod_Type = 'A' AND Mod_Price < 200.00 AND Mod_Skill = 'Beginner' AND Mod_FieldReq = 'Large';
