(define (problem task-ffe6d5e-1)
  (:domain appworld-ffe6d5e-1)
  (:objects
    hunter wife - person
    username-2123782445 hun-weaver-at-gmail-com - username
    phone-password simple-note-password - password
    phone-token simple-note-token - token
    relationship-wife - relationship
    wife-phone-number - phone-number
    query-favorite-recipes query-recipes - query
    favorite-recipes-note other-recipes-note - note
    favorite-recipe non-favorite-recipe - recipe
    message-favorite-recipe-name message-non-favorite-recipe-name - message
  )
  (:init
    (username-for phone username-2123782445)
    (username-for simple-note hun-weaver-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (has-relationship wife relationship-wife)
    (phone-number-of wife wife-phone-number)
    (note-matches query-favorite-recipes favorite-recipes-note)
    (note-matches query-recipes favorite-recipes-note)
    (note-matches query-recipes other-recipes-note)
    (recipe-in-note favorite-recipe favorite-recipes-note)
    (recipe-in-note non-favorite-recipe other-recipes-note)
    (is-favorite favorite-recipe)
    (message-names message-favorite-recipe-name favorite-recipe)
    (message-names message-non-favorite-recipe-name non-favorite-recipe)
  )
  (:goal (and
    (replied-with-recipe wife favorite-recipe)
    (task-completed)
  ))
)
