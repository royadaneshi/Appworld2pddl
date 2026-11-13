from ed import *
CODE=LOGIN+"""t=tok('spotify')
fa=[(a['artist_id'],a['name']) for a in pages(apis.spotify.show_following_artists,access_token=t)]
ls=[(s['song_id'],s['title'],[(a['id'],a['name']) for a in s['artists']]) for s in pages(apis.spotify.show_liked_songs,access_token=t)]
print('JSON'+json.dumps({'fa':fa,'ls':ls}))"""
for t in ['aa8502b_1','aa8502b_2','aa8502b_3']:
    d=envjson(t,CODE); want=set(private(t)['to_be_acted_upon_artist_ids']); name={}
    for i,n in d['fa']: name[i]=n
    for _,_,ar in d['ls']:
        for i,n in ar: name[i]=n
    ao=lambda i:'artist-'+slug(name[i]); followed={i for i,_ in d['fa']}; liked_artists={i for _,_,ar in d['ls'] for i,_ in ar}
    keep=keep_init(t,r'username|password-for')
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.match(r'(artist|liked-song|other-song)',x['object'])]
    if t.endswith('_2'):
        assert followed-liked_artists==want,(sorted(followed-liked_artists),sorted(want))
        A=sorted(followed); sub(t,'domain.pddl','artist-no-liked-1 artist-no-liked-2 artist-with-liked-1 - artist',' '.join(ao(i) for i in A)+' - artist')
        cond=[f'(unfollowed {ao(i)})' for i in A if i in want]+[f'(followed {ao(i)})' for i in A if i not in want]; ctask(t,cond)
        init=keep+[f'(followed {ao(i)})' for i in A]+[f'(has-liked-song {ao(i)})' for i in A if i not in want]; goal=cond
        add=[(ao(i),None,'spotify.show_following_artists',f'artist_id of the followed artist "{name[i]}"; '+('none of the liked songs is by this artist -> unfollow' if i in want else 'has at least one liked song -> keep')) for i in A]
    else:
        assert liked_artists-followed==want,(sorted(liked_artists-followed),sorted(want))
        A=sorted(want); wit={}
        for sid,title,ar in d['ls']:
            for i,_ in ar:
                if i in want: wit.setdefault(i,(sid,title))
        songs=sorted({wit[i] for i in A}); so=lambda s:f'song-{s[0]}'
        old='artist-a artist-b artist-c - artist' if t.endswith('_1') else 'artist-1 artist-2 artist-3 artist-4 - artist'
        sub(t,'domain.pddl',old,' '.join(ao(i) for i in A)+' - artist'); ctask(t,[f'(following {ao(i)})' for i in A]); set_objects(t,'song',[so(s) for s in songs])
        rel=(lambda i:f'(sung-by {so(wit[i])} {ao(i)})') if t.endswith('_1') else (lambda i:f'(sings {ao(i)} {so(wit[i])})')
        init=keep+[f'(liked {so(s)})' for s in songs]+[rel(i) for i in A]; goal=[f'(following {ao(i)})' for i in A]
        add=[(ao(i),None,'spotify.show_liked_songs',f'artists[].id of "{name[i]}": sings the liked song "{wit[i][1]}" and is not in spotify.show_following_artists') for i in A]+[(so(s),None,'spotify.show_liked_songs',f'song_id of the liked song "{s[1]}"') for s in songs]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    binds(t,drop=drop,add=add); print(t,len(A),'artists',len(want),'to act on')
