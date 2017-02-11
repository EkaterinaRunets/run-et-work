USE runetwork;

CREATE TABLE `User` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `login` VARCHAR(64) NOT NULL UNIQUE COLLATE utf8_unicode_ci,
  `password_hash` VARCHAR(64) NOT NULL COLLATE utf8_unicode_ci,
  `role` VARCHAR(32) NOT NULL COLLATE utf8_unicode_ci DEFAULT 'USER',
  `name` VARCHAR(64) NOT NULL COLLATE utf8_unicode_ci,
  `lastname` VARCHAR(64) NOT NULL COLLATE utf8_unicode_ci,
  `patronymic` VARCHAR(64) COLLATE utf8_unicode_ci,
  `birthdate` DATE,
  `image_url` TEXT COLLATE utf8_unicode_ci
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `Contact` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `type` VARCHAR(32) NOT NULL,
  `contact` VARCHAR(64) NOT NULL COLLATE utf8_unicode_ci,
  `user_id` BIGINT NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `Department` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL COLLATE utf8_unicode_ci,
  `parent_id` BIGINT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `Group` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL COLLATE utf8_unicode_ci,
  `department_id` BIGINT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `GroupToUser` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `group_id` BIGINT NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `GroupToCourse` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `course_id` BIGINT NOT NULL,
  `group_id` BIGINT NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `Task` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL COLLATE utf8_unicode_ci,
  `description` TEXT COLLATE utf8_unicode_ci,
  `status` VARCHAR(32) NOT NULL,
  `result` TEXT,
  `creation_date` DATE NOT NULL,
  `update_date` DATE NOT NULL,
  `deadline_date` DATE NOT NULL,
  `creator_id` BIGINT NOT NULL,
  `assignee_id` BIGINT,
  `course_id` BIGINT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `Course` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL COLLATE utf8_unicode_ci,
  `description` TEXT COLLATE utf8_unicode_ci,
  `duration` INT DEFAULT 0,
  `professor_id` BIGINT
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `Notification` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `notification_text` VARCHAR(128) NOT NULL,
  `creation_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
  `read` TINYINT DEFAULT 0,
  `target_user_id` BIGINT NOT NULL,
  `source_user_id` BIGINT NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `Comment` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `comment_text` TEXT NOT NULL,
  `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
  `user_id` BIGINT NOT NULL,
  `task_id` BIGINT NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `Contact`
  ADD CONSTRAINT `contact_user_id` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `Department`
  ADD CONSTRAINT `parent_department_id` FOREIGN KEY (`parent_id`) REFERENCES `Department` (`id`);

ALTER TABLE `Group`
  ADD CONSTRAINT `group_department_id` FOREIGN KEY (`department_id`) REFERENCES `Department` (`id`);

ALTER TABLE `GroupToUser`
  ADD CONSTRAINT `g2u_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group` (`id`),
  ADD CONSTRAINT `g2u_user_id` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

ALTER TABLE `GroupToCourse`
  ADD CONSTRAINT `g2c_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group` (`id`),
  ADD CONSTRAINT `g2c_course_id` FOREIGN KEY (`course_id`) REFERENCES `Course` (`id`);

ALTER TABLE `Task`
  ADD CONSTRAINT `task_creator_id` FOREIGN KEY (`creator_id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `task_assignee_id` FOREIGN KEY (`assignee_id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `task_course_id` FOREIGN KEY (`course_id`) REFERENCES `Course` (`id`);

ALTER TABLE `Course`
  ADD CONSTRAINT `course_professor_id` FOREIGN KEY (`professor_id`) REFERENCES `User` (`id`);

ALTER TABLE `Notification`
  ADD CONSTRAINT `notifiable_user_id` FOREIGN KEY (`target_user_id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `notifying_user_id` FOREIGN KEY (`source_user_id`) REFERENCES `User` (`id`);

ALTER TABLE `Comment`
  ADD CONSTRAINT `comment_user_id` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `comment_task_id` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`);
