from ed import *
CODE=LOGIN+"""t=tok('spotify')
out=[]
if KIND=='album':
    for a in pages(apis.spotify.show_album_library,access_token=t):
        d=apis.spotify.show_album(album_id=a['album_id']); out.append({'id':a['album_id'],'title':a['title'],'songs':[s['id'] for s in d['songs']]})
else:
    for p in pages(apis.spotify.show_playlist_library,access_token=t):
        d=apis.spotify.show_playlist(playlist_id=p['playlist_id'],access_token=t); out.append({'id':p['playlist_id'],'title':p['title'],'songs':[s['id'] for s in d['songs']]})
meta={}
for c in out:
    for i in c['songs']:
        if i not in meta:
            s=apis.spotify.show_song(song_id=i); meta[i]=(s['title'],s['play_count'],s['rating'])
print('JSON'+json.dumps({'c':out,'meta':meta}))"""
for t,kind,metric in [('6171bbc_1','album',1),('6171bbc_2','playlist',2),('6171bbc_3','playlist',1)]:
    d=envjson(t,f"KIND={kind!r}\n"+CODE); meta={int(k):v for k,v in d['meta'].items()}; want=set(private(t)['playlist_song_ids'])
    C=[]
    for c in d['c']:
        if not c['songs']: continue
        top=max(c['songs'],key=lambda i:meta[i][metric]); C.append(dict(o=f'{kind}-{c["id"]}',title=c['title'],songs=c['songs'],top=top))
    assert {c['top'] for c in C}==want,(sorted(c['top'] for c in C),sorted(want))
    allsongs=sorted({i for c in C for i in c['songs']}); tops=sorted(want); so=lambda i:f'song-{i}'
    cred=keep_init(t,r'username-for|password-for|new-playlist|playlist-title new-playlist')
    mname='play_count' if metric==1 else 'rating'
    if t.endswith('_1'):
        set_objects(t,'album',[c['o'] for c in C]); set_objects(t,'song',[so(i) for i in allsongs])
        init=cred+[f"(in-library {c['o']})" for c in C]+[f"(song-in-album {so(i)} {c['o']})" for c in C for i in c['songs']]+[f"(most-played {c['o']} {so(c['top'])})" for c in C]
        goal=['(playlist-created my-most-played-album-songs)','(playlist-titled my-most-played-album-songs title-my-most-played-album-songs)']+[f'(song-added my-most-played-album-songs {so(i)})' for i in tops]
        drop=['album-1','album-2','top-song-album-1','top-song-album-2']
    elif t.endswith('_2'):
        set_objects(t,'playlist',['my-highest-rated-playlist-songs']+[c['o'] for c in C]); set_objects(t,'song',[so(i) for i in allsongs])
        init=cred+[f"(user-playlist {c['o']})" for c in C]+[f"(in-playlist {so(i)} {c['o']})" for c in C for i in c['songs']]+[f"(highest-rated {c['o']} {so(c['top'])})" for c in C]
        goal=['(playlist-titled my-highest-rated-playlist-songs title-my-highest-rated-playlist-songs)']+[f"(added-highest-rated {c['o']} my-highest-rated-playlist-songs)" for c in C]
        drop=['playlist-1','playlist-2','song-1a','song-1b','song-2a','song-2b']
    else:
        sub(t,'domain.pddl','top-song-1 top-song-2 - song',' '.join(so(i) for i in tops)+' - song'); ctask(t,['(created new-playlist)']+[f'(added {so(i)} new-playlist)' for i in tops])
        set_objects(t,'playlist',[c['o'] for c in C]); set_objects(t,'song',[so(i) for i in allsongs if i not in want])
        init=cred+[f"(owned-playlist {c['o']})" for c in C]+[f"(in-playlist {so(i)} {c['o']})" for c in C for i in c['songs']]+[f"(most-played-in {so(c['top'])} {c['o']})" for c in C]
        goal=['(created new-playlist)']+[f'(added {so(i)} new-playlist)' for i in tops]
        drop=['playlist-1','playlist-2','top-song-1','top-song-2','other-song-1','other-song-2']
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    lib='spotify.show_album_library' if kind=='album' else 'spotify.show_playlist_library'; show='spotify.show_album' if kind=='album' else 'spotify.show_playlist'
    add=[(c['o'],None,lib,f"{kind}_id of the library {kind} \"{c['title']}\" (iterate all pages)") for c in C]
    add+=[(so(i),None,show,f"songs[].id of \"{meta[i][0]}\" ({mname} {meta[i][metric]} via spotify.show_song)"+("; the top song of its "+kind if i in want else "")) for i in allsongs]
    binds(t,drop=drop,add=add); print(t,len(C),kind,len(allsongs),'songs')
