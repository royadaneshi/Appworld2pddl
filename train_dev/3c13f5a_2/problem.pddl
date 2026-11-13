(define (problem task-3c13f5a-2)
  (:domain appworld-3c13f5a-2)
  (:objects
    username-3567801924 username-lindseysimpson-at-gmail-com - username
    password-phone password-file-system password-venmo - password
    token-phone token-file-system token-venmo - token
    query-roommate - query
    relationship-roommate - relationship
    dir-home - directory-path
    substring-internet - substring
    entry-type-files - entry-type
    file-internet-bill-last-month - file-path
    amount-bill-share - amount
    note-internet-bill-for-the-last-month - note
    lindsey roommate-chris roommate-jose roommate-paul - person
    email-roommate-chris email-roommate-jose email-roommate-paul - email
    request-roommate-chris request-roommate-jose request-roommate-paul - payment-request
  )
  (:init
    (credential-of-app phone password-phone)
    (credential-of-app phone token-phone)
    (credential-of-app file-system password-file-system)
    (credential-of-app file-system token-file-system)
    (credential-of-app venmo password-venmo)
    (credential-of-app venmo token-venmo)
    (password-for phone password-phone)
    (password-for file-system password-file-system)
    (password-for venmo password-venmo)
    (login-username phone username-3567801924)
    (login-username file-system username-lindseysimpson-at-gmail-com)
    (login-username venmo username-lindseysimpson-at-gmail-com)
    (roommate-query query-roommate)
    (roommate-relationship relationship-roommate)
    (home-directory dir-home)
    (bill-substring substring-internet)
    (files-entry-type entry-type-files)
    (last-month-bill-receipt file-internet-bill-last-month)
    (bill-share amount-bill-share)
    (request-note note-internet-bill-for-the-last-month)
    (roommate roommate-chris)
    (roommate roommate-jose)
    (roommate roommate-paul)
    (roommate-email roommate-chris email-roommate-chris)
    (roommate-email roommate-jose email-roommate-jose)
    (roommate-email roommate-paul email-roommate-paul)
    (request-for request-roommate-chris roommate-chris)
    (request-for request-roommate-jose roommate-jose)
    (request-for request-roommate-paul roommate-paul))
  (:goal (and
    (request-sent request-roommate-chris amount-bill-share note-internet-bill-for-the-last-month)
    (request-sent request-roommate-jose amount-bill-share note-internet-bill-for-the-last-month)
    (request-sent request-roommate-paul amount-bill-share note-internet-bill-for-the-last-month)
    (task-completed)))
)
