(define (domain appworld-cb4ee7a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query first-name last-name
    verification-code email-thread payment-card card-name owner-name card-number
    expiry-year expiry-month cvv-number duration - object)
  (:constants spotify gmail - app yearly - duration)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (profile-known)
    (payment-cards-known)
    (password-for ?a - app ?pw - password)
    (chosen-password ?a - app ?pw - password)
    (login-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (supervisor ?p - person)
    (first-name-of ?p - person ?fn - first-name)
    (last-name-of ?p - person ?ln - last-name)
    (email-of ?p - person ?e - email)
    (account-created ?a - app)
    (account-email ?a - app ?e - email)
    (account-verified ?a - app)
    (verification-email-sent ?a - app)
    (query-matches ?q - query ?th - email-thread)
    (code-in-thread ?th - email-thread ?c - verification-code)
    (known-id ?th - email-thread)
    (found-verification-code ?c - verification-code)
    (card-name-of ?pc - payment-card ?cn - card-name)
    (card-owner-of ?pc - payment-card ?on - owner-name)
    (card-number-of ?pc - payment-card ?num - card-number)
    (card-expiry-year-of ?pc - payment-card ?ey - expiry-year)
    (card-expiry-month-of ?pc - payment-card ?em - expiry-month)
    (card-cvv-of ?pc - payment-card ?cvv - cvv-number)
    (card-added ?a - app ?pc - payment-card)
    (premium-subscribed ?a - app ?d - duration)
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

  ; API: supervisor.show_payment_cards
  (:action supervisor-show-payment-cards
    :parameters ()
    :precondition (not (task-completed))
    :effect (payment-cards-known))

  ; API: spotify.signup
  (:action spotify-signup
    :parameters (?fn - first-name ?ln - last-name ?e - email ?pw - password ?p - person)
    :precondition (and (passwords-known) (not (task-completed)) (profile-known) (supervisor ?p)
                       (first-name-of ?p ?fn) (last-name-of ?p ?ln) (email-of ?p ?e)
                       (chosen-password spotify ?pw) (not (account-created spotify)))
    :effect (and (account-created spotify) (account-email spotify ?e) (verification-email-sent spotify)))


  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (credential-of-app gmail ?u) (not (task-completed)) (passwords-known) (login-username gmail ?u)
                       (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t)
                       (verification-email-sent spotify) (query-matches ?q ?th))
    :effect (known-id ?th))

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - verification-code)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th) (code-in-thread ?th ?c))
    :effect (found-verification-code ?c))

  ; API: spotify.verify_account
  (:action spotify-verify-account
    :parameters (?e - email ?c - verification-code)
    :precondition (and (not (task-completed)) (account-created spotify) (account-email spotify ?e)
                       (found-verification-code ?c) (not (account-verified spotify)))
    :effect (account-verified spotify))

  ; API: spotify.login
  (:action spotify-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app spotify ?t) (credential-of-app spotify ?pw) (credential-of-app spotify ?u) (not (task-completed)) (account-verified spotify) (login-username spotify ?u)
                       (chosen-password spotify ?pw) (not (has-token spotify ?t)))
    :effect (has-token spotify ?t))

  ; API: spotify.add_payment_card
  (:action spotify-add-payment-card
    :parameters (?cn - card-name ?on - owner-name ?num - card-number ?ey - expiry-year
                 ?em - expiry-month ?cvv - cvv-number ?t - token ?pc - payment-card)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (payment-cards-known)
                       (card-name-of ?pc ?cn) (card-owner-of ?pc ?on) (card-number-of ?pc ?num)
                       (card-expiry-year-of ?pc ?ey) (card-expiry-month-of ?pc ?em) (card-cvv-of ?pc ?cvv)
                       (not (card-added spotify ?pc)))
    :effect (card-added spotify ?pc))

  ; API: spotify.subscribe_premium
  (:action spotify-subscribe-premium
    :parameters (?pc - payment-card ?d - duration ?t - token)
    :precondition (and (not (task-completed)) (has-token spotify ?t) (card-added spotify ?pc)
                       (not (premium-subscribed spotify ?d)))
    :effect (premium-subscribed spotify ?d))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (not (task-completed)) (account-created spotify) (account-verified spotify)
                       (premium-subscribed spotify yearly))
    :effect (task-completed))
)
