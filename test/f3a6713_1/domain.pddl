(define (domain appworld-f3a6713-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query sort-key quantity file-path - object
    entity - object
    email-thread attachment product-type product address payment-card - entity)
  (:constants gmail file-system amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (commitments-known)
    (attachment-downloaded ?att - attachment)
    (file-available ?f - file-path)
    (checklist-known)
    (candidate-product ?p - product ?pt - product-type)
    (checklist-quantity ?pt - product-type ?q - quantity)
    (found-best-product ?pt - product-type ?p - product)
    (cart-cleared)
    (added-to-cart ?p - product)
    (type-added-to-cart ?pt - product-type)
    (order-placed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (not (task-completed)) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t))
    :effect (and (known-id ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?att - attachment)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th))
    :effect (and (commitments-known) (known-id ?att)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (not (task-completed)) (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t)))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?att - attachment ?ft - token ?t - token ?path - file-path)
    :precondition (and (not (task-completed)) (known-id ?att) (has-token file-system ?ft) (has-token gmail ?t))
    :effect (and (attachment-downloaded ?att) (file-available ?path)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?path - file-path ?t - token)
    :precondition (and (not (task-completed)) (file-available ?path) (has-token file-system ?t))
    :effect (and (checklist-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (not (task-completed)) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (not (order-placed)))
    :effect (and (cart-cleared)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?pt - product-type ?sort - sort-key ?p - product)
    :precondition (and (not (task-completed)) (checklist-known) (commitments-known) (candidate-product ?p ?pt))
    :effect (and (found-best-product ?pt ?p) (known-id ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?pt - product-type)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (cart-cleared) (found-best-product ?pt ?p) (checklist-quantity ?pt ?qty) (not (added-to-cart ?p)) (not (order-placed)))
    :effect (and (added-to-cart ?p) (type-added-to-cart ?pt)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?addr - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-id ?addr)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (and (known-id ?card)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?addr - address ?t - token ?pt1 - product-type ?pt2 - product-type)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?card) (known-id ?addr) (type-added-to-cart ?pt1) (type-added-to-cart ?pt2) (not (= ?pt1 ?pt2)) (not (order-placed)))
    :effect (and (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed)))
)
