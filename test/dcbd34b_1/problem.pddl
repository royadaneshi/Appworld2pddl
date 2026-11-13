(define (problem task-dcbd34b-1)
  (:domain appworld-dcbd34b-1)
  (:objects
    eric - person
    eric-bailey-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-expense - query
    expense-request-thread - thread
    reimbursements-csv - file-path
    reimbursements-csv-content - content
  )
  (:init
    (username-for gmail eric-bailey-at-gmail-com)
    (username-for file-system eric-bailey-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (expense-query query-expense)
    (content-for reimbursements-csv-content reimbursements-csv)
    (expense-thread expense-request-thread))
  (:goal (and (file-updated reimbursements-csv reimbursements-csv-content) (task-completed))))
