(define (domain appworld-302c169-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token alarm time-value bool-value - object)
  (:constants phone - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (phone-username ?u - username)
    (has-token ?a - app ?t - token)
    (alarms-listed)
    (alarm-setting ?al - alarm ?tm - time-value ?en - bool-value)
    (time-arg ?al - alarm ?old - time-value ?new - time-value)
    (enabled-arg ?al - alarm ?old - bool-value ?new - bool-value)
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

  ; API: phone.update_alarm
  (:action phone-update-alarm
    :parameters (?al - alarm ?t - token ?tm - time-value ?en - bool-value ?old-tm - time-value ?old-en - bool-value)
    :precondition (and (has-token phone ?t) (alarms-listed)
                       (alarm-setting ?al ?old-tm ?old-en)
                       (time-arg ?al ?old-tm ?tm)
                       (enabled-arg ?al ?old-en ?en)
                       (not (task-completed)))
    :effect (and (not (alarm-setting ?al ?old-tm ?old-en))
                 (alarm-setting ?al ?tm ?en)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (not (task-completed))
    :effect (task-completed))
)
