(define (domain appworld-f86d850-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query product quantity
    payment-card address order amount note email-thread email-message - object
  )
  (:constants supervisor amazon gmail venmo phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (contact-query ?q - query ?p - person)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (product-query ?q - query ?pr - product)
    (known-id ?x - object)
    (in-cart ?pr - product)
    (order-placed ?o - order)
    (ordered ?pr - product)
    (order-total ?o - order ?amt - amount)
    (known-amount ?amt - amount)
    (email-query ?q - query ?th - email-thread)
    (confirmation-thread-of ?o - order ?th - email-thread)
    (email-in-thread ?th - email-thread ?em - email-message)
    (forwarded ?em - email-message ?p - person)
    (payment-requested ?p - person ?amt - amount ?n - note)
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
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?q ?p) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pr - product)
    :precondition (and (product-query ?q ?pr) (not (task-completed)))
    :effect (and (known-id ?pr))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token ?qty - quantity)
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
    :parameters (?c - payment-card ?ad - address ?t - token ?o - order ?pr - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?pr)
                       (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (ordered ?pr) (known-id ?o) (not (in-cart ?pr)))
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-placed ?o) (order-total ?o ?amt) (not (task-completed)))
    :effect (and (known-amount ?amt))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread ?o - order)
    :precondition (and (has-token gmail ?t) (email-query ?q ?th) (confirmation-thread-of ?o ?th)
                       (order-placed ?o) (not (task-completed)))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?em - email-message)
    :precondition (and (has-token gmail ?t) (known-id ?th) (email-in-thread ?th ?em) (not (task-completed)))
    :effect (and (known-id ?em))
  )

  ; API: gmail.forward_email_from_thread
  (:action gmail-forward-email-from-thread
    :parameters (?th - email-thread ?em - email-message ?e - email ?t - token ?p - person)
    :precondition (and (has-token gmail ?t) (known-id ?th) (known-id ?em) (email-in-thread ?th ?em)
                       (known-email ?p ?e) (not (task-completed)))
    :effect (and (forwarded ?em ?p))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-amount ?amt) (not (task-completed)))
    :effect (and (payment-requested ?p ?amt ?n))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?pr - product ?em - email-message ?p - person ?amt - amount ?n - note)
    :precondition (and (order-placed ?o) (ordered ?pr) (order-total ?o ?amt) (forwarded ?em ?p)
                       (payment-requested ?p ?amt ?n) (not (task-completed)))
    :effect (and (task-completed))
  )
)
