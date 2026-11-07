(define (domain appworld-383cbac-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query relationship amount - object)
  (:constants
    phone venmo - app
    coworker manager - relationship)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (current-datetime-known)
    (query-for-relationship ?q - query ?r - relationship)
    (known-contacts ?r - relationship)
    (my-share ?amt - amount)
    (answer-slot ?amt - amount)
    (found-total ?amt - amount)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (current-datetime-known)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (not (task-completed))
                       (has-token phone ?t)
                       (query-for-relationship ?q ?r))
    :effect (and (known-contacts ?r)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (profile-known)
                       (passwords-known)
                       (username-for venmo ?u)
                       (password-for venmo ?pw)
                       (not (has-token venmo ?t)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_social_feed
  (:action venmo-show-social-feed
    :parameters (?t - token ?share - amount ?total - amount)
    :precondition (and (not (task-completed))
                       (has-token venmo ?t)
                       (known-contacts coworker)
                       (known-contacts manager)
                       (current-datetime-known)
                       (my-share ?share)
                       (answer-slot ?total))
    :effect (and (found-total ?total)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount)
    :precondition (and (not (task-completed))
                       (found-total ?answer))
    :effect (and (task-completed))))
