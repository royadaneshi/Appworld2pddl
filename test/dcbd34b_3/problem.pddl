(define (problem task-dcbd34b-3)
  (:domain appworld-dcbd34b-3)
  (:objects
    brandon - person
    brandon-webe-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-expense - query
    company-trip-expense-thread - email-thread
    company-trip-expenses-csv - file
    expenses-csv-content - content)
  (:init
    (credential-of-app gmail brandon-webe-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system brandon-webe-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password))
  (:goal (and
    (file-filled company-trip-expenses-csv expenses-csv-content)
    (task-completed)))
)
