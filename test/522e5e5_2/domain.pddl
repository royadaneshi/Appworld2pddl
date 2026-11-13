(define (domain appworld-522e5e5-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email direction datetime - object)
  (:constants
    venmo supervisor - app
    recipient-1 recipient-2 recipient-3 recipient-4 recipient-5 recipient-6 recipient-7 recipient-8 recipient-9 - person
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (filter-direction ?d - direction)
    (filter-min-date ?dt - datetime)
    (sent-money-this-month ?p - person)
    (email-of ?p - person ?e - email)
    (transactions-listed)
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
    :precondition (and (passwords-known)
                       (username-for venmo ?u)
                       (password-for venmo ?pw)
                       (not (has-token venmo ?t))
                       (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?min - datetime ?dir - direction)
    :precondition (and (has-token venmo ?t)
                       (filter-min-date ?min)
                       (filter-direction ?dir)
                       (not (task-completed)))
    :effect (transactions-listed))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (has-token venmo ?t)
                       (transactions-listed)
                       (sent-money-this-month ?p)
                       (email-of ?p ?e)
                       (not (friend ?p))
                       (not (task-completed)))
    :effect (friend ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (friend recipient-1)
      (friend recipient-2)
      (friend recipient-3)
      (friend recipient-4)
      (friend recipient-5)
      (friend recipient-6)
      (friend recipient-7)
      (friend recipient-8)
      (friend recipient-9)
      (not (task-completed)))
    :effect (task-completed))
)
