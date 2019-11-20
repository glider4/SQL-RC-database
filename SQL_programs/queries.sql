-- Database queries

SELECT Manufac_Name, Mod_Name, Mod_Type, Mod_Price
FROM Model
JOIN Manufacturer ON Model.Mod_Manufac = Manufacturer.Manufac_ID