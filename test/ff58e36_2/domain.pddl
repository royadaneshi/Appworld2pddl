(define (domain appworld-ff58e36-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person relationship username password token email - object)
  (:constants venmo phone - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contacts-searched ?r - relationship)
    (venmo-friends-checked)
    (venmo-friend ?p - person)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-searched ?r))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (venmo-friends-checked))

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person ?r - relationship)
    :precondition (and (has-token venmo ?t) (venmo-friends-checked) (contacts-searched ?r) (has-relationship ?p ?r) (contact-email ?p ?e) (not (venmo-friend ?p)) (not (task-completed)))
    :effect (venmo-friend ?p))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p1 - person ?p2 - person ?p3 - person)
    :precondition (and (venmo-friend ?p1) (venmo-friend ?p2) (venmo-friend ?p3) (not (= ?p1 ?p2)) (not (= ?p1 ?p3)) (not (= ?p2 ?p3)) (not (task-completed)))
    :effect (task-completed))
)
