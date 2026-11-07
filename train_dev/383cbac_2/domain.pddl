(define (domain appworld-383cbac-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query relationship amount - object)
  (:constants
    phone venmo - app
    rel-coworker rel-manager - relationship)
  (:predicates
    (passwords-known)
    (profile-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (current-date-known)
    (query-for ?q - query ?r - relationship)
    (contacts-found ?r - relationship)
    (found-total ?amt - amount)
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
    :precondition (and (passwords-known) (profile-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?r - relationship)
    :precondition (and (has-token phone ?t) (query-for ?q ?r) (not (task-completed)))
    :effect (contacts-found ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (profile-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_social_feed
  (:action venmo-show-social-feed
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token venmo ?t) (contacts-found rel-coworker) (contacts-found rel-manager) (current-date-known) (not (task-completed)))
    :effect (found-total ?amt))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount)
    :precondition (and (found-total ?amt) (not (task-completed)))
    :effect (task-completed)))
