(define (problem task-dcbd34b-1)
  (:domain appworld-dcbd34b-1)
  (:objects
    eric coworker-1 coworker-2 coworker-3 - person
    eric-bailey-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-expense - query
    thread-coworker-1 thread-coworker-2 thread-coworker-3 - thread
    reimbursements-csv - file-path
    reimbursements-csv-content - content
    n0 n1 n2 n3 - count)
  (:init
    (username-for gmail eric-bailey-at-gmail-com)
    (username-for file-system eric-bailey-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (coworker coworker-1)
    (coworker coworker-2)
    (coworker coworker-3)
    (expense-query query-expense)
    (thread-from thread-coworker-1 coworker-1)
    (thread-from thread-coworker-2 coworker-2)
    (thread-from thread-coworker-3 coworker-3)
    (succ n0 n1)
    (succ n1 n2)
    (succ n2 n3)
    (collected-count n0)
    (num-coworkers n3)
    (content-for reimbursements-csv-content reimbursements-csv))
  (:goal (and (file-updated reimbursements-csv reimbursements-csv-content) (task-completed))))
