(define (domain appworld-771d8fc-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token phone-number text-message voice-message - object)
  (:constants phone - app)
  (:predicates
    (profile-known)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (text-from ?m - text-message ?n - phone-number)
    (voice-from ?v - voice-message ?n - phone-number)
    (text-messages-searched ?n - phone-number)
    (voice-messages-searched ?n - phone-number)
    (text-deleted ?m - text-message)
    (voice-deleted ?v - voice-message)
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
    :precondition (and (profile-known) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (text-messages-searched ?n))

  ; API: phone.delete_text_message
  (:action phone-delete-text-message
    :parameters (?m - text-message ?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (text-from ?m ?n) (text-messages-searched ?n)
                       (not (text-deleted ?m)) (not (task-completed)))
    :effect (text-deleted ?m))

  ; API: phone.search_voice_messages
  (:action phone-search-voice-messages
    :parameters (?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (voice-messages-searched ?n))

  ; API: phone.delete_voice_message
  (:action phone-delete-voice-message
    :parameters (?v - voice-message ?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (voice-from ?v ?n) (voice-messages-searched ?n)
                       (not (voice-deleted ?v)) (not (task-completed)))
    :effect (voice-deleted ?v))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (task-completed))
)
