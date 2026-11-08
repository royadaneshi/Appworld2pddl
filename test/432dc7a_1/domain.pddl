(define (domain appworld-432dc7a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token query promo-code order - object
    record - object
    email-thread address payment-card - record)
  (:constants amazon gmail - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (known-id ?x - record)
    (home-address ?ad - address)
    (query-finds ?q - query ?th - email-thread)
    (thread-contains-promo ?th - email-thread ?c - promo-code)
    (known-promo-code ?c - promo-code)
    (promo-applied ?c - promo-code)
    (found-cart-discount ?c - promo-code)
    (cart-reveals ?applied - promo-code ?revealed - promo-code)
    (best-promo ?c - promo-code)
    (order-placed ?o - order)
    (order-address ?o - order ?ad - address)
    (order-promo ?o - order ?c - promo-code))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (has-token amazon ?t))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?applied - promo-code ?revealed - promo-code)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (promo-applied ?applied) (cart-reveals ?applied ?revealed))
    :effect (and (found-cart-discount ?applied) (known-promo-code ?revealed)))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (query-finds ?q ?th))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - promo-code)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th) (thread-contains-promo ?th ?c))
    :effect (known-promo-code ?c))

  ; API: amazon.apply_promo_code_to_cart
  (:action amazon-apply-promo-code-to-cart
    :parameters (?c - promo-code ?t - token ?prev - promo-code)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-promo-code ?c) (promo-applied ?prev) (found-cart-discount ?prev) (not (= ?c ?prev)))
    :effect (and (promo-applied ?c) (not (promo-applied ?prev))))

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (known-id ?ad))

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?pc - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (known-id ?pc))

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?pc - payment-card ?ad - address ?t - token ?o - order ?c - promo-code)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?pc) (known-id ?ad) (home-address ?ad) (promo-applied ?c) (best-promo ?c) (not (order-placed ?o)))
    :effect (and (order-placed ?o) (order-address ?o ?ad) (order-promo ?o ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order ?ad - address ?c - promo-code)
    :precondition (and (not (task-completed)) (order-placed ?o) (order-address ?o ?ad) (home-address ?ad) (order-promo ?o ?c) (best-promo ?c))
    :effect (task-completed)))
