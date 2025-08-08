USE WORLD;
# 1. Tampilkan 10 kota dengan populasi terbanyak. (tampilkan nama kota, asal negara, dan populasinya)
SELECT*FROM City;
SELECT*FROM Country;
SELECT C.Name AS nama_kota, 
       O.Name AS nama_negara, 
       C.Population AS populasi
FROM City AS C
LEFT JOIN Country AS O 
ON C.CountryCode = O.code
ORDER BY C.Population DESC
LIMIT 10;
# 2. Tampilkan negara - negara di asia yang angka harapan hidupnya lebih besar dari rata-rata angka harapan hidup
# negara di benua eropa. Urutkan 10 data dari angka harapan hidup tertinggi. (tampilkan, nama negara, benua, angka harapan hidup, dan gnp).
SELECT*FROM Country;
SELECT 
	name AS Nama_negara,
    continent AS Benua,
    LifeExpectancy AS Angka_Harapan_Hidup,
    GNP
FROM Country
WHERE Continent = 'Asia'
HAVING lifeexpectancy>(SELECT AVG(LifeExpectancy)FROM Country WHERE Continent = 'europe')
ORDER BY lifeexpectancy DESC
LIMIT 10;
# 3. Tampilkan 10 negara dengan persentase tertinggi yang menggunakan bahasa inggris sebagai bahasa resmi negaranya.
# (Tampilkan kode negara, nama negara, bahasa, Resmi(T/F), persentase).
SELECT*FROM Countrylanguage;
SELECT*FROM Country;
SELECT 
	L.CountryCode AS Kode_Negara,
    C.name AS Nama_Negara,
    L.Language AS Bahasa,
    L.IsOfficial AS Resmi,
    L.Percentage AS Persentase
FROM CountryLanguage L 
LEFT JOIN Country C ON L.CountryCode = C.Code
WHERE Language = 'English' AND IsOfficial = 'T'
ORDER BY Percentage DESC
LIMIT 10;
# 4. Tampilkan negara, populasi negara, GNP, ibukota, dan populasi ibukota. DI ASEAN dan urutkan berdasarkan abjad nama negara. 
SELECT*FROM Country;
SELECT*FROM City;
SELECT 
	N.name AS Negara,
    N.Population AS Populasi_Negara,
    N.GNP,
    C.name As Ibu_Kota,
    C.Population AS Populasi_ibukota
FROM Country N 
LEFT JOIN City C ON N.Capital = C.ID
WHERE region = 'Southeast Asia'
ORDER BY N.name ASC;
# 5. Sama seperti no.4 Untuk negara G-20
SELECT*FROM Country;
SELECT 
	N.name AS Negara,
    N.Population AS Populasi_Negara,
    N.GNP,
    C.name As Ibu_Kota,
    C.Population AS Populasi_ibukota
FROM Country N 
LEFT JOIN City C ON N.Capital = C.ID
WHERE N.Code IN ('ARG', 'AUS', 'BRA', 'CAN', 'CHN', 'FRA', 'DEU', 'IND', 'IDN', 
               'ITA', 'JPN', 'KOR', 'MEX', 'RUS', 'SAU', 'ZAF', 'TUR', 'GBR', 'USA')
ORDER BY N.name ASC;

#===================================================================================================
# SAKILA

# 1. Tampilkan 10 baris data customer id, rental id, amount, dan payment date pada table payment!
USE sakila;
SELECT*FROM Payment;
SELECT customer_id,rental_id,amount,payment_date FROM Payment
LIMIT 10;
# 2. Dari table “film”, tampilkan 10 judul film, tahun release, dan durasi rental di mana judul film yang ditampilkan yang dimulai dengan huruf “S”!
SELECT*FROM film;
SELECT title, release_year, rental_duration FROM film
WHERE title LIKE 'S%'
LIMIT 10;
# 3. Dari tabel “film”, tampilkan durasi rental, banyaknya film setiap durasi rental, dan rata-rata durasi film!
# Kelompokkan jumlah film dan rata-rata durasi film berdasarkan durasi rentalnya!
# Karena rata-rata durasi film angka desimal, bulatkan 2 angka di belakang koma!
SELECT*FROM Film;
SELECT rental_duration,Count(distinct title) AS Total_Film,Round(AVG(length),2) AS Average_duration FROM Film
GROUP BY rental_duration;
# 4. Dari tabel film, tampilkan title, durasi film, dan juga rating yang durasi filmnya lebih dari rata-rata durasi film total!
# Tampilkan 25 data yang diurutkan dari durasi terlama!
SELECT*FROM film;
SELECT title,length as film_duration, rating FROM Film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC
LIMIT 25;
# 5. Dari tabel “film”, tampilkan rating, Replacement Cost tertinggi, Rental Rate Terendah, dan Rata-Rata Durasi 
# dan kelompokkan berdasarkan rating film!
SELECT*FROM Film;
SELECT rating, max(replacement_cost),min(rental_rate),AVG(rental_duration) FROM film
group by rating; 
# 6. Tampilkan 15 daftar film yang memiliki huruf “K” pada akhir pada title, lalu tampilkan title, durasi, serta Bahasa pada film!
# Sebagai catatan, lakukan join terlebih dahulu dari tabel “film” dan tabel “language”!
SELECT*FROM Film;
SELECT*FROM Language;
SELECT 
	F.title,
	F.length AS Duration,
    L.name AS Language
FROM film F 
LEFT JOIN language L ON F.language_id=L.language_id
WHERE F.title LIKE '%K'
LIMIT 15;
# 7. Tampilkan Judul Film (dari tabel “film”), First Name (dari tabel “actor”), dan Last Name (Dari tabel “actor”) dari actor yang memiliki “actor_id” = 14!
# Sebagai catatan, lakukan join table terlebih dahulu antara tabel “film”, “film_actor”, dan “actor”!
SELECT*FROM film;
SELECT*FROM film_actor;
SELECT*FROM actor;
SELECT 
    F.title AS Judul_Film,
    CONCAT(A.first_name, ' ', A.last_name) AS Nama_Aktor,
    A.actor_id
FROM film F 
LEFT JOIN film_actor FA ON F.film_id = FA.film_id
LEFT JOIN actor A ON FA.actor_id = A.actor_id
WHERE A.actor_id = 14;
# 8. Dari tabel "city“, tampilkan city dan country id! 
# Tampilkan hanya city atau kota yang namanya ada huruf "d" di posisi mana pun dan diakhiri huruf “a”!
# Tampilkan 15 data yang diurutkan berdasarkan city-nya secara ascending!
USE world;
SELECT name as city,countrycode FROM City
WHERE name LIKE '%d%_a'
ORDER BY name asc
LIMIT 15;
# 9. Tampilkan nama genre (name dari tabel “category”) dan jumlah banyaknya film di setiap genrenya!
# Lakukan join terlebih dahulu antara tabel “film”, “film_category”, dan “category”!
# Urutkan berdasarkan jumlah film di setiap kategorinya secara ascending!
USE sakila;
SELECT*FROM film;
SELECT*FROM film_category;
SELECT*FROM category;

SELECT 
	C.name as genre,
    Count(DISTINCT F.title) AS Banyaknya_Film
FROM film F 
LEFT JOIN film_category FC ON F.film_id = FC.film_id
LEFT JOIN category C ON FC.category_id = C.category_id
GROUP BY C.name
ORDER BY C.name ASC;
# 10. Dari tabel “film”, tampilkan title, description, length, serta rating!
# Tampilkan 10 judul film yang diakhiri huruf ‘h’ dan durasinya di atas durasi rata-rata!
# Urutkan berdasarkan judulnya secara ascending!
SELECT*FROM film;
SELECT title,description,length,rating FROM film
WHERE title LIKE '%h'
HAVING length>(SELECT AVG(length)FROM film)
ORDER BY title ASC
LIMIT 10;

    


