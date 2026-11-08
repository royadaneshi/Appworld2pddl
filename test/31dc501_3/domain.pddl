(define (domain appworld-31dc501-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token alarm minutes - object)
  (:constants phone supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (known-id ?al - alarm)
    (alarm-details-known ?al - alarm)
    (wants-snooze ?al - alarm ?m - minutes)
    (snooze-set ?al - alarm ?m - minutes)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.show_alarms
  (:action phone-show-alarms
    :parameters (?t - token ?al - alarm)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (known-id ?al)))

  ; API: phone.show_alarm
  (:action phone-show-alarm
    :parameters (?al - alarm ?t - token)
    :precondition (and (has-token phone ?t) (known-id ?al) (not (task-completed)))
    :effect (and (alarm-details-known ?al)))

  ; API: phone.update_alarm
  (:action phone-update-alarm
    :parameters (?al - alarm ?t - token ?m - minutes)
    :precondition (and (has-token phone ?t) (known-id ?al) (alarm-details-known ?al) (not (task-completed)))
    :effect (and (snooze-set ?al ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?al - alarm ?m - minutes)
    :precondition (and (wants-snooze ?al ?m) (snooze-set ?al ?m) (not (task-completed)))
    :effect (and (task-completed))))
