# -*- coding: utf-8 -*-
# Copyright (C) 2009, 2010, 2011  Roman Zimbelmann <romanz@lavabit.com>
# This configuration file is licensed under the same terms as ranger.
# ===================================================================
# This is the configuration file for file type detection and application
# handling.  It's all in python; lines beginning with # are comments.
#
# You can customize this in the file ~/.config/ranger/apps.py.
# It has the same syntax as this file.  In fact, you can just copy this
# file there with `ranger --copy-config=apps' and make your modifications.
# But make sure you update your configs when you update ranger.
#
# In order to add application definitions "on top of" the default ones
# in your ~/.config/ranger/apps.py, you should subclass the class defined
# here like this:
#
# from ranger.defaults.apps import CustomApplications as DefaultApps
# class CustomApplications(DeafultApps):
#     <your definitions here>
#
# ===================================================================
# This system is based on things called MODES and FLAGS.  You can read
# in the man page about them.  To remind you, here's a list of all flags.
# An uppercase flag inverts previous flags of the same name.
#     s   Silent mode.  Output will be discarded.
#     d   Detach the process.  (Run in background)
#     p   Redirect output to the pager
#     w   Wait for an Enter-press when the process is done
#     c   Run the current file only, instead of the selection
#
# To implement flags in this file, you could do this:
#     context.flags += "d"
# Another example:
#     context.flags += "Dw"
#
# To implement modes in this file, you can do something like:
#     if context.mode == 1:
#         <run in one way>
#     elif context.mode == 2:
#         <run in another way>
#
# ===================================================================
# The methods are called with a "context" object which provides some
# attributes that transfer information.  Relevant attributes are:
#
# mode -- a number, mainly used in determining the action in app_xyz()
# flags -- a string with flags which change the way programs are run
# files -- a list containing files, mainly used in app_xyz
# filepaths -- a list of the paths of each file
# file -- an arbitrary file from that list (or None)
# fm -- the filemanager instance
# popen_kws -- keyword arguments which are directly passed to Popen
#
# ===================================================================
# The return value of the functions should be either:
# 1. A reference to another app, like:
#     return self.app_editor(context)
#
# 2. A call to the "either" method, which uses the first program that
# is installed on your system.  If none are installed, None is returned.
#     return self.either(context, "libreoffice", "soffice", "ooffice")
#
# 3. A tuple of arguments that should be run.
#     return "mplayer", "-fs", context.file.path
# If you use lists instead of strings, they will be flattened:
#     args = ["-fs", "-shuf"]
#     return "mplayer", args, context.filepaths
# "context.filepaths" can, and will often be abbreviated with just "context":
#     return "mplayer", context
#
# 4. "None" to indicate that no action was found.
#     return None
#
# ===================================================================
# When using the "either" method, ranger determines which program to
# pick by looking at its dependencies.  You can set dependencies by
# adding the decorator "depends_on":
#     @depends_on("vim")
#     def app_vim(self, context):
#         ....
# There is a special keyword which you can use as a dependence: "X"
# This ensures that the program will only run when X is running.
# ===================================================================

import re
from ranger.defaults.apps import CustomApplications as DefaultApps

class CustomApplications(DefaultApps):

        def app_default(self, c):
                """How to determine the default application?"""
                f = c.file
                
                if f.extension is not None:
                        if f.extension in ('pdf', ):
                                c.flags='d'
                                return self.either(c, 'llpp', 'mupdf')
                        if f.extension in ('mm', ):
                                c.flags='d'
                                return "freemind", c
                        if f.extension in ('graphml', ):
                                c.flags='d'
                                return "yEd", c
                        if f.extension in ('doc', 'xls', 'ppt', 'pptx'):
                                c.flags='d'
                                return self.either(c, 'ooffice', 'libreoffice', 'soffice')

                if f.mimetype is not None:
                        if INTERPRETED_LANGUAGES.match(f.mimetype):
                                return self.either(c, 'edit_or_run')

                if f.container:
                        return "aunpack", c

                if f.image:
                        if c.mode in (11, 12, 13, 14):
                                return self.either(c, 'set_bg_with_feh')
                        else:
                                return "feh", c

                if f.document or f.filetype.startswith('text') or f.size == 0:
                        return self.either(c, 'editor')

                # decide based on mime type with the help of mimeo
                return "mimeopen", c

CustomApplications.generic('wine', deps=['X'])

# Add those which should only run in X AND should be detached/forked here:
CustomApplications.generic('opera', 'firefox',
                           'soffice', 'ooffice', 'libreoffice',
                           flags='d', deps=['X'])

# What filetypes are recognized as scripts for interpreted languages?
# This regular expression is used in app_default()
INTERPRETED_LANGUAGES = re.compile(r'''
        ^(text|application)/x-(
                haskell|perl|python|ruby|sh
        )$''', re.VERBOSE)
