(define (domain appworld-20c1328-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query product-type price sort-key relationship quantity flag product address payment-card - object)
  (:constants supervisor amazon phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - object)
    (is-roommates ?r - relationship)
    (count-result ?r - relationship ?q - quantity)
    (known-roommate-count ?q - quantity)
    (search-spec ?q - query ?pt - product-type ?minp - price ?maxp - price ?sb - sort-key)
    (search-result ?p - product)
    (found-highest-rated ?p - product)
    (clear-first ?f - flag)
    (in-cart ?p - product ?q - quantity)
    (home-address-text-known)
    (is-home ?a - address)
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
    :parameters (?t - token ?r - relationship ?q - quantity)
    :precondition (and (has-token phone ?t) (is-roommates ?r) (count-result ?r ?q) (not (task-completed)))
    :effect (and (known-roommate-count ?q)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?pt - product-type ?minp - price ?maxp - price ?sb - sort-key ?p - product)
    :precondition (and (search-spec ?q ?pt ?minp ?maxp ?sb) (search-result ?p) (not (task-completed)))
    :effect (and (known-id ?p) (found-highest-rated ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?cf - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (found-highest-rated ?p) (known-roommate-count ?q) (clear-first ?cf) (not (task-completed)))
    :effect (and (in-cart ?p ?q)))

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (home-address-text-known)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (home-address-text-known) (is-home ?a) (not (task-completed)))
    :effect (and (known-id ?a)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home ?a) (in-cart ?p ?q) (not (task-completed)))
    :effect (and (ordered ?p ?q ?a) (not (in-cart ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?q - quantity ?a - address)
    :precondition (and (ordered ?p ?q ?a) (found-highest-rated ?p) (known-roommate-count ?q) (is-home ?a) (not (task-completed)))
    :effect (and (task-completed)))
)
