(define (domain appworld-df61dc5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship datetime transaction - object)
  (:constants
    supervisor phone venmo - app
    tx-1 tx-2 tx-3 tx-4 tx-5 tx-6 tx-7 tx-8 tx-9 tx-10 tx-11 tx-12 tx-13 tx-14 tx-15 tx-16 tx-17 tx-18 tx-19 tx-20 tx-21 tx-22 tx-23 tx-24 - transaction)
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
      (liked tx-1)
      (liked tx-2)
      (liked tx-3)
      (liked tx-4)
      (liked tx-5)
      (liked tx-6)
      (liked tx-7)
      (liked tx-8)
      (liked tx-9)
      (liked tx-10)
      (liked tx-11)
      (liked tx-12)
      (liked tx-13)
      (liked tx-14)
      (liked tx-15)
      (liked tx-16)
      (liked tx-17)
      (liked tx-18)
      (liked tx-19)
      (liked tx-20)
      (liked tx-21)
      (liked tx-22)
      (liked tx-23)
      (liked tx-24)
      (not (task-completed)))
    :effect (task-completed))
)
