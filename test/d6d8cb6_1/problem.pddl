(define (problem task-d6d8cb6-1)
  (:domain appworld-d6d8cb6-1)
  (:objects
    timothy aaron - person
    timothy-whit-at-gmail-com phone-9465999623 - username
    amazon-password gmail-password phone-password - password
    amazon-token gmail-token phone-token - token
    query-room-essentials-stick-table-lamp query-aaron query-return-confirmation - query
    lamp-order - order
    stick-table-lamp - product
    ups - deliverer
    quantity-1 - quantity
    aaron-email - email
    return-confirmation-thread - email-thread
    return-confirmation-email - email-message)
  (:init
    (credential-of-app amazon timothy-whit-at-gmail-com)
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app phone phone-9465999623)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app gmail timothy-whit-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (username-for amazon timothy-whit-at-gmail-com)
    (username-for gmail timothy-whit-at-gmail-com)
    (username-for phone phone-9465999623)
    (password-for amazon amazon-password)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (order-query query-room-essentials-stick-table-lamp lamp-order)
    (order-contains lamp-order stick-table-lamp)
    (confirmation-thread-of lamp-order return-confirmation-thread)
    (thread-query query-return-confirmation return-confirmation-thread)
    (thread-contains return-confirmation-thread return-confirmation-email)
    (contact-query query-aaron aaron)
    (contact-email aaron aaron-email))
  (:goal (and
    (return-initiated lamp-order stick-table-lamp ups quantity-1)
    (forwarded return-confirmation-email aaron-email)
    (task-completed))))
