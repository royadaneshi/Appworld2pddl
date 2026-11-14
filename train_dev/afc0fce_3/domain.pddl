(define (domain appworld-afc0fce-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship datetime direction transaction comment-text - object)
  (:constants phone venmo - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (current-datetime-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (target-query ?q - query)
    (target-relationship ?r - relationship)
    (is-roommate ?p - person)
    (contact-email ?p - person ?e - email)
    (roommates-found)
    (min-created-at ?d - datetime)
    (received-direction ?dir - direction)
    (received-from ?x - transaction ?p - person)
    (in-window ?x - transaction)
    (transactions-found ?p - person)
    (target-comment ?c - comment-text)
    (liked ?x - transaction)
    (commented ?x - transaction ?c - comment-text)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-datetime-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (target-query ?q) (target-relationship ?r))
    :effect (roommates-found))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (not (task-completed)) (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?e - email ?d - datetime ?dir - direction ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (roommates-found) (is-roommate ?p) (contact-email ?p ?e)
                       (current-datetime-known) (min-created-at ?d)
                       (received-direction ?dir))
    :effect (transactions-found ?p))

  ; API: venmo.like_transaction
  (:action venmo-like-transaction
    :parameters (?x - transaction ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (transactions-found ?p) (received-from ?x ?p) (in-window ?x)
                       (not (liked ?x)))
    :effect (liked ?x))

  ; API: venmo.create_transaction_comment
  (:action venmo-create-transaction-comment
    :parameters (?x - transaction ?c - comment-text ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t)
                       (transactions-found ?p) (received-from ?x ?p) (in-window ?x)
                       (target-comment ?c) (not (commented ?x ?c)))
    :effect (commented ?x ?c))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
