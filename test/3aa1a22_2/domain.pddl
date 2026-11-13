(define (domain appworld-3aa1a22-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query voice-message phone-number invitation-code group - object)
  (:constants supervisor phone splitwise - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (message-from ?m - voice-message ?n - phone-number)
    (message-has-code ?m - voice-message ?c - invitation-code)
    (code-for-group ?c - invitation-code ?g - group)
    (in-contacts ?n - phone-number)
    (messages-found)
    (contact-checked ?n - phone-number)
    (group-joined ?g - group)
    (message-deleted ?m - voice-message))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_voice_messages
  (:action phone-search-voice-messages
    :parameters (?t - token ?q - query)
    :precondition (and (has-token phone ?t) (not (task-completed)))
    :effect (and (messages-found)))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (messages-found) (not (task-completed)))
    :effect (and (contact-checked ?n)))

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app splitwise ?t) (credential-of-app splitwise ?pw) (credential-of-app splitwise ?u) (passwords-known) (username-for splitwise ?u) (password-for splitwise ?pw) (not (has-token splitwise ?t)) (not (task-completed)))
    :effect (and (has-token splitwise ?t)))

  ; API: splitwise.accept_group_invitation
  (:action splitwise-accept-group-invitation
    :parameters (?c - invitation-code ?t - token ?m - voice-message ?n - phone-number ?g - group)
    :precondition (and (has-token splitwise ?t) (messages-found) (message-has-code ?m ?c) (message-from ?m ?n) (contact-checked ?n) (in-contacts ?n) (code-for-group ?c ?g) (not (group-joined ?g)) (not (task-completed)))
    :effect (and (group-joined ?g)))

  ; API: phone.delete_voice_message
  (:action phone-delete-voice-message
    :parameters (?m - voice-message ?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (messages-found) (message-from ?m ?n) (contact-checked ?n) (not (in-contacts ?n)) (not (message-deleted ?m)) (not (task-completed)))
    :effect (and (message-deleted ?m)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?g - group ?m - voice-message)
    :precondition (and (group-joined ?g) (message-deleted ?m) (not (task-completed)))
    :effect (and (task-completed))))
