(define (domain appworld-522e5e5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person email username password token direction datetime - object
  )
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (received-direction ?d - direction)
    (month-start ?dt - datetime)
    (transactions-listed)
    (sender-this-month ?p - person)
    (email-of ?p - person ?e - email)
    (friend ?p - person)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?from - datetime ?d - direction)
    :precondition (and (has-token venmo ?t) (month-start ?from) (received-direction ?d) (not (task-completed)))
    :effect (and (transactions-listed))
  )

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (transactions-listed) (sender-this-month ?p) (email-of ?p ?e) (not (friend ?p)) (not (task-completed)))
    :effect (and (friend ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person)
    :precondition (and (sender-this-month ?p1) (sender-this-month ?p2) (not (= ?p1 ?p2)) (friend ?p1) (friend ?p2) (not (task-completed)))
    :effect (and (task-completed))
  )
)
