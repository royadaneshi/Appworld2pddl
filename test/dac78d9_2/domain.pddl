(define (domain appworld-dac78d9-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token count - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (account-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (found-friend-count ?c - count)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (account-username venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?c - count)
    :precondition (and (not (task-completed)) (has-token venmo ?t))
    :effect (and (found-friend-count ?c)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - count)
    :precondition (and (not (task-completed)) (found-friend-count ?c))
    :effect (and (task-completed))))
