(define (domain appworld-df61dc5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship datetime transaction - object)
  (:constants
    supervisor phone venmo - app
    tx-1067 tx-1082 tx-1086 tx-1087 tx-1107 tx-1108 tx-1115 tx-1120 tx-1122 tx-2642 tx-4444 tx-4450 tx-4492 tx-5984 tx-5986 tx-6343 tx-8229 tx-8231 tx-8232 tx-8234 tx-8237 tx-8239 tx-8243 tx-8246 - transaction)
  (:predicates
    (credential-of-app ?a - app ?c - object)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known)
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
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known)
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
    :precondition (and
      (liked tx-1067)
      (liked tx-1082)
      (liked tx-1086)
      (liked tx-1087)
      (liked tx-1107)
      (liked tx-1108)
      (liked tx-1115)
      (liked tx-1120)
      (liked tx-1122)
      (liked tx-2642)
      (liked tx-4444)
      (liked tx-4450)
      (liked tx-4492)
      (liked tx-5984)
      (liked tx-5986)
      (liked tx-6343)
      (liked tx-8229)
      (liked tx-8231)
      (liked tx-8232)
      (liked tx-8234)
      (liked tx-8237)
      (liked tx-8239)
      (liked tx-8243)
      (liked tx-8246)
      (not (task-completed)))
    :effect (task-completed))
)
