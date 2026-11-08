(define (domain appworld-2c544f9-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount - object)
  (:constants supervisor phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (requested-payment ?p - person ?amt - amount)
    (transaction-sent ?p - person ?amt - amount)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (username-for phone ?u)
                       (password-for phone ?pw)
                       (not (has-token phone ?t))
                       (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t)
                       (contact-query ?p ?q)
                       (email-of ?p ?e)
                       (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known)
                       (username-for venmo ?u)
                       (password-for venmo ?pw)
                       (not (has-token venmo ?t))
                       (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?p - person)
    :precondition (and (has-token venmo ?t)
                       (known-email ?p ?e)
                       (requested-payment ?p ?amt)
                       (not (transaction-sent ?p ?amt))
                       (not (task-completed)))
    :effect (and (transaction-sent ?p ?amt)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?amt - amount)
    :precondition (and (requested-payment ?p ?amt)
                       (transaction-sent ?p ?amt)
                       (not (task-completed)))
    :effect (and (task-completed)))
)
