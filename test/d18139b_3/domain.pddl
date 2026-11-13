(define (domain appworld-d18139b-3)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person payment-request username password token relationship status - object
    amount payment-card - object)
  (:constants phone venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (roommate-relationship ?rel - relationship)
    (pending-status ?s - status)
    (is-roommate ?p - person)
    (sent-by ?r - payment-request ?p - person)
    (created-this-month ?r - payment-request)
    (pending ?r - payment-request)
    (roommates-found)
    (received-requests-found)
    (approved ?r - payment-request)
    (task-completed)
    (balance-known)
    (usable-card ?c - payment-card)
    (card-known ?c - payment-card)
    (shortfall ?a - amount)
    (balance-sufficient))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (token-for phone ?t) (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?rel - relationship)
    :precondition (and (not (task-completed)) (has-token phone ?t) (roommate-relationship ?rel))
    :effect (roommates-found))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for venmo ?u) (password-for venmo ?pw) (token-for venmo ?t) (not (has-token venmo ?t)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (pending-status ?s))
    :effect (received-requests-found))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (balance-known))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token ?c - payment-card)
    :precondition (and (has-token venmo ?t) (usable-card ?c) (not (task-completed)))
    :effect (card-known ?c))

  ; API: venmo.add_to_venmo_balance  (the balance alone does not cover the payments)
  (:action venmo-add-to-venmo-balance
    :parameters (?a - amount ?c - payment-card ?t - token)
    :precondition (and (has-token venmo ?t) (balance-known) (card-known ?c) (shortfall ?a) (not (balance-sufficient)) (not (task-completed)))
    :effect (balance-sufficient))

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token ?p - person)
    :precondition (and (not (task-completed)) (has-token venmo ?t) (balance-sufficient) (roommates-found) (received-requests-found) (sent-by ?r ?p) (is-roommate ?p) (created-this-month ?r) (pending ?r) (not (approved ?r)))
    :effect (and (approved ?r) (not (pending ?r))))


  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (forall (?r - payment-request) (imply (created-this-month ?r) (approved ?r))) (not (task-completed)))
    :effect (task-completed))

)
