from ed import *
W=r'\s+'
def rs(t,old,new): sub(t,'problem.pddl',re.escape(old).replace(r'\ ',W),new,regex=True)
t='b119b1f_1'
set_objects(t,'song',['song-start','song-back-1','song-back-2','song-back-3','song-luna']); set_objects(t,'queue-pos',['q0','q1','q2','q3','q4'])
rs(t,'(prev-of q2 q3)','(prev-of q2 q3) (prev-of q3 q4)'); rs(t,'(song-at q3 song-luna)','(song-at q3 song-back-3) (song-at q4 song-luna)')
rs(t,'(by-artist song-back-2 other-artist)','(by-artist song-back-2 other-artist) (by-artist song-back-3 other-artist)')
rs(t,'(cursor-at q3) (seen-song-by q3 luna-starlight)','(cursor-at q4) (seen-song-by q4 luna-starlight)')
binds(t,set_={'song-luna':{'field':'song_id of the current song after the 4th previous_song call (song 158): the first one whose artists[*].id contains the Luna Starlight artist_id; the 3 songs before it are by other artists'}})
t='b119b1f_2'
set_objects(t,'song',['current-song-0','queued-song-1','queued-song-2','queued-song-3','lily-moon-song'])
rs(t,'(song-by queued-song-1 other-artist)','(song-by queued-song-1 other-artist) (song-by queued-song-2 other-artist) (song-by queued-song-3 other-artist)')
rs(t,'(queue-next queued-song-1 lily-moon-song)','(queue-next queued-song-1 queued-song-2) (queue-next queued-song-2 queued-song-3) (queue-next queued-song-3 lily-moon-song)')
binds(t,set_={'lily-moon-song':{'field':'id of the current song after the 4th next_song call (song 68): the first one whose artists[].id contains the Lily Moon artist_id'}},
      add=[(f'queued-song-{i}',None,'spotify.show_current_song',f'id of the current song after next_song call {i}; its artists do not include Lily Moon (loop continues)') for i in (2,3)])
t='b119b1f_3'
set_objects(t,'song',['song-current','song-prev-1','song-prev-2','song-prev-3','song-silent-thunder']); set_objects(t,'position',['pos-current','pos-prev-1','pos-prev-2','pos-prev-3','pos-prev-4'])
rs(t,'(prev-position pos-prev-1 pos-prev-2)','(prev-position pos-prev-1 pos-prev-2) (prev-position pos-prev-2 pos-prev-3) (prev-position pos-prev-3 pos-prev-4)')
rs(t,'(song-at pos-prev-2 song-silent-thunder)','(song-at pos-prev-2 song-prev-2) (song-at pos-prev-3 song-prev-3) (song-at pos-prev-4 song-silent-thunder)')
rs(t,'(by-artist song-prev-1 other-artist)','(by-artist song-prev-1 other-artist) (by-artist song-prev-2 other-artist) (by-artist song-prev-3 other-artist)')
rs(t,'(cursor-at pos-prev-2)','(cursor-at pos-prev-4)')
binds(t,set_={'song-silent-thunder':{'field':'current song after the 4th previous_song call (song 224): the first one whose artists[].id contains the Silent Thunder artist_id (loop stop condition)'}})
# b0a8eae_2: real playlists and songs
t='b0a8eae_2'
CODE=LOGIN+"""t=tok('spotify')
out=[]
for p in pages(apis.spotify.show_playlist_library,access_token=t):
    out.append((p['playlist_id'],p['title'],[(s,apis.spotify.show_song(song_id=s)['duration']) for s in p['song_ids']]))
print('JSON'+json.dumps(out))"""
P=envjson(t,CODE); mins=private(t)['workout_duration_mins']; want=set(private(t)['long_enough_playlist_song_ids'])
long=[p for p in P if sum(d for _,d in p[2])>=mins*60]; assert len(long)==1 and {s for s,_ in long[0][2]}==want
po=lambda p:f'playlist-{p[0]}'; so=lambda s:f'song-{s}'
set_objects(t,'playlist',[po(p) for p in P]); set_objects(t,'song',sorted({so(s) for p in P for s,_ in p[2]},key=lambda x:int(x.split('-')[1])))
init=keep_init(t,r'username|password-for|current-weekday|note-matches|plan-duration')
for p in P:
    ids=[s for s,_ in p[2]]
    init+=[f'(song-to-check {po(p)} {so(ids[0])})']+[f'(followed-by {po(p)} {so(a)} {so(b)})' for a,b in zip(ids,ids[1:]+ids[:1])]+[f'(last-song {po(p)} {so(ids[-1])})']
init.append(f'(long-enough {po(long[0])} workout-duration-today)')
set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',[f'(playing-playlist {po(long[0])})','(task-completed)'],wrap_and=True)
b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.match(r'(playlist-|song-\d)',x['object'])]
add=[(po(p),None,'spotify.show_playlist_library',f'playlist_id of "{p[1]}" ({len(p[2])} songs, total duration {sum(d for _,d in p[2])} s'+(f'; the only playlist lasting at least {mins} minutes' if p is long[0] else '; too short')+')') for p in P]
add+=[(so(s),None,'spotify.show_playlist_library',f'song_ids entry {s} (duration {d} s via spotify.show_song)') for s,d in sorted({(s,d) for p in P for s,d in p[2]})]
binds(t,drop=drop,add=add); print(t,len(P),'playlists; long enough:',long[0][1],'dropped',drop)
