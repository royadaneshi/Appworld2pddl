from ed import *
import os
cfg={'68ee2c9_1':('downloads','trash'),'68ee2c9_2':('dir-downloaded-files','dir-recycle-bin'),'68ee2c9_3':('dir-my-downloads','dir-archive')}
for t,(dl,tr) in cfg.items():
    pv=private(t); F=[]
    for key,d in (('this_year_start_to_end_file_path',dl),('before_this_year_start_to_end_file_path',tr)):
        for src,dst in sorted(pv[key].items()):
            base=os.path.basename(src); st=slug(base); F.append(dict(f='file-'+st,src='src-'+st,dst='dst-'+st,y=os.path.basename(dst)[:4],d=d,srcp=src,dstp=dst,this=d==dl))
    assert len({f['f'] for f in F})==len(F)
    years=sorted({f['y'] for f in F}|{'2023'}); n=len(F)
    cred=keep_init(t,r'username|password-for|is-supervisor')
    if t.endswith('_1'):
        sub(t,'domain.pddl','file-1 file-2 file-3 file-4 - file',' '.join(f['f'] for f in F)+' - file'); ctask(t,[f"(moved {f['f']})" for f in F])
        set_objects(t,'path',[f['dst'] for f in F]); set_objects(t,'year',[f'year-{y}' for y in years])
        init=cred+['(current-year year-2023)']+[f"(destination-dir year-{y} year-2023 {dl if y=='2023' else tr})" for y in years]+[f"(in-directory {f['f']} {dl})" for f in F]+[f"(file-year {f['f']} year-{f['y']})" for f in F]+[f"(path-in-directory {f['dst']} {f['d']})" for f in F]+[f"(prefixed-path {f['dst']} {f['f']})" for f in F]
        goal=[f"(moved {f['f']})" for f in F]+[f"(at-path {f['f']} {f['dst']})" for f in F]
    elif t.endswith('_2'):
        set_objects(t,'file',[f['f'] for f in F]); set_objects(t,'filepath',[f['src'] for f in F]+[f['dst'] for f in F]); set_objects(t,'year',[f'year-{y}' for y in years]); set_objects(t,'count',[f'count-{i}' for i in range(1,n+1)])
        init=cred+[f"(dest-dir-for-year year-{y} {dl if y=='2023' else tr})" for y in years]+[f"(file-at {f['f']} {f['src']})" for f in F]+[f"(file-year {f['f']} year-{f['y']})" for f in F]+[f"(path-in-dir {f['src']} {dl})" for f in F]+[f"(path-in-dir {f['dst']} {f['d']})" for f in F]+[f"(prefixed-path {f['f']} {f['dst']})" for f in F]+[f'(pending-files count-{n})']+[f'(next-count count-{i} count-{i+1})' for i in range(n)]
        goal=['(pending-files count-0)']+[f"(file-at {f['f']} {f['dst']})" for f in F]
    else:
        set_objects(t,'file',[f['f'] for f in F]); set_objects(t,'filepath',[f['src'] for f in F]+[f['dst'] for f in F])
        yo=lambda f:'year-2023' if f['this'] else 'year-before-2023'
        init=cred+[f'(year-destination year-2023 {dl})',f'(year-destination year-before-2023 {tr})']+[f"(in-directory {f['f']} {dl})" for f in F]+[f"(file-at {f['f']} {f['src']})" for f in F]+[f"(created-in-year {f['f']} {yo(f)})" for f in F]+[f"(prefixed-path {f['f']} {f['d']} {f['dst']})" for f in F]
        goal=[f"(renamed {f['f']})" for f in F]+[f"(file-at {f['f']} {f['dst']})" for f in F]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text())
    keepb={x['object'] for x in b if x.get('value') is not None or str(x.get('from_api','')).endswith('.login') or x.get('from_api')=='supervisor.show_account_passwords'}
    add=[]
    for f in F:
        if not t.endswith('_1'): add.append((f['src'],None,'file_system.show_directory',f"the listed file path \"{f['srcp']}\""))
        else: add.append((f['f'],None,'file_system.show_directory',f"the listed file path \"{f['srcp']}\""))
        add.append((f['dst'],None,'file_system.show_file',f"computed from created_at of that file: \"{f['dstp']}\" (created {os.path.basename(f['dstp'])[:10]}; {'stays in the downloads directory' if f['this'] else 'not from this year, goes to the trash directory'})"))
    binds(t,drop=[x['object'] for x in b if x['object'] not in keepb],add=add); print(t,n,'files',years)
