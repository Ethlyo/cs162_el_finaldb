--
-- Database: `simplesheets`
--
DROP DATABASE `simplesheets`;
CREATE DATABASE IF NOT EXISTS `simplesheets` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `simplesheets`;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `line1` varchar(50) NOT NULL,
  `line2` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `dob` date NOT NULL DEFAULT '1000-01-01',
  `shipment_address` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `name` varchar(20) NOT NULL,
  `description` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `order_status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `order_line`
--

DROP TABLE IF EXISTS `order_line`;
CREATE TABLE `order_line` (
  `product_name` varchar(20) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_name` varchar(20) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `quantity_on_hand` int(11) NOT NULL DEFAULT 0,
  `quantity_on_hold` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
CREATE TABLE `shipment` (
  `shipment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `shipment_date` date NOT NULL DEFAULT current_timestamp(),
  `weight_oz` int(11) NOT NULL,
  `delivered` tinyint(1) NOT NULL DEFAULT 0,
  `destination_address` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `name` varchar(20) NOT NULL,
  `department` varchar(20) NOT NULL,
  `description` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `customer_address` (`shipment_address`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_relation` (`customer_id`);

--
-- Indexes for table `order_line`
--
ALTER TABLE `order_line`
  ADD PRIMARY KEY (`product_name`,`order_id`) USING BTREE;

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_name`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`shipment_id`),
  ADD KEY `order_shipments` (`order_id`),
  ADD KEY `shipments_address` (`destination_address`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`name`),
  ADD KEY `status_department` (`department`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_address` FOREIGN KEY (`shipment_address`) REFERENCES `address` (`address_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `customer_relation` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_line`
--
ALTER TABLE `order_line`
  ADD CONSTRAINT `order_line_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_line_product` FOREIGN KEY (`product_name`) REFERENCES `product` (`product_name`);

--
-- Constraints for table `shipment`
--
ALTER TABLE `shipment`
  ADD CONSTRAINT `order_shipments` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `shipments_address` FOREIGN KEY (`destination_address`) REFERENCES `address` (`address_id`);

--
-- Constraints for table `status`
--
ALTER TABLE `status`
  ADD CONSTRAINT `status_department` FOREIGN KEY (`department`) REFERENCES `department` (`name`) ON UPDATE CASCADE;
COMMIT;

INSERT INTO address (line1, line2, city, state, zip)
Values
	('123 Mark St.', '', 'Hood River', 'OR', '97031');

INSERT INTO customer (first_name, last_name, email, phone, dob, shipment_address)
Values
	('John', 'Doe', 'johnd@mail.com', '5555555555', '1999-03-03', '1'),
    ('Jane', 'Doe', 'janed@mail.com', '6666666666', '2000-01-01', '1');

INSERT INTO product (product_name, description, quantity_on_hand, quantity_on_hold)
Values 
	('Paper', 'asdasdad', '200', '150'),
    ('PrinterPap', 'asdasdad', '200', '20'),
    ('babababab', 'asdasdad', '200', '100'),
    ('askdjaksjd', 'asdasdad', '200', '100');
    
INSERT INTO department (name, description)
Values 
	('Sales', 'asdasdad'),
    ('Finance', 'asdasdad'),
    ('Packaging', 'asdasdad'),
    ('Shipping', 'asdasdad');

INSERT INTO `status` (name, department, description)
Values
	('Processing', 'Finance', 'Default, when order is created'),
    ('Paid', 'Packaging', 'Order has been paid, continues to Pkg'),
    ('Packaged', 'Shipping', 'Order has been packaged, continues to Ship'),
    ('Shipped', 'Shipping', 'Order has been shipped'),
    ('Cancelled', 'Sales', 'Order has been cancelled'),
    ('Delivered', 'Finance', 'Order has been delivered');
    

INSERT INTO `orders` (customer_id, order_date, paid, order_status)
Values
	('1', '2021-03-03', '1', 'Delivered'),
    ('2', '2021-03-03', '1', 'Delivered'),
    ('2', '2021-04-04', '1', 'Paid'),
    ('2', '2021-05-05', '0', 'Processing');

INSERT INTO order_line (product_name, order_id)
Values
	('Paper', '1'),
    ('PrinterPap', '2'),
    ('babababab', '2'),
    ('babababab', '3'),
    ('askdjaksjd', '3'),
    ('Paper', '3'),
    ('Paper', '4');
	
    