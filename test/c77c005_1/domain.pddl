(define (domain appworld-c77c005-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email datetime - object)
  (:constants
    venmo - app
    recent-payee-1 recent-payee-2 recent-payee-3 recent-payee-4 recent-payee-5 recent-payee-6 recent-payee-7 recent-payee-8 recent-payee-9 recent-payee-10 stale-friend-1 stale-friend-2 stale-friend-3 stale-friend-4 stale-friend-5 stale-friend-6 stale-friend-7 stale-friend-8 stale-friend-9 stale-friend-10 stale-friend-11 - person
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (month-start ?d - datetime)
    (email-of ?p - person ?e - email)
    (transacted-this-month ?p - person)
    (is-friend ?p - person)
    (transactions-reviewed)
    (friends-reviewed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?d - datetime)
    :precondition (and (has-token venmo ?t) (month-start ?d) (not (task-completed)))
    :effect (and (transactions-reviewed)))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (friends-reviewed)))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (transactions-reviewed) (friends-reviewed) (email-of ?p ?e) (transacted-this-month ?p) (not (is-friend ?p)) (not (task-completed)))
    :effect (and (is-friend ?p)))

  ; API: venmo.remove_friend
  (:action venmo-remove-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (transactions-reviewed) (friends-reviewed) (email-of ?p ?e) (not (transacted-this-month ?p)) (is-friend ?p) (not (task-completed)))
    :effect (and (not (is-friend ?p))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (is-friend recent-payee-1)
      (is-friend recent-payee-2)
      (is-friend recent-payee-3)
      (is-friend recent-payee-4)
      (is-friend recent-payee-5)
      (is-friend recent-payee-6)
      (is-friend recent-payee-7)
      (is-friend recent-payee-8)
      (is-friend recent-payee-9)
      (is-friend recent-payee-10)
      (not (is-friend stale-friend-1))
      (not (is-friend stale-friend-2))
      (not (is-friend stale-friend-3))
      (not (is-friend stale-friend-4))
      (not (is-friend stale-friend-5))
      (not (is-friend stale-friend-6))
      (not (is-friend stale-friend-7))
      (not (is-friend stale-friend-8))
      (not (is-friend stale-friend-9))
      (not (is-friend stale-friend-10))
      (not (is-friend stale-friend-11))
      (not (task-completed))
      (not (task-completed)))
    :effect (and (task-completed)))
)
