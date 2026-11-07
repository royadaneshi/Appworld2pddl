(define (problem task-3c13f5a-3)
  (:domain appworld-3c13f5a-3)
  (:objects
    jennifer-powell roommate-1 roommate-2 - person
    username-4288705164 username-jepowell-at-gmail-com - username
    phone-password file-system-password venmo-password - password
    phone-token file-system-token venmo-token - token
    roommate-1-email roommate-2-email - email
    query-roommate - query
    relationship-roommate - relationship
    dir-home - directory-path
    substring-cable - substring
    entry-type-files - entry-type
    file-cable-bill-last-month - file-path
    amount-bill-share - amount
    note-i-paid-for-cable-bill - description
    c0 c1 - count)
  (:init
    (username-for phone username-4288705164)
    (username-for file-system username-jepowell-at-gmail-com)
    (username-for venmo username-jepowell-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for venmo venmo-password)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (roommate-email roommate-1 roommate-1-email)
    (roommate-email roommate-2 roommate-2-email)
    (roommate-query query-roommate)
    (roommate-relationship relationship-roommate)
    (home-directory dir-home)
    (bill-substring substring-cable)
    (files-entry-type entry-type-files)
    (last-month-receipt file-cable-bill-last-month)
    (share-of file-cable-bill-last-month amount-bill-share)
    (note-text note-i-paid-for-cable-bill)
    (requests-sent-count c0)
    (succ c0 c1)
    (succ c1 c-all))
  (:goal (and (requests-sent-count c-all) (task-completed))))
