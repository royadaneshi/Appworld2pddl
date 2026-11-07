(define (domain appworld-383cbac-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token query relationship amount - object)
  (:constants
    phone venmo - app
    coworker manager - relationship)
  (:predicates
    (passwords-known)
    (profile-known)
    (date-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?r - relationship)
    (known-contacts ?r - relationship)
    (my-share ?amt - amount)
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

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (date-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (token-for phone ?t) (not (has-token phone ?t))
                       (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (query-for ?q ?r)
                       (not (task-completed)))
    :effect (and (known-contacts ?r)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (profile-known) (passwords-known)
                       (username-for venmo ?u) (password-for venmo ?pw)
                       (token-for venmo ?t) (not (has-token venmo ?t))
                       (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_social_feed
  (:action venmo-show-social-feed
    :parameters (?t - token ?total - amount)
    :precondition (and (has-token venmo ?t) (date-known)
                       (known-contacts coworker) (known-contacts manager)
                       (not (my-share ?total))
                       (not (task-completed)))
    :effect (and (found-total ?total)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?answer - amount)
    :precondition (and (found-total ?answer) (not (task-completed)))
    :effect (and (task-completed)))
)
