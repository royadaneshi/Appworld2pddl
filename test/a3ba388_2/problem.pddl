(define (problem task-a3ba388-2)
  (:domain appworld-a3ba388-2)
  (:objects
    tracy-weber manager-person - person
    tra-weber-at-gmail-com phone-7487389769 - username
    phone-password gmail-password file-system-password - password
    phone-token gmail-token file-system-token - token
    manager-email - email
    relationship-manager - relationship
    resignation-draft - draft
    query-resignation - query
    resignation-letter-path - file-path
    dt-2023-05-30t10-00-00 - datetime
  )
  (:init
    (username-for phone phone-7487389769)
    (username-for gmail tra-weber-at-gmail-com)
    (username-for file-system tra-weber-at-gmail-com)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (has-relationship manager-person relationship-manager)
    (is-manager manager-person)
    (email-of manager-person manager-email)
    (draft-matches resignation-draft query-resignation)
    (target-draft resignation-draft)
    (target-file resignation-letter-path)
    (target-datetime dt-2023-05-30t10-00-00)
  )
  (:goal (and
    (attached resignation-draft resignation-letter-path)
    (scheduled resignation-draft manager-email dt-2023-05-30t10-00-00)
    (task-completed)
  ))
)
