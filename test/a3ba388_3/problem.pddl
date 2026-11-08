(define (problem task-a3ba388-3)
  (:domain appworld-a3ba388-3)
  (:objects
    alex manager - person
    alexwhite-at-gmail-com phone-3707865891 - username
    gmail-password phone-password file-system-password - password
    gmail-token phone-token file-system-token - token
    resignation-draft - draft
    query-resignation - query
    manager-relationship - relationship
    manager-email - email
    letter-of-resignation-pdf - file-path
    next-wednesday-11am - datetime)
  (:init
    (username-for gmail alexwhite-at-gmail-com)
    (username-for file-system alexwhite-at-gmail-com)
    (username-for phone phone-3707865891)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (draft-matches resignation-draft query-resignation)
    (contact-relationship manager manager-relationship)
    (email-of manager manager-email)
    (attachment-target resignation-draft letter-of-resignation-pdf)
    (recipient-target resignation-draft manager)
    (schedule-target resignation-draft next-wednesday-11am))
  (:goal (and
    (attached letter-of-resignation-pdf resignation-draft)
    (draft-recipient resignation-draft manager-email)
    (draft-scheduled resignation-draft next-wednesday-11am)
    (task-completed)))
)
