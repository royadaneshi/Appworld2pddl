(define (domain appworld-13547f5-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token relationship phone-number message - object)
  (:constants phone supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (phone-of ?p - person ?n - phone-number)
    (known-phone ?p - person ?n - phone-number)
    (voice-message-sent ?n - phone-number ?m - message)
    (target-person ?p - person)
    (target-message ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (phone-of ?p ?n) (not (task-completed)))
    :effect (and (known-phone ?p ?n)))

  ; API: phone.send_voice_message
  (:action phone-send-voice-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person)
    :precondition (and (has-token phone ?t) (known-phone ?p ?n) (not (task-completed)))
    :effect (and (voice-message-sent ?n ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?p - person ?n - phone-number ?m - message)
    :precondition (and (target-person ?p) (target-message ?m) (phone-of ?p ?n) (voice-message-sent ?n ?m) (not (task-completed)))
    :effect (and (task-completed)))
)
