(define (domain appworld-1a79e37-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship datetime thread
    product-type price sort-key product quantity flag
    address address-name street city state country zip payment-card - object)
  (:constants supervisor phone gmail amazon - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (relation-of ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (work-address-of ?p - person ?ad - address)
    (known-email ?p - person ?e - email)
    (known-address ?ad - address)
    (thread-from ?th - thread ?e - email)
    (thread-requests ?th - thread ?pt - product-type ?mp - price)
    (requirements-known ?pt - product-type ?mp - price)
    (best-match ?pr - product ?pt - product-type ?mp - price)
    (known-id ?x - object)
    (in-cart ?pr - product)
    (address-fields ?ad - address ?n - address-name ?st - street ?c - city ?s - state ?co - country ?z - zip)
    (address-added ?ad - address)
    (order-placed ?pr - product ?ad - address)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship ?p - person ?e - email ?ad - address)
    :precondition (and (has-token phone ?t) (relation-of ?p ?rel) (email-of ?p ?e) (work-address-of ?p ?ad) (not (task-completed)))
    :effect (and (known-email ?p ?e) (known-address ?ad))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?from - email ?since - datetime ?p - person ?th - thread)
    :precondition (and (has-token gmail ?t) (known-email ?p ?from) (thread-from ?th ?from) (not (task-completed)))
    :effect (known-id ?th)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - thread ?t - token ?pt - product-type ?mp - price)
    :precondition (and (has-token gmail ?t) (known-id ?th) (thread-requests ?th ?pt ?mp) (not (task-completed)))
    :effect (requirements-known ?pt ?mp)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?mp - price ?sb - sort-key ?pr - product)
    :precondition (and (requirements-known ?pt ?mp) (best-match ?pr ?pt ?mp) (not (task-completed)))
    :effect (known-id ?pr)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?pr - product ?t - token ?q - quantity ?cf - flag)
    :precondition (and (has-token amazon ?t) (known-id ?pr) (not (in-cart ?pr)) (not (task-completed)))
    :effect (in-cart ?pr)
  )

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?st - street ?c - city ?s - state ?co - country ?z - zip ?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (known-address ?ad) (address-fields ?ad ?n ?st ?c ?s ?co ?z) (not (address-added ?ad)) (not (task-completed)))
    :effect (and (address-added ?ad) (known-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?pr - product)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (address-added ?ad) (in-cart ?pr) (not (task-completed)))
    :effect (and (order-placed ?pr ?ad) (not (in-cart ?pr)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?pr - product ?ad - address)
    :precondition (and (order-placed ?pr ?ad) (not (task-completed)))
    :effect (task-completed)
  )
)
