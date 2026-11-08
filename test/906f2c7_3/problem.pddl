(define (problem task-906f2c7-3)
  (:domain appworld-906f2c7-3)
  (:objects
    marcus cody - person
    username-7196131136 username-ma-smith-at-gmail-com - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    query-cody - query
    cody-phone-number - phone-number
    cody-email - email
    vacation-pictures-directory - directory
    vacation-pictures-file - file-path
    subject-vacation-pictures - subject
    body-vacation-pictures - body)
  (:init
    (username-for phone username-7196131136)
    (username-for file-system username-ma-smith-at-gmail-com)
    (username-for gmail username-ma-smith-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (contact-query cody query-cody)
    (phone-of cody cody-phone-number)
    (email-of cody cody-email)
    (requested-directory cody vacation-pictures-directory)
    (file-in-directory vacation-pictures-file vacation-pictures-directory))
  (:goal (and (email-sent cody vacation-pictures-file) (task-completed))))
