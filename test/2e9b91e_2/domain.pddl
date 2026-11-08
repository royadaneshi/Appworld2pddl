(define (domain appworld-2e9b91e-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query email amount - object)
  (:constants amazon phone venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (cart-cost ?amt - amount)
    (known-amount ?amt - amount)
    (roommate ?p - person)
    (query-for ?q - query ?p - person)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (payment-request-sent ?p - person ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for amazon ?u) (password-for amazon ?pw) (token-for amazon ?t) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (and (has-token amazon ?t)))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (cart-cost ?amt) (not (task-completed)))
    :effect (and (known-amount ?amt)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (query-for ?q ?p) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-amount ?amt) (cart-cost ?amt) (not (task-completed)))
    :effect (and (payment-request-sent ?p ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?amt - amount)
    :precondition (and (roommate ?p) (cart-cost ?amt) (payment-request-sent ?p ?amt) (not (task-completed)))
    :effect (and (task-completed)))
)
