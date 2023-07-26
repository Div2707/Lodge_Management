-- How many distinct guest have made bookings for a particular month?
	SELECT guest_first_name, guest_last_name,guest_contact_number
	FROM guests
	WHERE guest_id IN 
		( SELECT distinct guests_guest_id 		-- get distinct guests
		  FROM bookings
		  WHERE MONTH(check_in_date) = 8);		-- bookings for the month of August
	
-- How many available rooms are in a particular lodge for a given date?
	SELECT l.lodge_room_capacity AS 'Total Rooms', SUM(total_rooms_booked) AS 'Total Rooms Booked' , h.hotel_room_capacity - SUM(b.total_rooms_booked) 	AS 'Available Rooms'	-- get available rooms
	FROM `bookings` b JOIN lodge l
    	ON b.lodge_lodge_id = l.lodge_id
	WHERE booking_date LIKE '2018-08-14%' AND lodge_lodge_id = 1	-- for given date and for lodge(King George Inn & Suites) with id 1 
	
-- How many hotels are in a lodge chain?
	SELECT count(*) AS 'Total Lodges' 		-- count of total lodges
	FROM lodge_chain_has_lodge 
	WHERE lodge_chains_lodge_chain_id = 1;  -- for lodge chain 'best western hotels'
	
-- How many books has a customer made in one year?
	SELECT count(*) AS 'Total Bookings' 		-- count of total bookings 		
	FROM bookings
	WHERE YEAR(booking_date) = 2018 AND guests_guest_id = 1;		-- bookings in Year 2018 by guest Jane with id 1
	
-- How many rooms are booked in a particular lodge on a given date?
	SELECT SUM(total_rooms_booked) AS 'Total Rooms Booked' 		-- sum of total rooms
	FROM `bookings` 
	WHERE booking_date LIKE '2018-06-08%' AND hotel_hotel_id = 1;	-- for date 6th August,2018; and for lodge(King George Inn & Suites) with id 1 

-- List all the unique countries lodge are located in.
	SELECT DISTINCT country					-- unique countries
	FROM addresses
	WHERE address_id IN 					-- compare to get addresses of lodge
		( SELECT  addresses_address_id		-- address id of lodge
		  FROM hotel);
	
	
-- How many rooms are available in a given lodge?
	SELECT  l.lodge_room_capacity - SUM(b.total_rooms_booked) 	AS 'Available Rooms'	-- get available rooms
	FROM `bookings` b JOIN lodge l
    	ON b.lodge_lodge_id = l.lodge_id
	WHERE booking_date LIKE '2018-06-08%' AND hotel_hotel_id = 1	-- for given date and for lodge(King George Inn & Suites) with id 1 

-- List all the lodges that have a URL available.
	SELECT * 
	FROM `lodge` 
	WHERE lodge_website IS NOT NULL;	-- get the hotels whose URL is not null
	
-- List the rate for a room at a given time during the year.
	SELECT ROUND((r_type.room_cost - ((r_dis.discount_rate * r_type.room_cost)/100)), 2) AS 'Room Rate' -- get room price on the basis od discount
	FROM room_rate_discount r_dis JOIN room_type r_type 		-- join rate discount table with room type
	ON r_dis.room_type_room_type_id = r_type.room_type_id
    WHERE r_type.room_type_id 
	IN ( Select rooms_type_rooms_type_id from rooms where room_id = 1)	-- get room type id for room with id 1
    AND MONTH(NOW()) BETWEEN r_dis.start_month AND r_dis.end_month;		-- get discount rate for current month
	
