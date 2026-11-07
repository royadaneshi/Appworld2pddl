(define (domain appworld-23cf851-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token date like-count likes-total - object)
  (:constants supervisor venmo phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (datetime-known)
    (password-for ?a - app ?pw - password)
    (supervisor-username ?u - username)
    (has-token ?a - app ?t - token)
    (month-start-date ?d - date)
    (like-filter ?c - like-count)
    (found-total-likes ?l - likes-total)
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
    :effect (and (datetime-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (supervisor-username ?u) (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_transactions
  (:action venmo-show-transactions
    :parameters (?t - token ?c - like-count ?d - date ?l - likes-total)
    :precondition (and (has-token venmo ?t) (like-filter ?c) (datetime-known) (month-start-date ?d) (not (task-completed)))
    :effect (and (found-total-likes ?l)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?l - likes-total)
    :precondition (and (found-total-likes ?l) (not (task-completed)))
    :effect (and (task-completed))))
