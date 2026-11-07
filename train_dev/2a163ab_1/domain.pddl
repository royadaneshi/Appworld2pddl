(define (domain appworld-2a163ab-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship transaction date - object)
  (:constants supervisor phone venmo - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (current-date ?d - date)
    (date-known ?d - date)
    (has-relationship ?p - person ?r - relationship)
    (query-for ?q - query ?r - relationship)
    (contacts-searched ?r - relationship)
    (feed-shown)
    (on-feed ?tx - transaction)
    (transaction-involves ?tx - transaction ?p - person)
    (transaction-on ?tx - transaction ?d - date)
    (liked ?tx - transaction)
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

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters (?d - date)
    :precondition (and (not (task-completed)) (current-date ?d))
    :effect (and (date-known ?d)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t) (query-for ?q ?r))
    :effect (and (contacts-searched ?r)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_social_feed
  (:action venmo-show-social-feed
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (and (feed-shown)))

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?tx - transaction ?t - token ?p - person ?r - relationship ?d - date)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (feed-shown) (on-feed ?tx) (transaction-involves ?tx ?p) (has-relationship ?p ?r) (contacts-searched ?r) (transaction-on ?tx ?d) (date-known ?d) (not (liked ?tx)))
    :effect (and (liked ?tx)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?tx1 - transaction ?tx2 - transaction)
    :precondition (and (not (task-completed)) (liked ?tx1) (liked ?tx2) (not (= ?tx1 ?tx2)))
    :effect (and (task-completed)))
)
