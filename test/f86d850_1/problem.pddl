(define (problem task-f86d850-1)
  (:domain appworld-f86d850-1)
  (:objects
    troy debra - person
    tr-solo-at-gmail-com phone-7273731063 - username
    password-phone password-amazon password-gmail password-venmo - password
    token-phone token-amazon token-gmail token-venmo - token
    email-of-debra - email
    query-debra query-sullivans-ceramic-vase-set query-amazon-order-confirmation - query
    sullivans-ceramic-vase-set - product
    card-troy - payment-card
    address-troy - address
    order-new - order
    amount-order-total - amount
    thread-order-confirmation - email-thread
    email-order-confirmation - email-msg
    note-for-amazon-order - description
    flag-true - flag
  )
  (:init
    (credential-of-app phone phone-7273731063)
    (credential-of-app phone password-phone)
    (credential-of-app phone token-phone)
    (credential-of-app amazon tr-solo-at-gmail-com)
    (credential-of-app amazon password-amazon)
    (credential-of-app amazon token-amazon)
    (credential-of-app gmail tr-solo-at-gmail-com)
    (credential-of-app gmail password-gmail)
    (credential-of-app gmail token-gmail)
    (credential-of-app venmo tr-solo-at-gmail-com)
    (credential-of-app venmo password-venmo)
    (credential-of-app venmo token-venmo)
    (username-for phone phone-7273731063)
    (username-for amazon tr-solo-at-gmail-com)
    (username-for gmail tr-solo-at-gmail-com)
    (username-for venmo tr-solo-at-gmail-com)
    (password-for phone password-phone)
    (password-for amazon password-amazon)
    (password-for gmail password-gmail)
    (password-for venmo password-venmo)
    (requester debra)
    (contact-query debra query-debra)
    (email-of debra email-of-debra)
    (wanted-product sullivans-ceramic-vase-set)
    (product-query sullivans-ceramic-vase-set query-sullivans-ceramic-vase-set)
    (total-of order-new amount-order-total)
    (confirmation-query query-amazon-order-confirmation)
    (confirmation-thread thread-order-confirmation order-new)
    (email-in-thread email-order-confirmation thread-order-confirmation)
    (wanted-note note-for-amazon-order)
  )
  (:goal (and
    (order-placed order-new)
    (order-contains order-new sullivans-ceramic-vase-set)
    (confirmation-forwarded order-new debra)
    (payment-requested debra order-new amount-order-total note-for-amazon-order)
    (task-completed)
  ))
)
