(define (domain appworld-ff58e36-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person email username password token relationship - object
  )
  (:constants
    supervisor phone venmo - app
    friend-1 friend-2 roommate-1 roommate-2 - person
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (relationships-known)
    (contact-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contacts-found ?r - relationship)
    (venmo-friends-known)
    (venmo-friend ?p - person)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: phone.show_contact_relationships
  (:action phone-show-contact-relationships
    :parameters (?t - token)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (relationships-known))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (relationships-known) (not (task-completed)))
    :effect (and (contacts-found ?r))
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t))
  )

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (venmo-friends-known))
  )

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (venmo-friends-known) (contacts-found ?r) (contact-relationship ?p ?r) (contact-email ?p ?e) (not (venmo-friend ?p)) (not (task-completed)))
    :effect (and (venmo-friend ?p))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (venmo-friend friend-1) (venmo-friend friend-2) (venmo-friend roommate-1) (venmo-friend roommate-2) (not (task-completed)))
    :effect (and (task-completed))
  )
)
