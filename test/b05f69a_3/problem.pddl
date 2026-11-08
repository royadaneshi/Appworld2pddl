(define (problem task-b05f69a-3)
  (:domain appworld-b05f69a-3)
  (:objects
    hunter-weaver - person
    hun-weaver-at-gmail-com - username
    amazon-password file-system-password - password
    amazon-token file-system-token - token
    order-1 order-2 order-3 - order
    receipt-file-order-1 receipt-file-order-2 receipt-file-order-3 - filepath
    dir-bills-amazon-purchases - dirpath)
  (:init
    (password-for amazon amazon-password)
    (password-for file-system file-system-password)
    (token-for amazon amazon-token)
    (token-for file-system file-system-token)
    (receipt-path order-1 receipt-file-order-1)
    (receipt-path order-2 receipt-file-order-2)
    (receipt-path order-3 receipt-file-order-3)
    (in-directory receipt-file-order-1 dir-bills-amazon-purchases)
    (in-directory receipt-file-order-2 dir-bills-amazon-purchases)
    (in-directory receipt-file-order-3 dir-bills-amazon-purchases))
  (:goal (and
    (receipt-downloaded order-1)
    (receipt-downloaded order-2)
    (receipt-downloaded order-3)
    (task-completed)))
)
