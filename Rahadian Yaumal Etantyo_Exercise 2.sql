USE world;
SELECT*FROM Country;
#=============================================================
#1. Ada berapa region di database world? Ubah headernya menjadi 'Jumlah_Region'!
SELECT DISTINCT COUNT(region) AS Jumlah_Region FROM Country;
#=============================================================
#2. Ada berapa negara di Africa? Ubah headernya menjadi 'Jumlah_Negara'!
SELECT DISTINCT COUNT(name) AS Jumlah_Negara FROM Country
WHERE Continent = 'Africa';
#=============================================================
#3. Tampilkan 5 negara dengan populasi terbesar! 
# Ubah headernya menjadi 'Nama_Negara' dan 'Populasi'!
SELECT name AS Nama_Negara,population AS Populasi FROM Country
ORDER BY Population DESC
LIMIT 5;
#=============================================================================
#4. Tampilkan rata-rata harapan hidup tiap benua dan urutkan dari yang terendah! 
# Ubah headernya menjadi 'Nama_Benua' dan 'Rata_Rata_Harapan_Hidup'!
SELECT Continent AS Nama_Benua,AVG(LifeExpectancy)AS Rata_Rata_Harapan_Hidup FROM Country
GROUP BY Continent
HAVING AVG(LifeExpectancy)
ORDER BY AVG(LifeExpectancy) ASC;
#===========================================================================
#5. Tampilkan Jumlah region tiap benua dengan jumlah region lebih dari 3! 
# Ubah headernya menjadi 'Nama_Benua' dan 'Jumlah_Region'!
SELECT Continent AS Nama_Benua, COUNT(Region) AS Jumlah_Region FROM Country
GROUP BY Continent
HAVING COUNT(Region)>3;
#===========================================================================
#6. Tampilkan rata-rata GNP di Afrika berdasarkan regionnya 
# dan urutkan dari rata-rata GNP terbesar! 
# Ubah headernya menjadi 'Nama_Region' dan 'Rata_Rata_GNP'!
SELECT Region AS Nama_Region, AVG(GNP) AS Rata_Rata_GNP FROM Country
WHERE Continent ='Africa'
GROUP BY Region
ORDER BY AVG(GNP) DESC;
#==========================================================================
#7. Tampilkan negara di Eropa yang memiliki nama dimulai dari huruf I
SELECT name FROM Country
WHERE name like 'I%'
AND Continent = 'Europe';
#========================================================================
#8. Tampilkan Jumlah bahasa tiap negara! Urutkan dari yg paling banyak! 
# Ubah headernya menjadi 'Jumlah_Bahasa'
SELECT*FROM Countrylanguage;
SELECT CountryCode AS Negara, COUNT(distinct Language)AS Jumlah_Bahasa FROM Countrylanguage
GROUP BY CountryCode
HAVING COUNT(distinct Language);
#====================================================================================
#9. Tampilkan nama negara yang panjang hurufnya 6 huruf dan berakhiran 'O'
SELECT*FROM Country;
SELECT name FROM Country
WHERE name like '_____o';
#===================================================================================
#10. Tampilkan 7 bahasa terbesar di Indonesia 
# (secara persentase, dengan persentase yg dibulatkan)! 
# Ubah headernya menjadi 'Bahasa' dan 'Persentase'
SELECT*FROM Countrylanguage;
SELECT Language AS Bahasa, ROUND(Percentage,0) AS Persentase FROM CountryLanguage
WHERE CountryCode = 'IDN'
ORDER BY ROUND(Percentage,0) DESC
LIMIT 7;
#===================================================================================
#11. Tampilkan Continent yang memiliki GovernmentForm kurang dari 10
SELECT*FROM Country;
SELECT Continent FROM Country
GROUP BY Continent
HAVING COUNT(DISTINCT GovernmentForm) < 10;
#===========================================================================
# 12. Region mana saja yg Total GNP-nya mengalami kenaikan dari Total GNP sebelumnya (GNPOld)? 
# Urutkan dari yg tertinggi!
SELECT Region, SUM(GNPOld),SUM(GNP) FROM Country
GROUP BY Region
HAVING SUM(GNP)>SUM(GNPOld)
ORDER BY SUM(GNP) - SUM(GNPOld) DESC;

