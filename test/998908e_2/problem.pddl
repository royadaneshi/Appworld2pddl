(define (problem task-998908e-2)
  (:domain appworld-998908e-2)
  (:objects
    debra-ritter - person
    de-ritt-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-hotel - query
    today-start-2023-05-18 - datetime
    hotel-booking-thread-1 hotel-booking-thread-2 hotel-booking-thread-3 - email-thread
    receipt-attachment-1 receipt-attachment-2 receipt-attachment-3 - attachment
    receipt-file-1 receipt-file-2 receipt-file-3 - file-path
    discover-total - amount)
  (:init
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (booking-query query-hotel)
    (day-start today-start-2023-05-18)
    (booking-thread hotel-booking-thread-1)
    (booking-thread hotel-booking-thread-2)
    (booking-thread hotel-booking-thread-3)
    (has-attachment hotel-booking-thread-1 receipt-attachment-1)
    (has-attachment hotel-booking-thread-2 receipt-attachment-2)
    (has-attachment hotel-booking-thread-3 receipt-attachment-3)
    (attachment-file receipt-attachment-1 receipt-file-1)
    (attachment-file receipt-attachment-2 receipt-file-2)
    (attachment-file receipt-attachment-3 receipt-file-3)
    (total-of discover-total receipt-file-1 receipt-file-2 receipt-file-3))
  (:goal (and
    (receipt-read receipt-file-1)
    (receipt-read receipt-file-2)
    (receipt-read receipt-file-3)
    (task-completed)))
)
