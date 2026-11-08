(define (domain appworld-b6d1f70-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship product-type rating quantity bool addr-name street city state country zipcode product order wrap-status amazon-record - object
    address payment-card - amazon-record
  )
  (:constants
    supervisor amazon phone - app
    wrapped unwrapped - wrap-status
  )
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - amazon-record)
    (relationship-of ?p - person ?r - relationship)
    (known-contact-address ?p - person)
    (home-address-of ?p - person ?a - address)
    (address-details ?a - address ?n - addr-name ?s - street ?c - city ?st - state ?co - country ?z - zipcode)
    (amazon-stored-address ?a - address)
    (search-criteria ?pt - product-type ?r - rating)
    (found-product ?p - product)
    (product-verified ?p - product)
    (in-cart ?p - product)
    (cart-wrap ?p - product ?w - wrap-status)
    (order-placed ?o - order)
    (order-product ?o - order ?p - product)
    (order-address ?o - order ?a - address)
    (order-wrap ?o - order ?w - wrap-status)
    (deliver-wrapped ?o - order ?a - address)
    (deliver-plain ?o - order ?a - address)
    (task-completed)
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
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship ?p - person)
    :precondition (and (has-token phone ?t) (relationship-of ?p ?rel) (not (task-completed)))
    :effect (known-contact-address ?p)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?r - rating ?p - product)
    :precondition (and (search-criteria ?pt ?r) (not (task-completed)))
    :effect (found-product ?p)
  )

  ; API: amazon.show_product
  (:action amazon-show-product
    :parameters (?p - product)
    :precondition (and (found-product ?p) (not (task-completed)))
    :effect (product-verified ?p)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (amazon-stored-address ?a) (not (task-completed)))
    :effect (known-id ?a)
  )

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - addr-name ?s - street ?c - city ?st - state ?co - country ?z - zipcode ?t - token ?p - person ?a - address)
    :precondition (and (has-token amazon ?t) (known-contact-address ?p) (home-address-of ?p ?a) (address-details ?a ?n ?s ?c ?st ?co ?z) (not (known-id ?a)) (not (task-completed)))
    :effect (known-id ?a)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?clear - bool)
    :precondition (and (has-token amazon ?t) (product-verified ?p) (not (in-cart ?p)) (not (task-completed)))
    :effect (and (in-cart ?p) (cart-wrap ?p unwrapped) (not (cart-wrap ?p wrapped)))
  )

  ; API: amazon.add_gift_wrapping_to_product
  (:action amazon-add-gift-wrapping-to-product
    :parameters (?p - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (in-cart ?p) (cart-wrap ?p unwrapped) (not (task-completed)))
    :effect (and (cart-wrap ?p wrapped) (not (cart-wrap ?p unwrapped)))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?p - product ?w - wrap-status ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (in-cart ?p) (cart-wrap ?p ?w) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (order-product ?o ?p) (order-address ?o ?a) (order-wrap ?o ?w) (not (in-cart ?p)) (not (cart-wrap ?p ?w)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?og - order ?ag - address ?oh - order ?ah - address ?p - product)
    :precondition (and (deliver-wrapped ?og ?ag) (deliver-plain ?oh ?ah)
      (order-placed ?og) (order-product ?og ?p) (order-address ?og ?ag) (order-wrap ?og wrapped)
      (order-placed ?oh) (order-product ?oh ?p) (order-address ?oh ?ah) (order-wrap ?oh unwrapped)
      (not (task-completed)))
    :effect (task-completed)
  )
)
