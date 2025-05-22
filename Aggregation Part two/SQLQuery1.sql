create database MovieStreamingPlatform

use MovieStreamingPlatform




CREATE TABLE users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    subscription_type VARCHAR(10) NOT NULL CHECK (subscription_type IN ('Basic', 'Standard', 'Premium')),
    signup_date DATE NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- Movies table
CREATE TABLE movies (
    movie_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    release_year INT NOT NULL,
    duration_minutes INT NOT NULL,
    director VARCHAR(100) NOT NULL,
    imdb_rating DECIMAL(3,1)
);

-- User viewing history
CREATE TABLE viewing_history (
    view_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    completion_percentage DECIMAL(5,2) NOT NULL,
    device_type VARCHAR(10) NOT NULL CHECK (device_type IN ('Mobile', 'Tablet', 'Smart TV', 'Desktop')),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- User ratings
CREATE TABLE ratings (
    rating_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    movie_id INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating BETWEEN 1 AND 5),
    rating_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    CONSTRAINT UQ_user_movie_rating UNIQUE (user_id, movie_id)
);

-- Subscription changes
CREATE TABLE subscription_changes (
    change_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    old_subscription VARCHAR(10) NULL CHECK (old_subscription IN ('Basic', 'Standard', 'Premium')),
    new_subscription VARCHAR(10) NOT NULL CHECK (new_subscription IN ('Basic', 'Standard', 'Premium')),
    change_date DATETIME NOT NULL,
    reason VARCHAR(200),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- Insert sample users
INSERT INTO users (username, email, subscription_type, signup_date, country) VALUES
('movie_lover42', 'ml42@example.com', 'Premium', '2022-01-15', 'USA'),
('cinema_fan', 'cfan@example.com', 'Standard', '2022-03-22', 'Canada'),
('stream_queen', 'squeen@example.com', 'Premium', '2022-02-10', 'UK'),
('film_buff', 'fbuff@example.com', 'Basic', '2022-04-05', 'Australia'),
('watchaholic', 'watch@example.com', 'Standard', '2022-01-30', 'USA'),
('screen_time', 'stime@example.com', 'Premium', '2022-05-18', 'Canada'),
('popcorn_addict', 'popaddict@example.com', 'Basic', '2022-06-12', 'UK'),
('binge_watcher', 'binge@example.com', 'Premium', '2022-03-01', 'USA'),
('film_critic', 'critic@example.com', 'Standard', '2022-02-28', 'Australia'),
('night_viewer', 'night@example.com', 'Basic', '2022-04-20', 'Canada');

-- Insert sample movies
INSERT INTO movies (title, genre, release_year, duration_minutes, director, imdb_rating) VALUES
('The Last Adventure', 'Action', 2022, 128, 'James Cameron', 7.8),
('Midnight in Paris', 'Romance', 2021, 112, 'Woody Allen', 8.1),
('Space Odyssey 3000', 'Sci-Fi', 2023, 145, 'Christopher Nolan', 8.9),
('The Silent Witness', 'Thriller', 2021, 98, 'David Fincher', 7.5),
('Laugh Out Loud', 'Comedy', 2022, 105, 'Judd Apatow', 6.9),
('Historical Times', 'Drama', 2020, 132, 'Steven Spielberg', 8.3),
('The Dark Forest', 'Horror', 2022, 115, 'Jordan Peele', 7.2),
('Ocean Mysteries', 'Documentary', 2021, 89, 'James Cameron', 8.0),
('Family Ties', 'Drama', 2023, 121, 'Greta Gerwig', 7.7),
('Racing Hearts', 'Action', 2022, 137, 'Michael Bay', 6.5);

-- Insert sample viewing history
INSERT INTO viewing_history (user_id, movie_id, start_time, end_time, completion_percentage, device_type) VALUES
(1, 3, '2023-01-15 20:00:00', '2023-01-15 22:25:00', 100.00, 'Smart TV'),
(1, 5, '2023-01-16 18:30:00', '2023-01-16 20:05:00', 95.24, 'Mobile'),
(2, 1, '2023-01-10 19:00:00', '2023-01-10 21:08:00', 100.00, 'Desktop'),
(2, 8, '2023-01-12 15:00:00', '2023-01-12 16:29:00', 100.00, 'Tablet'),
(3, 2, '2023-01-05 21:00:00', '2023-01-05 22:52:00', 100.00, 'Smart TV'),
(3, 4, '2023-01-07 20:30:00', '2023-01-07 22:08:00', 100.00, 'Desktop'),
(4, 6, '2023-01-18 19:00:00', '2023-01-18 21:12:00', 100.00, 'Mobile'),
(5, 7, '2023-01-20 22:00:00', '2023-01-20 23:55:00', 100.00, 'Smart TV'),
(6, 9, '2023-01-22 18:00:00', '2023-01-22 20:01:00', 100.00, 'Desktop'),
(7, 10, '2023-01-25 20:30:00', '2023-01-25 22:47:00', 100.00, 'Tablet'),
(1, 2, '2023-02-01 19:00:00', '2023-02-01 20:40:00', 85.71, 'Mobile'),
(2, 3, '2023-02-02 20:00:00', '2023-02-02 22:25:00', 100.00, 'Smart TV'),
(3, 1, '2023-02-03 18:30:00', '2023-02-03 20:38:00', 100.00, 'Desktop'),
(4, 5, '2023-02-04 21:00:00', '2023-02-04 22:35:00', 90.48, 'Mobile'),
(5, 8, '2023-02-05 15:00:00', '2023-02-05 16:15:00', 75.00, 'Tablet');

-- Insert sample ratings
INSERT INTO ratings (user_id, movie_id, rating, rating_date) VALUES
(1, 3, 5.0, '2023-01-16'),
(1, 5, 4.0, '2023-01-17'),
(2, 1, 4.5, '2023-01-11'),
(2, 8, 5.0, '2023-01-13'),
(3, 2, 4.0, '2023-01-06'),
(3, 4, 3.5, '2023-01-08'),
(4, 6, 5.0, '2023-01-19'),
(5, 7, 4.0, '2023-01-21'),
(6, 9, 4.5, '2023-01-23'),
(7, 10, 3.0, '2023-01-26'),
(1, 2, 4.5, '2023-02-02'),
(2, 3, 5.0, '2023-02-03'),
(3, 1, 4.0, '2023-02-04'),
(4, 5, 3.5, '2023-02-05'),
(5, 8, 4.0, '2023-02-06');

-- Insert sample subscription changes
INSERT INTO subscription_changes (user_id, old_subscription, new_subscription, change_date, reason) VALUES
(4, NULL, 'Basic', '2022-04-05 14:32:10', 'New signup'),
(7, NULL, 'Basic', '2022-06-12 09:15:45', 'New signup'),
(4, 'Basic', 'Standard', '2023-01-20 18:22:33', 'Wanted HD streaming'),
(7, 'Basic', 'Premium', '2023-02-01 11:05:17', 'Wanted 4K and multiple screens'),
(5, 'Standard', 'Basic', '2023-01-15 20:45:09', 'Cost saving'),
(5, 'Basic', 'Standard', '2023-02-10 16:30:22', 'Missed HD quality');

-- 1. Total Number of Users
SELECT COUNT(*) AS total_users FROM users;

-- 2. Average Duration of All Movies
SELECT AVG(duration_minutes) AS avg_duration_minutes FROM movies;

-- 3. Total Watch Time (in minutes)
SELECT SUM(DATEDIFF(MINUTE, start_time, end_time)) AS total_watch_time_minutes
FROM viewing_history;

-- 4. Number of Movies per Genre
SELECT genre, COUNT(*) AS movie_count
FROM movies
GROUP BY genre
ORDER BY movie_count DESC;

-- 5. Earliest User Join Date
SELECT MIN(signup_date) AS earliest_join_date FROM users;

-- 6. Latest Movie Release Year
SELECT MAX(release_year) AS latest_release_year FROM movies;


--4. Number of Users Per Subscription Type

SELECT 
    subscription_type,
    COUNT(*) AS user_count,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users) AS DECIMAL(5,2)) AS percentage
FROM users
GROUP BY subscription_type
ORDER BY user_count DESC;

--5. Total Watch Time per User

SELECT 
    u.user_id,
    u.username,
    u.subscription_type,
    SUM(DATEDIFF(MINUTE, vh.start_time, vh.end_time))/60.0 AS total_watch_hours,
    COUNT(vh.view_id) AS view_count
FROM users u
LEFT JOIN viewing_history vh ON u.user_id = vh.user_id
GROUP BY u.user_id, u.username, u.subscription_type
ORDER BY total_watch_hours DESC;

--6. Average Watch Duration per Movie
SELECT 
    m.movie_id,
    m.title,
    m.duration_minutes AS movie_length_minutes,
    AVG(DATEDIFF(MINUTE, vh.start_time, vh.end_time)) AS avg_watch_duration_minutes,
    AVG(vh.completion_percentage) AS avg_completion_percentage
FROM movies m
LEFT JOIN viewing_history vh ON m.movie_id = vh.movie_id
GROUP BY m.movie_id, m.title, m.duration_minutes
ORDER BY avg_completion_percentage DESC;


--7. Average Watch Time per Subscription Type

SELECT 
    m.movie_id,
    m.title,
    COUNT(vh.view_id) AS view_count,
    CASE WHEN COUNT(vh.view_id) = 0 THEN 'No views' 
         WHEN COUNT(vh.view_id) BETWEEN 1 AND 5 THEN '1-5 views'
         WHEN COUNT(vh.view_id) BETWEEN 6 AND 10 THEN '6-10 views'
         ELSE '10+ views' END AS view_category
FROM movies m
LEFT JOIN viewing_history vh ON m.movie_id = vh.movie_id
GROUP BY m.movie_id, m.title
ORDER BY view_count DESC;

--8. Number of Views per Movie (Including Zero)

SELECT 
    m.movie_id,
    m.title,
    COUNT(vh.view_id) AS view_count,
    CASE WHEN COUNT(vh.view_id) = 0 THEN 'No views' 
         WHEN COUNT(vh.view_id) BETWEEN 1 AND 5 THEN '1-5 views'
         WHEN COUNT(vh.view_id) BETWEEN 6 AND 10 THEN '6-10 views'
         ELSE '10+ views' END AS view_category
FROM movies m
LEFT JOIN viewing_history vh ON m.movie_id = vh.movie_id
GROUP BY m.movie_id, m.title
ORDER BY view_count DESC;

--9. Average Movie Duration per Release Year
SELECT 
    release_year,
    COUNT(*) AS movie_count,
    AVG(duration_minutes) AS avg_duration_minutes,
    MIN(duration_minutes) AS min_duration,
    MAX(duration_minutes) AS max_duration
FROM movies
GROUP BY release_year
ORDER BY release_year DESC;


--7. Most Watched Movie
SELECT TOP 5
    m.movie_id,
    m.title,
    COUNT(vh.view_id) AS view_count,
    SUM(DATEDIFF(MINUTE, vh.start_time, vh.end_time)) AS total_watch_minutes,
    AVG(vh.completion_percentage) AS avg_completion_percentage,
    AVG(r.rating) AS avg_user_rating
FROM movies m
LEFT JOIN viewing_history vh ON m.movie_id = vh.movie_id
LEFT JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
ORDER BY total_watch_minutes DESC, view_count DESC;
--8. Users Who Watched More Than 100 Minutes
SELECT 
    u.user_id,
    u.username,
    u.subscription_type,
    SUM(DATEDIFF(MINUTE, vh.start_time, vh.end_time)) AS total_watch_minutes,
    COUNT(DISTINCT vh.movie_id) AS unique_movies_watched
FROM users u
JOIN viewing_history vh ON u.user_id = vh.user_id
GROUP BY u.user_id, u.username, u.subscription_type
HAVING SUM(DATEDIFF(MINUTE, vh.start_time, vh.end_time)) > 100
ORDER BY total_watch_minutes DESC;
--9. Total Watch Time per Genre

SELECT 
    m.genre,
    SUM(DATEDIFF(MINUTE, vh.start_time, vh.end_time))/60.0 AS total_watch_hours,
    COUNT(vh.view_id) AS view_count,
    COUNT(DISTINCT vh.user_id) AS unique_users
FROM movies m
JOIN viewing_history vh ON m.movie_id = vh.movie_id
GROUP BY m.genre
ORDER BY total_watch_hours DESC;

--10. Identify Binge Watchers (Users Who Watched 2 or More Movies in One Day)
SELECT 
    u.user_id,
    u.username,
    u.subscription_type,
    COUNT(DISTINCT CAST(v1.start_time AS DATE)) AS binge_days,
    MAX(day_counts.movies_watched) AS max_movies_in_day
FROM users u
JOIN viewing_history v1 ON u.user_id = v1.user_id
JOIN (
    SELECT 
        user_id,
        CAST(start_time AS DATE) AS watch_date,
        COUNT(DISTINCT movie_id) AS movies_watched
    FROM viewing_history
    GROUP BY user_id, CAST(start_time AS DATE)
) AS day_counts ON u.user_id = day_counts.user_id 
                AND CAST(v1.start_time AS DATE) = day_counts.watch_date
                AND day_counts.movies_watched >= 2
GROUP BY u.user_id, u.username, u.subscription_type
ORDER BY binge_days DESC, max_movies_in_day DESC;

--11. Genre Popularity (Total Watch Duration by Genre)
SELECT 
    m.genre,
    SUM(DATEDIFF(MINUTE, vh.start_time, vh.end_time))/60.0 AS total_watch_hours,
    AVG(vh.completion_percentage) AS avg_completion_percentage,
    COUNT(DISTINCT vh.user_id) AS unique_viewers,
    COUNT(vh.view_id) AS total_views
FROM movies m
JOIN viewing_history vh ON m.movie_id = vh.movie_id
GROUP BY m.genre
ORDER BY total_watch_hours DESC;

--12. User Retention Insight: Number of Users Joined Each Month

SELECT 
    YEAR(u.signup_date) AS signup_year,
    MONTH(u.signup_date) AS signup_month,
    DATENAME(MONTH, u.signup_date) AS month_name,
    COUNT(DISTINCT u.user_id) AS new_users,
    COUNT(DISTINCT CASE WHEN vh.start_time >= DATEADD(MONTH, -1, GETDATE()) THEN u.user_id END) AS active_users,
    CASE 
        WHEN COUNT(DISTINCT u.user_id) = 0 THEN 0
        ELSE CAST(COUNT(DISTINCT CASE WHEN vh.start_time >= DATEADD(MONTH, -1, GETDATE()) THEN u.user_id END) * 100.0 / 
             COUNT(DISTINCT u.user_id) AS DECIMAL(5,2))
    END AS retention_rate
FROM users u
LEFT JOIN viewing_history vh ON u.user_id = vh.user_id
GROUP BY YEAR(u.signup_date), MONTH(u.signup_date), DATENAME(MONTH, u.signup_date)
ORDER BY signup_year DESC, signup_month DESC;

