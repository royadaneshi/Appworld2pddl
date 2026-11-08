(define (problem task-98d2608-1)
  (:domain appworld-98d2608-1)
  (:objects
    cody my-partner - person
    phone-7826309761 cod-smith-at-gmail-com - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    partner-email - email
    partner - relationship
    query-license - query
    flag-true - flag
    driving-license-file - file-path
    subject-driving-license - subject
    body-driving-license - body
  )
  (:init
    (username-for phone phone-7826309761)
    (username-for file-system cod-smith-at-gmail-com)
    (username-for gmail cod-smith-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (has-relationship my-partner partner)
    (email-of my-partner partner-email)
    (file-matches driving-license-file query-license)
  )
  (:goal (and
    (sent-attachment-to my-partner driving-license-file)
    (task-completed)
  ))
)
