(define (domain appworld-2e9b91e-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship amount description - object)
  (:constants supervisor amazon phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (cart-cost ?amt - amount)
    (known-cart-cost ?amt - amount)
    (contact-query ?p - person ?q - query)
    (contact-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (requested-from ?p - person ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for amazon ?pw) (not (has-token amazon ?t)) (not (task-completed)))
    :effect (has-token amazon ?t))

  ; API: amazon.show_cart
  (:action amazon-show-cart
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token amazon ?t) (cart-cost ?amt) (not (task-completed)))
    :effect (known-cart-cost ?amt))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?rel - relationship ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (contact-relationship ?p ?rel) (contact-email ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?p - person)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-cart-cost ?amt) (not (requested-from ?p ?amt)) (not (task-completed)))
    :effect (requested-from ?p ?amt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?amt - amount)
    :precondition (and (requested-from ?p ?amt) (not (task-completed)))
    :effect (task-completed))
)
