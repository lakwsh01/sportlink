

Alter Table venue add column creation timestamp NOT NULL default (now() at time zone 'utc');
Alter Table venue add column md timestamp NOT NULL default (now() at time zone 'utc');
Alter Table venue add column creator varchar(255) NOT NULL;
Alter Table venue add column last_modifier varchar(255) NOT NULL;

Alter Table venue add column creator varchar(255) NOT NULL;
Alter Table venue add column last_modifier varchar(255) NOT NULL;
Alter Table venue Alter column last_modifier set default 'system';



INSERT INTO venue (facilities,geog,division,source,description,address,name)
Values('{}','SRID=4326;POINT(113.9437026 22.2905532)'::geometry,'"country" => "HKG","district" => "island_district","province" => NULL,"zone" => "isn"','"google_place_sdk" => "ChIJAXysXLDiAzQR3gSWrs77M4Q"',Null,'"zh_HK" => "香港東涌文東路39號東涌市政大樓","zh_TW" => "香港東涌文東路39號東涌市政大樓","en" => "Tung Chung Municipal Services Building, 39 Man Tung Rd, Tung Chung, Hong Kong"','"zh_HK" => "東涌文東路體育館","zh_TW" => "東涌文東路體育館","en" => "Tung Chung Man Tung Road Sports Centre"')