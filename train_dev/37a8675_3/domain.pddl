(define (domain appworld-37a8675-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email phone-number query amount description privacy payment-card transaction - object)
  (:constants phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (current-datetime-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (has-phone ?p - person ?n - phone-number)
    (query-for-phone ?q - query ?n - phone-number)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (known-id ?c - payment-card)
    (tx-receiver ?tx - transaction ?p - person)
    (tx-amount ?tx - transaction ?amt - amount)
    (tx-privacy ?tx - transaction ?priv - privacy)
    (transaction-sent ?tx - transaction)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (passwords-known))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (current-datetime-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?n - phone-number ?e - email)
    :precondition (and (has-token phone ?t) (has-phone ?p ?n) (query-for-phone ?q ?n) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (current-datetime-known) (not (task-completed)))
    :effect (known-id ?c))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?c - payment-card ?priv - privacy ?p - person ?tx - transaction)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-id ?c) (tx-receiver ?tx ?p) (tx-amount ?tx ?amt) (tx-privacy ?tx ?priv) (not (transaction-sent ?tx)) (not (task-completed)))
    :effect (transaction-sent ?tx))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
