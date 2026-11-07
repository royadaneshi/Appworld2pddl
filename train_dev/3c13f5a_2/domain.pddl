(define (domain appworld-3c13f5a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token email query relationship
    directory-path substring entry-type file-path amount note payment-request - object
  )
  (:constants venmo phone file-system - app)
  (:predicates
    (passwords-known)
    (profile-known)
    (current-date-known)
    (roommates-found)
    (task-completed)
    (password-for ?a - app ?pw - password)
    (login-username ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (roommate ?p - person)
    (roommate-email ?p - person ?e - email)
    (request-for ?r - payment-request ?p - person)
    (roommate-query ?q - query)
    (roommate-relationship ?rel - relationship)
    (home-directory ?d - directory-path)
    (bill-substring ?s - substring)
    (files-entry-type ?et - entry-type)
    (last-month-bill-receipt ?f - file-path)
    (known-file ?f - file-path)
    (bill-share ?amt - amount)
    (found-share-amount ?amt - amount)
    (request-note ?n - note)
    (request-sent ?r - payment-request ?amt - amount ?n - note)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters ()
    :precondition (not (task-completed))
    :effect (profile-known)
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
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (login-username phone ?u)
      (password-for phone ?pw)
      (not (has-token phone ?t))
    )
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts
  (:action phone-search-contacts
    :parameters (?t - token ?q - query ?rel - relationship)
    :precondition (and
      (not (task-completed))
      (has-token phone ?t)
      (roommate-query ?q)
      (roommate-relationship ?rel)
    )
    :effect (roommates-found)
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (login-username file-system ?u)
      (password-for file-system ?pw)
      (not (has-token file-system ?t))
    )
    :effect (has-token file-system ?t)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path ?s - substring ?et - entry-type ?f - file-path)
    :precondition (and
      (not (task-completed))
      (has-token file-system ?t)
      (current-date-known)
      (home-directory ?d)
      (bill-substring ?s)
      (files-entry-type ?et)
      (last-month-bill-receipt ?f)
    )
    :effect (known-file ?f)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token ?amt - amount)
    :precondition (and
      (not (task-completed))
      (has-token file-system ?t)
      (known-file ?f)
      (last-month-bill-receipt ?f)
      (roommates-found)
      (bill-share ?amt)
    )
    :effect (found-share-amount ?amt)
  )

  ; API: venmo.login
  (:action venmo-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and
      (not (task-completed))
      (profile-known)
      (passwords-known)
      (login-username venmo ?u)
      (password-for venmo ?pw)
      (not (has-token venmo ?t))
    )
    :effect (has-token venmo ?t)
  )

  ; API: venmo.create_payment_request
  (:action venmo-create-payment-request
    :parameters (?e - email ?amt - amount ?t - token ?n - note ?r - payment-request ?p - person)
    :precondition (and
      (not (task-completed))
      (has-token venmo ?t)
      (roommates-found)
      (roommate ?p)
      (roommate-email ?p ?e)
      (request-for ?r ?p)
      (found-share-amount ?amt)
      (request-note ?n)
      (not (request-sent ?r ?amt ?n))
    )
    :effect (request-sent ?r ?amt ?n)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?r1 - payment-request ?r2 - payment-request ?amt - amount ?n - note)
    :precondition (and
      (not (task-completed))
      (not (= ?r1 ?r2))
      (bill-share ?amt)
      (request-note ?n)
      (request-sent ?r1 ?amt ?n)
      (request-sent ?r2 ?amt ?n)
    )
    :effect (task-completed)
  )
)
