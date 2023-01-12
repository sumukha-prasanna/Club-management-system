

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AllUserData` ()   BEGIN
DECLARE done INT DEFAULT 0;
DECLARE user_id, userph,semester,clubid int;
DECLARE fname, lname, email VARCHAR(30);
DECLARE cur CURSOR FOR SELECT users.User_id, users.Fname, users.Lname, users.User_ph,users.Email, users.Semester, club_heads.Club_id FROM users,club_heads WHERE users.User_id=club_heads.User_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;

OPEN cur ;
label: LOOP
FETCH cur INTO user_id, fname, lname, userph, email,semester,clubid;
INSERT INTO club_head_details VALUES (user_id, fname, lname,userph ,email, semester , clubid);
IF done = 1 THEN LEAVE label;
END IF;
END LOOP;
CLOSE cur;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bal_udpate` (IN `Clubid` INT)   BEGIN
DECLARE extra int;
set extra = 1000;
update accounts set Available_balance=Available_balance+extra where Club_id=Clubid;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `check_funds` (`cnt` INT) RETURNS VARCHAR(50) CHARSET utf8mb4  BEGIN
 
    DECLARE sf_value VARCHAR(50);
	
    IF cnt> 20000 THEN 
	   SET sf_value = 'You can conduct an event';	
	ELSE 
	   SET sf_value= 'Not enough funds to conduct an event';
	   
    END IF;
    
	RETURN sf_value;
	
END$$

DELIMITER ;


CREATE TABLE `accounts` (
  `Acc_no` int(15) NOT NULL,
  `Available_balance` int(6) DEFAULT 60000,
  `Club_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `accounts` (`Acc_no`, `Available_balance`, `Club_id`) VALUES
(1234, 152000, 1),
(1235, 90000, 2),
(1236, 50000, 3);


DELIMITER $$
CREATE TRIGGER `before_account_update` BEFORE UPDATE ON `accounts` FOR EACH ROW BEGIN
	DECLARE err_msg varchar(100);
    SET err_msg = "The funds added cannot exceed 5000";
    IF new.Available_balance-old.Available_balance>5000 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT=err_msg;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `club`
--

CREATE TABLE `club` (
  `Club_id` int(11) NOT NULL,
  `Club_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `club`
--

INSERT INTO `club` (`Club_id`, `Club_name`) VALUES
(1, 'Cricket'),
(2, 'Soccer'),
(3, 'Management'),
(4, 'Hockey'),
(5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `club_events`
--

CREATE TABLE `club_events` (
  `Event_id` int(11) NOT NULL,
  `Event_name` varchar(100) DEFAULT NULL,
  `Club_id` int(11) DEFAULT NULL,
  `Event_date` varchar(10) DEFAULT NULL,
  `Event_time` varchar(7) DEFAULT NULL,
  `Place` varchar(30) DEFAULT NULL,
  `Description` varchar(300) DEFAULT NULL,
  `Members_applied` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `club_events`
--

INSERT INTO `club_events` (`Event_id`, `Event_name`, `Club_id`, `Event_date`, `Event_time`, `Place`, `Description`, `Members_applied`) VALUES
(1, 'Division-1', 1, '2022-11-22', '12:30PM', 'PES RR campus Ground', 'Division Cricket Match', 30),
(2, 'Chettri Support', 2, '2022-11-23', '12:30PM', 'Indiranagar Football Ground', 'Football Match', 30),
(3, 'Entrepreneurship Build', 3, '2022-11-24', '12:30PM', 'PES EC Campus', 'Improvising management skills', 25);

-- --------------------------------------------------------

--
-- Table structure for table `club_heads`
--

CREATE TABLE `club_heads` (
  `Club_id` int(11) DEFAULT NULL,
  `User_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `club_heads`
--

INSERT INTO `club_heads` (`Club_id`, `User_id`) VALUES
(1, 3),
(2, 3),
(3, 3),
(4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `club_head_details`
--

CREATE TABLE `club_head_details` (
  `User_id` int(11) DEFAULT NULL,
  `Fname` varchar(30) DEFAULT NULL,
  `Lname` varchar(30) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `User_ph` int(11) DEFAULT NULL,
  `Semester` int(11) DEFAULT NULL,
  `Club_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `club_head_details`
--

INSERT INTO `club_head_details` (`User_id`, `Fname`, `Lname`, `Email`, `User_ph`, `Semester`, `Club_id`) VALUES
(3, 'Steve', 'Jobs', '928272', 0, 7, 1),
(3, 'Steve', 'Jobs', '928272', 0, 7, 2),
(3, 'Steve', 'Jobs', '928272', 0, 7, 3),
(3, 'Steve', 'Jobs', '928272', 0, 7, 4),
(3, 'Steve', 'Jobs', '928272', 0, 7, 4);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `Login_id` int(11) NOT NULL,
  `Username` varchar(100) DEFAULT NULL,
  `User_password` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`Login_id`, `Username`, `User_password`) VALUES
(1, 'Virat', 'Virat18'),
(2, 'Lionel', 'Lionel10'),
(3, 'Steve', 'Jobs');

-- --------------------------------------------------------

--
-- Table structure for table `logistics`
--

CREATE TABLE `logistics` (
  `Event_id` int(11) DEFAULT NULL,
  `Funds_available` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logistics`
--

INSERT INTO `logistics` (`Event_id`, `Funds_available`) VALUES
(1, 100000),
(2, 50000),
(3, 30000);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `User_id` int(11) DEFAULT NULL,
  `Fname` varchar(100) DEFAULT NULL,
  `Lname` varchar(100) DEFAULT NULL,
  `User_ph` int(10) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Semester` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_id`, `Fname`, `Lname`, `User_ph`, `Email`, `Semester`) VALUES
(1, 'Virat', 'Kohli', 928278, 'viratkohli18@gmail.com', 5),
(2, 'Lionel', 'Messi', 928275, 'lionelmessi10@gmail.com', 5),
(3, 'Steve', 'Jobs', 928272, 'stevejobs@gmail.com', 7);

-- --------------------------------------------------------

--
-- Table structure for table `user_clubs`
--

CREATE TABLE `user_clubs` (
  `User_id` int(11) DEFAULT NULL,
  `Club_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_clubs`
--

INSERT INTO `user_clubs` (`User_id`, `Club_id`) VALUES
(1, 1),
(2, 2),
(3, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`Acc_no`),
  ADD KEY `Club_id` (`Club_id`);

--
-- Indexes for table `club`
--
ALTER TABLE `club`
  ADD PRIMARY KEY (`Club_id`);

--
-- Indexes for table `club_events`
--
ALTER TABLE `club_events`
  ADD PRIMARY KEY (`Event_id`),
  ADD KEY `Club_id` (`Club_id`);

--
-- Indexes for table `club_heads`
--
ALTER TABLE `club_heads`
  ADD KEY `Club_id` (`Club_id`),
  ADD KEY `User_id` (`User_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`Login_id`);

--
-- Indexes for table `logistics`
--
ALTER TABLE `logistics`
  ADD KEY `Event_id` (`Event_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD KEY `User_id` (`User_id`);

--
-- Indexes for table `user_clubs`
--
ALTER TABLE `user_clubs`
  ADD KEY `User_id` (`User_id`),
  ADD KEY `Club_id` (`Club_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `Login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`Club_id`) REFERENCES `club` (`Club_id`);

--
-- Constraints for table `club_events`
--
ALTER TABLE `club_events`
  ADD CONSTRAINT `club_events_ibfk_1` FOREIGN KEY (`Club_id`) REFERENCES `club` (`Club_id`);

--
-- Constraints for table `club_heads`
--
ALTER TABLE `club_heads`
  ADD CONSTRAINT `club_heads_ibfk_1` FOREIGN KEY (`Club_id`) REFERENCES `club` (`Club_id`),
  ADD CONSTRAINT `club_heads_ibfk_2` FOREIGN KEY (`User_id`) REFERENCES `login` (`Login_id`);

--
-- Constraints for table `logistics`
--
ALTER TABLE `logistics`
  ADD CONSTRAINT `logistics_ibfk_1` FOREIGN KEY (`Event_id`) REFERENCES `club_events` (`Event_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `login` (`Login_id`);

--
-- Constraints for table `user_clubs`
--
ALTER TABLE `user_clubs`
  ADD CONSTRAINT `user_clubs_ibfk_1` FOREIGN KEY (`User_id`) REFERENCES `login` (`Login_id`),
  ADD CONSTRAINT `user_clubs_ibfk_2` FOREIGN KEY (`Club_id`) REFERENCES `club` (`Club_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
