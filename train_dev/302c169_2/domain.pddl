(define (domain appworld-302c169-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token alarm alarm-time bool-value - object)
  (:constants phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (phone-username ?u - username)
    (has-token ?a - app ?t - token)
    (alarms-listed)
    (wake-up-alarm ?al - alarm)
    (alarm-time ?al - alarm ?tm - alarm-time)
    (minus-40-minutes ?from - alarm-time ?to - alarm-time)
    (alarm-enabled ?al - alarm)
    (bool-false ?b - bool-value)
    (wake-up-alarm-rescheduled)
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

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known) (phone-username ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.show_alarms
  (:action phone-show-alarms
    :parameters (?t - token)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (alarms-listed))

  ; API: phone.update_alarm  (only the time field is passed)
  (:action phone-update-alarm-time
    :parameters (?al - alarm ?t - token ?new - alarm-time ?old - alarm-time)
    :precondition (and (has-token phone ?t) (alarms-listed) (wake-up-alarm ?al) (alarm-time ?al ?old) (minus-40-minutes ?old ?new) (not (task-completed)))
    :effect (and (not (alarm-time ?al ?old)) (alarm-time ?al ?new) (wake-up-alarm-rescheduled)))

  ; API: phone.update_alarm  (only the enabled field is passed)
  (:action phone-update-alarm-enabled
    :parameters (?al - alarm ?t - token ?en - bool-value)
    :precondition (and (has-token phone ?t) (alarms-listed) (not (wake-up-alarm ?al)) (alarm-enabled ?al) (bool-false ?en) (not (task-completed)))
    :effect (not (alarm-enabled ?al)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (wake-up-alarm-rescheduled) (not (task-completed)))
    :effect (task-completed))
)
