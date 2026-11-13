(define (domain appworld-3aa1a22-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query phone-number text-message invitation-code - object
  )
  (:constants phone splitwise - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (messages-searched)
    (message-from ?m - text-message ?n - phone-number)
    (message-has-code ?m - text-message ?c - invitation-code)
    (received-this-week ?m - text-message)
    (in-contacts ?n - phone-number)
    (contact-checked ?n - phone-number)
    (invitation-accepted ?c - invitation-code)
    (message-deleted ?m - text-message)
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
    :precondition (and (has-token phone ?t) (not (task-completed)))
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
    :parameters (?c - invitation-code ?t - token ?m - text-message ?n - phone-number)
    :precondition (and (has-token splitwise ?t) (messages-searched) (message-has-code ?m ?c) (message-from ?m ?n) (received-this-week ?m) (contact-checked ?n) (in-contacts ?n) (not (invitation-accepted ?c)) (not (task-completed)))
    :effect (and (invitation-accepted ?c))
  )

  ; API: phone.delete_text_message
  (:action phone-delete-text-message
    :parameters (?m - text-message ?t - token ?n - phone-number)
    :precondition (and (has-token phone ?t) (messages-searched) (message-from ?m ?n) (received-this-week ?m) (contact-checked ?n) (not (in-contacts ?n)) (not (message-deleted ?m)) (not (task-completed)))
    :effect (and (message-deleted ?m))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - invitation-code ?m - text-message)
    :precondition (and (invitation-accepted ?c) (message-deleted ?m) (not (task-completed)))
    :effect (and (task-completed))
  )
)
