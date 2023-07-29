-- Primary Keys can't be empty or duplicated
-- Create staff table (no foreign keys)
create table staffSAM(
	staff_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	position VARCHAR(100)	
	);

-- Create customer table (no foreign keys)
create table customerSAM(
	customer_id SERIAL primary key,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	zipcode VARCHAR(7)
	);

-- Create vehicle table (first foreign key using customerSAM) 
create table vehicleSAM(
	VIN VARCHAR(17) primary key, --uses VIN instead of regular ID, since these are never duplicated and can ID
	make VARCHAR(100),
	mdoel VARCHAR(100),
	year_ INTEGER,
	color VARCHAR(50),
	customer_id INTEGER,
	foreign key (customer_id) references customerSAM(customer_id)
	);
	
-- Create service ticket table (2 foreign keys)
create table service_ticketSAM(
	service_ticket_id SERIAL primary key,
	service_performed VARCHAR(750),
	parts_needed VARCHAR(1000),
    dealer_cost NUMERIC(11,2),
    service_hours NUMERIC(5,1),
    service_date TIME,
    amount NUMERIC(11,2),
    VIN VARCHAR(17),
    customer_id INTEGER,
	foreign key (VIN) references vehicleSAM(VIN),
    foreign key (customer_id) references customerSAM(customer_id)
	);
	
-- Create mechanic_service table (2 foreign keys)
create table mechanic_serviceSAM( -- doesn't look like you can use dashes in sql in a table name
	mech_serv_id SERIAL primary key,
	service_ticket_id INTEGER,
	staff_id INTEGER,
	foreign key (service_ticket_id) references service_ticketSAM(service_ticket_id),
	foreign key (staff_id) references staffSAM(staff_id)
	);
    	
-- Create invoice table (3 foreign keys)
create table invoiceSAM(
	invoice_id SERIAL primary key,
	amount NUMERIC(11,2),
	invoice_Date TIME,
	VIN VARCHAR(17),
	staff_id INTEGER,
	customer_id INTEGER,
	foreign key (VIN) references vehicleSAM(VIN),
    foreign key (staff_id) references staffSAM(staff_id),
    foreign key (customer_id) references customerSAM(customer_id)
	);

    -- Create purchase table (2 foreign keys)
create table purchaseSAM(
	purchase_id SERIAL primary key,
	car_or_service NUMERIC(11,2),
	description_ TIME,
	invoice_id INTEGER,
	service_ticket_id INTEGER,
	customer_id INTEGER,
	foreign key (invoice_id) references invoiceSAM(invoice_id),
    foreign key (service_ticket_id) references service_ticketSAM(service_ticket_id),
    foreign key (customer_id) references customerSAM(customer_id)
	);