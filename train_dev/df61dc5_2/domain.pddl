(define (domain appworld-df61dc5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship datetime transaction - object)
  (:constants
    supervisor phone venmo - app
    tx-1 tx-2 tx-3 tx-4 - transaction)
  (:predicates
    (profile-known)
    (passwords-known)
    (current-datetime-known)
    (contacts-searched)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (friend-filter ?q - query ?r - relationship)
    (is-friend ?p - person)
    (email-of ?p - person ?e - email)
    (month-start ?d - datetime)
    (transaction-with ?x - transaction ?e - email)
    (in-current-month ?x - transaction)
    (transactions-listed ?e - email)
    (liked ?x - transaction)
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
    :precondition (and (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (friend-filter ?q ?r) (not (task-completed)))
    :effect (contacts-searched))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - datetime ?p - person)
    :precondition (and (has-token venmo ?t) (contacts-searched) (current-datetime-known)
                       (is-friend ?p) (email-of ?p ?e) (month-start ?d)
                       (not (task-completed)))
    :effect (transactions-listed ?e))

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?x - transaction ?t - token ?e - email)
    :precondition (and (has-token venmo ?t) (transactions-listed ?e)
                       (transaction-with ?x ?e) (in-current-month ?x)
                       (not (liked ?x)) (not (task-completed)))
    :effect (liked ?x))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (liked tx-1) (liked tx-2) (liked tx-3) (not (task-completed)))
    :effect (task-completed))
)
