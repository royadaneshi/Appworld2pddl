(define (problem task-b7a9ee9-1)
  (:domain appworld-b7a9ee9-1)
  (:objects
    jason-simpson - person
    jasonsimp-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    pop - genre
    playlist-366 playlist-365 playlist-371 playlist-370 playlist-369 playlist-368 playlist-372 - playlist
    song-82 song-139 song-151 song-152 song-216 song-266 song-267 - song
  )
  (:init
    (username-for spotify jasonsimp-at-gmail-com)
    (password-for spotify spotify-password)
    (owns-playlist playlist-366)
    (owns-playlist playlist-365)
    (owns-playlist playlist-371)
    (owns-playlist playlist-370)
    (owns-playlist playlist-369)
    (owns-playlist playlist-368)
    (owns-playlist playlist-372)
    (contains playlist-366 song-216)
    (contains playlist-365 song-266)
    (contains playlist-371 song-139)
    (contains playlist-371 song-267)
    (contains playlist-370 song-151)
    (contains playlist-370 song-216)
    (contains playlist-369 song-82)
    (contains playlist-368 song-152)
    (contains playlist-368 song-266)
    (contains playlist-372 song-82)
    (song-genre song-82 classical)
    (song-genre song-139 classical)
    (song-genre song-151 classical)
    (song-genre song-152 classical)
    (song-genre song-216 classical)
    (song-genre song-266 classical)
    (song-genre song-267 classical)
    (song-artist song-82 artist-felix-blackwood)
    (song-artist song-139 artist-zoe-mitchell)
    (song-artist song-151 artist-mia-sullivan)
    (song-artist song-152 artist-mia-sullivan)
    (song-artist song-216 artist-oceanic-odyssey)
    (song-artist song-266 artist-evelyn-rose)
    (song-artist song-267 artist-evelyn-rose))
  (:goal (and
    (following artist-zoe-mitchell)
    (following artist-mia-sullivan)
    (following artist-oceanic-odyssey)
    (following artist-evelyn-rose)
    (following artist-felix-blackwood)
    (task-completed)))
)
