(define (domain appworld-1a79e37-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship datetime
    email-thread product-type price sort-key product quantity flag
    work-address address-name street city state country zipcode
    address payment-card order - object)
  (:constants supervisor phone gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (known-id ?x)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (work-address-of ?p - person ?wa - work-address)
    (address-components ?wa - work-address ?n - address-name ?s - street ?c - city ?st - state ?co - country ?z - zipcode)
    (known-email ?p - person ?e - email)
    (known-work-address ?p - person ?wa - work-address)
    (today ?d - datetime)
    (thread-from ?th - email-thread ?p - person)
    (request-in-thread ?th - email-thread ?pt - product-type ?mp - price)
    (found-product-type ?pt - product-type)
    (found-max-price ?mp - price)
    (sorts-by-rating-desc ?sk - sort-key)
    (matches-request ?prod - product ?pt - product-type ?mp - price)
    (found-product ?prod - product)
    (quantity-one ?q - quantity)
    (is-true ?f - flag)
    (in-cart ?prod - product ?q - quantity)
    (amazon-address-for ?addr - address ?wa - work-address)
    (address-added ?addr - address ?wa - work-address)
    (order-placed ?o - order ?prod - product ?q - quantity ?addr - address)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email ?wa - work-address)
    :precondition (and (not (task-completed)) (has-token phone ?t) (has-relationship ?p ?r) (email-of ?p ?e) (work-address-of ?p ?wa))
    :effect (and (known-email ?p ?e) (known-work-address ?p ?wa))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?e - email ?d - datetime ?th - email-thread ?p - person)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-email ?p ?e) (today ?d) (thread-from ?th ?p))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?pt - product-type ?mp - price)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th) (request-in-thread ?th ?pt ?mp))
    :effect (and (found-product-type ?pt) (found-max-price ?mp))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?mp - price ?sk - sort-key ?prod - product)
    :precondition (and (not (task-completed)) (found-product-type ?pt) (found-max-price ?mp) (sorts-by-rating-desc ?sk) (matches-request ?prod ?pt ?mp))
    :effect (and (found-product ?prod))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?q - quantity ?f - flag)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (found-product ?prod) (quantity-one ?q) (is-true ?f))
    :effect (and (in-cart ?prod ?q))
  )

  ; API: amazon.add_address
  (:action amazon-add-address
    :parameters (?n - address-name ?s - street ?c - city ?st - state ?co - country ?z - zipcode ?t - token ?p - person ?wa - work-address ?addr - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-work-address ?p ?wa) (address-components ?wa ?n ?s ?c ?st ?co ?z) (amazon-address-for ?addr ?wa) (not (address-added ?addr ?wa)))
    :effect (and (address-added ?addr ?wa) (known-id ?addr))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-id ?card))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?prod - product ?q - quantity ?wa - work-address ?o - order)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?card) (known-id ?addr) (address-added ?addr ?wa) (in-cart ?prod ?q))
    :effect (and (order-placed ?o ?prod ?q ?addr) (not (in-cart ?prod ?q)))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?prod - product ?q - quantity ?addr - address ?wa - work-address)
    :precondition (and (not (task-completed)) (order-placed ?o ?prod ?q ?addr) (address-added ?addr ?wa))
    :effect (and (task-completed))
  )
)
