(define (domain appworld-f86d850-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount description flag - object
    entity - object
    product payment-card address order email-thread email-msg - entity
  )
  (:constants phone amazon gmail venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (requester ?p - person)
    (contact-query ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (wanted-product ?pr - product)
    (product-query ?pr - product ?q - query)
    (known-id ?x - entity)
    (in-cart ?pr - product)
    (order-placed ?o - order)
    (order-contains ?o - order ?pr - product)
    (total-of ?o - order ?amt - amount)
    (known-total ?o - order ?amt - amount)
    (confirmation-query ?q - query)
    (confirmation-thread ?th - email-thread ?o - order)
    (email-in-thread ?em - email-msg ?th - email-thread)
    (confirmation-forwarded ?o - order ?p - person)
    (wanted-note ?d - description)
    (payment-requested ?p - person ?o - order ?amt - amount ?d - description)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pr - product)
    :precondition (and (product-query ?pr ?q) (not (task-completed)))
    :effect (and (known-id ?pr))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token ?clear - flag)
    :precondition (and (has-token amazon ?t) (known-id ?pr) (not (in-cart ?pr)) (not (task-completed)))
    :effect (and (in-cart ?pr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?ad))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?pr - product ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?pr) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-contains ?o ?pr) (known-id ?o) (not (in-cart ?pr)))
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-placed ?o) (total-of ?o ?amt) (not (task-completed)))
    :effect (and (known-total ?o ?amt))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread ?o - order)
    :precondition (and (has-token gmail ?t) (confirmation-query ?q) (order-placed ?o) (confirmation-thread ?th ?o) (not (task-completed)))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?em - email-msg)
    :precondition (and (has-token gmail ?t) (known-id ?th) (email-in-thread ?em ?th) (not (task-completed)))
    :effect (and (known-id ?em))
  )

  ; API: gmail.forward_email_from_thread
  (:action gmail-forward-email-from-thread
    :parameters (?th - email-thread ?em - email-msg ?e - email ?t - token ?p - person ?o - order)
    :precondition (and (has-token gmail ?t) (known-id ?th) (known-id ?em) (email-in-thread ?em ?th) (confirmation-thread ?th ?o) (known-email ?p ?e) (not (confirmation-forwarded ?o ?p)) (not (task-completed)))
    :effect (and (confirmation-forwarded ?o ?p))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person ?o - order)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-total ?o ?amt) (not (payment-requested ?p ?o ?amt ?d)) (not (task-completed)))
    :effect (and (payment-requested ?p ?o ?amt ?d))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?pr - product ?p - person ?amt - amount ?d - description)
    :precondition (and (wanted-product ?pr) (requester ?p) (wanted-note ?d) (order-placed ?o) (order-contains ?o ?pr) (confirmation-forwarded ?o ?p) (payment-requested ?p ?o ?amt ?d) (not (task-completed)))
    :effect (and (task-completed))
  )
)
