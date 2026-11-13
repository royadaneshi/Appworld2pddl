from ed import *
for t in ['692c77d_1','692c77d_2','692c77d_3']:
    pv=private(t); A=sorted(pv['to_add_review_song_ids']); U=sorted(pv['to_update_review_song_ids']); so=lambda i:f'song-{i}'; rv=lambda i:f'review-of-song-{i}'
    allo=[so(i) for i in A+U]
    keep=keep_init(t,r'supervisor-email|password-for|target-rating|is-supervisor|has-email')
    if t.endswith('_1'):
        sub(t,'domain.pddl','song-a song-b song-d - song',' '.join(allo)+' - song'); ctask(t,[f'(rated {o} rating-5)' for o in allo]); set_objects(t,'song',[])
        init=keep+[f'(in-playlist {o})' for o in allo]+[f'(liked {o})' for o in allo]+[f'(has-existing-review {so(i)})' for i in U]+[f'(review-of {rv(i)} {so(i)})' for i in U]
        goal=[f'(rated {o} rating-5)' for o in allo]; where='a playlist of the playlist library (spotify.show_playlist_library song_ids) and liked'
    elif t.endswith('_2'):
        set_objects(t,'song',allo)
        init=keep+[f'(in-library {o})' for o in allo]+[f'(unreviewed {so(i)})' for i in A]+[f'(has-review {so(i)} {rv(i)})' for i in U]
        goal=[f'(rated-one {o})' for o in allo]; where='the song library and not liked'
    else:
        set_objects(t,'song',allo)
        init=keep+[f'(in-album-library {o})' for o in allo]+[f'(liked {o})' for o in allo]+[f'(song-reviewed {so(i)})' for i in U]+[f'(has-review {so(i)} {rv(i)})' for i in U]
        goal=[f'(song-rated {o} rating-4)' for o in allo]; where='an album of the album library and liked'
    set_objects(t,'review',[rv(i) for i in U])
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text())
    drop=[x['object'] for x in b if x['object'].startswith(('song-','review-'))]
    add=[(so(i),None,'spotify.show_liked_songs',f'song_id {i}: in {where}; no review by the supervisor yet (spotify.show_song_reviews with user_email returns none)') for i in A]\
       +[(so(i),None,'spotify.show_liked_songs',f'song_id {i}: in {where}; already reviewed by the supervisor with a different rating') for i in U]\
       +[(rv(i),None,'spotify.show_song_reviews',f"song_review_id of the supervisor's existing review of song {i}") for i in U]
    binds(t,drop=drop,add=add); print(t,len(A),len(U))
