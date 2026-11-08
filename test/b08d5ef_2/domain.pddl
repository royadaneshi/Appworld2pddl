(define (domain appworld-b08d5ef-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship product home
    addr-name street city state country zip-code payment-card quantity flag - object)
  (:constants
    supervisor phone amazon - app
    home-parents home-sibling-1 home-sibling-2 - home
    codenames-board-game - product)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (relationships-known)
    (contacts-found ?r - relationship)
    (home-of-relationship ?h - home ?r - relationship)
    (home-name ?h - home ?n - addr-name)
    (home-street ?h - home ?s - street)
    (home-city ?h - home ?c - city)
    (home-state ?h - home ?st - state)
    (home-country ?h - home ?co - country)
    (home-zip ?h - home ?z - zip-code)
    (needs-quantity ?h - home ?q - quantity)
    (search-query ?p - product ?q - query)
    (known-id ?x)
    (address-added ?h - home)
    (cart-loaded)
    (cart-has ?p - product ?q - quantity)
    (order-placed ?h - home ?p - product)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.show_contact_relationships
  (:action phone-show-contact-relationships
    :parameters (?t - token)
    :precondition (and (has-token phone ?t) (not (relationships-known)) (not (task-completed)))
    :effect (and (relationships-known)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (relationships-known) (not (contacts-found ?r)) (not (task-completed)))
    :effect (and (contacts-found ?r)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (search-query ?p ?q) (not (known-id ?p)) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (known-id ?c)) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - addr-name ?s - street ?c - city ?st - state ?co - country ?z - zip-code ?t - token ?h - home ?r - relationship)
    :precondition (and (has-token amazon ?t) (contacts-found ?r) (home-of-relationship ?h ?r)
                       (home-name ?h ?n) (home-street ?h ?s) (home-city ?h ?c) (home-state ?h ?st)
                       (home-country ?h ?co) (home-zip ?h ?z)
                       (not (address-added ?h)) (not (task-completed)))
    :effect (and (address-added ?h)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?cf - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (not (cart-loaded)) (not (task-completed)))
    :effect (and (cart-loaded) (cart-has ?p ?q)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?h - home ?t - token ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (address-added ?h)
                       (cart-loaded) (cart-has ?p ?q) (needs-quantity ?h ?q)
                       (not (order-placed ?h ?p)) (not (task-completed)))
    :effect (and (order-placed ?h ?p) (not (cart-loaded)) (not (cart-has ?p ?q))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed home-parents codenames-board-game)
                       (order-placed home-sibling-1 codenames-board-game)
                       (order-placed home-sibling-2 codenames-board-game)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
