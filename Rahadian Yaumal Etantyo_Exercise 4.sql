USE sakila;
# 1. Tampilkan lima total rental_duration di tiap kategori film.
# Hitung jumlah kumulatif atau cumulative sum dan rata-rata bergerak atau moving average dari total rental_duration.
# Untuk membatasi data, pilih hanya film yang rental_duration-nya ≤ rata-rata keseluruhan rental_duration.

-- Cumulative sum --> SUM --> ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- Moving average --> AVG --> ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT*FROM Film;
SELECT*FROM film_category;
SELECT*FROM category;
WITH table_sum AS(SELECT
	C.name AS genre,
    SUM(F.rental_duration) OVER(partition by C.name) AS Total_Rental_Duration,
    ROW_NUMBER () OVER (Partition by C.name ORDER BY F.rental_duration DESC) AS RANK_NUMB 
FROM film F 
INNER JOIN film_category FC ON F.film_id = FC.film_id
INNER JOIN category C ON FC.category_id = C.category_id
)
SELECT genre,total_rental_duration FROM table_sum
WHERE rank_numb <=5;
#================================================================
WITH kumulatif_sum AS (Select
	C.name AS genre,
    SUM(F.rental_duration) AS Total_rental_duration
FROM film F 
INNER JOIN film_category FC ON F.film_id = FC.film_id
INNER JOIN category C ON FC.category_id = C.category_id
GROUP BY C.name
)
SELECT 
	genre,
    Total_rental_duration,
    SUM(Total_rental_duration) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Cumulative_Sum,
    AVG(Total_rental_duration) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS MA
FROM kumulatif_sum
WHERE Total_rental_duration <= (SELECT AVG(Total_rental_duration) FROM kumulatif_sum);
# 2. Tampilkan rating film beserta rata-rata durasi rentalnya.
# Gunakan data durasi rental film yang berasal dari 3 kategori dengan jumlah film terbanyak
WITH Film_terbanyak AS (
    SELECT 
        FC.category_id,
        C.name AS genre,
        COUNT(FC.film_id) AS Jumlah_Film
    FROM film_category FC
    INNER JOIN category C ON FC.category_id = C.category_id
    GROUP BY FC.category_id, C.name
    ORDER BY Jumlah_Film DESC
    LIMIT 3
)

SELECT 
    F.rating,
    AVG(F.rental_duration) AS avg_rental_duration
FROM film F
INNER JOIN film_category FC ON F.film_id = FC.film_id
INNER JOIN Film_terbanyak FT ON FC.category_id = FT.category_id
GROUP BY F.rating
ORDER BY avg_rental_duration DESC;WITH Film_terbanyak AS (
    SELECT 
        FC.category_id,
        C.name AS genre,
        COUNT(FC.film_id) AS Jumlah_Film
    FROM film_category FC
    JOIN category C ON FC.category_id = C.category_id
    GROUP BY FC.category_id, C.name
    ORDER BY Jumlah_Film DESC
    LIMIT 3
)

SELECT 
    F.rating,
    AVG(F.rental_duration) AS avg_rental_duration
FROM film F
JOIN film_category FC ON F.film_id = FC.film_id
JOIN Film_terbanyak FT ON FC.category_id = FT.category_id
GROUP BY F.rating
ORDER BY avg_rental_duration DESC;
# 3. Tampilkan judul film dan total konsumen yang menyewa di tiap judul film tersebut.
# Saat menampilkan data tersebut, penuhi beberapa syarat berikut ini.
# Pertama, huruf pertama judul film adalah huruf ‘C’ atau ‘G’.
# Kedua, total konsumen yang menyewa di tiap judul film harus lebih tinggi dari rata-rata keseluruhan.
# Ketiga, total konsumen yang menyewa di tiap judul film harus ≥ 15 dan ≤ 25
SELECT*FROM film;
SELECT*FROM inventory;
SELECT*FROM rental;
WITH tb_sewa AS (
    SELECT 
        I.film_id,
        COUNT(distinct R.customer_id) AS Total_Menyewa
    FROM inventory I 
    INNER JOIN rental R ON I.inventory_id = R.inventory_id
    GROUP BY I.film_id
),
rata_sewa AS (
    SELECT AVG(Total_Menyewa) AS Rata_Rata_Sewa FROM tb_sewa
)
SELECT 
    F.title,
    T.Total_Menyewa AS Jumlah_penyewa
FROM film F 
INNER JOIN tb_sewa T ON F.film_id = T.film_id
WHERE (F.title LIKE 'C%' OR F.title LIKE 'G%')
AND T.Total_Menyewa > (SELECT Rata_Rata_Sewa FROM rata_sewa)
AND T.Total_Menyewa BETWEEN 15 AND 25
ORDER BY T.Total_Menyewa DESC;


    
    



    

	
    
