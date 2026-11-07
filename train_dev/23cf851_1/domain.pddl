(define (domain appworld-23cf851-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token date direction like-count count - object)
  (:constants venmo phone - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (date-known)
    (supervisor-username ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (month-start ?d - date)
    (direction-sent ?dir - direction)
    (like-filter ?lc - like-count)
    (found-total-likes ?n - count)
    (task-completed))

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known)))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (date-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (supervisor-username ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?d - date ?lc - like-count ?dir - direction ?n - count)
    :precondition (and (has-token venmo ?t) (date-known) (month-start ?d) (like-filter ?lc) (direction-sent ?dir) (not (task-completed)))
    :effect (and (found-total-likes ?n)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?n - count)
    :precondition (and (found-total-likes ?n) (not (task-completed)))
    :effect (and (task-completed))))
