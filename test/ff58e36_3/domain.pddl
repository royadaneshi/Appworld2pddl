(define (domain appworld-ff58e36-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person relation username password token email - object)
  (:constants
    supervisor phone venmo - app
    coworkers roommates - relation
    coworker-1 coworker-2 roommate-1 roommate-2 - person)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (relationships-known)
    (has-relation ?p - person ?r - relation)
    (contact-email ?p - person ?e - email)
    (contacts-found ?r - relation)
    (friendship-checked ?p - person)
    (is-friend ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.show_contact_relationships
  (:action phone-show-contact-relationships
    :parameters (?t - token)
    :precondition (and (not (task-completed)) (has-token phone ?t))
    :effect (relationships-known))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relation)
    :precondition (and (not (task-completed)) (has-token phone ?t) (relationships-known))
    :effect (contacts-found ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_profile
  (:action venmo-show-profile
    :parameters (?t - token ?e - email ?p - person ?r - relation)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (contacts-found ?r) (has-relation ?p ?r) (contact-email ?p ?e))
    :effect (friendship-checked ?p))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (contact-email ?p ?e) (friendship-checked ?p) (not (is-friend ?p)))
    :effect (is-friend ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)) (contacts-found coworkers) (contacts-found roommates) (is-friend coworker-1) (is-friend coworker-2) (is-friend roommate-1) (is-friend roommate-2))
    :effect (task-completed))
)
