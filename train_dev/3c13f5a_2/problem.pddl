(define (problem task-3c13f5a-2)
  (:domain appworld-3c13f5a-2)
  (:objects
    lindsey roommate-1 roommate-2 - person
    username-3567801924 username-lindseysimpson-at-gmail-com - username
    password-phone password-file-system password-venmo - password
    token-phone token-file-system token-venmo - token
    email-roommate-1 email-roommate-2 - email
    query-roommate - query
    relationship-roommate - relationship
    dir-home - directory-path
    substring-internet - substring
    entry-type-files - entry-type
    file-internet-bill-last-month - file-path
    amount-bill-share - amount
    note-internet-bill-for-the-last-month - note
    request-roommate-1 request-roommate-2 - payment-request
  )
  (:init
    (password-for phone password-phone)
    (password-for file-system password-file-system)
    (password-for venmo password-venmo)
    (login-username phone username-3567801924)
    (login-username file-system username-lindseysimpson-at-gmail-com)
    (login-username venmo username-lindseysimpson-at-gmail-com)
    (roommate roommate-1)
    (roommate roommate-2)
    (roommate-email roommate-1 email-roommate-1)
    (roommate-email roommate-2 email-roommate-2)
    (request-for request-roommate-1 roommate-1)
    (request-for request-roommate-2 roommate-2)
    (roommate-query query-roommate)
    (roommate-relationship relationship-roommate)
    (home-directory dir-home)
    (bill-substring substring-internet)
    (files-entry-type entry-type-files)
    (last-month-bill-receipt file-internet-bill-last-month)
    (bill-share amount-bill-share)
    (request-note note-internet-bill-for-the-last-month)
  )
  (:goal (and
    (request-sent request-roommate-1 amount-bill-share note-internet-bill-for-the-last-month)
    (request-sent request-roommate-2 amount-bill-share note-internet-bill-for-the-last-month)
    (task-completed)
  ))
)
