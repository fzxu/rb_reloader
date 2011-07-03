Ruby reloader
=============

This would be helpful if you want to reload your ruby files.

How to use:
-----------

  RbReloader.register(["#{current_folder}/**/t*.rb"])

That is all.

When you want to reload them:
-----------------------------

  RbReloader.reload

it will auto reload the changed files. You can register the reloader somewhere in the router for example.