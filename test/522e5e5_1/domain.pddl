(define (domain appworld-522e5e5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token email datetime - object)
  (:constants
    venmo - app
    counterparty-1 counterparty-2 counterparty-3 counterparty-4 counterparty-5 counterparty-6 counterparty-7 counterparty-8 counterparty-9 counterparty-10 - person
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (month-start ?d - datetime)
    (transactions-listed)
    (counterparty-this-month ?p - person)
    (email-of ?p - person ?e - email)
    (friend ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?d - datetime)
    :precondition (and (has-token venmo ?t) (month-start ?d) (not (task-completed)))
    :effect (transactions-listed))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (transactions-listed) (counterparty-this-month ?p) (email-of ?p ?e) (not (friend ?p)) (not (task-completed)))
    :effect (friend ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (friend counterparty-1)
      (friend counterparty-2)
      (friend counterparty-3)
      (friend counterparty-4)
      (friend counterparty-5)
      (friend counterparty-6)
      (friend counterparty-7)
      (friend counterparty-8)
      (friend counterparty-9)
      (friend counterparty-10)
      (not (task-completed)))
    :effect (task-completed))
)
