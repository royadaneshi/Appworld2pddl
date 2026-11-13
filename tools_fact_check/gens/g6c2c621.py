from ed import *
import os
for t in ['6c2c621_1','6c2c621_2','6c2c621_3']:
    paths=sorted(private(t)['file_path_to_content']); N=[]
    for p in paths:
        base=os.path.basename(p)[:-3]; st=slug(base); N.append(dict(n='note-'+st,c='content-'+st,f='file-'+st,path=p,title=base.replace('_',' ')))
    assert len({x['n'] for x in N})==len(N)
    keep=keep_init(t,r'\(supervisor |supervisor-username|password-for|token-for|username-of')
    set_objects(t,'note',[x['n'] for x in N]); set_objects(t,'content',[x['c'] for x in N]); set_objects(t,'file-path',[x['f'] for x in N])
    if t.endswith('_1'):
        init=keep+[f"(content-of {x['n']} {x['c']})" for x in N]+[f"(backup-file-of {x['n']} {x['f']})" for x in N]+[f"(next-note {a['n']} {b['n']})" for a,b in zip(N,N[1:])]+[f"(next-note {N[-1]['n']} end-of-notes)",f"(export-cursor {N[0]['n']})"]
        goal=['(export-cursor end-of-notes)']+[f"(file-created {x['f']})" for x in N]
    elif t.endswith('_2'):
        init=keep+[f"(note-content {x['n']} {x['c']})" for x in N]+[f"(note-file {x['n']} {x['f']})" for x in N]
        goal=[f"(exported {x['n']})" for x in N]
    else:
        init=keep+[f"(note-content {x['n']} {x['c']})" for x in N]+[f"(note-file-path {x['n']} {x['f']})" for x in N]+[f"(next-note {a['n']} {b['n']})" for a,b in zip(N,N[1:])]+[f"(next-note {N[-1]['n']} no-more-notes)",f"(all-exported-before {N[0]['n']})"]
        goal=['(all-exported-before no-more-notes)']+[f"(note-exported {x['n']})" for x in N]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text())
    drop=[x['object'] for x in b if x['object'].startswith(('note-','content-','backup'))]
    add=[]
    for x in N:
        add+=[(x['n'],None,'simple_note.search_notes',f"note_id of the note titled \"{x['title']}\" (iterate all pages)"),(x['c'],None,'simple_note.show_note',f"content of that note"),(x['f'],x['path'],None,'computed from the note title: spaces replaced by "_", extension ".md"')]
    binds(t,drop=drop,add=add); print(t,len(N))
