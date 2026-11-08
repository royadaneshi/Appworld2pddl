(define (domain appworld-cb4ee7a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app username password token email name query code email-thread payment-card duration
    card-name owner-name card-number expiry-year expiry-month cvv-number - object)
  (:constants amazon gmail - app monthly - duration)
  (:predicates
    (passwords-known)
    (cards-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (token-for ?a - app ?t - token)
    (has-token ?a - app ?t - token)
    (supervisor-first-name ?n - name)
    (supervisor-last-name ?n - name)
    (supervisor-email ?e - email)
    (signup-password ?pw - password)
    (account-created)
    (verification-sent)
    (account-verified)
    (verification-email-thread ?th - email-thread)
    (thread-exists ?th - email-thread)
    (query-matches ?q - query ?th - email-thread)
    (code-in-thread ?th - email-thread ?c - code)
    (known-id ?x - object)
    (known-code ?c - code)
    (card-details ?c - payment-card ?cn - card-name ?on - owner-name ?num - card-number ?ey - expiry-year ?em - expiry-month ?cvv - cvv-number)
    (card-added ?c - payment-card)
    (subscribed-prime ?d - duration)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  ; API: supervisor.show_payment_cards
  (:action supervisor-show-payment-cards
    :parameters ()
    :precondition (not (task-completed))
    :effect (cards-known))

  ; API: amazon.signup
  (:action amazon-signup
    :parameters (?fn - name ?ln - name ?e - email ?pw - password)
    :precondition (and (not (task-completed))
                       (supervisor-first-name ?fn)
                       (supervisor-last-name ?ln)
                       (supervisor-email ?e)
                       (signup-password ?pw)
                       (not (account-created)))
    :effect (and (account-created) (password-for amazon ?pw)))

  ; API: amazon.send_verification_code
  (:action amazon-send-verification-code
    :parameters (?e - email ?th - email-thread)
    :precondition (and (not (task-completed))
                       (supervisor-email ?e)
                       (account-created)
                       (not (account-verified))
                       (verification-email-thread ?th))
    :effect (and (verification-sent) (thread-exists ?th)))

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (passwords-known)
                       (username-for gmail ?u)
                       (password-for gmail ?pw)
                       (token-for gmail ?t)
                       (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed))
                       (has-token gmail ?t)
                       (thread-exists ?th)
                       (query-matches ?q ?th))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - code)
    :precondition (and (not (task-completed))
                       (has-token gmail ?t)
                       (known-id ?th)
                       (code-in-thread ?th ?c))
    :effect (known-code ?c))

  ; API: amazon.verify_account
  (:action amazon-verify-account
    :parameters (?e - email ?c - code)
    :precondition (and (not (task-completed))
                       (supervisor-email ?e)
                       (account-created)
                       (verification-sent)
                       (known-code ?c)
                       (not (account-verified)))
    :effect (account-verified))

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed))
                       (account-verified)
                       (username-for amazon ?u)
                       (password-for amazon ?pw)
                       (token-for amazon ?t)
                       (not (has-token amazon ?t)))
    :effect (has-token amazon ?t))

  ; API: amazon.add_payment_card
  (:action amazon-add-payment-card
    :parameters (?cn - card-name ?on - owner-name ?num - card-number ?ey - expiry-year ?em - expiry-month ?cvv - cvv-number ?t - token ?c - payment-card)
    :precondition (and (not (task-completed))
                       (has-token amazon ?t)
                       (cards-known)
                       (card-details ?c ?cn ?on ?num ?ey ?em ?cvv)
                       (not (card-added ?c)))
    :effect (and (card-added ?c) (known-id ?c)))

  ; API: amazon.subscribe_prime
  (:action amazon-subscribe-prime
    :parameters (?c - payment-card ?d - duration ?t - token)
    :precondition (and (not (task-completed))
                       (has-token amazon ?t)
                       (card-added ?c)
                       (known-id ?c)
                       (not (subscribed-prime ?d)))
    :effect (subscribed-prime ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed))
                       (account-created)
                       (account-verified)
                       (subscribed-prime monthly))
    :effect (task-completed))
)
