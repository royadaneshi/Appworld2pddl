(define (domain appworld-f86d850-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email note amount entity - object
    product payment-card address order email-thread email-msg - entity
  )
  (:constants supervisor amazon gmail venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (known-id ?x - entity)
    (product-query ?q - query ?p - product)
    (person-query ?q - query ?p - person)
    (confirmation-query ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (cart-cleared)
    (in-cart ?p - product)
    (order-placed ?o - order ?p - product)
    (order-total ?o - order ?amt - amount)
    (found-thread ?th - email-thread ?o - order)
    (email-in-thread ?em - email-msg ?th - email-thread)
    (forwarded ?o - order ?p - person)
    (payment-requested ?p - person ?o - order ?n - note)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (product-query ?q ?p) (not (task-completed)))
    :effect (known-id ?p)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-cleared) (not (task-completed)))
    :effect (in-cart ?p)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?ad)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?o - order ?p - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?p)
                       (not (known-id ?o)) (not (task-completed)))
    :effect (and (order-placed ?o ?p) (known-id ?o) (not (in-cart ?p)))
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (not (task-completed)))
    :effect (order-total ?o ?amt)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread ?o - order)
    :precondition (and (has-token gmail ?t) (confirmation-query ?q) (known-id ?o) (not (task-completed)))
    :effect (and (found-thread ?th ?o) (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?em - email-msg)
    :precondition (and (has-token gmail ?t) (known-id ?th) (not (task-completed)))
    :effect (and (email-in-thread ?em ?th) (known-id ?em))
  )

  ; API: gmail.forward_email_from_thread
  (:action gmail-forward-email-from-thread
    :parameters (?th - email-thread ?em - email-msg ?e - email ?t - token ?o - order ?p - person)
    :precondition (and (has-token gmail ?t) (found-thread ?th ?o) (email-in-thread ?em ?th)
                       (known-email ?p ?e) (not (task-completed)))
    :effect (forwarded ?o ?p)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token venmo ?t) (person-query ?q ?p) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e)
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?p - person ?o - order)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (order-total ?o ?amt)
                       (not (payment-requested ?p ?o ?n)) (not (task-completed)))
    :effect (payment-requested ?p ?o ?n)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?fr - person ?n - note)
    :precondition (and (order-placed ?o ?p) (forwarded ?o ?fr) (payment-requested ?fr ?o ?n)
                       (not (task-completed)))
    :effect (task-completed)
  )
)
