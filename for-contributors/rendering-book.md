Instructions how to render the book
====================

Any markdown/Quarto code you write and commit on a local machine will be
will be pushed to the central repo on the server.
But the render html _will stay on your local machine_.
GitHub Actions will use Quarto & Pandoc to convert the markdown to html
every time a commit is pushed to the main branch.

So for big changes (like adding a complex table or figure),
I render everything on my dev/local machine so I can better see what it will look like
(when GitHub Actions will essentially redo the rendering on the server.).
But for little changes (like a spelling correction),
I believe it's adequate to just make the change in code, and trust it will be rendered correctly.
At worst, just push a correction later.

On your dev machine
--------------------

Install

* [Quarto](https://quarto.org/docs/download/)
* [Pandoc](https://pandoc.org/installing.html)
* [Visual Studio Code] https://code.visualstudio.com/

  For VSCode, I have some [recommendations on extensions](https://ouhscbbmc.github.io/data-science-practices-1/workstation.html#workstation-vscode)

  For this project, [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) is the most relevant.

On the server
--------------------
