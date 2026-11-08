(define (domain appworld-e201314-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship product-type rating product quantity flag address payment-card - object)
  (:constants
    supervisor phone amazon - app
    friends roommates - relationship)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (found-contacts ?r - relationship)
    (invitee-count ?q - quantity)
    (target-product-type ?pt - product-type)
    (required-min-rating ?r - rating)
    (found-product ?p - product)
    (product-verified ?p - product)
    (true-flag ?f - flag)
    (in-cart ?p - product ?q - quantity)
    (addresses-known)
    (is-home-address ?a - address)
    (payment-cards-known)
    (ordered ?p - product ?q - quantity ?a - address)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (found-contacts ?r)) (not (task-completed)))
    :effect (and (found-contacts ?r)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?minr - rating ?p - product)
    :precondition (and (target-product-type ?pt) (required-min-rating ?minr) (not (found-product ?p)) (not (task-completed)))
    :effect (and (found-product ?p)))

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (found-product ?p) (not (product-verified ?p)) (not (task-completed)))
    :effect (and (product-verified ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?clear - flag)
    :precondition (and (has-token amazon ?t) (product-verified ?p) (found-contacts friends) (found-contacts roommates) (invitee-count ?q) (true-flag ?clear) (not (in-cart ?p ?q)) (not (task-completed)))
    :effect (and (in-cart ?p ?q)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (addresses-known)) (not (task-completed)))
    :effect (and (addresses-known)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (payment-cards-known)) (not (task-completed)))
    :effect (and (payment-cards-known)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (payment-cards-known) (addresses-known) (is-home-address ?a) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q ?a) (not (in-cart ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity ?a - address)
    :precondition (and (ordered ?p ?q ?a) (not (task-completed)))
    :effect (and (task-completed))))
