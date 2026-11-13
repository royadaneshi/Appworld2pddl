(define (problem task-a5b0084-2)
  (:domain appworld-a5b0084-2)
  (:objects
    erica sibling-1 sibling-2 person-1 - person
    username-eri-powe-at-gmail-com username-4675246489 - username
    gmail-password phone-password new-password-68qunl - password
    gmail-token phone-token - token
    eri-powe-at-gmail-com - email
    query-password-reset - query
    spotify-reset-email-thread - email-thread
    spotify-reset-code - reset-code
    sibling - relationship
    phone-of-sibling-1 phone-of-sibling-2 phone-of-sibling-3 - phone-number
    message-new-spotify-password - message
  )
  (:init
    (credential-of-app gmail eri-powe-at-gmail-com)
    (credential-of-app gmail username-eri-powe-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app phone username-4675246489)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (username-for gmail username-eri-powe-at-gmail-com)
    (username-for phone username-4675246489)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (supervisor-email eri-powe-at-gmail-com)
    (target-password new-password-68qunl)
    (relationship-of sibling-1 sibling)
    (relationship-of sibling-2 sibling)
    (relationship-of person-1 sibling)
    (phone-number-of sibling-1 phone-of-sibling-1)
    (phone-number-of sibling-2 phone-of-sibling-2)
    (phone-number-of person-1 phone-of-sibling-3)
    (message-contains message-new-spotify-password new-password-68qunl))
  (:goal (and
    (password-reset spotify new-password-68qunl)
    (text-sent sibling-1 message-new-spotify-password)
    (text-sent sibling-2 message-new-spotify-password)
    (text-sent person-1 message-new-spotify-password)
    (task-completed)))
)
