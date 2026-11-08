(define (domain appworld-f3a6713-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query sort-key
    email-thread attachment file-path
    product-type product quantity payment-card address - object
  )
  (:constants gmail file-system amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (thread-search-query ?qry - query)
    (found-thread ?th - email-thread)
    (commitments-known)
    (known-attachment ?at - attachment)
    (downloaded ?fp - file-path)
    (checklist-known)
    (to-order ?pt - product-type)
    (search-query-for ?pt - product-type ?qry - query)
    (candidate-product ?pt - product-type ?p - product)
    (needs-quantity ?pt - product-type ?q - quantity)
    (found-best-product ?pt - product-type ?p - product)
    (cart-cleared)
    (in-cart ?pt - product-type)
    (known-payment-card ?pc - payment-card)
    (known-address ?ad - address)
    (order-placed)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (has-token gmail ?t)
  )

  ; API: gmail.show_outbox_threads
  (:action gmail-show-outbox-threads
    :parameters (?t - token ?qry - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-search-query ?qry) (not (task-completed)))
    :effect (found-thread ?th)
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?at - attachment)
    :precondition (and (has-token gmail ?t) (found-thread ?th) (not (task-completed)))
    :effect (and (commitments-known) (known-attachment ?at))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?fst - token ?t - token ?fp - file-path)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-attachment ?at) (not (task-completed)))
    :effect (downloaded ?fp)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?fp - file-path ?t - token)
    :precondition (and (has-token file-system ?t) (downloaded ?fp) (not (task-completed)))
    :effect (checklist-known)
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t)
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (order-placed)) (not (task-completed)))
    :effect (cart-cleared)
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?qry - query ?s - sort-key ?pt - product-type ?p - product)
    :precondition (and (commitments-known) (checklist-known) (to-order ?pt) (search-query-for ?pt ?qry) (candidate-product ?pt ?p) (not (task-completed)))
    :effect (found-best-product ?pt ?p)
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?pt - product-type)
    :precondition (and (has-token amazon ?t) (cart-cleared) (to-order ?pt) (found-best-product ?pt ?p) (needs-quantity ?pt ?q) (not (in-cart ?pt)) (not (order-placed)) (not (task-completed)))
    :effect (in-cart ?pt)
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?pc - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-payment-card ?pc)
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (known-address ?ad)
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?pc - payment-card ?ad - address ?t - token ?pt1 - product-type ?pt2 - product-type)
    :precondition (and (has-token amazon ?t) (known-payment-card ?pc) (known-address ?ad) (to-order ?pt1) (to-order ?pt2) (not (= ?pt1 ?pt2)) (in-cart ?pt1) (in-cart ?pt2) (not (order-placed)) (not (task-completed)))
    :effect (order-placed)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (task-completed)
  )
)
