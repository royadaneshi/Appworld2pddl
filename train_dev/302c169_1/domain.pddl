(define (domain appworld-302c169-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person alarm username password token clock-time bool-value - object)
  (:constants phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (alarms-listed)
    (go-to-sleep-alarm ?al - alarm)
    (desired-time ?al - alarm ?tm - clock-time)
    (desired-enabled ?al - alarm ?v - bool-value)
    (alarm-time ?al - alarm ?tm - clock-time)
    (alarm-enabled ?al - alarm ?v - bool-value)
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
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (username-for phone ?u)
                       (password-for phone ?pw)
                       (not (has-token phone ?t)))
    :effect (and (has-token phone ?t)))

  ; API: phone.show_alarms
  (:action phone-show-alarms
    :parameters (?t - token)
    :precondition (and (not (task-completed))
                       (has-token phone ?t))
    :effect (and (alarms-listed)))

  ; API: phone.update_alarm
  (:action phone-update-alarm
    :parameters (?al - alarm ?t - token ?tm - clock-time ?en - bool-value)
    :precondition (and (not (task-completed))
                       (has-token phone ?t)
                       (alarms-listed)
                       (not (alarm-updated ?al))
                       (desired-time ?al ?tm)
                       (desired-enabled ?al ?en))
    :effect (and (alarm-time ?al ?tm)
                 (alarm-enabled ?al ?en)
                 (alarm-updated ?al)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (task-completed)))
)
