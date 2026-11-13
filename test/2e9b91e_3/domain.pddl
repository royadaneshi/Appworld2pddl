(define (domain appworld-2e9b91e-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount cart payment-request - object
  )
  (:constants amazon phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-of-supervisor ?c - cart)
    (cart-for ?c - cart ?p - person)
    (cart-subtotal ?c - cart ?amt - amount)
    (found-cart-cost ?c - cart ?amt - amount)
    (contact-query ?p - person ?q - query)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (request-exists ?r - payment-request)
    (request-created ?r - payment-request ?p - person ?amt - amount)
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
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (not (task-completed)) (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?c - cart ?amt - amount)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (cart-of-supervisor ?c) (cart-subtotal ?c ?amt))
    :effect (and (found-cart-cost ?c ?amt))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (not (task-completed)) (has-token phone ?t) (contact-query ?p ?q) (contact-email ?p ?e))
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?p - person ?c - cart ?r - payment-request)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (known-email ?p ?e) (found-cart-cost ?c ?amt) (not (request-exists ?r)))
    :effect (and (request-exists ?r) (request-created ?r ?p ?amt))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request ?c - cart ?p - person ?amt - amount)
    :precondition (and (not (task-completed)) (cart-of-supervisor ?c) (cart-for ?c ?p) (cart-subtotal ?c ?amt) (request-created ?r ?p ?amt))
    :effect (and (task-completed))
  )
)
