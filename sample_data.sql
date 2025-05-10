-- Sample Data for Kenyan Library Management System
USE LibraryDB;

-- Insert Publishers (Kenyan publishers)
INSERT INTO Publishers (name, address, contact_email, website) VALUES
('Longhorn Kenya', 'P.O Box 18033-00500, Nairobi', 'info@longhorn.co.ke', 'www.longhornpublishers.com'),
('East African Educational Publishers', 'P.O Box 45314-00100, Nairobi', 'info@eastafricanpublishers.com', 'www.eastafricanpublishers.com'),
('Oxford University Press Kenya', 'P.O Box 72532-00200, Nairobi', 'nairobi@oup.com', 'www.oup.co.ke'),
('Jomo Kenyatta Foundation', 'P.O Box 30533-00100, Nairobi', 'info@jkf.co.ke', 'www.jkf.co.ke'),
('Storymoja Publishers', 'P.O Box 14248-00800, Nairobi', 'hello@storymojaafrica.co.ke', 'www.storymojaafrica.co.ke');

-- Insert Authors (Kenyan authors)
INSERT INTO Authors (name, bio, nationality) VALUES
('Ngũgĩ wa Thiong''o', 'Renowned Kenyan writer and academic', 'Kenyan'),
('Grace Ogot', 'First Kenyan woman to publish a novel in English', 'Kenyan'),
('Binyavanga Wainaina', 'Founder of Kwani Trust, author of "One Day I Will Write About This Place"', 'Kenyan'),
('Yvonne Adhiambo Owuor', 'Author of "Dust" and "The Dragonfly Sea"', 'Kenyan'),
('Meja Mwangi', 'Award-winning novelist known for works like "Kill Me Quick"', 'Kenyan'),
('Mwangi Gicheru', 'Popular Kenyan novelist', 'Kenyan'),
('Margaret Ogola', 'Author of "The River and the Source"', 'Kenyan');

-- Insert Members (Kenyan names)
INSERT INTO Members (first_name, last_name, email, phone, address, membership_date, membership_status) VALUES
('Wanjiku', 'Mwangi', 'wanjiku.m@email.com', '0712345678', '123 Kasarani, Nairobi', '2022-01-15', 'Active'),
('Kamau', 'Ochieng', 'kamau.o@email.com', '0723456789', '456 Rongai, Kajiado', '2022-03-22', 'Active'),
('Amina', 'Mohammed', 'amina.m@email.com', '0734567890', '789 Eastleigh, Nairobi', '2022-05-10', 'Suspended'),
('Juma', 'Odhiambo', 'juma.o@email.com', '0745678901', '321 Kisumu CBD', '2022-07-18', 'Active'),
('Nyambura', 'Gitau', 'nyambura.g@email.com', '0756789012', '654 Thika Road, Kiambu', '2022-09-05', 'Expired'),
('Maina', 'Kamau', 'maina.k@email.com', '0767890123', '987 Nakuru Town', '2022-11-11', 'Active');

-- Insert Staff (Kenyan names)
INSERT INTO Staff (first_name, last_name, email, phone, position, hire_date, salary) VALUES
('Njeri', 'Wambui', 'njeri.w@library.org', '0721122334', 'Chief Librarian', '2018-06-15', 150000.00),
('Omondi', 'Onyango', 'omondi.o@library.org', '0732233445', 'Assistant Librarian', '2020-02-20', 80000.00),
('Wairimu', 'Njoroge', 'wairimu.n@library.org', '0743344556', 'Cataloguer', '2021-04-10', 65000.00),
('Mutua', 'Mbithi', 'mutua.m@library.org', '0754455667', 'IT Support', '2019-08-05', 95000.00);

-- Insert Books (with Kenyan publishers and authors)
INSERT INTO Books (title, isbn, publisher_id, publication_year, edition, category, total_copies, available_copies, shelf_location) VALUES
('Petals of Blood', '978-0143039174', 1, 1977, 1, 'Literature', 5, 3, 'FIC-001'),
('The River and the Source', '978-9966464485', 2, 1994, 2, 'Literature', 3, 1, 'FIC-002'),
('Dust', '978-1101870311', 3, 2014, 1, 'Fiction', 4, 4, 'FIC-003'),
('One Day I Will Write About This Place', '978-1555975909', 4, 2011, 1, 'Memoir', 2, 0, 'BIO-001'),
('Weep Not, Child', '978-0143106692', 1, 1964, 3, 'Literature', 6, 2, 'FIC-004'),
('The Dragonfly Sea', '978-0525657749', 3, 2019, 1, 'Fiction', 3, 3, 'FIC-005'),
('Kill Me Quick', '978-0435902194', 2, 1973, 1, 'Fiction', 2, 1, 'FIC-006');

-- Insert BookAuthors (linking Kenyan authors to books)
INSERT INTO BookAuthors (book_id, author_id) VALUES
(1, 1),  -- Petals of Blood by Ngũgĩ wa Thiong'o
(2, 7),  -- The River and the Source by Margaret Ogola
(3, 4),  -- Dust by Yvonne Adhiambo Owuor
(4, 3),  -- One Day I Will Write... by Binyavanga Wainaina
(5, 1),  -- Weep Not, Child by Ngũgĩ wa Thiong'o
(6, 4),  -- The Dragonfly Sea by Yvonne Adhiambo Owuor
(7, 5);  -- Kill Me Quick by Meja Mwangi

-- Insert Loans (with realistic Kenyan dates)
INSERT INTO Loans (book_id, member_id, loan_date, due_date, return_date, status) VALUES
(1, 1, '2023-01-10', '2023-01-24', '2023-01-22', 'Returned'),
(2, 2, '2023-02-15', '2023-03-01', NULL, 'Overdue'),
(4, 3, '2023-03-05', '2023-03-19', '2023-03-18', 'Returned'),
(5, 4, '2023-04-12', '2023-04-26', NULL, 'Active'),
(7, 5, '2023-05-20', '2023-06-03', '2023-05-30', 'Returned'),
(1, 6, '2023-06-01', '2023-06-15', NULL, 'Active');

-- Insert Fines
INSERT INTO Fines (loan_id, amount, issue_date, payment_date, status) VALUES
(2, 500.00, '2023-03-02', NULL, 'Pending'),
(6, 200.00, '2023-06-16', NULL, 'Pending');

-- Insert Reservations
INSERT INTO Reservations (book_id, member_id, reservation_date, status) VALUES
(4, 2, '2023-06-10 09:30:00', 'Pending'),
(5, 3, '2023-06-11 14:15:00', 'Fulfilled'),
(2, 1, '2023-06-12 11:00:00', 'Cancelled');
