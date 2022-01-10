05 - Linking Error
==================

I observed the error with version v0.9.

With a double slash
-------------------

Here is a description how to reproduce the error
with version v0.9:

- You need a hierarchy of pages like this one
- You follow a link containing two forward slashes (//):
  [subfolder//README.md](subfolder//README.md)
- Within that document, you follow a link leading two levels upward:
  [../../05_linking-error/README.md](../../05_linking-error/README.md)

Note: With current main, the bug does not show up!

Without double slash
--------------------

- You need a hierarchy of pages like this one
- You follow a link **not** containing two forward slashes (//):
  [another-subfolder/README.md](another-subfolder/README.md)
- Within that document, you follow a link leading two levels upward:
  [../../05_linking-error/README.md](../../05_linking-error/README.md)
- This seems to work even with version v0.9

