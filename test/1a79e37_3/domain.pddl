(define (domain appworld-1a79e37-3)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token relationship email date thread
    product-type price sort-key product quantity flag address
    addr-name street city state country zipcode payment-card order - object)
  (:constants supervisor phone gmail amazon - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (task-completed)
    (known-id ?x - object)
    ; phone contact book (static facts)
    (has-relationship ?p - person ?r - relationship)
    (contact-email ?p - person ?e - email)
    (contact-work-address ?p - person ?wa - address)
    ; knowledge gained from phone.search_contacts
    (known-email ?p - person ?e - email)
    (known-work-address ?p - person ?wa - address)
    ; address components (static facts)
    (address-name ?wa - address ?n - addr-name)
    (address-street ?wa - address ?s - street)
    (address-city ?wa - address ?c - city)
    (address-state ?wa - address ?st - state)
    (address-country ?wa - address ?co - country)
    (address-zip ?wa - address ?z - zipcode)
    ; gmail (static facts about the partner's email)
    (today ?d - date)
    (thread-from ?th - thread ?e - email)
    (thread-date ?th - thread ?d - date)
    (email-requests ?th - thread ?pt - product-type ?mp - price ?wa - address)
    ; knowledge gained from reading the email
    (instructions-known ?pt - product-type ?mp - price)
    (deliver-to ?wa - address)
    ; amazon
    (top-rated-product ?prod - product ?pt - product-type ?mp - price)
    (in-cart ?prod - product)
    (address-registered ?wa - address)
    (ordered ?o - order ?prod - product ?wa - address))

  (:action supervisor-show-account-passwords
    ; API: supervisor.show_account_passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known))

  (:action phone-login
    ; API: phone.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (not (task-completed)) (passwords-known)
                       (username-for phone ?u) (password-for phone ?pw)
                       (not (has-token phone ?t)))
    :effect (has-token phone ?t))

  (:action phone-search-contacts
    ; API: phone.search_contacts
    :parameters (?t - token ?r - relationship ?p - person ?e - email ?wa - address)
    :precondition (and (not (task-completed)) (has-token phone ?t)
                       (has-relationship ?p ?r) (contact-email ?p ?e)
                       (contact-work-address ?p ?wa))
    :effect (and (known-email ?p ?e) (known-work-address ?p ?wa)))

  (:action gmail-login
    ; API: gmail.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app gmail ?t) (credential-of-app gmail ?pw) (not (task-completed)) (passwords-known)
                       (username-for gmail ?u) (password-for gmail ?pw)
                       (not (has-token gmail ?t)))
    :effect (has-token gmail ?t))

  (:action gmail-show-inbox-threads
    ; API: gmail.show_inbox_threads
    :parameters (?t - token ?from - email ?d - date ?p - person ?th - thread)
    :precondition (and (not (task-completed)) (has-token gmail ?t)
                       (known-email ?p ?from) (today ?d)
                       (thread-from ?th ?from) (thread-date ?th ?d))
    :effect (known-id ?th))

  (:action gmail-show-thread
    ; API: gmail.show_thread
    :parameters (?th - thread ?t - token ?pt - product-type ?mp - price ?wa - address)
    :precondition (and (not (task-completed)) (has-token gmail ?t)
                       (known-id ?th) (email-requests ?th ?pt ?mp ?wa))
    :effect (and (instructions-known ?pt ?mp) (deliver-to ?wa)))

  (:action amazon-login
    ; API: amazon.login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app amazon ?t) (credential-of-app amazon ?pw) (not (task-completed)) (passwords-known)
                       (username-for amazon ?u) (password-for amazon ?pw)
                       (not (has-token amazon ?t)))
    :effect (has-token amazon ?t))

  (:action amazon-search-products
    ; API: amazon.search_products
    :parameters (?pt - product-type ?mp - price ?sb - sort-key ?prod - product)
    :precondition (and (not (task-completed)) (instructions-known ?pt ?mp)
                       (top-rated-product ?prod ?pt ?mp))
    :effect (known-id ?prod))

  (:action amazon-add-product-to-cart
    ; API: amazon.add_product_to_cart
    :parameters (?prod - product ?t - token ?q - quantity ?cc - flag)
    :precondition (and (not (task-completed)) (has-token amazon ?t) (known-id ?prod))
    :effect (in-cart ?prod))

  (:action amazon-add-address
    ; API: amazon.add_address
    :parameters (?n - addr-name ?s - street ?c - city ?st - state ?co - country ?z - zipcode ?t - token ?p - person ?wa - address)
    :precondition (and (not (task-completed)) (has-token amazon ?t)
                       (known-work-address ?p ?wa) (deliver-to ?wa)
                       (address-name ?wa ?n) (address-street ?wa ?s) (address-city ?wa ?c)
                       (address-state ?wa ?st) (address-country ?wa ?co) (address-zip ?wa ?z))
    :effect (and (address-registered ?wa) (known-id ?wa)))

  (:action amazon-show-payment-cards
    ; API: amazon.show_payment_cards
    :parameters (?t - token ?card - payment-card)
    :precondition (and (not (task-completed)) (has-token amazon ?t))
    :effect (known-id ?card))

  (:action amazon-place-order
    ; API: amazon.place_order
    :parameters (?card - payment-card ?wa - address ?t - token ?prod - product ?o - order)
    :precondition (and (not (task-completed)) (has-token amazon ?t)
                       (known-id ?card) (address-registered ?wa) (known-id ?wa)
                       (in-cart ?prod))
    :effect (and (ordered ?o ?prod ?wa) (not (in-cart ?prod))))

  (:action supervisor-complete-task
    ; API: supervisor.complete_task
    :parameters (?o - order ?prod - product ?wa - address)
    :precondition (and (not (task-completed)) (ordered ?o ?prod ?wa))
    :effect (task-completed))
)
