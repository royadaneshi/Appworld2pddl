(define (domain appworld-302c169-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person alarm username password token clock-time flag - object)
  (:constants
    phone - app
    alarm-go-to-sleep alarm-other-1 alarm-other-2 - alarm)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (alarms-listed)
    (go-to-sleep-alarm ?al - alarm)
    (alarm-time ?al - alarm ?tm - clock-time)
    (plus-20-minutes ?old - clock-time ?new - clock-time)
    (moved-later ?al - alarm)
    (enabled ?al - alarm)
    (flag-false ?f - flag)
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

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (profile-known) (username-for phone ?u) (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t)))

  ; API: phone.show_alarms
  (:action phone-show-alarms
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token phone ?t))
    :effect (and (alarms-listed)))

  ; API: phone.update_alarm (called with only the optional time field)
  (:action phone-update-alarm-time
    :parameters (?al - alarm ?t - token ?new - clock-time ?old - clock-time)
    :precondition (and (not (task-completed)) (has-token phone ?t) (alarms-listed) (go-to-sleep-alarm ?al) (alarm-time ?al ?old) (plus-20-minutes ?old ?new) (not (moved-later ?al)))
    :effect (and (not (alarm-time ?al ?old)) (alarm-time ?al ?new) (moved-later ?al)))

  ; API: phone.update_alarm (called with only the optional enabled field)
  (:action phone-update-alarm-enabled
    :parameters (?al - alarm ?t - token ?f - flag)
    :precondition (and (not (task-completed)) (has-token phone ?t) (alarms-listed) (flag-false ?f) (enabled ?al) (not (go-to-sleep-alarm ?al)))
    :effect (and (not (enabled ?al))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)) (moved-later alarm-go-to-sleep) (enabled alarm-go-to-sleep) (not (enabled alarm-other-1)) (not (enabled alarm-other-2)))
    :effect (and (task-completed)))
)
