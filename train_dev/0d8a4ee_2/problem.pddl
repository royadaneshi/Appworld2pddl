(define (problem task-0d8a4ee-2)
  (:domain appworld-0d8a4ee-2)
  (:objects
    adam-blackburn - person
    username-8944155247 username-ad-blackburn-at-gmail-com - username
    password-phone password-venmo - password
    token-phone token-venmo - token
    siblings roommates - relationship
    phone-sibling-1 phone-sibling-2 phone-roommate-1 - phone-number
    email-sibling-1 email-sibling-2 email-roommate-1 - email)
  (:init
    (username-for phone username-8944155247)
    (username-for venmo username-ad-blackburn-at-gmail-com)
    (password-for phone password-phone)
    (password-for venmo password-venmo)
    (token-for phone token-phone)
    (token-for venmo token-venmo)
    (has-relationship sibling-1 siblings)
    (has-relationship sibling-2 siblings)
    (has-relationship roommate-1 roommates)
    (phone-of sibling-1 phone-sibling-1)
    (phone-of sibling-2 phone-sibling-2)
    (phone-of roommate-1 phone-roommate-1)
    (email-of sibling-1 email-sibling-1)
    (email-of sibling-2 email-sibling-2)
    (email-of roommate-1 email-roommate-1)
    (no-venmo-account sibling-1)
    (no-venmo-account roommate-1))
  (:goal (and
    (venmo-status-known sibling-1)
    (venmo-status-known sibling-2)
    (venmo-status-known roommate-1)
    (message-sent sibling-1 msg-get-on-venmo-please)
    (message-sent roommate-1 msg-get-on-venmo-please)
    (task-completed))))
