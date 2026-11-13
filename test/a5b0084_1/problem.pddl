(define (problem task-a5b0084-1)
  (:domain appworld-a5b0084-1)
  (:objects
    anita-burch roommate-1 roommate-2 person-1 - person
    anita-burch-at-gmail-com - email
    username-anita-burch-at-gmail-com username-3643463570 - username
    gmail-password phone-password zlp9tir - password
    gmail-token phone-token - token
    query-password-reset - query
    amazon-reset-code-thread - email-thread
    amazon-reset-code - code
    roommate - relationship
    phone-roommate-1 phone-roommate-2 phone-roommate-3 - phone-number
    message-new-amazon-password - message
  )
  (:init
    (credential-of-app gmail anita-burch-at-gmail-com)
    (credential-of-app gmail username-anita-burch-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app phone username-3643463570)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (username-for gmail username-anita-burch-at-gmail-com)
    (password-for gmail gmail-password)
    (username-for phone username-3643463570)
    (password-for phone phone-password)
    (account-email amazon anita-burch-at-gmail-com)
    (target-password amazon zlp9tir)
    (reset-code-query query-password-reset)
    (has-relationship roommate-1 roommate)
    (has-relationship roommate-2 roommate)
    (has-relationship person-1 roommate)
    (phone-of roommate-1 phone-roommate-1)
    (phone-of roommate-2 phone-roommate-2)
    (phone-of person-1 phone-roommate-3)
    (message-contains message-new-amazon-password zlp9tir))
  (:goal (and
    (password-changed amazon zlp9tir)
    (text-sent roommate-1)
    (text-sent roommate-2)
    (text-sent person-1)
    (task-completed))))
