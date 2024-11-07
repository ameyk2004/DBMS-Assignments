-- Unnamed PL/SQL code block: Use of Control structure and Exception handling is mandatory.

-- Suggested Problem statement:

-- Consider Tables:

-- Borrower(Roll no, Name, Date of Issue, Name of Book, Status)

-- Fine(Roll no, Date, Amt)

-- Accept Roll no and Name of Book from user.

-- Check the number of days (from date of issue). If days are between 15 to 30 then: fine amount will be Rs 5 per day. If no. of days>30: per day fine will be Rs 50 per day and for days less than 30, Rs. S per day.

-- After submitting the book, status will change from I to R.

-- If condition of fine is true, then details will be stored into fine table.

-- Also handles the exception by named exception handler or user define exception handler


CREATE TABLE borrower (
    roll_no INT NOT NULL,
    borrower_name VARCHAR(50) NOT NULL,
    doi DATE DEFAULT (CURDATE()),
    book_name VARCHAR(50) NOT NULL,
    borrow_status CHAR(1) NOT NULL DEFAULT 'I',
    PRIMARY KEY (roll_no, book_name, doi),
    CHECK (borrow_status IN ('I', 'R'))
);

CREATE TABLE fine (
    roll_no INT,
    book_name VARCHAR(50),
    doi DATE,
    fine_date DATE DEFAULT (CURDATE()),
    amount INT NOT NULL,
    PRIMARY KEY (roll_no, book_name, doi),
    FOREIGN KEY (roll_no, book_name, doi) REFERENCES borrower(roll_no, book_name, doi) ON DELETE NO ACTION,
    CHECK (amount >= 0)
);

INSERT INTO borrower
    (roll_no, borrower_name, doi, book_name)
    VALUES
    (
        1, 'Tirthraj Mahajan', '2024-11-01', 'C++ Programming'
    ),
    (
        1, 'Tirthraj Mahajan', '2024-11-02', 'Python Programming'
    ),
    (
        1, 'Tirthraj Mahajan', '2024-10-15', 'Java Programming'
    ),
    (
        1, 'Tirthraj Mahajan', '2024-10-01', 'Rust Programming'
    ),
    (
        2, 'Advait Joshi', '2024-10-23', 'ML Engineering'
    ),
    (
        2, 'Advait Joshi', '2024-10-23', 'Java Programming'
    ),
    (
        3, 'Suvrat Ketkar', '2023-07-01', 'DSA'
    ),
    (
        4, 'Vardhan Dongre', '2024-06-15', 'Cracking Coding Interviews'
    ),
    (
        5, 'Aditya Mulay', '2024-10-20', 'Java Programming'
    ),
    (
        6, 'Arnav Vaidya', '2024-07-01', 'Cybersecurity'
    );

DELIMITER //

CREATE PROCEDURE calculate_fine(
    IN roll_no INT, 
    IN book_name VARCHAR(50), 
    OUT fine_amt INT
)
BEGIN
    DECLARE days INT;
    DECLARE date_of_issue DATE;

    -- Error handler for when no rows are found
    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'No matching record found';
    END;

    -- Start the transaction
    START TRANSACTION;

    -- Fetch the date_of_issue for the given roll_no and book_name
    SELECT doi INTO date_of_issue
    FROM Borrower
    WHERE roll_no = roll_no 
    AND book_name = book_name
    LIMIT 1;


    -- Set initial fine amount to 0
    SET fine_amt = 0;

    -- If no matching record is found, the handler will trigger
    IF (date_of_issue IS NULL) THEN
        ROLLBACK;
        SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = 'No matching record found';
    END IF;

    -- Calculate the number of days difference
    SET days = DATEDIFF(CURDATE(), date_of_issue);

    -- Output the days difference (for debugging purposes, can be removed later)
    SELECT days AS date_difference;

    -- If the days difference is negative, rollback
    IF days < 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid fine amount';
    END IF;

    -- Calculate fine amount based on days
    IF days > 15 AND days <= 25 THEN
        SET fine_amt = 5000;
    ELSEIF days > 25 THEN
        SET fine_amt = 15000;
    END IF;

    -- Commit the transaction
    COMMIT;

END //

DELIMITER ;


db.users.find({
    "favoriteFruit" :
        {"$eq" : "apple"},
    "$and": [
        {"eyecolor" : {"$eq" : "green"}},
    ]
});

db.users.find({
    "favoriteFruit": { "$eq": "apple" },
    and: [
        { "eyecolor": { "$eq": "green" } },
        { "gender": { "$eq": "female" } }
    ]
});


db.Sample.deleteOne(
    {},
    {$set: {"name": "Raji"}},
    {upsert: true}
)