(define (domain appworld-dac78d9-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token page page-limit count - object)
  (:constants venmo - app page-0 page-1 - page)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (fetched-friends-page ?pg - page)
    (tallied-friends-page ?pg - page ?n - count)
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

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token ?pg - page ?pl - page-limit ?n - count)
    :precondition (and (has-token venmo ?t) (not (fetched-friends-page ?pg)) (not (task-completed)))
    :effect (and (fetched-friends-page ?pg) (tallied-friends-page ?pg ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - count)
    :precondition (and (tallied-friends-page page-0 ?n) (tallied-friends-page page-1 ?n) (not (task-completed)))
    :effect (and (task-completed))))
