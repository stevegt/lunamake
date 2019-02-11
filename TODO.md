- steps: 
    - implement simple stow-like in python
    - stow libs
    - run makefiles
    - stow targets
    - use pygit2?

- enablers:
    - vars can be declared anywhere in makefile
    - we can dynamically build the top-level Makefile
    - we can define a file format that declares prereqs
    - might implement 'lunamke clone http://example.com/badpkgname mypkgname'
        - clones into lib/mypkgname
        - does subtree magic?

- rework tree:

    lib/infrastructures/NNN-xxxxxxx
    lib/infrastructures/*.mk


- move all numbered scripts into site or local
    - goal of guthub project is to gain contrib
        - most valuable contrib may be makefile stanzas and helper
          scripts, not numbered scripts
        - or is a module a makefile stanza + numbered script?
    - rename local to site/name
    - move lunamake and lmutil.py into basedir
    - are numbered scripts called 'modules' or 'hooks'?
        - does one of these enable contrib?
    - does this easily migrate into gdo?

- go to three-digit numbered scripts

- figure out how to meld numbered scripts, helper scripts, and makefile fragments
    - each in its own tree, in search path(s)
    - probably merge into path via a pre-make stow run
        - contrib subdirs domain-named, github-user-named, or topic?
            - register username in a flat file?
            - cpan-like ops in github
            - RFC series
        - merge in everything?  how to resolve conflicts?

- replace stow
    - move existing file into a git branch
    - 
    - diff with previous commits rather than adopt?

- platform

- stowpath

- dev process:
    - clone from github
    - each branch is a different DVM
    - pull between branches for staging dev->test->prod

- rework tree:

    bin/lunamake
    bin/30-pull
    bin/40-mount
    bin/50-make
    bin/70-stow
    bin/99-reboot
    bin/lmutil.py

    # ./state is in .gitignore
    state/.env
    state/somestamp

    # ./local is in local branch(es)
    # - do not accept pull requests with ./local in them

    local/bin/40-run-before-make
    local/bin/50-replacement-make

    local/etc/main.conf
    local/etc/Makefile

    local/stow/example.com
    local/stow/d3.example.com
    local/stow/host1.d3.example.com
    





- XXX move site stuff to site subdirs
    - site is a lunamake arg
        - defaults to fqdn[1:]
    - any numbered script in site dir overrides same number in top dir
    - deprecate examples dir
    - site/foo.com/main.conf
    - site/foo.com/stow
    - site/bar.com/...
    - site/tests
    - tree out local the same way
    - put stow under site
- write test script
    - runs in a test site
