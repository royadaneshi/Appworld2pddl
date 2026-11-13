(define (domain appworld-ff58e36-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person relation username password token email - object)
  (:constants
    supervisor phone venmo - app
    coworkers roommates - relation
    coworker-new-1 coworker-new-2 coworker-new-3 coworker-new-4 roommate-new-1 coworker-already-1 coworker-already-2 coworker-already-3 coworker-already-4 roommate-already-1 - person
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
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
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
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
    :precondition (and (credential-of-app venmo ?t) (credential-of-app venmo ?pw) (credential-of-app venmo ?u) (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)))
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
    :precondition (and
      (contacts-found coworkers)
      (contacts-found roommates)
      (is-friend coworker-new-1)
      (is-friend coworker-new-2)
      (is-friend coworker-new-3)
      (is-friend coworker-new-4)
      (is-friend roommate-new-1)
      (is-friend coworker-already-1)
      (is-friend coworker-already-2)
      (is-friend coworker-already-3)
      (is-friend coworker-already-4)
      (is-friend roommate-already-1)
      (not (task-completed))
      (not (task-completed)))
    :effect (task-completed))
)
