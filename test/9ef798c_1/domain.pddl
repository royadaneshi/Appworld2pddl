(define (domain appworld-9ef798c-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token query email record - object
    payment-request payment-card - record
  )
  (:constants supervisor phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (query-for ?q - query ?p - person)
    (email-of ?p - person ?e - email)
    (known-email ?p - person ?e - email)
    (requested-by ?r - payment-request ?p - person)
    (known-id ?x - record)
    (approved ?r - payment-request)
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
    :precondition (and (passwords-known) (password-for phone ?pw) (not (has-token phone ?t)) (not (task-completed)))
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?p - person ?e - email)
    :precondition (and (has-token phone ?t) (query-for ?q ?p) (email-of ?p ?e) (not (task-completed)))
    :effect (known-email ?p ?e)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t)
  )

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?r - payment-request ?p - person ?e - email)
    :precondition (and (has-token venmo ?t) (known-email ?p ?e) (requested-by ?r ?p) (not (task-completed)))
    :effect (known-id ?r)
  )

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (known-id ?c)
  )

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (known-id ?r) (known-id ?c) (not (approved ?r)) (not (task-completed)))
    :effect (approved ?r)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r - payment-request)
    :precondition (and (approved ?r) (not (task-completed)))
    :effect (task-completed)
  )
)
