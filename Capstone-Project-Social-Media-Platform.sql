/*Database Schema*/
CREATE DATABASE SocialMediaPlatform;
USE SocialMediaPlatform;

CREATE TABLE users
(user_id INT PRIMARY KEY NOT NULL,
username VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
password VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
profile_picture VARCHAR(200) NOT NULL);

CREATE TABLE posts
(post_id INT PRIMARY KEY NOT NULL,
user_id INT NOT NULL,
post_text VARCHAR(500) NOT NULL,
post_date DATE NOT NULL,
media_url VARCHAR(200) NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE comments
(comment_id INT PRIMARY KEY NOT NULL,
post_id INT NOT NULL,
user_id INT NOT NULL,
comment_text VARCHAR(300) NOT NULL,
comment_date DATE NOT NULL,
FOREIGN KEY (post_id) REFERENCES posts(post_id),
FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE likes
(like_id INT PRIMARY KEY NOT NULL,
post_id INT NOT NULL,
user_id INT NOT NULL,
like_date DATE NOT NULL,
FOREIGN KEY (post_id) REFERENCES posts(post_id),
FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE follows
(follow_id INT PRIMARY KEY NOT NULL,
follower_id INT NOT NULL,
following_id INT NOT NULL,
follow_date DATE NOT NULL,
FOREIGN KEY (follower_id) REFERENCES users(user_id),
FOREIGN KEY (following_id) REFERENCES users(user_id));

CREATE TABLE messages
(message_id INT PRIMARY KEY NOT NULL,
sender_id INT NOT NULL,
receiver_id INT NOT NULL,
message_text VARCHAR(500) NOT NULL,
message_date DATE NOT NULL,
is_read BOOL NOT NULL,
FOREIGN KEY (sender_id) REFERENCES users(user_id),
FOREIGN KEY (receiver_id) REFERENCES users(user_id));

CREATE TABLE notifications
(notification_id INT PRIMARY KEY NOT NULL,
user_id INT NOT NULL,
notification_text VARCHAR(200) NOT NULL,
notification_date DATE NOT NULL,
is_read BOOL NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(user_id));

/*Insert Sample Data*/
INSERT INTO users (user_id, username, email, password, date_of_birth, profile_picture) VALUES
(1, 'futurama5000', 'johnsmith25@gmail.com', '12345', '1996-05-01', 'https://www.vecteezy.com/free-vector/profile-icon'),
(2, 'laura1995', 'laura1212@gmail.com', 'password', '1998-10-12', 'https://www.vecteezy.com/free-vector/profile-icon'),
(3, 'mzero20', 'moniquezero@gmail.com', 'barthomer', '2000-01-20', 'https://www.vecteezy.com/free-vector/profile-icon'),
(4, 'duderanch97', 'newmail2025@gmail.com', 'blink182', '1999-04-20', 'https://www.vecteezy.com/free-vector/profile-icon'),
(5, 'idkidk25', 'stephenmax@gmail.com', 'qwerty3', '2001-12-15', 'https://www.vecteezy.com/free-vector/profile-icon');

INSERT INTO posts (post_id, user_id, post_text, post_date, media_url) VALUES
(1, 2, 'Good morning everyone!', '2025-05-01', 'https://www.socialmedia.com/asdfasd23123'),
(2, 4, 'Making chocolate chip cookies', '2025-05-01', 'https://www.socialmedia.com/vcxbvxc54332'),
(3, 1, 'Check out my new song', '2025-05-02', 'https://www.socialmedia.com/hgdfhgd85493'),
(4, 5, 'Books are too expensive!', '2025-05-03', 'https://www.socialmedia.com/uytruyr38543'),
(5, 3, 'Its the Minecraft movie good?', '2025-05-04', 'https://www.socialmedia.com/lytroyt85430');

INSERT INTO comments (comment_id, post_id, user_id, comment_text, comment_date) VALUES
(1, 1, 3, 'Good morning to you', '2025-05-01'),
(2, 1, 5, 'Hello', '2025-05-01'),
(3, 2, 2, 'Are you sharing some?', '2025-05-02'),
(4, 4, 3, 'I know right', '2025-05-03'),
(5, 5, 1, 'Its good', '2025-05-04');

INSERT INTO likes (like_id, post_id, user_id, like_date) VALUES
(1, 1, 4, '2025-05-01'),
(2, 1, 3, '2025-05-01'),
(3, 2, 2, '2025-05-03'),
(4, 3, 5, '2025-05-03'),
(5, 4, 1, '2025-05-03');

INSERT INTO follows (follow_id, follower_id, following_id, follow_date) VALUES
(1, 1, 5, '2025-05-01'),
(2, 1, 4, '2025-05-01'),
(3, 5, 1, '2025-05-01'),
(4, 3, 2, '2025-05-01'),
(5, 4, 2, '2025-05-01');

INSERT INTO messages (message_id, sender_id, receiver_id, message_text, message_date, is_read) VALUES
(1, 5, 2, 'Hello', '2025-05-01', true),
(2, 1, 3, 'What are you doing tonight?', '2025-05-01', true),
(3, 4, 1, 'Lunch tomorrow?', '2025-05-02', true),
(4, 3, 2, 'Good morning', '2025-05-03', false),
(5, 1, 4, 'Check this out', '2025-05-03', true);

INSERT INTO notifications (notification_id, user_id, notification_text, notification_date, is_read) VALUES
(1, 3, 'You have a new message', '2025-05-01', 1),
(2, 2, 'You have a new message', '2025-05-01', 1),
(3, 5, 'You have a new message', '2025-05-02', 1),
(4, 2, 'Your post received a comment', '2025-05-03', 1),
(5, 1, 'Your post received a comment', '2025-05-03', 1);

/*Queries*/

/*Retrieve the posts and activities of a user's timeline.*/
SELECT a.username, b.post_text, b.post_date FROM users a
INNER JOIN posts b
ON a.user_id = b.user_id
WHERE a.user_id = 2;

/*Retrieve the comments and likes for a specific post.*/
SELECT a.post_id, a.user_id, a.post_text, a.post_date, b.comment_text, c.like_id FROM posts a
INNER JOIN comments b
ON a.post_id = b.post_id
INNER JOIN likes c
ON a.post_id = c.post_id
WHERE a.post_id = 2;

/*Retrieve the list of followers for a user.*/
SELECT * FROM follows WHERE following_id = 2;

/*Retrieve unread messages for a user.*/
SELECT * FROM messages WHERE receiver_id = 2 AND is_read = false;

/*Retrieve the most liked posts.*/
SELECT a.post_id, a.post_text, COUNT(b.like_id) AS number_likes FROM posts a
INNER JOIN likes b
ON a.post_id = b.post_id
GROUP BY a.post_id
ORDER BY number_likes DESC;

/*Retrieve the latest notifications for a user.*/
SELECT * FROM notifications WHERE user_id = 2
ORDER BY notification_date DESC;

/*Data Modification*/

/*Add a new post to the platform.*/
INSERT INTO posts (post_id, user_id, post_text, post_date, media_url) VALUES
(6, 3, 'Back from the gym!', '2025-05-05', 'https://www.socialmedia.com/lokdmsa98983');

/*Comment on a post.*/
INSERT INTO comments (comment_id, post_id, user_id, comment_text, comment_date) VALUES
(6, 6, 2, 'I work out too', '2025-05-05');

/*Update user profile information.*/
UPDATE users SET password = 'metallica' WHERE user_id = 1;

/*Remove a like from a post.*/
DELETE FROM likes WHERE post_id = 3 LIMIT 1;

/*Complex Queries*/

/*Identify users with the most followers.*/
SELECT following_id AS user_id, COUNT(following_id) AS followers FROM follows 
GROUP BY user_id
ORDER BY followers DESC;

/*Find the most active users based on post count and interaction.*/
SELECT a.user_id, COUNT(DISTINCT a.post_id) AS number_posts, 
COUNT(b.like_id) AS number_likes,
COUNT(DISTINCT a.post_id) + COUNT(b.like_id) AS number_interactions 
FROM posts a
LEFT JOIN likes b
ON a.post_id = b.post_id
GROUP BY a.user_id
ORDER BY number_interactions DESC;

/*Calculate the average number of comments per post.*/
SELECT COUNT(comment_id) DIV COUNT(DISTINCT post_id) AS comment_average 
FROM comments;

/*Advanced Topics*/

/*Automatically notify users of new messages.*/
CREATE TRIGGER ins_sum AFTER INSERT ON messages
FOR EACH ROW INSERT INTO notifications 
(notification_id, user_id, notification_text, notification_date, is_read) VALUES
(LAST_INSERT_ID() + 6, new.receiver_id, 'You got a new message', new.message_date, false);

/*Generate personalized recommendations for users to follow.*/
CREATE DEFINER=`usuariocurso`@`localhost` PROCEDURE `send_recomendations`(IN user_id INT)
BEGIN
DECLARE _id BIGINT UNSIGNED;
DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT follow_id FROM follows WHERE follower_id != user_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;

  OPEN cur;

  testLoop: LOOP
    FETCH cur INTO _id;
    IF done THEN
      LEAVE testLoop;
    END IF;
    INSERT INTO notifications 
    (user_id, notification_text, notification_date, is_read) VALUES
    (user_id, 'Follow this person', DATE(now()), false);
  END LOOP testLoop;

  CLOSE cur;

END








