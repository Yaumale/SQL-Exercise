use world;
show full tables;
SELECT*FROM country;
#NO 1 Ada berapa negara di database?
SELECT COUNT(name) FROM country;
#NO 2 Tampilkan Rata-Rata Harapan hidup di benua asia
SELECT AVG (LifeExpectancy) FROM Country where Continent ='Asia';
#NO 3 Tampilkan total populasi dari asia tenggara
SELECT SUM(Population) FROM Country where Region = 'Southeast Asia';
#NO 4 Tampilkan rata-rata GNP di benua Afrika region Eastern Africa.
#Gunakan alias 'Average_GNP' untuk rata-rata GNP!
SELECT AVG(GNP) AS 'Average_GNP' FROM Country where continent = 'Africa' and region = 'Eastern Africa';
#NO 5 Tampilkan rata-rata Populasi pada negara yang luas areanya lebih dari 5 juta km2!
SELECT AVG(Population) From Country where surfacearea > 5000000;
#NO 6 Ada berapa bahasa (unique) di dunia?
SELECT*FROM countrylanguage;
SELECT DISTINCT COUNT(Language) FROM countrylanguage;
#NO 7 Tampilkan GNP dari 5 negara di Asia yang populasinya di atas 100 juta penduduk!
SELECT GNP FROM Country where Population > 100000000 and continent ='Asia'
limit 5;
#NO 8 Tampilkan negara di Afrika yang memiliki SurfaceArea di atas 1.200.000!
SELECT name FROM country where continent='Africa' and surfacearea > 1200000;
#NO 9 Tampilkan negara di Asia yang sistem pemerintahannya adalah republik.
#Ada berapa jumlah negaranya
SELECT name FROM Country WHERE governmentform = 'Republic' AND continent = 'Asia';
SELECT COUNT(name) FROM Country WHERE governmentform = 'Republic' AND continent = 'Asia';
#NO 10 Tampilkan jumlah negara di Eropa yang merdeka sebelum 1940!
SELECT COUNT(name) From Country WHERE continent = 'europe' AND indepyear < 1940;





 


