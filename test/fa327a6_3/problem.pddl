(define (problem task-fa327a6-3)
  (:domain appworld-fa327a6-3)
  (:objects
    sabrina valerie - person
    username-6639773608 sab-brown-at-gmail-com - username
    phone-password amazon-password venmo-password - password
    phone-token amazon-token venmo-token - token
    query-valerie - query
    valerie-email - email
    order-1 order-2 order-3 order-4 - order
    c0 c1 c2 c3 c4 - count
    amount-difference - amount
    note-adjusting-amazon-payment - note)
  (:init
    ; credentials (values obtained at runtime)
    (username-for phone username-6639773608)
    (username-for amazon sab-brown-at-gmail-com)
    (username-for venmo sab-brown-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (password-for venmo venmo-password)
    (token-for phone phone-token)
    (token-for amazon amazon-token)
    (token-for venmo venmo-token)
    ; friend lookup
    (search-query-for valerie query-valerie)
    (email-of valerie valerie-email)
    ; the last four amazon orders (ids discovered via show_orders)
    (recent-order order-1)
    (recent-order order-2)
    (recent-order order-3)
    (recent-order order-4)
    (orders-checked c0)
    (next-count c0 c1)
    (next-count c1 c2)
    (next-count c2 c3)
    (next-count c3 c4)
    (required-order-count c4)
    ; adjustment record
    (difference-amount valerie amount-difference)
    (adjustment-note note-adjusting-amazon-payment)
    ; assumed outcome of the runtime comparison: Valerie sent less than the orders total,
    ; so the difference must be requested; replace with (overpaid valerie) to send instead
    (underpaid valerie))
  (:goal (and
    (difference-settled valerie amount-difference note-adjusting-amazon-payment)
    (task-completed))))
