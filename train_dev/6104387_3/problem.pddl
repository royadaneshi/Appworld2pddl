(define (problem task-6104387-3)
  (:domain appworld-6104387-3)
  (:objects
    christina-harrison - person
    chrharrison-at-gmail-com - username
    spotify-password file-system-password - password
    spotify-token file-system-token - token
    library-song - song
    library-song-artist - artist
    backups-spotify-songs-csv - file-path
    csv-title-artists - content)
  (:init
    (credential-of-app spotify spotify-password)
    (credential-of-app spotify spotify-token)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (supervisor-username chrharrison-at-gmail-com)
    (password-for spotify spotify-password)
    (password-for file-system file-system-password)
    (backup-path backups-spotify-songs-csv)
    (csv-of csv-title-artists library-song library-song-artist))
  (:goal (and (backup-file-created) (spotify-account-deleted) (task-completed)))
)
