from ed import *
import os
cfg={'7d7fbf6_1':'~/photographs/vacations/','7d7fbf6_2':'~/photos/vacations/','7d7fbf6_3':'~/pictures/vacations/'}
for t,root in cfg.items():
    Z=sorted(os.path.basename(p) for p in private(t)['compressed_file_paths']); ext=Z[0].split('.')[-1]; spots=[z.rsplit('.',1)[0] for z in Z]
    do=[f'dir-{s}' for s in spots]; zo=[f'{ext}-{s}' for s in spots]
    keep=keep_init(t,r'username|password-for|is-true|is-false|vacations-root')
    if t.endswith('_1'):
        set_objects(t,'directory',['vacations-dir']+do); set_objects(t,'filepath',zo)
        init=keep+[f'(sub-directory-of {d} vacations-dir)' for d in do]+[f'(zip-target {d} {z})' for d,z in zip(do,zo)]; goal=[f'(archived {d})' for d in do]
    elif t.endswith('_2'):
        sub(t,'domain.pddl',r'spot-dir-1 spot-dir-2 spot-dir-3 - dirpath\s+spot-tar-1 spot-tar-2 spot-tar-3 - filepath',' '.join(do)+' - dirpath\n    '+' '.join(zo)+' - filepath',regex=True)
        goal=[x for d,z in zip(do,zo) for x in (f'(compressed-to {d} {z})',f'(directory-deleted {d})')]; ctask(t,goal)
        init=keep+[f'(subdir-of {d} vacations-dir)' for d in do]+[f'(tar-path-for {d} {z})' for d,z in zip(do,zo)]
    else:
        sub(t,'domain.pddl',r'vacation-dir-1 vacation-dir-2 vacation-dir-3 - directory\s+vacation-zip-1 vacation-zip-2 vacation-zip-3 - zipfile',' '.join(do)+' - directory\n    '+' '.join(zo)+' - zipfile',regex=True)
        goal=[x for d,z in zip(do,zo) for x in (f'(compressed {d} {z})',f'(directory-deleted {d})')]; ctask(t,goal)
        init=keep+[f'(subdirectory-of pictures-vacations-dir {d})' for d in do]+[f'(zip-target {d} {z})' for d,z in zip(do,zo)]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.search(r'(spot|vacation)-(dir|zip|tar)-\d',x['object'])]
    add=[]
    for s,d,z in zip(spots,do,zo):
        add+=[(d,None,'file_system.show_directory',f'the listed sub-directory "{root}{s}" (one of 4 vacation-spot sub-directories)'),(z,f'{root}{s}.{ext}',None,f'computed: vacations directory + sub-directory name + ".{ext}"')]
    binds(t,drop=drop,add=add); print(t,spots)
