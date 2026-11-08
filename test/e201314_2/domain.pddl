(define (domain appworld-e201314-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship product-type rating review-count deadline product quantity flag address payment-card - object
  )
  (:constants phone amazon supervisor - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (invitee-relation ?r - relationship)
    (contacts-found ?r - relationship)
    (invitee-quantity ?q - quantity ?r1 - relationship ?r2 - relationship)
    (required-product-type ?pt - product-type)
    (required-min-rating ?r - rating)
    (required-min-reviews ?n - review-count)
    (delivery-deadline ?d - deadline)
    (true-flag ?f - flag)
    (home-address ?a - address)
    (known-id ?x - object)
    (product-matches ?p - product)
    (product-verified ?p - product)
    (in-cart ?p - product ?q - quantity)
    (order-placed ?p - product ?q - quantity ?a - address)
    (gifts-ordered)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (invitee-relation ?r) (not (task-completed)))
    :effect (contacts-found ?r)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?r - rating ?p - product)
    :precondition (and (required-product-type ?pt) (required-min-rating ?r) (not (task-completed)))
    :effect (and (known-id ?p) (product-matches ?p))
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product ?n - review-count ?d - deadline)
    :precondition (and (known-id ?p) (product-matches ?p) (required-min-reviews ?n) (delivery-deadline ?d) (not (task-completed)))
    :effect (product-verified ?p)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?f - flag ?r1 - relationship ?r2 - relationship)
    :precondition (and (has-token amazon ?t) (known-id ?p) (product-matches ?p) (product-verified ?p) (true-flag ?f) (invitee-quantity ?q ?r1 ?r2) (contacts-found ?r1) (contacts-found ?r2) (not (task-completed)))
    :effect (in-cart ?p ?q)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (home-address ?a) (not (task-completed)))
    :effect (known-id ?a)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (home-address ?a) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (order-placed ?p ?q ?a) (gifts-ordered) (not (in-cart ?p ?q)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (gifts-ordered) (not (task-completed)))
    :effect (task-completed)
  )
)
