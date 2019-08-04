INSERT INTO `users` (`id`, `name`, `email`, `created_at`, `updated_at`)
VALUES
    (1, 'Takash', 'takashi@example.com', NOW(), NOW()),
    (2, 'Yuki', 'yuki@example.com', NOW(), NOW()),
    (3, 'Takahashi', 'takahashi@example.com', NOW(), NOW()),
    (4, 'Yasuko', 'yasuko@example.com', NOW(), NOW()),
    (5, 'Naoshi', 'naoshi@example.com', NOW(), NOW());

INSERT INTO `user_attributes` (`id`, `user_id`, `gender`, `location`, `created_at`, `updated_at`)
VALUES
    (1, 1, 'male', 'Hokkaido', NOW(), NOW()),
    (2, 2, 'female', 'Shizuoka',  NOW(), NOW()),
    (3, 3, 'female', 'Tokyo', NOW(), NOW()),
    (4, 4, 'female', 'Hokkaido', NOW(), NOW()),
    (5, 5, 'male', 'Okinawa', NOW(), NOW());

