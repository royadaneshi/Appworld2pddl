(define (problem task-ffe6d5e-3)
  (:domain appworld-ffe6d5e-3)
  (:objects
    cory mother - person
    username-5412564532 username-corwils-at-gmail-com - username
    phone-password simple-note-password - password
    phone-token simple-note-token - token
    mother-phone-number - phone-number
    relationship-mother - relationship
    query-favorite-recipes - query
    favorite-recipes-note - note
    favorite-recipe-name - recipe
  )
  (:init
    (credential-of-app phone username-5412564532)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app simple-note username-corwils-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (username-for phone username-5412564532)
    (username-for simple-note username-corwils-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (has-relationship mother relationship-mother)
    (phone-number-of mother mother-phone-number)
    (note-matches-query favorite-recipes-note query-favorite-recipes)
    (recipe-in-note favorite-recipe-name favorite-recipes-note)
    (is-favorite favorite-recipe-name)
  )
  (:goal (and
    (replied-with mother favorite-recipe-name)
    (task-completed)
  ))
)
