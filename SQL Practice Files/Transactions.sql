-- Transactions

/* Syantax

	START TRANSACTION;
		query 1;
        query 2;
        query 3;
        query 4;
        
	COMMIT;/ROLLBACK; 
*/

-- ACID Properties
/*
	-- ATOMICITY
    Atomicity means that our transactions are like atoms, they are unbreakable. Each transaction is a single unit
    of work no matter how many statements it contains. Either all the statements get executed succeessfully and the
    transaction is committed or all the changes are undone/rollback either one of the statement is failed to execute.
    
    -- CONSISTANCY
    In tranactions our data should remain in a consistance state.
    For example: if we are inserting new data in multiple table our data should get inserted successfully
    in the selected table. We should have consistance data and no row or data should be missing in the child table.
    
    -- ISOLATION
    This means that our transactions are isolated. MySQL will execute one transaction at a time and if multiple 
    transactions try to execute our will lock automatically.
    
    -- Durability
    
*/

-- Concurrency And Locking in Transactions 

/*
	Concurrency:
    In real world application, multiple users can try to modify or access the same data in real time.
    This can create concurrency problems. MySql handles concurrecy problems by default. MySql waits for the first
    transaction to commit change or rollback if the transaction fails and then it will process to the next transaction.
    
    Until the first transaction is in process, mysql will lock that particular row in the database and it will
    not allow any other user to commit changes in the same row
*/

USE sql_store;
START TRANSACTION;
UPDATE customers
SET points = points + 10
WHERE customer_id = 1;
ROLLBACK;


/*
	Concurrency Problems:
    
   1. Lost Updates
   ================
   This happens when two transactions try to update the same data and we donot use locks.
   
   The updates made by the first transaction will be over written by the update made by the
   second transaction
   
   To prevent this, we have to implement some isolation level between transactions. MySQL uses
   locks by default to prevent transactions to update the same data at the same time.
   
   
   2. Dirty Reads
   ==============
   A dirty reads happens when a transaction read changes that haven't been committed yet.
   
   For example: 
   Transaction A updates the data but haven't been committed yet. At the same time transaction B reads the
   data. If the changes made by Transaction A rollbacks then Transaction B read the data that never existed. This is
   known as a dirt read
   
   To prevenet this we will use isolation level READ COMMITTED, this will allow transaction to read only the committed data
   
   
   3. Non-repeatable reads
   =======================
   This happens when same select query gives different results at a time. 
   
   For Example:
   Consider two transactions Transaction A and Transaction B. When transactio A executed the first select statement it gives 10 as result
   meanwhile, when transaction A was in process Tranasction B updates the data. When Transaction A reads the same data it gives different results.
   This creates problem when have to implement business logics based on the basis of our data.
   
   Prevention:
   In any point of time we should read data that is most up to date. If something updates the data during the execution of current transaction,
   we should not see the changes and read the initial snapshot of the data.
   
   We will use REPEATABLE READS islotion level
   
   
   
   4. Phantom Reads
   ================
   This happens when we read the data from a table, and at the same time that data is updated other transaction. 
   Resulting first transaction did not return the updated data. 
   This means that we have data that was not read by the transaction. We will use SERIALIZABLE to avoid where it is absolutly critical
   to read all the data that is present in the database including phantom data.
   
   We will make sure that no other query is running that will impact the selection of eligible data.
   
   If we use serializable isolation, our transaction will be aware of other transactions that are making changes to the database. In this case
   the serializable transaction will wait for other transactions to complete and then it will execute.
   
*/

use sql_store;
show variables like 'transaction_isolation';
set transaction isolation level read committed; 
start transaction;
select points from customers
where customer_id=1;
commit;



































