(define (problem task-0d8a4ee-2)
  (:domain appworld-0d8a4ee-2)
  (:objects
    adam-blackburn - person
    username-8944155247 username-ad-blackburn-at-gmail-com - username
    password-phone password-venmo - password
    token-phone token-venmo - token
    siblings roommates - relationship
    phone-sibling-matthew phone-sibling-martin phone-sibling-kevin phone-roommate-carl phone-roommate-jeremy - phone-number
    email-sibling-matthew email-sibling-martin email-sibling-kevin email-roommate-carl email-roommate-jeremy - email)
  (:init
    (username-for phone username-8944155247)
    (username-for venmo username-ad-blackburn-at-gmail-com)
    (password-for phone password-phone)
    (password-for venmo password-venmo)
    (token-for phone token-phone)
    (token-for venmo token-venmo)
    (has-relationship sibling-matthew siblings)
    (has-relationship sibling-martin siblings)
    (has-relationship sibling-kevin siblings)
    (has-relationship roommate-carl roommates)
    (has-relationship roommate-jeremy roommates)
    (phone-of sibling-matthew phone-sibling-matthew)
    (phone-of sibling-martin phone-sibling-martin)
    (phone-of sibling-kevin phone-sibling-kevin)
    (phone-of roommate-carl phone-roommate-carl)
    (phone-of roommate-jeremy phone-roommate-jeremy)
    (email-of sibling-matthew email-sibling-matthew)
    (email-of sibling-martin email-sibling-martin)
    (email-of sibling-kevin email-sibling-kevin)
    (email-of roommate-carl email-roommate-carl)
    (email-of roommate-jeremy email-roommate-jeremy)
    (no-venmo-account sibling-martin)
    (no-venmo-account roommate-jeremy))
  (:goal (and
    (venmo-status-known sibling-matthew)
    (venmo-status-known sibling-martin)
    (venmo-status-known sibling-kevin)
    (venmo-status-known roommate-carl)
    (venmo-status-known roommate-jeremy)
    (message-sent sibling-martin msg-get-on-venmo-please)
    (message-sent roommate-jeremy msg-get-on-venmo-please)
    (task-completed))))
