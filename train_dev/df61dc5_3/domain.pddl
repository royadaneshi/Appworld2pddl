(define (domain appworld-df61dc5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship datetime transaction - object
  )
  (:constants
    phone venmo - app
    coworker - relationship
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?r - relationship)
    (contacts-searched ?r - relationship)
    (has-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (current-datetime-known)
    (year-start ?d - datetime)
    (transactions-found ?p - person)
    (transaction-with ?x - transaction ?p - person)
    (liked ?x - transaction)
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

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (query-for ?q ?r) (not (task-completed)))
    :effect (and (contacts-searched ?r))
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-datetime-known))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - datetime ?p - person)
    :precondition (and (has-token venmo ?t) (contacts-searched coworker) (has-relationship ?p coworker) (contact-email ?p ?e) (current-datetime-known) (year-start ?d) (not (task-completed)))
    :effect (and (transactions-found ?p))
  )

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?x - transaction ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (transaction-with ?x ?p) (transactions-found ?p) (not (liked ?x)) (not (task-completed)))
    :effect (and (liked ?x))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed))
  )
)
