(define (problem task-b05f69a-2)
  (:domain appworld-b05f69a-2)
  (:objects
    nicholas-weber - person
    nicholas-weber-at-gmail-com - username
    amazon-password file-system-password - password
    amazon-token file-system-token - token
    receipt-path-order-1 receipt-path-order-2 receipt-path-order-3 - file-path
    dir-bills-shopping-amazon - dir-path
    flag-true - flag)
  (:init
    (password-for amazon amazon-password)
    (password-for file-system file-system-password)
    (supervisor-order order-1)
    (supervisor-order order-2)
    (supervisor-order order-3)
    (receipt-path order-1 receipt-path-order-1)
    (receipt-path order-2 receipt-path-order-2)
    (receipt-path order-3 receipt-path-order-3)
    (path-in-directory receipt-path-order-1 dir-bills-shopping-amazon)
    (path-in-directory receipt-path-order-2 dir-bills-shopping-amazon)
    (path-in-directory receipt-path-order-3 dir-bills-shopping-amazon)
    (target-directory dir-bills-shopping-amazon))
  (:goal (and
    (receipt-downloaded order-1)
    (receipt-downloaded order-2)
    (receipt-downloaded order-3)
    (task-completed)))
)
