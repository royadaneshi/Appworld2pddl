(define (domain appworld-432dc7a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email-thread promo-code address payment-card order - object
  )
  (:constants gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (thread-matches ?q - query ?th - email-thread)
    (found-thread ?th - email-thread)
    (thread-contains-code ?th - email-thread ?c - promo-code)
    (known-promo-code ?c - promo-code)
    (applied-promo ?c - promo-code)
    (discount-known ?c - promo-code)
    (cart-check-reveals ?applied - promo-code ?revealed - promo-code)
    (best-deal ?c - promo-code)
    (home-address ?ad - address)
    (known-address-id ?ad - address)
    (known-card-id ?pc - payment-card)
    (order-placed ?o - order)
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
    :precondition (and (has-token gmail ?t) (thread-matches ?q ?th) (not (task-completed)))
    :effect (and (found-thread ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - promo-code)
    :precondition (and (has-token gmail ?t) (found-thread ?th) (thread-contains-code ?th ?c) (not (task-completed)))
    :effect (and (known-promo-code ?c))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (credential-of-app amazon ?u) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?c - promo-code ?r - promo-code)
    :precondition (and (has-token amazon ?t) (applied-promo ?c) (cart-check-reveals ?c ?r) (not (task-completed)))
    :effect (and (discount-known ?c) (known-promo-code ?r))
  )

  ; API: amazon.apply_promo_code_to_cart
  (:action amazon-apply-promo-code-to-cart
    :parameters (?c - promo-code ?t - token ?old - promo-code)
    :precondition (and (has-token amazon ?t) (known-promo-code ?c) (applied-promo ?old) (discount-known ?old) (not (= ?c ?old)) (not (task-completed)))
    :effect (and (applied-promo ?c) (not (applied-promo ?old)))
  )

  ; API: amazon.show_addresses
  (:action amazon-show-addresses
    :parameters (?t - token ?ad - address)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-address-id ?ad))
  )

  ; API: amazon.show_payment_cards
  (:action amazon-show-payment-cards
    :parameters (?t - token ?pc - payment-card)
    :precondition (and (has-token amazon ?t) (not (task-completed)))
    :effect (and (known-card-id ?pc))
  )

  ; API: amazon.place_order
  (:action amazon-place-order
    :parameters (?pc - payment-card ?ad - address ?t - token ?o - order ?c - promo-code)
    :precondition (and (has-token amazon ?t) (known-card-id ?pc) (known-address-id ?ad) (home-address ?ad) (applied-promo ?c) (best-deal ?c) (not (order-placed ?o)) (not (task-completed)))
    :effect (and (order-placed ?o))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?o - order)
    :precondition (and (order-placed ?o) (not (task-completed)))
    :effect (and (task-completed))
  )
)
