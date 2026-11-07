(define (problem task-6ea6792-2)
  (:domain appworld-6ea6792-2)
  (:objects
    connor-brown friend-contact roommate-contact other-sender - person
    username-5734599766 username-connorbrow-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    query-friend query-roommate - query
    rel-friend rel-roommate - relationship
    status-pending - status
    pr-from-friend pr-from-roommate pr-from-other - payment-request
    count-2 count-1 - count)
  (:init
    (username-for phone username-5734599766)
    (username-for venmo username-connorbrow-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for query-friend rel-friend)
    (query-for query-roommate rel-roommate)
    (contact-relation friend-contact rel-friend)
    (contact-relation roommate-contact rel-roommate)
    (pending-status status-pending)
    (request-from pr-from-friend friend-contact)
    (request-from pr-from-roommate roommate-contact)
    (request-from pr-from-other other-sender)
    (pending pr-from-friend)
    (pending pr-from-roommate)
    (pending pr-from-other)
    (remaining count-2)
    (next-count count-2 count-1)
    (next-count count-1 count-0))
  (:goal (and
    (denied pr-from-friend)
    (denied pr-from-roommate)
    (remaining count-0)
    (task-completed))))
