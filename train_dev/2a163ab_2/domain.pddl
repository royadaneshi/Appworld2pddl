(define (domain appworld-2a163ab-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship transaction - object
  )
  (:constants
    phone venmo - app
  )
  (:predicates
    (passwords-known)
    (profile-known)
    (date-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (target-relationship ?r - relationship)
    (relationship-query ?r - relationship ?q - query)
    (relatives-known)
    (feed-known)
    (on-feed ?x - transaction)
    (from-yesterday ?x - transaction)
    (involves-relative ?x - transaction)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (date-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t)
                       (not (has-token phone ?t)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (target-relationship ?r) (relationship-query ?r ?q))
    :effect (and (relatives-known))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t)
                       (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_social_feed
  (:action venmo-show-social-feed
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (and (feed-known))
  )

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?x - transaction ?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (feed-known) (date-known) (relatives-known)
                       (on-feed ?x) (from-yesterday ?x) (involves-relative ?x)
                       (not (liked ?x)))
    :effect (and (liked ?x))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?x1 - transaction ?x2 - transaction)
    :precondition (and (not (task-completed)) (not (= ?x1 ?x2))
                       (liked ?x1) (liked ?x2))
    :effect (and (task-completed))
  )
)
