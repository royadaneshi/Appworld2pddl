(define (domain appworld-3d9a636-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email relationship count - object
  )
  (:constants
    phone venmo - app
    n0 - count
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (friend-relationship ?r - relationship)
    (email-of ?p - person ?e - email)
    (phone-friend ?p - person)
    (venmo-friend ?p - person)
    (phone-friends-found)
    (venmo-friends-found)
    (next ?n - count ?m - count)
    (befriend-remaining ?n - count)
    (unfriend-remaining ?n - count)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (friend-relationship ?r) (not (task-completed)))
    :effect (phone-friends-found)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.search_friends
  (:action venmo-search-friends
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (venmo-friends-found)
  )

  ; API: venmo.add_friend
  (:action venmo-add-friend
    :parameters (?e - email ?t - token ?p - person ?n - count ?m - count)
    :precondition (and (has-token venmo ?t) (phone-friends-found) (venmo-friends-found) (email-of ?p ?e) (phone-friend ?p) (not (venmo-friend ?p)) (befriend-remaining ?n) (next ?n ?m) (not (task-completed)))
    :effect (and (venmo-friend ?p) (not (befriend-remaining ?n)) (befriend-remaining ?m))
  )

  ; API: venmo.remove_friend
  (:action venmo-remove-friend
    :parameters (?e - email ?t - token ?p - person ?n - count ?m - count)
    :precondition (and (has-token venmo ?t) (phone-friends-found) (venmo-friends-found) (email-of ?p ?e) (venmo-friend ?p) (not (phone-friend ?p)) (unfriend-remaining ?n) (next ?n ?m) (not (task-completed)))
    :effect (and (not (venmo-friend ?p)) (not (unfriend-remaining ?n)) (unfriend-remaining ?m))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (befriend-remaining n0) (unfriend-remaining n0) (not (task-completed)))
    :effect (task-completed)
  )
)
