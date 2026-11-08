(define (domain appworld-b08d5ef-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person relationship address quantity username password token query
    address-name street city state country zip-code identifiable - object
    product payment-card - identifiable)
  (:constants
    supervisor phone amazon - app
    hurom-hp-slow-juicer - product
    addr-parents-home addr-sibling-1-home addr-sibling-2-home - address)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (lives-at ?p - person ?addr - address)
    (searched-relationship ?r - relationship)
    (addr-has-name ?addr - address ?n - address-name)
    (addr-has-street ?addr - address ?s - street)
    (addr-has-city ?addr - address ?c - city)
    (addr-has-state ?addr - address ?s - state)
    (addr-has-country ?addr - address ?c - country)
    (addr-has-zip ?addr - address ?z - zip-code)
    (addr-has-quantity ?addr - address ?q - quantity)
    (address-added ?addr - address)
    (product-query ?prod - product ?q - query)
    (known-id ?x - identifiable)
    (cart-empty)
    (cart-staged)
    (cart-for ?addr - address ?prod - product ?q - quantity)
    (ordered ?addr - address ?prod - product)
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

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (searched-relationship ?r)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?prod - product)
    :precondition (and (product-query ?prod ?q) (not (task-completed)))
    :effect (and (known-id ?prod)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?card)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-empty)) (not (cart-staged)) (not (task-completed)))
    :effect (and (cart-empty)))

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?street - street ?city - city ?state - state ?country - country ?zip - zip-code ?t - token ?addr - address ?p - person ?r - relationship)
    :precondition (and (has-token amazon ?t) (searched-relationship ?r) (has-relationship ?p ?r) (lives-at ?p ?addr)
                       (addr-has-name ?addr ?n) (addr-has-street ?addr ?street) (addr-has-city ?addr ?city)
                       (addr-has-state ?addr ?state) (addr-has-country ?addr ?country) (addr-has-zip ?addr ?zip)
                       (not (address-added ?addr)) (not (task-completed)))
    :effect (and (address-added ?addr)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?q - quantity ?addr - address)
    :precondition (and (known-id ?prod) (has-token amazon ?t) (cart-empty) (address-added ?addr)
                       (addr-has-quantity ?addr ?q) (not (ordered ?addr ?prod)) (not (task-completed)))
    :effect (and (cart-for ?addr ?prod ?q) (cart-staged) (not (cart-empty))))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?prod - product ?q - quantity)
    :precondition (and (known-id ?card) (address-added ?addr) (has-token amazon ?t)
                       (cart-for ?addr ?prod ?q) (not (task-completed)))
    :effect (and (ordered ?addr ?prod) (not (cart-for ?addr ?prod ?q)) (not (cart-staged)) (cart-empty)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (ordered addr-parents-home hurom-hp-slow-juicer)
                       (ordered addr-sibling-1-home hurom-hp-slow-juicer)
                       (ordered addr-sibling-2-home hurom-hp-slow-juicer)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
