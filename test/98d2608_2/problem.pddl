(define (problem task-98d2608-2)
  (:domain appworld-98d2608-2)
  (:objects
    edwin-wilson manager - person
    phone-username-8506051563 ed-wilson-at-gmail-com - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    manager-email - email
    relationship-manager - relationship
    substring-headshot - substring
    true-flag - flag
    headshot-file-path - filepath
    subject-headshot - subject
    body-headshot - body)
  (:init
    (credential-of-app phone phone-username-8506051563)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app file-system ed-wilson-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app gmail ed-wilson-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (username-for phone phone-username-8506051563)
    (username-for file-system ed-wilson-at-gmail-com)
    (username-for gmail ed-wilson-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (has-relationship manager relationship-manager)
    (email-of manager manager-email)
    (file-matches substring-headshot headshot-file-path)
    (is-true true-flag))
  (:goal (and (email-sent manager headshot-file-path) (task-completed)))
)
