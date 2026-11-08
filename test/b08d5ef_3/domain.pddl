(define (domain appworld-b08d5ef-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship home product card quantity address-name street city state country zip-code - object)
  (:constants
    supervisor phone amazon - app
    sibling parent - relationship)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (relatives-found ?r - relationship)
    (search-query ?q - query ?p - product)
    (known-id ?x)
    (home-name ?h - home ?n - address-name)
    (home-street ?h - home ?s - street)
    (home-city ?h - home ?c - city)
    (home-state ?h - home ?st - state)
    (home-country ?h - home ?co - country)
    (home-zip ?h - home ?z - zip-code)
    (household-size ?h - home ?q - quantity)
    (address-added ?h - home)
    (cart-dirty)
    (cart-empty)
    (cart-holds ?p - product ?q - quantity ?h - home)
    (ordered ?h - home ?p - product)
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
    :precondition (and (has-token phone ?t) (not (relatives-found ?r)) (not (task-completed)))
    :effect (and (relatives-found ?r)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (search-query ?q ?p) (not (known-id ?p)) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token amazon ?t) (not (known-id ?c)) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (cart-dirty) (not (task-completed)))
    :effect (and (not (cart-dirty)) (cart-empty)))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?s - street ?c - city ?st - state ?co - country ?z - zip-code ?t - token ?h - home)
    :precondition (and (has-token amazon ?t) (relatives-found sibling) (relatives-found parent) (home-name ?h ?n) (home-street ?h ?s) (home-city ?h ?c) (home-state ?h ?st) (home-country ?h ?co) (home-zip ?h ?z) (not (address-added ?h)) (not (task-completed)))
    :effect (and (address-added ?h)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?h - home)
    :precondition (and (has-token amazon ?t) (known-id ?p) (cart-empty) (relatives-found sibling) (relatives-found parent) (household-size ?h ?q) (not (ordered ?h ?p)) (not (task-completed)))
    :effect (and (not (cart-empty)) (cart-holds ?p ?q ?h)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - card ?h - home ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (address-added ?h) (cart-holds ?p ?q ?h) (not (task-completed)))
    :effect (and (ordered ?h ?p) (not (cart-holds ?p ?q ?h)) (cart-empty)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - product ?h1 - home ?h2 - home)
    :precondition (and (ordered ?h1 ?p) (ordered ?h2 ?p) (not (= ?h1 ?h2)) (not (task-completed)))
    :effect (and (task-completed)))
)
