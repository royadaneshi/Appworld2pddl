(define (domain appworld-f6be291-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query - object
    email-thread attachment file-path - object
    product quantity count address payment-card - object
  )
  (:constants supervisor gmail file-system amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (thread-matches ?th - email-thread ?q - query)
    (from-husband ?th - email-thread)
    (found-thread ?th - email-thread)
    (attachment-of ?th - email-thread ?at - attachment)
    (known-attachment ?at - attachment)
    (attachment-downloaded ?at - attachment)
    (file-downloaded ?f - file-path)
    (checklist-read)
    (on-checklist ?p - product ?q - quantity)
    (cart-cleared)
    (added-to-cart ?p - product)
    (in-cart ?p - product ?q - quantity)
    (items-added ?n - count)
    (next-count ?n - count ?m - count)
    (checklist-size ?n - count)
    (known-address ?ad - address)
    (home-address ?ad - address)
    (known-card ?c - payment-card)
    (order-placed)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (thread-matches ?th ?q) (not (task-completed)))
    :effect (and (found-thread ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?at - attachment)
    :precondition (and (has-token gmail ?t) (found-thread ?th) (from-husband ?th) (attachment-of ?th ?at) (not (task-completed)))
    :effect (and (known-attachment ?at))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?at - attachment ?ft - token ?t - token ?f - file-path)
    :precondition (and (known-attachment ?at) (has-token file-system ?ft) (has-token gmail ?t) (not (attachment-downloaded ?at)) (not (task-completed)))
    :effect (and (attachment-downloaded ?at) (file-downloaded ?f))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and (file-downloaded ?f) (has-token file-system ?t) (not (task-completed)))
    :effect (and (checklist-read))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?n - count ?m - count)
    :precondition (and (has-token amazon ?t) (checklist-read) (cart-cleared) (on-checklist ?p ?q) (not (added-to-cart ?p)) (items-added ?n) (next-count ?n ?m) (not (order-placed)) (not (task-completed)))
    :effect (and (added-to-cart ?p) (in-cart ?p ?q) (not (items-added ?n)) (items-added ?m))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?ad - address ?t - token ?n - count)
    :precondition (and (has-token amazon ?t) (known-card ?c) (known-address ?ad) (home-address ?ad) (cart-cleared) (items-added ?n) (checklist-size ?n) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))
  )
)
