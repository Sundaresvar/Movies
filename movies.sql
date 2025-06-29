--Running total of box office by year
SELECT 
    release_year, 
    title, 
    box_office,
    SUM(box_office) OVER (
        PARTITION BY release_year 
        ORDER BY box_office DESC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM movies
ORDER BY release_year, running_total DESC;

-- Average rating per genre
SELECT g.name AS genre, AVG(r.rating) AS avg_rating
FROM movies m
JOIN genres g ON m.genre_id = g.genre_id
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY g.name
ORDER BY avg_rating DESC;

select * from genres

select * from movies

select * from ratings

--Rank movies by rating within each genre
WITH RankedMovies AS (
  SELECT m.title, g.name AS genre, r.rating,
         RANK() OVER (PARTITION BY g.name ORDER BY r.rating DESC) AS rank
  FROM movies m
  JOIN genres g ON m.genre_id = g.genre_id
  JOIN ratings r ON m.movie_id = r.movie_id
)
SELECT * FROM RankedMovies WHERE rank = 1;

--Number of movies per director
SELECT d.name AS director, COUNT(*) AS movie_count
FROM movies m
JOIN directors d ON m.director_id = d.director_id
GROUP BY d.name
ORDER BY movie_count DESC;

--Total box office by genre
SELECT g.name AS genre, SUM(m.box_office) AS total_revenue
FROM movies m
JOIN genres g ON m.genre_id = g.genre_id
GROUP BY g.name
ORDER BY total_revenue DESC;

--Top 5 highest-rated movies
SELECT m.title, r.rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
ORDER BY r.rating DESC
LIMIT 5;

--Show movies with box office and ratings
SELECT m.title, m.box_office, r.rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id;

--Show movies with director names and genres
SELECT m.title, m.release_year, d.name AS director, g.name AS genre
FROM movies m
JOIN directors d ON m.director_id = d.director_id
JOIN genres g ON m.genre_id = g.genre_id;

--List all movies with their genre names
SELECT m.title, g.name AS genre
FROM movies m
JOIN genres g ON m.genre_id = g.genre_id;


