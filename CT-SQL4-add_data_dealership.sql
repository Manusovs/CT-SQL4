--This is just to insert data with functions
--Step 1 create a function for each table
--Step A name function
--Step B list variables
--Step C Begin 
--Step D insert using table variable names
--Step E values using function variable names
--Step F end
--Step G langauge
--Step 2 call functions with data

--Add data to the staff table
create function add_staff(fname VARCHAR(100), lname VARCHAR(100),pos VARCHAR(100))
returns VOID AS
$$
begin
	insert into staffSAM (first_name, last_name, position) 
	values (fname,lname,pos);
end;
$$
LANGUAGE plpgsql;

--Add data to the customer table
create function add_customer(fname VARCHAR(100), lname VARCHAR(100) ,zip VARCHAR(7))
returns VOID AS
$$
begin
	insert into customerSAM (first_name, last_name, zipcode) 
	values (fname,lname,zip);
end;
$$
LANGUAGE plpgsql;

--Add data to the vehicle table
create function add_vehicle(VINp VARCHAR(100), makep VARCHAR(100) ,modelp VARCHAR(7), yearp INTEGER, colorp VARCHAR(50), customer_idk INTEGER)
returns VOID AS
$$
begin
	insert into vehicleSAM (VIN, make, mdoel, year_, color, customer_id) 
	values (VINp, makep, modelp, yearp, colorp, customer_idk);
end;
$$
LANGUAGE plpgsql;

--Add data to the service ticket table
create function add_service_ticket( --make sure not to skip any variables
				sp VARCHAR(750), 
				pn VARCHAR(1000), 
				dc numeric(11,2), 
				sh numeric(5,1), 
				sd TIME, 
				am numeric(11,2), 
				VI VARCHAR(17), 
				cust_id INTEGER)
returns VOID AS
$$
begin
	insert into service_ticketSAM (service_performed, parts_needed, dealer_cost, service_hours, service_date, amount, VIN, customer_id) 
	values (sp, pn, dc, sh, sd, am, VI, cust_id);
end;
$$
LANGUAGE plpgsql;

--Add data to the mechanic service table
create function add_mechanic_service(
				srv_tick INTEGER, 
				staf_id INTEGER 
				)
returns VOID AS
$$
begin
	insert into mechanic_serviceSAM (service_ticket_id, staff_id) 
	values (srv_tick,staf_id);
end;
$$
LANGUAGE plpgsql;


--Add data to the invoice table
create function add_invoice( 
				amountp NUMERIC(11,2), 
				invdate TIME,
				VI VARCHAR(17),
				staff INTEGER,
				customer INTEGER
				)
returns VOID AS
$$
begin
	insert into invoiceSAM (amount, invoice_date, VIN, staff_id, customer_id) 
	values (amountp, invdate, VI, staff, customer);
end;
$$
LANGUAGE plpgsql;

--Add data to the purchase table for invoices, invoices and service ticekts need to be added differently
create function add_purchaseinv( 
				type_ VARCHAR(7), 
				desc_ VARCHAR(1000),
				inv INTEGER
				)
returns VOID AS
$$
begin
	insert into purchaseSAM (car_or_service, description_, invoice_id) 
	values (type_, desc_, inv);
end;
$$
LANGUAGE plpgsql;

--Add data to the purchase table for service tickets, invoices and service ticekts need to be added differently
create function add_purchasest( 
				type_ VARCHAR(7), 
				desc_ VARCHAR(1000),
				st INTEGER
				)
returns VOID AS
$$
begin
	insert into purchaseSAM (car_or_service, description_, service_ticket_id) 
	values (type_, desc_, st);
end;
$$
LANGUAGE plpgsql;


select add_staff('John', 'Doe', 'salesman'); 
select add_staff('Jane', 'Doe', 'mechanic'); 
select add_customer('Jim', 'Massey', '77777'); 
select add_vehicle('aaaaa8888rrr44tt', 'Honda', 'Civic', 1987, 'Blue',1);
select add_service_ticket('oil change', 'oil', 35.28, 3.5, '2023-07-08 5:34:00',85,'aaaaa8888rrr44tt', 1);
select add_mechanic_service(1, 2);
select add_invoice(12678.54,'2023-07-08 5:34:00', 'aaaaa8888rrr44tt', 1, 1);
select add_purchaseinv('car','old red corvette',1);
select add_staff('Kayleigh', 'Hemme', 'mechanic'); 
select add_customer('Tali', 'Merlin', '77277'); 
select add_vehicle('bbbaa8888rrr44tt', 'Toyota', 'highlander', 2007, 'Blue',2);
select add_service_ticket('tire rotation', 'nothing', 5, 0.5, '2023-09-08 5:34:00',50,'bbbaa8888rrr44tt', 2);
select add_mechanic_service(3,5);--no service ticket 2
select add_invoice(13745.54,'2023-07-08 5:34:00', 'bbbaa8888rrr44tt', 2, 2);
select add_purchasest('service','oil change',1);

--select * from purchaseSAM; --test to review what I've done, also check why id numbers aren't working, it skipped numbers