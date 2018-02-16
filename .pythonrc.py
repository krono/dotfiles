#
#
def setup_readline():
    import rlcompleter
    import readline
    import atexit
    import os

    readline_doc = getattr(readline, '__doc__', '')
    if readline_doc is not None and 'libedit' in readline_doc:
        readline.parse_and_bind('bind ^I rl_complete')
    else:
        readline.parse_and_bind('tab: complete')
        del readline_doc

    try:
        import __pypy__
    except:
        PYPY=False
    else:
        PYPY=True

    if not PYPY:
        try:
            readline.read_init_file()
        except (OSError, IOError):
            pass

    if readline.get_current_history_length() == 0:
        histfile = os.path.join(os.environ['HOME'], '.python_history')
        try:
            readline.read_history_file(histfile)
        except IOError:
            pass
    atexit.register(readline.write_history_file, histfile)

setup_readline()

del setup_readline
