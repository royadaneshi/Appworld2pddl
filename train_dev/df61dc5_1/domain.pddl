(define (domain appworld-df61dc5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship email date transaction - object)
  (:constants
    supervisor phone venmo - app
    tx-1245 tx-3809 tx-3813 tx-6221 tx-6224 - transaction)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (target-relationship ?r - relationship)
    (relationship-query ?q - query ?r - relationship)
    (has-relationship ?p - person ?r - relationship)
    (email-of ?p - person ?e - email)
    (contacts-searched ?r - relationship)
    (year-start ?d - date)
    (transaction-with ?tx - transaction ?e - email)
    (created-on-or-after ?tx - transaction ?d - date)
    (transactions-listed ?e - email ?d - date)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-date-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (target-relationship ?r)
                       (relationship-query ?q ?r) (not (task-completed)))
    :effect (and (contacts-searched ?r)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - date ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (target-relationship ?r)
                       (contacts-searched ?r) (has-relationship ?p ?r) (email-of ?p ?e)
                       (current-date-known) (year-start ?d) (not (task-completed)))
    :effect (and (transactions-listed ?e ?d)))

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?tx - transaction ?t - token ?e - email ?d - date)
    :precondition (and (has-token venmo ?t) (transactions-listed ?e ?d)
                       (transaction-with ?tx ?e) (created-on-or-after ?tx ?d)
                       (not (liked ?tx)) (not (task-completed)))
    :effect (and (liked ?tx)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (liked tx-1245)
      (liked tx-3809)
      (liked tx-3813)
      (liked tx-6221)
      (liked tx-6224)
      (not (task-completed)))
    :effect (and (task-completed)))
)
