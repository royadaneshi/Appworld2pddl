(define (domain appworld-c77c005-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email direction datetime - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (email-of ?p - person ?e - email)
    (received-from-this-month ?p - person)
    (friend ?p - person)
    (senders-known)
    (friends-known)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?d - direction ?min - datetime)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (and (senders-known)))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (and (friends-known)))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (senders-known) (friends-known) (email-of ?p ?e) (received-from-this-month ?p) (not (friend ?p)))
    :effect (and (friend ?p)))

  ; API: venmo.remove_friend
  (:action venmo-remove-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (senders-known) (friends-known) (email-of ?p ?e) (friend ?p) (not (received-from-this-month ?p)))
    :effect (and (not (friend ?p))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)) (senders-known) (friends-known))
    :effect (and (task-completed)))
)
