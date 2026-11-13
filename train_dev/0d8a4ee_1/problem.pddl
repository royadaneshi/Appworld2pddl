(define (problem task-0d8a4ee-1)
  (:domain appworld-0d8a4ee-1)
  (:objects
    erika - person
    phone-username-4226809725 venmo-username-erikabail-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    parents siblings - relationship
    parent-1-email parent-2-email sibling-1-email sibling-2-email - email
    parent-1-phone parent-2-phone sibling-1-phone sibling-2-phone - phone-number)
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone phone-username-4226809725)
    (username-for venmo venmo-username-erikabail-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (relation parent-1 parents)
    (relation parent-2 parents)
    (relation sibling-1 siblings)
    (relation sibling-2 siblings)
    (contact-email parent-1 parent-1-email)
    (contact-email parent-2 parent-2-email)
    (contact-email sibling-1 sibling-1-email)
    (contact-email sibling-2 sibling-2-email)
    (contact-phone parent-1 parent-1-phone)
    (contact-phone parent-2 parent-2-phone)
    (contact-phone sibling-1 sibling-1-phone)
    (contact-phone sibling-2 sibling-2-phone)
    (has-venmo-account parent-2)
    (has-venmo-account sibling-2))
  (:goal (and
    (venmo-checked parent-1)
    (venmo-checked parent-2)
    (venmo-checked sibling-1)
    (venmo-checked sibling-2)
    (message-sent parent-1 message-please-get-on-venmo)
    (message-sent sibling-1 message-please-get-on-venmo)
    (task-completed))))
