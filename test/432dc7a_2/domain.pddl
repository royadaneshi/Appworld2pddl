(define (domain appworld-432dc7a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query entity - object
    email-thread promo-code address payment-card - entity)
  (:constants gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (known-id ?x - entity)
    (query-for ?q - query ?th - email-thread)
    (thread-contains-code ?th - email-thread ?c - promo-code)
    (promo-applied ?c - promo-code)
    (cart-total-known ?c - promo-code)
    (cart-reveals ?applied - promo-code ?revealed - promo-code)
    (workplace-address ?ad - address)
    (cheapest-promo ?c - promo-code)
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
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)) (not (task-completed)))
    :effect (and (has-token gmail ?t)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (has-token gmail ?t) (query-for ?q ?th) (not (task-completed)))
    :effect (and (known-id ?th)))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - promo-code)
    :precondition (and (has-token gmail ?t) (known-id ?th) (thread-contains-code ?th ?c) (not (task-completed)))
    :effect (and (known-id ?c)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?c - promo-code ?d - promo-code)
    :precondition (and (has-token amazon ?t) (promo-applied ?c) (cart-reveals ?c ?d) (not (task-completed)))
    :effect (and (cart-total-known ?c) (known-id ?d)))

  ; API: amazon.apply_promo_code_to_cart
  (:action amazon-apply-promo-code-to-cart
    :parameters (?code - promo-code ?t - token ?prev - promo-code)
    :precondition (and (has-token amazon ?t) (known-id ?code) (promo-applied ?prev) (cart-total-known ?prev) (not (= ?code ?prev)) (not (task-completed)))
    :effect (and (promo-applied ?code) (not (promo-applied ?prev))))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?ad)))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?pc - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-id ?pc)))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?pc - payment-card ?ad - address ?t - token ?c - promo-code)
    :precondition (and (has-token amazon ?t) (known-id ?pc) (known-id ?ad) (workplace-address ?ad) (promo-applied ?c) (cheapest-promo ?c) (not (order-placed)) (not (task-completed)))
    :effect (and (order-placed)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (order-placed) (not (task-completed)))
    :effect (and (task-completed))))
