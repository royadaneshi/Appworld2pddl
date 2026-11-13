from ed import *
CODE=LOGIN+"""t=tok('spotify')
out=[]
for p in pages(apis.spotify.show_playlist_library,access_token=t):
    out.append((p['playlist_id'],p['title'],[(s,apis.spotify.show_song(song_id=s)['duration']) for s in p['song_ids']]))
print('JSON'+json.dumps(out))"""
for t,which in [('e7a10f8_2','shortest'),('e7a10f8_3','longest')]:
    P=[p for p in envjson(t,CODE) if p[2]]; tot={p[0]:sum(d for _,d in p[2]) for p in P}
    pick=(min if which=='shortest' else max)(P,key=lambda p:tot[p[0]]); ans=json.loads((awcheck.DATA/t/'ground_truth'/'answer.json').read_text()); assert round(tot[pick[0]]/60)==ans,(tot,ans)
    po=lambda p:f'playlist-{p[0]}'; so=lambda s:f'song-{s}'; order=list(dict.fromkeys(s for p in P for s,_ in p[2])); dur={s:d for p in P for s,d in p[2]}
    set_objects(t,'playlist',[po(p) for p in P]); set_objects(t,'song',[so(s) for s in order])
    keep=keep_init(t,r'username|supervisor-email|password-for'); ip=[f'(in-playlist {so(s)} {po(p)})' for p in P for s,_ in p[2]]
    if t.endswith('_2'):
        init=keep+ip+[f'(next-song {so(a)} {so(b)})' for a,b in zip(order,order[1:])]+[f'(next-song {so(order[-1])} {so(order[-1])})',f'(ready {so(order[0])})',f'(last-song {so(order[-1])})']
        goal=[f'(known-duration {so(s)})' for s in order]
    else:
        init=keep+[f'(in-library {po(p)})' for p in P]+ip+[f'(next-item {so(a)} {so(b)})' for a,b in zip(order,order[1:])]+[f'(next-item {so(order[-1])} minutes-answer)',f'(unlocked {so(order[0])})']
        goal=['(unlocked minutes-answer)']
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.match(r'(playlist-\d|song-\d)',x['object'])]
    add=[(po(p),None,'spotify.show_playlist_library',f'playlist_id of "{p[1]}" ({len(p[2])} songs, total {tot[p[0]]} s = {round(tot[p[0]]/60)} min'+(f'; the {which} playlist' if p is pick else '')+')') for p in P]+[(so(s),None,'spotify.show_playlist',f'songs[].id {s} (duration {dur[s]} s via spotify.show_song)') for s in order]
    binds(t,drop=drop,add=add); print(t,len(P),'playlists',len(order),'songs;',which,pick[1],round(tot[pick[0]]/60),'min')
