delimiter $$
create procedure check_client_id(p_client_id INT)
begin
	IF p_client_id NOT IN (
		select client_id 
		from clients
		where exists (
			select client_id
			from clients c where c.client_id = p_client_id
		)
    ) THEN
	SIGNAL SQLSTATE '23503' SET MESSAGE_TEXT = 'Client with this id does not exists'; 
    END IF;
end$$
delimiter ;

