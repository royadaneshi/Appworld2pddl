(define (domain appworld-13547f5-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token phone-number message relationship - object)
  (:constants
    phone - app
    roommate-1 roommate-2 - person
    msg-i-have-taken-out-the-trash - message)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (has-relationship ?p - person ?r - relationship)
    (has-phone-number ?p - person ?n - phone-number)
    (contacts-searched ?r - relationship)
    (voice-message-sent ?p - person ?m - message)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?r - relationship)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (contacts-searched ?r))

  ; API: phone.send_voice_message
  (:action phone-send-voice-message
    :parameters (?n - phone-number ?m - message ?t - token ?p - person ?r - relationship)
    :precondition (and (has-token phone ?t) (has-relationship ?p ?r) (contacts-searched ?r) (has-phone-number ?p ?n) (not (voice-message-sent ?p ?m)) (not (task-completed)))
    :effect (voice-message-sent ?p ?m))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (voice-message-sent roommate-1 msg-i-have-taken-out-the-trash) (voice-message-sent roommate-2 msg-i-have-taken-out-the-trash) (not (task-completed)))
    :effect (task-completed)))
