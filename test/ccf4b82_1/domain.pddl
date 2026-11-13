(define (domain appworld-ccf4b82-1)
  (:requirements :strips :typing :negative-preconditions :equality :disjunctive-preconditions :universal-preconditions :conditional-effects)
  (:types
    app person payment-request payment-card username password token amount status - object)
  (:constants venmo supervisor - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (task-completed)
    (is-pending-status ?s - status)
    (pending ?r - payment-request)
    (received-this-month ?r - payment-request)
    (requests-listed)
    (approved ?r - payment-request)
    (cards-listed)
    (target-card ?c - payment-card)
    (balance-known ?amt - amount)
    (balance-fresh)
    (balance-zero)
    (withdrawn-to ?c - payment-card))

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
    :precondition (and (has-token venmo ?t) (is-pending-status ?s) (not (task-completed)))
    :effect (requests-listed))

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (requests-listed) (pending ?r) (not (task-completed)))
    :effect (and (approved ?r) (not (pending ?r)) (not (balance-fresh)) (not (balance-zero))))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token ?amt - amount)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (balance-known ?amt) (balance-fresh)))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (cards-listed))

  ; API: venmo.withdraw_from_venmo_balance
  (:action venmo-withdraw-from-venmo-balance
    :parameters (?amt - amount ?c - payment-card ?t - token)
    :precondition (and (has-token venmo ?t) (balance-known ?amt) (balance-fresh) (cards-listed) (not (task-completed)))
    :effect (and (withdrawn-to ?c) (balance-zero) (not (balance-fresh)) (not (balance-known ?amt))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?c - payment-card)
    :precondition (and (forall (?r - payment-request) (imply (received-this-month ?r) (approved ?r))) (target-card ?c) (withdrawn-to ?c) (balance-zero) (not (task-completed)))
    :effect (task-completed))

)
