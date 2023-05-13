-- Events
-- Events are used to run scheduled task in MySQL, mostly used for database maintance and auditings
-- We can execute events on minutes, hourly, monthly, quaterly or yearly bases
-- date_add and date_sub functions are handy when we need to specify the time to execute the event

-- turning on event scheduler
SHOW variables LIKE "event%";
set global event_scheduler = ON;

-- Creating new event
DELIMITER $$
CREATE EVENT monthly_client_report
ON SCHEDULE
	EVERY 1 Month starts '2021-09-01' ends '2025-09-01' 
DO BEGIN
	SELECT COUNT(*) FROM clients;
END$$

SHOW EVENTS;
