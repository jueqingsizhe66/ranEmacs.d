"""
Fortpy EPC server. Adapted from jedi EPC server by Takafumi Arakaki.
"""

import os
import sys
import re
import itertools
import logging
import site

fortpy = None  # I will load it later

def fortpy_script(source, line, column, source_path):
    return fortpy.isense.Script(source, line, column, source_path)

def candidate_symbol(comp):
    """
    Return a character representing completion type.

    :type comp: fortpy.isense.classes.Completion
    :arg  comp: A completion object returned by `fortpy.isense.Script.complete`.

    """
    try:
        return comp.type[0].lower()
    except (AttributeError, TypeError):
        return '?'

def candidates_description(comp):
    """
    Return `comp.description` in an appropriate format.

    * Avoid return a string 'None'.
    * Strip off all newlines. This is required for using
      `comp.description` as candidate summary.

    """
    desc = comp.description
    #We need to try and format it to be a bit shorter for the autocomplete
    #The name and description can't be longer than 70 chars.
    sdesc = _WHITESPACES_RE.sub(' ', desc) if desc and desc != 'None' else ''
    # target_len = 80-len(comp.name)-1
    # if len(sdesc) > target_len + 1:
    #     return sdesc[:target_len]
    # else:
    return sdesc
_WHITESPACES_RE = re.compile(r'\s+')

def complete(*args):
    reply = []
    script = fortpy_script(*args).completions()
    for comp in script:
        reply.append(dict(
            word=comp.name,
            doc=comp.docstring,
            description=candidates_description(comp),
            symbol=candidate_symbol(comp),
        ))
    return reply

def bracket_complete(*args):
    """Gives documentation information for a function and its signature.
    Raised whenever '(' is entered."""
    script = fortpy_script(*args).bracket_complete()
    return script
    
def reparse_module(*args):
    """Reparses the module in the specified file paths from disk."""
    return _reparse_file(*args)

def _reparse_file(source, line, column, path):
    """Handles the reparse using the appropriate code parser for SSH or
    the local file system."""
    import fortpy.isense.cache as cache
    parser = cache.parser()
    if parser.tramp.is_ssh(path):
        cache.parser("ssh").reparse(path)
    else:
        parser.reparse(path)

    return "{}... Done".format(path)

def get_in_function_call(*args):
    #This gets called whenever the buffer goes idle and shows either
    #signature completion information or an autocomplete suggestion.
    script = fortpy.isense.Script(*args)
    result = script.in_function_call()

    #The format of result is [dict/list of complete, iexec]
    if isinstance(result, list):
        #We are offering autocomplete information for the call signature
        #parameter spot that the cursor is over.
        reply = []
        for comp in result:
            reply.append(dict(
                word=comp.name,
                doc=comp.docstring,
                description=candidates_description(comp),
                symbol=candidate_symbol(comp),
            ))
        return dict(
            reply=reply,
            replytype="completion",
        )
    else:
        #We have compiled parameter information for the parameter under
        #the cursor.
        return dict(
            reply=result,
            replytype="signature",
        )

def goto(*args):
    return []

def related_names(*args):
    return []

def get_definition(*args):
    d = fortpy.isense.Script(*args).goto_definitions()
    result = dict(
        doc=d.fulldoc,
        description=d.description,
        desc_with_module="",
        line_nr=d.line,
        column=d.column,
        module_path=d.module_path,
        name=getattr(d, 'name', []),
        full_name=getattr(d, 'full_name', []),
        type=getattr(d, 'type', []),
    )

    return [result]

def defined_names(*args):
    return []

def get_module_version(module):
    try:
        from pkg_resources import get_distribution, DistributionNotFound
        try:
            return get_distribution(module.__name__).version
        except DistributionNotFound:
            pass
    except ImportError:
        pass

    notfound = object()
    for key in ['__version__', 'version']:
        version = getattr(module, key, notfound)
        if version is not notfound:
            return version

def get_fortpy_version():
    import epc
    import sexpdata
    return [dict(
        name=module.__name__,
        file=getattr(module, '__file__', []),
        version=get_module_version(module) or [],
    ) for module in [sys, fortpy, epc, sexpdata]]

def fortpy_epc_server(address='localhost', port=0, port_file=sys.stdout,
                    sys_path=[], virtual_env=[],
                    debugger=None, log=None, log_level=None,
                    log_traceback=None):
    add_virtualenv_path()
    for p in virtual_env:
        add_virtualenv_path(p)
    sys_path = map(os.path.expandvars, map(os.path.expanduser, sys_path))
    sys.path = [''] + list(filter(None, itertools.chain(sys_path, sys.path)))

    import_fortpy()
    import epc.server
    server = epc.server.EPCServer((address, port))
    server.register_function(complete)
    server.register_function(get_in_function_call)
    server.register_function(goto)
    server.register_function(related_names)
    server.register_function(get_definition)
    server.register_function(defined_names)
    server.register_function(get_fortpy_version)
    server.register_function(bracket_complete)
    server.register_function(reparse_module)

    @server.register_function
    def toggle_log_traceback():
        server.log_traceback = not server.log_traceback
        return server.log_traceback

    port_file.write(str(server.server_address[1]))  # needed for Emacs client
    port_file.write("\n")
    port_file.flush()
    if port_file is not sys.stdout:
        port_file.close()

    # This is not supported Python-EPC API, but I am using this for
    # backward compatibility for Python-EPC < 0.0.4.  In the future,
    # it should be passed to the constructor.
    server.log_traceback = bool(log_traceback)

    if log:
        handler = logging.FileHandler(filename=log, mode='w')
        if log_level:
            log_level = getattr(logging, log_level.upper())
            handler.setLevel(log_level)
            server.logger.setLevel(log_level)
        server.logger.addHandler(handler)
    if debugger:
        server.set_debugger(debugger)
        handler = logging.StreamHandler()
        handler.setLevel(logging.DEBUG)
        server.logger.addHandler(handler)
        server.logger.setLevel(logging.DEBUG)

    server.serve_forever()
    server.logger.info('exit')
    return server

def import_fortpy():
    global fortpy
    import fortpy
    import fortpy.isense

def add_virtualenv_path(venv=os.getenv('VIRTUAL_ENV')):
    """Add virtualenv's site-packages to `sys.path`."""
    if not venv:
        return
    venv = os.path.abspath(venv)
    path = os.path.join(
        venv, 'lib', 'python%d.%d' % sys.version_info[:2], 'site-packages')
    sys.path.insert(0, path)
    site.addsitedir(path)


def main(args=None):
    import argparse
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        description=__doc__)
    parser.add_argument(
        '--address', default='localhost')
    parser.add_argument(
        '--port', default=0, type=int)
    parser.add_argument(
        '--port-file', '-f', default='-', type=argparse.FileType('wt'),
        help='file to write port on.  default is stdout.')
    parser.add_argument(
        '--sys-path', '-p', default=[], action='append',
        help='paths to be inserted at the top of `sys.path`.')
    parser.add_argument(
        '--virtual-env', '-v', default=[], action='append',
        help='paths to be used as if VIRTUAL_ENV is set to it.')
    parser.add_argument(
        '--log', help='save server log to this file.')
    parser.add_argument(
        '--log-level',
        choices=['CRITICAL', 'ERROR', 'WARN', 'INFO', 'DEBUG'],
        help='logging level for log file.')
    parser.add_argument(
        '--log-traceback', action='store_true', default=False,
        help='Include traceback in logging output.')
    parser.add_argument(
        '--pdb', dest='debugger', const='pdb', action='store_const',
        help='start pdb when error occurs.')
    parser.add_argument(
        '--ipdb', dest='debugger', const='ipdb', action='store_const',
        help='start ipdb when error occurs.')
    ns = parser.parse_args(args)
    fortpy_epc_server(**vars(ns))


if __name__ == '__main__':
    main()
