(define (problem task-29caf6f-1)
  (:domain appworld-29caf6f-1)
  (:objects
    joyce christopher - person
    phone-username-3155673041 simple-note-username-joyce-weav-at-gmail-com - username
    phone-password simple-note-password - password
    phone-token simple-note-token - token
    query-christopher query-recommendation-suggestion-movie query-movie-recommendation-suggestion - query
    christopher-phone-number - phone-number
    christopher-request-message - text-message
    christopher-requested-director - director
    movie-recommendations-note - note
    reply-movie-titles - message
    flag-true - flag
  )
  (:init
    (username-for phone phone-username-3155673041)
    (username-for simple-note simple-note-username-joyce-weav-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (contact-query christopher query-christopher)
    (phone-number-of christopher christopher-phone-number)
    (message-query query-recommendation-suggestion-movie)
    (request-of christopher christopher-request-message)
    (request-director-of christopher-request-message christopher-requested-director)
    (note-query movie-recommendations-note query-movie-recommendation-suggestion)
    (reply-for reply-movie-titles christopher-requested-director movie-recommendations-note)
  )
  (:goal (and (message-sent christopher reply-movie-titles) (task-completed)))
)
