from __future__ import print_function

import inspect


try:
    from jedi.utils import setup_readline
    setup_readline()
except ImportError:
    # Fallback to the stdlib readline completer if it is installed.
    # Taken from http://docs.python.org/2/library/rlcompleter.html
    print("Jedi is not installed, falling back to readline")
    try:
        import readline
        import rlcompleter
        readline.parse_and_bind("tab: complete")
    except ImportError:
        print("Readline is not installed either. No tab completion is enabled.")


def what(stuff, predicate=None):
    for k, v in inspect.getmembers(stuff, predicate):
        print("* %s" % k)
        for line in str(v).splitlines():
            print("\t%s" % line)


# http://jedidjah.ch/code/2013/9/8/wrong_dir_function/

NotDefined = object()
old_dir = dir


def dir(obj=NotDefined):
    if obj is NotDefined:
        return old_dir()

    if isinstance(obj, type):
        return sorted(set(old_dir(obj)) | set(old_dir(obj.__class__)))
    else:
        return old_dir(object)
