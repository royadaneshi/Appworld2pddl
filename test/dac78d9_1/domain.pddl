(define (domain appworld-dac78d9-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token page-limit count - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (friends-listed)
    (found-friend-count ?c - count)
    (task-completed))

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

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?pl - page-limit ?c - count)
    :precondition (and (has-token venmo ?t) (not (friends-listed)) (not (task-completed)))
    :effect (and (friends-listed) (found-friend-count ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count)
    :precondition (and (friends-listed) (found-friend-count ?c) (not (task-completed)))
    :effect (task-completed))
)
