# BookMyShow SQL Assignment

## Context
BookMyShow is a ticketing platform where users select a theatre, choose a date from the next seven days, and view all running movie shows with timings.

## P1 - Entities, Attributes, and Table Structures

### 1) `theatres`
- `theatre_id` (PK, BIGINT, AUTO_INCREMENT)
- `name` (VARCHAR)
- `address` (VARCHAR)
- `city` (VARCHAR)
- `state` (VARCHAR)
- `pincode` (VARCHAR)

### 2) `screens`
- `screen_id` (PK, BIGINT, AUTO_INCREMENT)
- `theatre_id` (FK -> `theatres.theatre_id`)
- `screen_name` (VARCHAR)
- `total_seats` (INT)
- Unique constraint: (`theatre_id`, `screen_name`)

### 3) `movies`
- `movie_id` (PK, BIGINT, AUTO_INCREMENT)
- `title` (VARCHAR)
- `language` (VARCHAR)
- `duration_mins` (INT)
- `certificate` (VARCHAR)
- `is_active` (BOOLEAN)

### 4) `shows`
- `show_id` (PK, BIGINT, AUTO_INCREMENT)
- `screen_id` (FK -> `screens.screen_id`)
- `movie_id` (FK -> `movies.movie_id`)
- `show_date` (DATE)
- `start_time` (TIME)
- `end_time` (TIME)
- `base_price` (DECIMAL)
- `status` (ENUM: OPEN, CANCELLED)
- Unique constraint: (`screen_id`, `show_date`, `start_time`)

## Normalization Compliance

- 1NF: Atomic attributes only. No repeating groups.
- 2NF: No partial dependency on composite keys.
- 3NF: Non-key attributes depend only on primary keys.
- BCNF: Determinants are candidate keys.

## Sample Rows

### theatres
- (1, PVR Nexus Koramangala, Koramangala 5th Block, Bengaluru, Karnataka, 560095)

### screens
- (1, 1, Audi 1, 180)
- (2, 1, Audi 2, 150)

### movies
- (1, Dasara, Telugu, 156, U/A, true)
- (2, Kisi Ka Bhai Kisi Ki Jaan, Hindi, 145, U/A, true)

### shows
- (1, 1, 1, 2026-04-25, 12:15:00, 14:51:00, 180.00, OPEN)
- (2, 1, 2, 2026-04-25, 16:10:00, 18:35:00, 220.00, OPEN)

## SQL
Run `bookmyshow_assignment.sql`.  
It contains:
- Table creation SQL
- Seed data
- P2 query for show listing by theatre and date

## P2 Requirement
Query lists all shows at a given theatre on a given date with timings, movie, language, price, and status.
