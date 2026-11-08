(define (domain appworld-3d9a636-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token email - object)
  (:constants
    supervisor phone venmo - app
    contact-not-friend-1 contact-not-friend-2 contact-and-friend-1 friend-not-contact-1 - person)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (phone-contact ?p - person)
    (venmo-friend ?p - person)
    (email-of ?p - person ?e - email)
    (contacts-listed)
    (friends-listed)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-listed))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (friends-listed))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (contacts-listed) (friends-listed) (phone-contact ?p) (email-of ?p ?e) (not (venmo-friend ?p)) (not (task-completed)))
    :effect (venmo-friend ?p))

  ; API: venmo.remove_friend
  (:action venmo-remove-friend
    :parameters (?e - email ?t - token ?p - person)
    :precondition (and (has-token venmo ?t) (contacts-listed) (friends-listed) (venmo-friend ?p) (not (phone-contact ?p)) (email-of ?p ?e) (not (task-completed)))
    :effect (not (venmo-friend ?p)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (venmo-friend contact-not-friend-1) (venmo-friend contact-not-friend-2) (venmo-friend contact-and-friend-1) (not (venmo-friend friend-not-contact-1)) (not (task-completed)))
    :effect (task-completed))
)
