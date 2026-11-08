(define (problem task-98d2608-3)
  (:domain appworld-98d2608-3)
  (:objects
    kristin husband - person
    kri-powe-at-gmail-com phone-number-6017026518 - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    husband-email - email
    husband-rel - relationship
    substring-birth - query
    birth-certificate-path - file-path
    birth-certificate - document
    subject-birth-certificate - subject
    body-birth-certificate - body
    email-to-husband - email-message)
  (:init
    (username-for phone phone-number-6017026518)
    (username-for file-system kri-powe-at-gmail-com)
    (username-for gmail kri-powe-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (relationship-of husband husband-rel)
    (contact-email husband husband-email)
    (query-for birth-certificate substring-birth)
    (file-of birth-certificate birth-certificate-path))
  (:goal (and
    (email-sent email-to-husband husband birth-certificate)
    (task-completed)))
)
