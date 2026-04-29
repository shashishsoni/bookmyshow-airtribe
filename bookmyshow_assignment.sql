DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS screens;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS theatres;

CREATE TABLE theatres (
    theatre_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(80) NOT NULL,
    state VARCHAR(80) NOT NULL,
    pincode VARCHAR(12) NOT NULL
);

CREATE TABLE screens (
    screen_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    theatre_id BIGINT NOT NULL,
    screen_name VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL,
    CONSTRAINT fk_screens_theatre
        FOREIGN KEY (theatre_id) REFERENCES theatres(theatre_id)
        ON DELETE CASCADE,
    CONSTRAINT uq_theatre_screen UNIQUE (theatre_id, screen_name)
);

CREATE TABLE movies (
    movie_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    language VARCHAR(40) NOT NULL,
    duration_mins INT NOT NULL,
    certificate VARCHAR(10) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE shows (
    show_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    screen_id BIGINT NOT NULL,
    movie_id BIGINT NOT NULL,
    show_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    status ENUM('OPEN', 'CANCELLED') NOT NULL DEFAULT 'OPEN',
    CONSTRAINT fk_shows_screen
        FOREIGN KEY (screen_id) REFERENCES screens(screen_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_shows_movie
        FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
        ON DELETE RESTRICT,
    CONSTRAINT uq_screen_date_time UNIQUE (screen_id, show_date, start_time)
);

-- Sample data
INSERT INTO theatres (name, address, city, state, pincode)
VALUES
    ('PVR Nexus Koramangala', 'Koramangala 5th Block', 'Bengaluru', 'Karnataka', '560095');

INSERT INTO screens (theatre_id, screen_name, total_seats)
VALUES
    (1, 'Audi 1', 180),
    (1, 'Audi 2', 150);

INSERT INTO movies (title, language, duration_mins, certificate, is_active)
VALUES
    ('Dasara', 'Telugu', 156, 'U/A', TRUE),
    ('Kisi Ka Bhai Kisi Ki Jaan', 'Hindi', 145, 'U/A', TRUE),
    ('Tu Jhoothi Main Makkaar', 'Hindi', 159, 'U/A', TRUE),
    ('Avatar: The Way of Water', 'English', 192, 'U/A', TRUE);

INSERT INTO shows (screen_id, movie_id, show_date, start_time, end_time, base_price, status)
VALUES
    (1, 1, '2026-04-25', '12:15:00', '14:51:00', 180.00, 'OPEN'),
    (1, 2, '2026-04-25', '16:10:00', '18:35:00', 220.00, 'OPEN'),
    (2, 2, '2026-04-25', '19:20:00', '21:45:00', 250.00, 'OPEN'),
    (2, 3, '2026-04-25', '10:30:00', '13:09:00', 170.00, 'OPEN'),
    (1, 4, '2026-04-25', '21:00:00', '23:59:00', 300.00, 'OPEN');


SET @p_theatre_id = 1;
SET @p_show_date = '2026-04-25';

SELECT
    t.theatre_id,
    t.name AS theatre_name,
    s.screen_name,
    m.title AS movie_title,
    m.language,
    sh.show_date,
    sh.start_time,
    sh.end_time,
    sh.base_price,
    sh.status
FROM shows sh
JOIN screens s
    ON sh.screen_id = s.screen_id
JOIN theatres t
    ON s.theatre_id = t.theatre_id
JOIN movies m
    ON sh.movie_id = m.movie_id
WHERE t.theatre_id = @p_theatre_id
  AND sh.show_date = @p_show_date
  AND sh.status = 'OPEN'
ORDER BY sh.start_time, s.screen_name;
