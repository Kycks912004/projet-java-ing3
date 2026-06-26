-- SQLite schema — auto-loaded on first launch
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS accommodations (
  id                  INTEGER PRIMARY KEY AUTOINCREMENT,
  name                TEXT NOT NULL,
  address             TEXT NOT NULL,
  city                TEXT NOT NULL,
  country             TEXT NOT NULL,
  description         TEXT,
  price_per_night     REAL NOT NULL,
  max_guests          INTEGER NOT NULL,
  accommodation_type  TEXT NOT NULL,
  has_wifi            INTEGER DEFAULT 0,
  has_pool            INTEGER DEFAULT 0,
  has_parking_space   INTEGER DEFAULT 0,
  rating              INTEGER DEFAULT 0,
  has_restaurant      INTEGER DEFAULT 0,
  has_air_conditioning INTEGER DEFAULT 0,
  latitude            REAL,
  thumbnail_image     TEXT
);

CREATE TABLE IF NOT EXISTS amenities (
  id       INTEGER PRIMARY KEY AUTOINCREMENT,
  name     TEXT NOT NULL,
  icon     TEXT,
  category TEXT
);

CREATE TABLE IF NOT EXISTS accommodation_amenities (
  accommodation_id INTEGER NOT NULL,
  amenity_id       INTEGER NOT NULL,
  PRIMARY KEY (accommodation_id, amenity_id),
  FOREIGN KEY (accommodation_id) REFERENCES accommodations(id) ON DELETE CASCADE,
  FOREIGN KEY (amenity_id)       REFERENCES amenities(id)       ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS accommodation_images (
  id               INTEGER PRIMARY KEY AUTOINCREMENT,
  accommodation_id INTEGER NOT NULL,
  image_url        TEXT NOT NULL,
  is_primary       INTEGER DEFAULT 0,
  description      TEXT,
  FOREIGN KEY (accommodation_id) REFERENCES accommodations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  username     TEXT NOT NULL UNIQUE,
  password     TEXT NOT NULL,
  email        TEXT NOT NULL UNIQUE,
  first_name   TEXT NOT NULL,
  last_name    TEXT NOT NULL,
  phone_number TEXT,
  is_admin     INTEGER DEFAULT 0,
  new_users    INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS bookings (
  id               INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id          INTEGER NOT NULL,
  accommodation_id INTEGER NOT NULL,
  check_in_date    TEXT NOT NULL,
  check_out_date   TEXT NOT NULL,
  number_of_guests INTEGER NOT NULL,
  total_price      REAL NOT NULL,
  status           TEXT NOT NULL,
  booking_date     TEXT NOT NULL,
  FOREIGN KEY (user_id)          REFERENCES users(id)          ON DELETE CASCADE,
  FOREIGN KEY (accommodation_id) REFERENCES accommodations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS payments (
  id             INTEGER PRIMARY KEY AUTOINCREMENT,
  booking_id     INTEGER NOT NULL,
  amount         REAL NOT NULL,
  payment_method TEXT NOT NULL,
  payment_date   TEXT NOT NULL,
  status         TEXT NOT NULL,
  transaction_id TEXT UNIQUE,
  FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS promotions (
  id                  INTEGER PRIMARY KEY AUTOINCREMENT,
  accommodation_id    INTEGER NOT NULL,
  name                TEXT NOT NULL,
  description         TEXT,
  discount_percentage REAL NOT NULL,
  start_date          TEXT NOT NULL,
  end_date            TEXT NOT NULL,
  promo_code          TEXT UNIQUE,
  FOREIGN KEY (accommodation_id) REFERENCES accommodations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reviews (
  id               INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id          INTEGER NOT NULL,
  accommodation_id INTEGER NOT NULL,
  booking_id       INTEGER NOT NULL,
  rating           INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment          TEXT,
  review_date      TEXT NOT NULL,
  FOREIGN KEY (user_id)          REFERENCES users(id)          ON DELETE CASCADE,
  FOREIGN KEY (accommodation_id) REFERENCES accommodations(id) ON DELETE CASCADE,
  FOREIGN KEY (booking_id)       REFERENCES bookings(id)       ON DELETE CASCADE
);

-- Sample data
INSERT OR IGNORE INTO accommodations VALUES
(27,'Luxury Hotel Paris','123 Avenue des Champs-Elysees','Paris','France','Elegant 5-star hotel in the heart of Paris with stunning views of the Eiffel Tower.',350.00,4,'hotel',1,1,1,4,1,1,48.8698,'hotel_paris_1.jpg'),
(28,'Cozy Apartment Montmartre','45 Rue des Abbesses','Paris','France','Charming apartment in the artistic district of Montmartre.',120.00,2,'apartment',1,0,0,4,0,1,48.8865,'apartment_paris_1.jpg'),
(32,'Seaside Villa Amalfi','Via Marina Grande 22','Amalfi','Italy','Beautiful villa with panoramic sea views and a private pool.',420.00,6,'villa',1,1,1,5,0,1,40.6346,'villa_amalfi.jpg'),
(33,'Rustic Chalet Chamonix','100 Route des Praz','Chamonix','France','Traditional alpine chalet close to ski lifts.',180.00,5,'chalet',1,0,1,3,0,1,45.9237,'chalet_chamonix.jpg'),
(34,'City Apartment Tokyo','3-15-1 Shibuya','Tokyo','Japan','Modern apartment in the heart of Shibuya.',130.00,2,'apartment',1,0,0,4,0,1,35.6618,'apartment_tokyo.jpg'),
(35,'Eco Cottage Quebec','12 Forest Lane','Quebec','Canada','Sustainable cottage surrounded by nature.',110.00,3,'cottage',0,0,1,2,0,0,46.8139,'cottage_quebec.jpg'),
(36,'Boutique Hotel Lisbon','7 Rua Augusta','Lisbon','Portugal','Charming boutique hotel near Praca do Comercio.',160.00,2,'hotel',1,0,1,4,1,1,38.7071,'hotel_lisbon.jpg'),
(37,'Beachfront Bungalow Bali','Jl. Pantai Seseh','Canggu','Indonesia','Relaxing bungalow just steps from the beach.',95.00,2,'cottage',1,1,0,3,0,0,-8.6478,'bungalow_bali.jpg'),
(38,'Historic Hotel Vienna','1 Opernring','Vienna','Austria','Elegant historic hotel near the Vienna Opera House.',275.00,3,'hotel',1,0,1,5,1,1,48.2027,'hotel_vienna.jpg'),
(39,'Lakeview Cabin Tahoe','88 Pine Ridge','Lake Tahoe','USA','Rustic cabin with lake views and fireplace.',140.00,4,'cabin',1,0,1,1,0,1,39.0968,'cabin_tahoe.jpg'),
(40,'Contemporary Condo Sydney','10 Darling Drive','Sydney','Australia','Stylish condo with harbor views.',220.00,2,'condo',1,0,1,2,0,1,-33.871,'condo_sydney.jpg'),
(41,'Countryside Cottage Cotswolds','The Lane, Bourton-on-the-Water','Cotswolds','UK','Quaint stone cottage in the English countryside.',150.00,4,'cottage',1,0,1,3,0,0,51.885,'cottage_cotswolds.jpg');

INSERT OR IGNORE INTO amenities VALUES
(1,'Free WiFi','wifi','ESSENTIAL'),(2,'Swimming Pool','pool','LEISURE'),(3,'Parking','parking','CONVENIENCE'),
(4,'Restaurant','restaurant','DINING'),(5,'Air Conditioning','ac','COMFORT'),(6,'Pet Friendly','pet','SPECIAL'),
(7,'Gym','gym','WELLNESS'),(8,'Spa','spa','WELLNESS'),(9,'Bar','bar','DINING'),(10,'Room Service','service','COMFORT'),
(11,'Business Center','business','WORK'),(12,'Free Breakfast','breakfast','DINING'),(13,'Laundry Service','laundry','CONVENIENCE'),
(14,'Airport Shuttle','shuttle','TRANSPORTATION'),(15,'Concierge','concierge','SERVICE'),(16,'Beach Access','beach','LOCATION'),
(17,'Kid Friendly','kids','SPECIAL'),(18,'Hot Tub','hottub','WELLNESS'),(19,'Mountain View','mountain','VIEW'),(20,'Sea View','sea','VIEW');

INSERT OR IGNORE INTO users VALUES
(1,'admin','admin123','admin@booking.com','Admin','User','+33123456789',1,0),
(2,'john_doe','password123','john.doe@example.com','John','Doe','+33612345678',0,0),
(3,'jane_smith','password123','jane.smith@example.com','Jane','Smith','+33687654321',0,0),
(4,'alice_johnson','password123','alice.johnson@example.com','Alice','Johnson','+33612345679',0,0),
(5,'bob_brown','password123','bob.brown@example.com','Bob','Brown','+33687654322',0,0),
(6,'charlie_davis','password123','charlie.davis@example.com','Charlie','Davis','+33612345670',0,0),
(7,'diana_evans','password123','diana.evans@example.com','Diana','Evans','+33687654323',0,0);

INSERT OR IGNORE INTO bookings VALUES
(10,2,27,'2025-04-17','2025-04-19',2,1400.00,'CANCELLED','2025-04-16'),
(11,2,28,'2025-04-18','2025-04-20',2,480.00,'CONFIRMED','2025-04-17'),
(12,2,27,'2025-05-01','2025-05-05',2,1400.00,'CONFIRMED','2025-04-25'),
(13,3,28,'2025-06-10','2025-06-15',4,480.00,'CONFIRMED','2025-05-25'),
(17,7,32,'2025-10-01','2025-10-05',6,1500.00,'CONFIRMED','2025-09-20'),
(18,3,34,'2025-12-01','2025-12-05',4,720.00,'CONFIRMED','2025-11-10'),
(19,4,35,'2026-01-10','2026-01-15',3,900.00,'CONFIRMED','2025-12-20'),
(20,5,36,'2026-02-01','2026-02-05',2,600.00,'CONFIRMED','2026-01-15'),
(21,6,37,'2026-03-10','2026-03-15',5,1500.00,'CONFIRMED','2026-02-25'),
(22,7,38,'2026-04-15','2026-04-20',6,1800.00,'CONFIRMED','2026-04-05'),
(23,2,39,'2026-05-01','2026-05-05',2,1000.00,'CONFIRMED','2026-04-20'),
(24,3,40,'2026-06-01','2026-06-05',4,1200.00,'CONFIRMED','2026-05-20'),
(25,4,41,'2026-07-10','2026-07-15',3,900.00,'CONFIRMED','2026-06-25');

INSERT OR IGNORE INTO payments VALUES
(10,10,700.00,'CREDIT_CARD','2025-04-16 14:46:10','COMPLETED','TRX-20250416-9f19e8'),
(11,11,240.00,'CREDIT_CARD','2025-04-17 07:47:07','COMPLETED','TRX-20250417-d122de');

INSERT OR IGNORE INTO promotions VALUES
(11,27,'Summer Blast','20% off for summer 2025 vacations!',20.00,'2025-06-01','2025-09-01','SUMMER25'),
(12,28,'Weekend Escape','15% off all weekend stays!',15.00,'2025-04-01','2025-12-31','WEEKEND15');

INSERT OR IGNORE INTO reviews VALUES
(16,5,36,10,4,'Good stay overall, but the air conditioning was a bit noisy.','2024-05-04'),
(17,6,37,11,3,'Good location, but the place felt a bit dated.','2024-05-05'),
(26,2,27,12,4,'Wonderful stay, great location.','2025-05-06'),
(27,3,28,13,5,'Amazing apartment with a great view!','2025-06-16'),
(28,7,32,17,4,'The resort was nice, but the beach was a bit crowded.','2025-10-06'),
(29,3,34,18,5,'The cabin was perfect for a winter getaway.','2025-12-06'),
(30,4,35,19,4,'Great location and very comfortable.','2026-01-16');
