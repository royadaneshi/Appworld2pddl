(define (domain appworld-ccf4b82-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person payment-request payment-card username password token status amount - object)
  (:constants venmo - app)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (received-requests-listed)
    (pending ?r - payment-request)
    (received-this-month ?r - payment-request)
    (approved ?r - payment-request)
    (balance-known)
    (remaining-balance ?amt - amount)
    (payment-cards-listed)
    (balance-withdrawn)
    (withdrawn-to ?c - payment-card)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) (not (task-completed)))
    :effect (and (has-token venmo ?t)))

  ; API: venmo.show_received_payment_requests
  (:action venmo-show-received-payment-requests
    :parameters (?t - token ?s - status)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (received-requests-listed)))

  ; API: venmo.approve_payment_request
  (:action venmo-approve-payment-request
    :parameters (?r - payment-request ?t - token)
    :precondition (and (has-token venmo ?t) (received-requests-listed) (pending ?r) (not (approved ?r)) (not (balance-withdrawn)) (not (task-completed)))
    :effect (and (approved ?r) (not (pending ?r)) (not (balance-known))))

  ; API: venmo.show_venmo_balance
  (:action venmo-show-venmo-balance
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (balance-known)))

  ; API: venmo.show_payment_cards
  (:action venmo-show-payment-cards
    :parameters (?t - token)
    :precondition (and (has-token venmo ?t) (not (task-completed)))
    :effect (and (payment-cards-listed)))

  ; API: venmo.withdraw_from_venmo_balance
  (:action venmo-withdraw-from-venmo-balance
    :parameters (?amt - amount ?c - payment-card ?t - token)
    :precondition (and (has-token venmo ?t) (balance-known) (remaining-balance ?amt) (payment-cards-listed) (not (balance-withdrawn)) (not (task-completed)))
    :effect (and (balance-withdrawn) (withdrawn-to ?c) (not (balance-known))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (balance-withdrawn) (not (task-completed)))
    :effect (and (task-completed)))
)
