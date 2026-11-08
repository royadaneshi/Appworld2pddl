(define (problem task-ff58e36-3)
  (:domain appworld-ff58e36-3)
  (:objects
    debra-ritter - person
    phone-3375602296 de-ritt-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    coworker-1-email coworker-2-email roommate-1-email roommate-2-email - email)
  (:init
    (username-for phone phone-3375602296)
    (username-for venmo de-ritt-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (has-relation coworker-1 coworkers)
    (has-relation coworker-2 coworkers)
    (has-relation roommate-1 roommates)
    (has-relation roommate-2 roommates)
    (contact-email coworker-1 coworker-1-email)
    (contact-email coworker-2 coworker-2-email)
    (contact-email roommate-1 roommate-1-email)
    (contact-email roommate-2 roommate-2-email))
  (:goal (and
    (contacts-found coworkers)
    (contacts-found roommates)
    (is-friend coworker-1)
    (is-friend coworker-2)
    (is-friend roommate-1)
    (is-friend roommate-2)
    (task-completed)))
)
