(define (domain appworld-302c169-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person alarm username password token alarm-time bool-value - object)
  (:constants phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (alarms-listed)
    (go-to-sleep-alarm ?al - alarm)
    (alarm-time ?al - alarm ?tm - alarm-time)
    (one-hour-later ?from - alarm-time ?to - alarm-time)
    (enabled ?al - alarm)
    (shifted-one-hour-later ?al - alarm)
    (is-false ?v - bool-value)
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

  ; API: phone.update_alarm  (called with the optional `time` argument)
  (:action phone-update-alarm-time
    :parameters (?al - alarm ?t - token ?new - alarm-time ?old - alarm-time)
    :precondition (and (not (task-completed))
                       (has-token phone ?t)
                       (alarms-listed)
                       (go-to-sleep-alarm ?al)
                       (alarm-time ?al ?old)
                       (one-hour-later ?old ?new)
                       (not (shifted-one-hour-later ?al)))
    :effect (and (not (alarm-time ?al ?old))
                 (alarm-time ?al ?new)
                 (shifted-one-hour-later ?al)))

  ; API: phone.update_alarm  (called with the optional `enabled` argument)
  (:action phone-update-alarm-enabled
    :parameters (?al - alarm ?t - token ?v - bool-value)
    :precondition (and (not (task-completed))
                       (has-token phone ?t)
                       (alarms-listed)
                       (is-false ?v)
                       (enabled ?al)
                       (not (go-to-sleep-alarm ?al)))
    :effect (and (not (enabled ?al))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?target - alarm ?o1 - alarm ?o2 - alarm)
    :precondition (and (not (task-completed))
                       (go-to-sleep-alarm ?target)
                       (shifted-one-hour-later ?target)
                       (enabled ?target)
                       (not (= ?o1 ?o2))
                       (not (= ?o1 ?target))
                       (not (= ?o2 ?target))
                       (not (enabled ?o1))
                       (not (enabled ?o2)))
    :effect (and (task-completed)))
)
