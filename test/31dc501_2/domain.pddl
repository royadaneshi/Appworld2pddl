(define (domain appworld-31dc501-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person alarm username password token minutes - object)
  (:constants phone supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?al - alarm)
    (is-weekend-wake-up ?al - alarm)
    (found-weekend-wake-up ?al - alarm)
    (target-snooze ?m - minutes)
    (snooze-set ?al - alarm ?m - minutes)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.show_alarms
  (:action phone-show-alarms
    :parameters (?t - token ?al - alarm)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (known-id ?al))

  ; API: phone.show_alarm
  (:action phone-show-alarm
    :parameters (?al - alarm ?t - token)
    :precondition (and (has-token phone ?t) (known-id ?al) (is-weekend-wake-up ?al) (not (task-completed)))
    :effect (found-weekend-wake-up ?al))

  ; API: phone.update_alarm
  (:action phone-update-alarm
    :parameters (?al - alarm ?t - token ?m - minutes)
    :precondition (and (has-token phone ?t) (found-weekend-wake-up ?al) (not (task-completed)))
    :effect (snooze-set ?al ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?al - alarm ?m - minutes)
    :precondition (and (is-weekend-wake-up ?al) (target-snooze ?m) (snooze-set ?al ?m) (not (task-completed)))
    :effect (task-completed))
)
