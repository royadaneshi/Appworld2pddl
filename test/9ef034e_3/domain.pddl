(define (domain appworld-9ef034e-3)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token query phone-number email file-path subject body amount quantity entity - object
    text-message product address payment-card order - entity
  )
  (:constants phone amazon file-system gmail venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (task-completed)
    (known-id ?x - entity)
    (contact-query ?q - query ?p - person)
    (phone-of ?p - person ?n - phone-number)
    (email-of ?p - person ?e - email)
    (known-phone ?p - person ?n - phone-number)
    (known-email ?p - person ?e - email)
    (message-from ?p - person ?m - text-message)
    (message-about ?m - text-message ?prod - product ?q - quantity)
    (message-read ?p - person ?m - text-message)
    (requested ?prod - product ?q - quantity)
    (in-cart ?prod - product ?q - quantity)
    (is-home-address ?addr - address)
    (order-placed ?o - order ?addr - address)
    (order-contains ?o - order ?prod - product ?q - quantity)
    (known-total ?o - order ?amt - amount)
    (receipt-downloaded ?o - order ?f - file-path)
    (receipt-emailed ?p - person ?o - order)
    (payment-requested ?p - person ?o - order ?amt - amount)
    (cart-cleared)
    (product-query ?prod - product ?qr - query))

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
    :parameters (?t - token ?q - query ?p - person ?n - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?q ?p) (phone-of ?p ?n) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-phone ?p ?n) (known-email ?p ?e))
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?m - text-message)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (message-from ?p ?m) (not (task-completed)))
    :effect (and (known-id ?m) (message-read ?p ?m))
  )


  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?qr - query ?prod - product ?q - quantity ?m - text-message ?p - person)
    :precondition (and (message-read ?p ?m) (message-about ?m ?prod ?q) (product-query ?prod ?qr) (not (task-completed)))
    :effect (and (known-id ?prod) (requested ?prod ?q))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (cart-cleared))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?prod - product ?t - token ?q - quantity)
    :precondition (and (has-token amazon ?t) (cart-cleared) (known-id ?prod) (requested ?prod ?q) (not (task-completed)))
    :effect (in-cart ?prod ?q)
  )


  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?addr) (not (task-completed)))
    :effect (known-id ?addr)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: amazon.place_order  (orders the whole cart: every requested product must be in it)
  (:action amazon-place-order
    :parameters (?c - payment-card ?addr - address ?t - token ?o - order)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?addr) (is-home-address ?addr)
                       (forall (?m - text-message ?prod - product ?q - quantity) (imply (message-about ?m ?prod ?q) (in-cart ?prod ?q)))
                       (not (known-id ?o)) (not (task-completed)))
    :effect (and (known-id ?o) (order-placed ?o ?addr)
                 (forall (?prod - product ?q - quantity) (when (in-cart ?prod ?q) (order-contains ?o ?prod ?q))))
  )


  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (known-id ?o) (not (task-completed)))
    :effect (known-total ?o ?amt)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: amazon.download_order_receipt
  (:action amazon-download-order-receipt
    :parameters (?o - order ?t - token ?f - file-path ?ft - token)
    :precondition (and (has-token amazon ?t) (has-token file-system ?ft) (known-id ?o) (not (task-completed)))
    :effect (receipt-downloaded ?o ?f)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.send_email
  (:action gmail-send-email
    :parameters (?e - email ?s - subject ?b - body ?t - token ?f - file-path ?ft - token ?p - person ?o - order)
    :precondition (and (has-token gmail ?t) (has-token file-system ?ft) (known-email ?p ?e) (receipt-downloaded ?o ?f) (not (task-completed)))
    :effect (receipt-emailed ?p ?o)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?p - person ?o - order)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-total ?o ?amt) (not (task-completed)))
    :effect (payment-requested ?p ?o ?amt)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?o - order ?addr - address ?amt - amount)
    :precondition (and (order-placed ?o ?addr) (payment-requested ?p ?o ?amt) (not (task-completed)))
    :effect (task-completed)
  )

)
