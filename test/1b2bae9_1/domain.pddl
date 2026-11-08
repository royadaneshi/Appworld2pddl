(define (domain appworld-1b2bae9-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token query quantity flag directory file-path - object
    entity - object
    product address payment-card order - entity)
  (:constants amazon file-system - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (matches-query ?q - query ?p - product)
    (in-cart ?p - product ?q - quantity)
    (is-home ?a - address)
    (order-placed ?o - order ?p - product ?q - quantity ?a - address)
    (organization-known ?d - directory)
    (receipt-path-for ?f - file-path ?o - order ?d - directory)
    (receipt-saved ?o - order ?f - file-path)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (matches-query ?q ?p) (not (task-completed)))
    :effect (known-id ?p))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?cf - flag)
    :precondition (and (has-token amazon ?t) (known-id ?p) (not (task-completed)))
    :effect (in-cart ?p ?q))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?a))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-id ?c))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?o - order ?p - product ?q - quantity)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home ?a) (in-cart ?p ?q) (not (known-id ?o)) (not (task-completed)))
    :effect (and (order-placed ?o ?p ?q ?a) (known-id ?o) (not (in-cart ?p ?q))))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory ?r - flag)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (organization-known ?d))

  ; API: amazon.download_order_receipt
  (:action amazon-download-order-receipt
    :parameters (?o - order ?t - token ?f - file-path ?ft - token ?d - directory)
    :precondition (and (has-token amazon ?t) (has-token file-system ?ft) (known-id ?o) (organization-known ?d) (receipt-path-for ?f ?o ?d) (not (task-completed)))
    :effect (receipt-saved ?o ?f))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?p - product ?q - quantity ?a - address ?f - file-path)
    :precondition (and (order-placed ?o ?p ?q ?a) (receipt-saved ?o ?f) (not (task-completed)))
    :effect (task-completed)))
