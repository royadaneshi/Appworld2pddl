(define (domain appworld-2a163ab-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship transaction - object
  )
  (:constants
    phone venmo - app
    coworker - relationship
    txn-recent-coworker-1 txn-recent-coworker-2 txn-old-coworker txn-recent-noncoworker - transaction
  )
  (:predicates
    (profile-known)
    (passwords-known)
    (current-datetime-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?r - relationship)
    (has-relationship ?p - person ?r - relationship)
    (contacts-known ?r - relationship)
    (in-social-feed ?tx - transaction)
    (created-yesterday-or-today ?tx - transaction)
    (involves ?tx - transaction ?p - person)
    (feed-shown)
    (liked ?tx - transaction)
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
    :effect (and (current-datetime-known))
  )
  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )
  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (query-for ?q ?r) (not (task-completed)))
    :effect (and (contacts-known ?r))
  )
  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )
  ; API: venmo.show_social_feed
  (:action venmo-show-social-feed
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (feed-shown))
  )
  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?tx - transaction ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (feed-shown) (current-datetime-known) (contacts-known coworker) (in-social-feed ?tx) (created-yesterday-or-today ?tx) (involves ?tx ?p) (has-relationship ?p coworker) (not (liked ?tx)) (not (task-completed)))
    :effect (and (liked ?tx))
  )
  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (liked txn-recent-coworker-1) (liked txn-recent-coworker-2) (not (liked txn-old-coworker)) (not (liked txn-recent-noncoworker)) (not (task-completed)))
    :effect (and (task-completed))
  )
)
