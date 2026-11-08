(define (domain appworld-f6be291-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship quantity checklist-item - object
    entity - object
    email-thread attachment file product address payment-card - entity
  )
  (:constants phone gmail file-system amazon - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (known-email ?p - person ?e - email)
    (contact-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (thread-from ?th - email-thread ?e - email)
    (thread-matches ?th - email-thread ?q - query)
    (attachment-in-thread ?th - email-thread ?a - attachment)
    (attachment-file ?a - attachment ?f - file)
    (downloaded ?f - file)
    (checklist-in-file ?f - file)
    (checklist-read)
    (checklist-entry ?i - checklist-item ?p - product ?q - quantity)
    (product-query ?p - product ?q - query)
    (next-item ?i1 - checklist-item ?i2 - checklist-item)
    (last-item ?i - checklist-item)
    (cart-cleared)
    (cart-covers ?i - checklist-item)
    (added-to-cart ?p - product ?q - quantity)
    (is-home-address ?a - address)
    (order-placed)
    (task-completed)
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
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-relationship ?p ?r) (contact-email ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?from - email ?p - person ?th - email-thread)
    :precondition (and (has-token gmail ?t) (known-email ?p ?from) (thread-from ?th ?from) (thread-matches ?th ?q) (not (task-completed)))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?a - attachment)
    :precondition (and (has-token gmail ?t) (known-id ?th) (attachment-in-thread ?th ?a) (not (task-completed)))
    :effect (and (known-id ?a))
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t))
  )

  ; API: gmail.download_attachment
  (:action gmail-download-attachment
    :parameters (?a - attachment ?fst - token ?t - token ?f - file)
    :precondition (and (has-token gmail ?t) (has-token file-system ?fst) (known-id ?a) (attachment-file ?a ?f) (not (task-completed)))
    :effect (and (downloaded ?f) (known-id ?f))
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token)
    :precondition (and (has-token file-system ?t) (downloaded ?f) (known-id ?f) (checklist-in-file ?f) (not (task-completed)))
    :effect (and (checklist-read))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.clear_cart
  (:action amazon-clear-cart
    :parameters (?t - token)
    :precondition (and (has-token amazon ?t) (not (cart-cleared)) (not (task-completed)))
    :effect (and (cart-cleared))
  )

  ; API: amazon.search_products
  (:action amazon-search-products
    :parameters (?q - query ?p - product)
    :precondition (and (checklist-read) (product-query ?p ?q) (not (task-completed)))
    :effect (and (known-id ?p))
  )

  ; API: amazon.add_product_to_cart
  (:action amazon-add-product-to-cart
    :parameters (?p - product ?t - token ?q - quantity ?i - checklist-item ?prev - checklist-item)
    :precondition (and (has-token amazon ?t) (cart-cleared) (checklist-read) (known-id ?p) (checklist-entry ?i ?p ?q) (next-item ?prev ?i) (cart-covers ?prev) (not (cart-covers ?i)) (not (order-placed)) (not (task-completed)))
    :effect (and (added-to-cart ?p ?q) (cart-covers ?i))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?a - address)
    :precondition (and (has-token amazon ?t) (is-home-address ?a) (not (task-completed)))
    :effect (and (known-id ?a))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?c))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?c - payment-card ?a - address ?t - token ?last - checklist-item)
    :precondition (and (has-token amazon ?t) (known-id ?c) (known-id ?a) (is-home-address ?a) (last-item ?last) (cart-covers ?last) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))
  )
)
