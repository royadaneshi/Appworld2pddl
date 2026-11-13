(define (domain appworld-ccf4b82-2)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person username password token status amount card payment-request - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (pending-status ?s - status)
    (pending-in-window ?r - payment-request)
    (requests-listed)
    (approved ?r - payment-request)
    (balance-known ?amt - amount)
    (balance-up-to-date)
    (cards-listed)
    (target-card ?c - card)
    (withdrawn ?amt - amount ?c - card)
    (balance-settled)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (has-token venmo ?t))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (has-token venmo ?t) (pending-status ?s) (not (task-completed)))
    :effect (requests-listed))

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (requests-listed) (pending-in-window ?r) (not (approved ?r)) (not (task-completed)))
    :effect (and (approved ?r) (not (balance-up-to-date)) (not (balance-settled))))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (balance-known ?amt) (balance-up-to-date)))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (cards-listed))

  ; API: venmo.withdraw_from_venmo_balance
  (:action venmo-withdraw-from-venmo-balance
    :parameters (?amt - amount ?c - card ?t - token)
    :precondition (and (has-token venmo ?t) (balance-known ?amt) (balance-up-to-date) (cards-listed) (target-card ?c) (not (balance-settled)) (not (task-completed)))
    :effect (and (withdrawn ?amt ?c) (balance-settled)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?amt - amount ?c - card)
    :precondition (and (forall (?r - payment-request) (imply (pending-in-window ?r) (approved ?r))) (withdrawn ?amt ?c) (balance-settled) (not (task-completed)))
    :effect (task-completed))
)
