(define (problem task-aa8502b-2)
  (:domain appworld-aa8502b-2)
  (:objects
    christina - person
    chrharrison-at-gmail-com - username
    spotify-password - password
    spotify-token - token)
  (:init
    (password-for spotify spotify-password)
    (spotify-username chrharrison-at-gmail-com)
    (followed artist-no-liked-1)
    (followed artist-no-liked-2)
    (followed artist-with-liked-1)
    (has-liked-song artist-with-liked-1))
  (:goal (and
    (unfollowed artist-no-liked-1)
    (unfollowed artist-no-liked-2)
    (not (unfollowed artist-with-liked-1))
    (followed artist-with-liked-1)
    (task-completed)))
)
