(define (domain appworld-f6be291-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query - object
    email-thread attachment file-path - object
    product quantity count address payment-card - object)
  (:constants supervisor gmail file-system amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (known-id ?x)
    (wife-of ?p - person ?me - person)
    (sent-by ?th - email-thread ?p - person)
    (thread-query ?q - query ?th - email-thread)
    (attachment-of ?at - attachment ?th - email-thread)
    (download-path ?at - attachment ?f - file-path)
    (downloaded ?f - file-path)
    (checklist-read)
    (product-query ?q - query ?p - product)
    (on-checklist ?p - product ?qty - quantity)
    (cart-cleared)
    (cart-items ?n - count)
    (zero-count ?n - count)
    (next-count ?n - count ?m - count)
    (checklist-size ?n - count)
    (in-cart ?p - product ?qty - quantity)
    (known-home-address)
    (is-home-address ?ad - address)
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
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw)
                       (token-for gmail ?t) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-query ?q ?th) (not (task-completed)))
    :effect (and (known-id ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?at - attachment)
    :precondition (and (has-token gmail ?t) (known-id ?th) (attachment-of ?at ?th) (not (task-completed)))
    :effect (and (known-id ?at)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw)
                       (token-for file-system ?t) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?fst - token ?t - token ?f - file-path)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-id ?at)
                       (download-path ?at ?f) (not (task-completed)))
    :effect (and (downloaded ?f)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and (has-token file-system ?t) (downloaded ?f) (not (task-completed)))
    :effect (and (checklist-read)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw)
                       (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token ?n - count)
    :precondition (and (has-token amazon ?t) (zero-count ?n) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared) (cart-items ?n)))

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (checklist-read) (product-query ?q ?p) (not (task-completed)))
    :effect (and (known-id ?p)))

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?qty - quantity ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (known-id ?p) (checklist-read) (on-checklist ?p ?qty)
                       (not (in-cart ?p ?qty)) (cart-items ?n) (next-count ?n ?m)
                       (not (order-placed)) (not (task-completed)))
    :effect (and (in-cart ?p ?qty) (not (cart-items ?n)) (cart-items ?m)))

  ; API: supervisor.show_addresses
  (:action supervisor-show-addresses
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (known-home-address)))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (known-home-address) (is-home-address ?ad) (not (task-completed)))
    :effect (and (known-id ?ad)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?card)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?card - payment-card ?ad - address ?t - token ?n - count)
    :precondition (and (has-token amazon ?t) (known-id ?card) (known-id ?ad) (is-home-address ?ad)
                       (cart-items ?n) (checklist-size ?n) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed)))
)
