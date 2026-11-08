(define (problem task-b05f69a-1)
  (:domain appworld-b05f69a-1)
  (:objects
    sabrina-brown - person
    sab-brown-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-amazon - query
    confirmation-email-1 confirmation-email-2 - email-msg
    receipt-attachment-1 receipt-attachment-2 - attachment
    amazon-order-1 amazon-order-2 - order
    receipt-path-1 receipt-path-2 - file-path)
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (confirmation-query query-amazon)
    (confirmation-email-of confirmation-email-1 amazon-order-1)
    (confirmation-email-of confirmation-email-2 amazon-order-2)
    (receipt-attachment-of receipt-attachment-1 amazon-order-1)
    (receipt-attachment-of receipt-attachment-2 amazon-order-2)
    (receipt-path-for receipt-path-1 amazon-order-1)
    (receipt-path-for receipt-path-2 amazon-order-2))
  (:goal (and
    (receipt-saved amazon-order-1)
    (receipt-saved amazon-order-2)
    (task-completed)))
)
