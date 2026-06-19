# ⚽ Football Ticket Booking System

A simplified relational database project built to manage football fans, tournament matches, and ticket booking transactions. This project was created as part of a database design and SQL assignment, covering ERD design, table constraints, and intermediate-to-advanced SQL queries.

## 📋 Overview

The system models three core entities:

- **Users** — Football fans and ticket managers who use the platform.
- **Matches** — Tournament fixtures, pricing, and ticket availability.
- **Bookings** — Individual ticket purchase records linking users to matches.

## 🗂️ Entity Relationships

- **One User → Many Bookings**: A fan can purchase tickets for multiple matches.
- **One Match → Many Bookings**: A single match can have many ticket bookings from different fans.
- **Users ↔ Matches (Many-to-Many)**: Resolved through the `Bookings` table, which acts as a junction table linking the two.

## 📁 Repository Structure

```
football-ticket-booking-system
├── query.sql      # All 7 SQL queries for Part 2 of the assignment
└── README.md      # Project documentation (this file)
```

## 🛠️ Tech Stack

- **Database**: PostgreSQL
- **Tools used**: VS Code (writing SQL), Beekeeper Studio (testing/verifying queries), lucidchart (ERD design)

## 🚀 How to Run

1. Create the database:
   ```sql
   CREATE DATABASE football_ticketing;
   ```
2. Connect to the `football_ticketing` database in your SQL client (e.g., Beekeeper Studio, psql, pgAdmin).
3. Run the queries in `query.sql` individually to test against the expected sample output described in the assignment.

## 🧩 Database Schema

### Users
| Column | Type | Constraints |
|---|---|---|
| user_id | SERIAL | PRIMARY KEY |
| full_name | VARCHAR(100) | NOT NULL |
| email | VARCHAR(100) | UNIQUE |
| role | VARCHAR(20) | CHECK (Admin/Ticket Manager/Football Fan) |
| phone_number | VARCHAR(20) | |

### Matches
| Column | Type | Constraints |
|---|---|---|
| match_id | SERIAL | PRIMARY KEY |
| fixture | VARCHAR(150) | NOT NULL |
| tournament_category | VARCHAR(50) | |
| base_ticket_price | DECIMAL(10,2) | CHECK (>= 0) |
| match_status | VARCHAR(20) | CHECK (Available/Selling Fast/Sold Out/Postponed) |

### Bookings
| Column | Type | Constraints |
|---|---|---|
| booking_id | SERIAL | PRIMARY KEY |
| user_id | INT | FOREIGN KEY → users(user_id), ON DELETE CASCADE |
| match_id | INT | FOREIGN KEY → matches(match_id), ON DELETE CASCADE |
| seat_number | VARCHAR(10) | |
| payment_status | VARCHAR(20) | CHECK (Pending/Confirmed/Cancelled/Refunded) |
| total_cost | DECIMAL(10,2) | CHECK (>= 0) |

## 📊 SQL Queries (Part 2)

| # | Query | Concept Used |
|---|---|---|
| 1 | Available Champions League matches | `WHERE` filtering |
| 2 | Search users by name pattern | `LIKE` / `ILIKE` |
| 3 | Bookings with missing payment status | `IS NULL`, `COALESCE` |
| 4 | Booking details with user & match info | `INNER JOIN` |
| 5 | All users including those with no bookings | `LEFT JOIN` |
| 6 | Bookings above average cost | Subquery |
| 7 | Top 2 most expensive matches (skip highest) | `LIMIT` / `OFFSET` |

## 📐 ERD

The Entity Relationship Diagram was designed using lucidchart, showing Primary Keys, Foreign Keys, and crow's foot cardinality notation between Users, Matches, and Bookings.

🔗 **ERD Link**: https://lucid.app/lucidchart/8611269a-7ab7-4042-a6ff-e47738fd9e8a/edit?viewport_loc=-2568%2C-369%2C2175%2C1041%2C0_0&invitationId=inv_20d5bef3-1776-48b6-8b4d-678b1e6cf346

- `ILIKE` is PostgreSQL-specific and used for case-insensitive search in Query 2.
- Foreign keys use `ON DELETE CASCADE`, meaning deleting a user or match automatically removes their related bookings.
- All monetary fields use `DECIMAL(10,2)` rather than floating-point types to avoid rounding errors.
