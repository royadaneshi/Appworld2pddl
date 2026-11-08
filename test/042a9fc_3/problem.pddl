(define (problem task-042a9fc-3)
  (:domain appworld-042a9fc-3)
  (:objects
    lindsey roommate-1 roommate-2 - person
    phone-roommate-1 phone-roommate-2 - phone-number
    username-3567801924 lindseysimpson-at-gmail-com - username
    phone-password spotify-password - password
    phone-token spotify-token - token
    roommates - relationship
    query-song-add-1 query-song-add-2 - query)
  (:init
    (username-for phone username-3567801924)
    (username-for spotify lindseysimpson-at-gmail-com)
    (password-for phone phone-password)
    (password-for spotify spotify-password)
    (has-relationship roommate-1 roommates)
    (has-relationship roommate-2 roommates)
    (phone-of roommate-1 phone-roommate-1)
    (phone-of roommate-2 phone-roommate-2)
    (suggests-add roommate-1 song-add-1)
    (suggests-remove roommate-1 song-remove-1)
    (suggests-add roommate-2 song-add-2)
    (suggests-remove roommate-2 song-remove-2)
    (search-query song-add-1 query-song-add-1)
    (search-query song-add-2 query-song-add-2)
    (in-playlist song-remove-1 roadtrip-playlist)
    (in-playlist song-remove-2 roadtrip-playlist))
  (:goal (and
    (in-playlist song-add-1 roadtrip-playlist)
    (in-playlist song-add-2 roadtrip-playlist)
    (not (in-playlist song-remove-1 roadtrip-playlist))
    (not (in-playlist song-remove-2 roadtrip-playlist))
    (task-completed)))
)
