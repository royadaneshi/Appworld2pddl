(define (domain appworld-1b2bae9-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query dirpath file-path entity - object
    product address payment-card order - entity
  )
  (:constants amazon file-system supervisor - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (query-finds ?q - query ?p - product)
    (is-home-address ?a - address)
    (cart-cleared)
    (in-cart ?p - product)
    (order-placed ?o - order ?p - product ?a - address)
    (bills-folder ?d - dirpath)
    (organization-known)
    (receipt-path-for ?o - order ?f - file-path)
    (receipt-saved ?o - order ?f - file-path)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (not (task-completed)) (query-finds ?q ?p))
    :effect (and (known-id ?p))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (cart-cleared))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?p) (cart-cleared) (not (in-cart ?p)))
    :effect (and (in-cart ?p))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (is-home-address ?a))
    :effect (and (known-id ?a))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?o - order ?p - product)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home-address ?a) (in-cart ?p) (not (known-id ?o)))
    :effect (and (order-placed ?o ?p ?a) (known-id ?o) (not (in-cart ?p)))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (not (task-completed)) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - dirpath)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (bills-folder ?d))
    :effect (and (organization-known))
  )

  ; API: amazon.download_order_receipt
  (:action amazon-download-order-receipt
    :parameters (?o - order ?t - token ?f - file-path ?ft - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (has-token file-system ?ft) (known-id ?o) (organization-known) (receipt-path-for ?o ?f))
    :effect (and (receipt-saved ?o ?f))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?a - address ?f - file-path)
    :precondition (and (not (task-completed)) (order-placed ?o ?p ?a) (is-home-address ?a) (receipt-saved ?o ?f))
    :effect (and (task-completed))
  )
)
