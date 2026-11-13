(define (domain appworld-3aa1a22-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query text-message phone-number invitation-code group - object
  )
  (:constants phone splitwise - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (messages-searched)
    (invitation-received-yesterday ?m - text-message)
    (message-sender ?m - text-message ?n - phone-number)
    (message-code ?m - text-message ?c - invitation-code)
    (code-for-group ?c - invitation-code ?g - group)
    (sender-in-contacts ?n - phone-number)
    (contact-checked ?n - phone-number)
    (group-joined ?g - group)
    (message-deleted ?m - text-message)
    (task-completed)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (passwords-known)) (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (and (has-token phone ?t))
  )

  ; API: splitwise.login
  (:action splitwise-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app splitwise ?t) (credential-of-app splitwise ?pw) (credential-of-app splitwise ?u) (passwords-known) (username-for splitwise ?u) (password-for splitwise ?pw) (not (has-token splitwise ?t)) (not (task-completed)))
    :effect (and (has-token splitwise ?t))
  )

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?q - query)
    :precondition (and (has-token phone ?t) (not (messages-searched)) (not (task-completed)))
    :effect (and (messages-searched))
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (messages-searched) (not (contact-checked ?n)) (not (task-completed)))
    :effect (and (contact-checked ?n))
  )

  ; API: splitwise.accept_group_invitation
  (:action splitwise-accept-group-invitation
    :parameters (?c - invitation-code ?t - token ?m - text-message ?n - phone-number ?g - group)
    :precondition (and (has-token splitwise ?t) (messages-searched) (invitation-received-yesterday ?m) (message-sender ?m ?n) (message-code ?m ?c) (code-for-group ?c ?g) (contact-checked ?n) (sender-in-contacts ?n) (not (group-joined ?g)) (not (task-completed)))
    :effect (and (group-joined ?g))
  )

  ; API: phone.delete_text_message
  (:action phone-delete-text-message
    :parameters (?m - text-message ?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (messages-searched) (invitation-received-yesterday ?m) (message-sender ?m ?n) (contact-checked ?n) (not (sender-in-contacts ?n)) (not (message-deleted ?m)) (not (task-completed)))
    :effect (and (message-deleted ?m))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?g - group ?m - text-message)
    :precondition (and (group-joined ?g) (message-deleted ?m) (not (task-completed)))
    :effect (and (task-completed))
  )
)
