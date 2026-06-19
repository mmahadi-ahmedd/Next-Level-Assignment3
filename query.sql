CREATE DATABASE football_ticketing;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    role VARCHAR(20) NOT NULL
        CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20)
);

CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(50),
    base_ticket_price DECIMAL(10,2) NOT NULL
        CHECK (base_ticket_price >= 0),
    match_status VARCHAR(20) NOT NULL
        CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);