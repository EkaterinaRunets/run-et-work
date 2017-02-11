USE runetwork;
INSERT INTO `User` (`login`, `password_hash`, `role`, `name`, `lastname`, `patronymic`, `birthdate`, `image_url`) VALUES
    ('erunets', '$2a$04$0wSxtCC.lVXoGknKM/dCd.zNIr5HVWIWkkzGcjA6qJt.FKc6C.CBq', 'USER', 'Екатерина', 'Рунец', 'Сергеевна', '1994-11-28', 'https://scontent.fhen1-1.fna.fbcdn.net/v/t1.0-0/p160x160/15541324_1188142031282863_767948771434402864_n.jpg?oh=64a46904c2722dfa4aa3d48c641afcf6&oe=58FFE27A'),
    ('system', '', 'ADMIN', 'Account', 'System', '', CURRENT_DATE, NULL);

SELECT @erunetsId := `id` FROM `User` WHERE `login` = 'erunets';

INSERT INTO `Contact` (`type`, `contact`, `user_id`) VALUES
    ('MOBILE', '+375299793171', @erunetsId),
    ('EMAIL', 'ekaterina_runec@mail.ru', @erunetsId);

