(define (domain appworld-c77c005-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token email datetime direction entity - object
    person marker - entity)
  (:constants
    venmo - app
    worklist-end - marker)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (month-start ?dt - datetime)
    (sent-direction ?d - direction)
    (email-of ?p - person ?e - email)
    (sent-money-this-month ?p - person)
    (friend ?p - person)
    (recipients-known)
    (friends-known)
    (worklist-head ?x - entity)
    (worklist-next ?x - entity ?y - entity))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?from - datetime ?d - direction)
    :precondition (and (has-token venmo ?t) (month-start ?from) (sent-direction ?d) (not (task-completed)))
    :effect (recipients-known))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (friends-known))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person ?n - entity)
    :precondition (and (has-token venmo ?t) (recipients-known) (friends-known) (sent-money-this-month ?p) (not (friend ?p)) (email-of ?p ?e) (worklist-head ?p) (worklist-next ?p ?n) (not (task-completed)))
    :effect (and (friend ?p) (not (worklist-head ?p)) (worklist-head ?n)))

  ; API: venmo.remove_friend
  (:action venmo-remove-friend
    :parameters (?e - email ?t - token ?p - person ?n - entity)
    :precondition (and (has-token venmo ?t) (recipients-known) (friends-known) (friend ?p) (not (sent-money-this-month ?p)) (email-of ?p ?e) (worklist-head ?p) (worklist-next ?p ?n) (not (task-completed)))
    :effect (and (not (friend ?p)) (not (worklist-head ?p)) (worklist-head ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (worklist-head worklist-end) (not (task-completed)))
    :effect (task-completed))
)
