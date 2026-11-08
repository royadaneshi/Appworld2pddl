(define (problem task-ffe6d5e-2)
  (:domain appworld-ffe6d5e-2)
  (:objects
    jessica husband - person
    phone-username-3808719492 username-jes-mill-at-gmail-com - username
    phone-password simple-note-password - password
    phone-token simple-note-token - token
    relationship-husband - relationship
    husband-phone-number - phone-number
    query-favorite-recipes - query
    favorite-recipes-note - note
    favorite-recipe - recipe)
  (:init
    (username-for phone phone-username-3808719492)
    (password-for phone phone-password)
    (username-for simple-note username-jes-mill-at-gmail-com)
    (password-for simple-note simple-note-password)
    (contact-relationship husband relationship-husband)
    (phone-number-of husband husband-phone-number)
    (note-matches-query favorite-recipes-note query-favorite-recipes)
    (recipe-in-note favorite-recipe favorite-recipes-note))
  (:goal (and (replied-with-recipe husband favorite-recipe)
              (task-completed)))
)
