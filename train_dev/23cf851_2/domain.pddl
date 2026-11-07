(define (domain appworld-23cf851-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token direction datetime like-count count - object)
  (:constants venmo phone - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (current-date-known)
    (password-for ?a - app ?pw - password)
    (supervisor-email ?u - username)
    (has-token ?a - app ?t - token)
    (received-direction ?d - direction)
    (year-start ?d - datetime)
    (min-like-count-one ?c - like-count)
    (found-total-likes ?n - count)
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
    :effect (current-date-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (supervisor-email ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?dir - direction ?since - datetime ?minlikes - like-count ?total - count)
    :precondition (and (has-token venmo ?t) (current-date-known) (received-direction ?dir) (year-start ?since) (min-like-count-one ?minlikes) (not (task-completed)))
    :effect (found-total-likes ?total))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?ans - count)
    :precondition (and (found-total-likes ?ans) (not (task-completed)))
    :effect (task-completed))
)
