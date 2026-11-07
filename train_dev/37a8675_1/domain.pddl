(define (domain appworld-37a8675-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount privacy description payment-card transaction - object)
  (:constants supervisor phone venmo - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (current-datetime-known)
    (login-username ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (contact-query ?q - query ?p - person)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (known-valid-card ?c - payment-card)
    (txn-receiver ?tx - transaction ?p - person)
    (txn-amount ?tx - transaction ?amt - amount)
    (txn-privacy ?tx - transaction ?priv - privacy)
    (transaction-sent ?tx - transaction)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-datetime-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (login-username phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?q ?p) (email-of ?p ?e) (not (task-completed)))
    :effect (and (known-email ?p ?e)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (login-username venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (current-datetime-known) (not (task-completed)))
    :effect (and (known-valid-card ?c)))

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?c - payment-card ?priv - privacy ?tx - transaction ?p - person)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-valid-card ?c) (txn-receiver ?tx ?p) (txn-amount ?tx ?amt) (txn-privacy ?tx ?priv) (not (transaction-sent ?tx)) (not (task-completed)))
    :effect (and (transaction-sent ?tx)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx - transaction)
    :precondition (and (transaction-sent ?tx) (not (task-completed)))
    :effect (and (task-completed)))
)
