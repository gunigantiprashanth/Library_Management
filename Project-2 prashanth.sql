create database creating ;
use creating;
show tables;
create table publisher(
publisher_PublisherName  varchar(225) primary key ,
publisher_PublisherAddress varchar(500),
publisher_PublisherPhone varchar(100));

create table borrower(
borrower_CardNo int  primary key auto_increment,
borrower_BorrowerName varchar(100) ,
borrower_BorrowerAddress varchar(500),
borrower_BorrowerPhone varchar(500));

create table library_branch(
library_branch_id int primary key auto_increment,
library_branch_BranchName varchar(500) ,
library_branch_BranchAddress varchar(225));
 

create table books(
book_BookID int primary key auto_increment,
book_Title varchar(500),
book_PublisherName varchar(500),
foreign key(book_PublisherName) references publisher(publisher_PublisherName)
on update cascade);

create table authors (
book_authors_authorID int primary key auto_increment,
book_authors_BookID int ,
book_authors_AuthorName varchar(500),
foreign key(book_authors_BookID) references books(book_BookID)
on update cascade
);

drop table book_loans;
create table book_loans
(book_loans_loansID int primary key auto_increment,	
book_loans_BookID int ,
book_loans_BranchID int ,
book_loans_CardNo int ,
book_loans_DateOut varchar(50),
book_loans_DueDate varchar(50),
foreign key(book_loans_BookID) references books(book_BookID)
on update cascade,
foreign key(book_loans_BranchID) references  library_branch(library_branch_id)
on delete cascade,
foreign key(book_loans_CardNo) references  borrower(borrower_CardNo)
on update cascade
);

create table book_copies
(book_copies_copiesID int primary key auto_increment,
book_copies_BookID int ,
book_copies_BranchID int,
book_copies_No_Of_Copies int,
foreign key(book_copies_BookID ) references books(book_BookID)
on update cascade,
foreign key(book_copies_BranchID ) references library_branch(library_branch_id)
on update cascade)
;

select * from authors;
select * from books;-- 
select * from book_copies;
select * from book_loans;
select * from borrower;
select * from library_branch;
select * from publisher;


-- 1)How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?



select * from library_branch;
select * from book_copies;
select * from books;

select bo.book_Title,lb.library_branch_BranchName,book_copies_No_Of_Copies from book_copies  as b join  library_branch as lb on b.book_copies_BranchID=lb.library_branch_id join books as bo on b.book_copies_BookID=bo.book_BookID 
where book_Title="The Lost Tribe" and library_branch_BranchName="Sharpstown";

-- 2)How many copies of the book titled "The Lost Tribe" are owned by each library branch?
select * from books;
select * from library_branch;
select * from book_copies;






select b.book_Title,lb.library_branch_BranchName,book_copies_No_Of_Copies from book_copies as bc join library_branch as lb on bc.book_copies_BranchID=lb.library_branch_id 
join books as b on b.book_BookID=bc.book_copies_BookID
 where book_Title='the lost tribe';


-- 3)Retrieve the names of all borrowers who do not have any books checked out.
select * from borrower;
select * from book_loans;
select * from books;

select * from borrower where borrower_CardNo not in (select book_loans_CardNo from book_loans as bl join books as b on b.book_bookid=bl.book_loans_BookID );

-- 4)For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address.
 select * from book_loans ;
 select * from borrower;
 select * from library_branch;
 select * from books;
;
 
 select  bo.borrower_BorrowerName,bo.borrower_BorrowerAddress,b.book_Title from book_loans as bl join borrower as bo on
 bl.book_loans_CardNo=bo.borrower_CardNo join books as b on bl.book_loans_BookID=b.book_BookID where bl.book_loans_DueDate='2/3/18' 
 and 
 bl.book_loans_BranchID in ( select library_branch_id from library_branch where library_branch_BranchName='Sharpstown');
 
-- 5)For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
select * from library_branch;
select * from book_copies;
select count(*) from book_loans ;

select * from books;
select lb.library_branch_BranchName ,count(bl.book_loans_BranchID)  as count from library_branch as lb join book_loans as bl on lb.library_branch_id=bl.book_loans_BranchID 
group by bl.book_loans_BranchID;

-- 6)Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
select * from publisher;
select * from borrower;
select * from books;
select * from book_loans;

select borrower_BorrowerName ,borrower_BorrowerAddress , count(book_loans_BranchID) as count from borrower as b join
book_loans as bl on b.borrower_CardNo=bl.book_loans_CardNo group by (borrower_BorrowerName),(borrower_BorrowerAddress) having count>5;

-- 7)For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
select * from library_branch;
select * from books;
select * from authors;
select * from book_copies;

SELECT 
    b.book_Title,
    lb.library_branch_BranchName,
    bc.book_copies_No_Of_Copies
FROM
    library_branch AS lb
        JOIN
    book_copies AS bc ON lb.library_branch_id = bc.book_copies_BranchID
        JOIN
    books AS b ON b.book_BookID = bc.book_copies_BookID
        JOIN
    authors AS a ON a.book_authors_BookID = b.book_BookID
WHERE
    lb.library_branch_BranchName = 'Central'
        AND a.book_authors_AuthorName = 'Stephen King';







