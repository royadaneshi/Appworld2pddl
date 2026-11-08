(define (problem task-042a9fc-2)
  (:domain appworld-042a9fc-2)
  (:objects
    cheryl sibling-a sibling-b - person
    username-3517418245 cheweber-at-gmail-com - username
    phone-password spotify-password - password
    phone-token spotify-token - token
    relationship-sibling - relationship
    phone-number-sibling-a phone-number-sibling-b - phone-number
    roadtrip-playlist - playlist
    song-to-add song-to-remove - song
    query-song-to-add - query
  )
  (:init
    (username-for phone username-3517418245)
    (username-for spotify cheweber-at-gmail-com)
    (password-for phone phone-password)
    (password-for spotify spotify-password)
    (target-relationship relationship-sibling)
    (is-sibling sibling-a)
    (is-sibling sibling-b)
    (phone-number-of sibling-a phone-number-sibling-a)
    (phone-number-of sibling-b phone-number-sibling-b)
    (suggested-by sibling-a song-to-add)
    (suggested-by sibling-b song-to-remove)
    (suggested-add song-to-add)
    (suggested-remove song-to-remove)
    (song-query song-to-add query-song-to-add)
    (target-playlist roadtrip-playlist)
    (in-playlist roadtrip-playlist song-to-remove)
  )
  (:goal (and
    (in-playlist roadtrip-playlist song-to-add)
    (not (in-playlist roadtrip-playlist song-to-remove))
    (task-completed)
  ))
)
