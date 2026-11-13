(define (domain appworld-37a8675-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query amount card description privacy transaction - object
  )
  (:constants phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (datetime-known)
    (password-for ?a - app ?pw - password)
    (login-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (contact-query ?p - person ?q - query)
    (known-email ?p - person ?e - email)
    (known-card ?c - card)
    (tx-receiver ?tx - transaction ?p - person)
    (tx-amount ?tx - transaction ?amt - amount)
    (tx-privacy ?tx - transaction ?priv - privacy)
    (sent ?tx - transaction)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (datetime-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known) (login-username phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (contact-query ?p ?q) (not (task-completed)))
    :effect (and (known-email ?p ?e))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known) (login-username venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - card)
    :precondition (and (has-token venmo ?t) (datetime-known) (not (task-completed)))
    :effect (and (known-card ?c))
  )

  ; API: venmo.create_transaction
  (:action venmo-create-transaction
    :parameters (?e - email ?amt - amount ?t - token ?d - description ?c - card ?priv - privacy ?p - person ?tx - transaction)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (known-card ?c) (tx-receiver ?tx ?p) (tx-amount ?tx ?amt) (tx-privacy ?tx ?priv) (not (sent ?tx)) (not (task-completed)))
    :effect (and (sent ?tx))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx - transaction)
    :precondition (and (sent ?tx) (not (task-completed)))
    :effect (and (task-completed))
  )
)
