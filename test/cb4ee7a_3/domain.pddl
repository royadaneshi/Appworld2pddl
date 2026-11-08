(define (domain appworld-cb4ee7a-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person - object
    first-name last-name email username password token - object
    query email-thread verification-code - object
    card-name owner-name card-number expiry-year expiry-month cvv-number - object
    payment-card duration - object
  )
  (:constants amazon gmail - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (payment-cards-known)
    (task-completed)
    (is-supervisor ?p - person)
    (person-first-name ?p - person ?fn - first-name)
    (person-last-name ?p - person ?ln - last-name)
    (person-email ?p - person ?e - email)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (account-exists ?a - app)
    (account-email ?a - app ?e - email)
    (verification-sent ?a - app)
    (account-verified ?a - app)
    (verification-thread ?a - app ?th - email-thread)
    (query-finds ?q - query ?th - email-thread)
    (known-id ?th - email-thread)
    (thread-contains-code ?th - email-thread ?c - verification-code)
    (code-found ?c - verification-code)
    (verification-code-for ?a - app ?c - verification-code)
    (card-name-of ?card - payment-card ?cn - card-name)
    (card-owner-of ?card - payment-card ?on - owner-name)
    (card-number-of ?card - payment-card ?num - card-number)
    (card-expiry-year-of ?card - payment-card ?ey - expiry-year)
    (card-expiry-month-of ?card - payment-card ?em - expiry-month)
    (card-cvv-of ?card - payment-card ?cvv - cvv-number)
    (card-added ?card - payment-card)
    (target-duration ?d - duration)
    (prime-subscribed ?a - app)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (profile-known))
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known))
  )

  ; API: supervisor.show_payment_cards
  (:action supervisor-show-payment-cards
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (payment-cards-known))
  )

  ; API: amazon.signup
  (:action amazon-signup
    :parameters (?fn - first-name ?ln - last-name ?e - email ?pw - password ?p - person)
    :precondition (and (not (task-completed)) (profile-known) (is-supervisor ?p)
                       (person-first-name ?p ?fn) (person-last-name ?p ?ln) (person-email ?p ?e)
                       (password-for amazon ?pw) (not (account-exists amazon)))
    :effect (and (account-exists amazon) (account-email amazon ?e) (verification-sent amazon))
  )

  ; API: amazon.send_verification_code
  (:action amazon-send-verification-code
    :parameters (?e - email)
    :precondition (and (not (task-completed)) (account-exists amazon) (account-email amazon ?e) (not (account-verified amazon)))
    :effect (and (verification-sent amazon))
  )

  ; API: gmail.login
  (:action gmail-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (passwords-known) (username-for gmail ?u) (password-for gmail ?pw) (not (has-token gmail ?t)))
    :effect (and (has-token gmail ?t))
  )

  ; API: gmail.show_inbox_threads
  (:action gmail-show-inbox-threads
    :parameters (?t - token ?q - query ?th - email-thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (verification-sent amazon) (verification-thread amazon ?th) (query-finds ?q ?th))
    :effect (and (known-id ?th))
  )

  ; API: gmail.show_thread
  (:action gmail-show-thread
    :parameters (?th - email-thread ?t - token ?c - verification-code)
    :precondition (and (not (task-completed)) (has-token gmail ?t) (known-id ?th) (thread-contains-code ?th ?c))
    :effect (and (code-found ?c))
  )

  ; API: amazon.verify_account
  (:action amazon-verify-account
    :parameters (?e - email ?c - verification-code)
    :precondition (and (not (task-completed)) (account-exists amazon) (account-email amazon ?e) (code-found ?c) (verification-code-for amazon ?c) (not (account-verified amazon)))
    :effect (and (account-verified amazon))
  )

  ; API: amazon.login
  (:action amazon-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (not (task-completed)) (account-exists amazon) (account-verified amazon) (username-for amazon ?u) (password-for amazon ?pw) (not (has-token amazon ?t)))
    :effect (and (has-token amazon ?t))
  )

  ; API: amazon.add_payment_card
  (:action amazon-add-payment-card
    :parameters (?cn - card-name ?on - owner-name ?num - card-number ?ey - expiry-year ?em - expiry-month ?cvv - cvv-number ?t - token ?card - payment-card)
    :precondition (and (not (task-completed)) (payment-cards-known) (has-token amazon ?t)
                       (card-name-of ?card ?cn) (card-owner-of ?card ?on) (card-number-of ?card ?num)
                       (card-expiry-year-of ?card ?ey) (card-expiry-month-of ?card ?em) (card-cvv-of ?card ?cvv)
                       (not (card-added ?card)))
    :effect (and (card-added ?card))
  )

  ; API: amazon.subscribe_prime
  (:action amazon-subscribe-prime
    :parameters (?card - payment-card ?d - duration ?t - token)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (card-added ?card) (target-duration ?d) (not (prime-subscribed amazon)))
    :effect (and (prime-subscribed amazon))
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (account-exists amazon) (account-verified amazon) (prime-subscribed amazon) (not (task-completed)))
    :effect (and (task-completed))
  )
)
