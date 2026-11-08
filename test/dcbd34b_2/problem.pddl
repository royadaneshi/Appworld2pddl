(define (problem task-dcbd34b-2)
  (:domain appworld-dcbd34b-2)
  (:objects
    katie-simpson - person
    kat-simp-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-expense - query
    expense-request-thread - thread
    expense-file - file-path
    content-expense-rows - content)
  (:init
    (username-for gmail kat-simp-at-gmail-com)
    (username-for file-system kat-simp-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (thread-matches expense-request-thread query-expense)
    (expense-thread expense-request-thread)
    (expense-content content-expense-rows))
  (:goal (and (file-updated expense-file content-expense-rows) (task-completed)))
)
