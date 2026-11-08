(define (domain appworld-1b2bae9-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query quantity flag directory-path file-path entity - object
    product address payment-card order - entity
  )
  (:constants amazon file-system supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (product-matches ?p - product ?q - query)
    (is-true ?f - flag)
    (is-home-address ?ad - address)
    (in-cart ?p - product ?n - quantity)
    (order-placed ?o - order)
    (ordered ?o - order ?p - product ?n - quantity ?ad - address)
    (known-order-date ?o - order)
    (organization-known ?d - directory-path)
    (receipt-path-for ?o - order ?f - file-path ?d - directory-path)
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
    :precondition (and (passwords-known) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (product-matches ?p ?q) (not (task-completed)))
    :effect (and (known-id ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?n - quantity ?cf - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (is-true ?cf) (not (task-completed)))
    :effect (and (in-cart ?p ?n))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?ad) (not (task-completed)))
    :effect (and (known-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?o - order ?p - product ?n - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?ad) (in-cart ?p ?n) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o) (known-id ?o) (ordered ?o ?p ?n ?ad) (not (in-cart ?p ?n)))
  )

  ; API: amazon.show_order
  (:action amazon-show-order
    :parameters (?o - order ?t - token)
    :precondition (and (has-token amazon ?t) (known-id ?o) (order-placed ?o) (not (task-completed)))
    :effect (and (known-order-date ?o))
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path ?r - flag)
    :precondition (and (has-token file-system ?t) (is-true ?r) (not (task-completed)))
    :effect (and (organization-known ?d))
  )

  ; API: amazon.download_order_receipt
  (:action amazon-download-order-receipt
    :parameters (?o - order ?t - token ?f - file-path ?ft - token ?d - directory-path)
    :precondition (and (has-token amazon ?t) (has-token file-system ?ft) (known-id ?o) (order-placed ?o) (known-order-date ?o) (organization-known ?d) (receipt-path-for ?o ?f ?d) (not (task-completed)))
    :effect (and (receipt-saved ?o ?f))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?n - quantity ?ad - address ?f - file-path)
    :precondition (and (ordered ?o ?p ?n ?ad) (receipt-saved ?o ?f) (not (task-completed)))
    :effect (and (task-completed))
  )
)
