(define (domain appworld-302c169-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person alarm username password token clock-time flag - object)
  (:constants
    phone - app
    alarm-go-to-sleep alarm-other-1 alarm-other-2 alarm-other-3 - alarm)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (alarms-listed)
    (required-time-arg ?al - alarm ?tm - clock-time)
    (required-enabled-arg ?al - alarm ?f - flag)
    (alarm-updated ?al - alarm)
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

  ; API: phone.update_alarm
  (:action phone-update-alarm
    :parameters (?al - alarm ?t - token ?tm - clock-time ?f - flag)
    :precondition (and (not (task-completed)) (has-token phone ?t) (alarms-listed) (not (alarm-updated ?al)) (required-time-arg ?al ?tm) (required-enabled-arg ?al ?f))
    :effect (and (alarm-updated ?al)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (alarm-updated alarm-go-to-sleep)
      (alarm-updated alarm-other-1)
      (alarm-updated alarm-other-2)
      (alarm-updated alarm-other-3)
      (not (task-completed)))
    :effect (and (task-completed)))
)
