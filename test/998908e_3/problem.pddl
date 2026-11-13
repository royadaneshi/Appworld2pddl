(define (problem task-998908e-3)
  (:domain appworld-998908e-3)
  (:objects
    patricia-ritter - person
    pa-ritter-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-hotel - query
    since-2023-05-18t00-00-00 - datetime
    hotel-thread-1 hotel-thread-2 hotel-thread-3 - email-thread
    receipt-1 receipt-2 receipt-3 - attachment
    path-receipt-1 path-receipt-2 path-receipt-3 - file-path
    sum-0 sum-1 sum-2 total-wells-fargo-spend - amount)
  (:init
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (username-for gmail pa-ritter-at-gmail-com)
    (username-for file-system pa-ritter-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (today-start since-2023-05-18t00-00-00)
    (listed-by hotel-thread-1 query-hotel)
    (listed-by hotel-thread-2 query-hotel)
    (listed-by hotel-thread-3 query-hotel)
    (attachment-of hotel-thread-1 receipt-1)
    (attachment-of hotel-thread-2 receipt-2)
    (attachment-of hotel-thread-3 receipt-3)
    (download-path receipt-1 path-receipt-1)
    (download-path receipt-2 path-receipt-2)
    (download-path receipt-3 path-receipt-3)
    (running-total sum-0)
    (sum-step sum-0 receipt-1 sum-1)
    (sum-step sum-1 receipt-2 sum-2)
    (sum-step sum-2 receipt-3 total-wells-fargo-spend)
    (answer-amount total-wells-fargo-spend))
  (:goal (and (running-total total-wells-fargo-spend) (task-completed)))
)
