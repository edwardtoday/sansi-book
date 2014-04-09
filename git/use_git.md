A Brief Git Tutorial
====================

Installation
------------

-   **Windows** Download and install [msysgit](http://code.google.com/p/msysgit/downloads/list?can=3)

-   **Linux** Install git via your package manager `apt`, `yum`, `pacman`, etc.

-   **OS X** Install git via [Homebrew](http://brew.sh/) if OS-provided version is too old. Or you could download [an installer](http://code.google.com/p/git-osx-installer).

Git provides a command line interface. If you wish to have a GUI, here are some free ones.

-   [GitHub for Windows](http://windows.github.com/) *Windows*

-   [GitHub for Mac](http://mac.github.com/) *Mac*

-   [GitX](http://rowanj.github.io/gitx/) *Mac*

-   [Git Extensions](http://code.google.com/p/gitextensions/) *Windows*

-   [SourceTree](http://www.sourcetreeapp.com/) *Mac & Windows*

-   [git-cola](http://git-cola.github.com/) *Windows, Mac & Linux*

If you really want to do everything in Visual Studio, Visual Studio has integrated git support. For earlier versions, these extensions may help.

-   [Git Source Control Provider](http://gitscc.codeplex.com/)

-   [Git Extensions](https://code.google.com/p/gitextensions/) (GUI with a plugin for Visual Studio 2005/2008/2010/2012)

First-Time Git Setup
--------------------

*Your Identity*.
Git stores your identity with every commit you make. To tell Git who you are, run

~~~~ {.bash}
git config --global user.name "John Doe"
git config --global user.email "johndoe@example.com"
~~~~

You only need to do this once. With the `--global` option, the information is stored in `~/.gitconfig`, which is your user-specific git configuration file.

*Your Editor*.
There are times when Git needs you to type in a message. E.g. when you commit your changes without an inline `-m "your commit message" option`. By default, Git uses the system’s default editor, which is usually Vi. To change the editor, you can do:

~~~~ {.bash}
git config --global core.editor emacs
~~~~

The annoying fact that Windows and Linux line endings are differnt sometimes messes things up. It would be better if the repository have only `LF`. When files are checkout on Windows, line endings are automatically replaced with `CRLF`. On Linux, line endings does not change.

To achive this you need the following configurations.

On Windows, run

~~~~ {.bash}
git config --global core.autocrlf true
~~~~

On Linux/Mac, run

~~~~ {.bash}
git config --global core.autocrlf input
~~~~

For finer control over line endings per project, you probably need a [.gitattributes file](https://help.github.com/articles/dealing-with-line-endings#per-repository-settings).

Create a Git Repository
-----------------------

In the project root directory (or create an empty directory for a new project), run

~~~~ {.bash}
git init
~~~~

Clone a Existing Repository
---------------------------

To work on an existing project managed with Git, you’ll first get a working copy locally with

~~~~ {.bash}
git clone /path/to/repository
~~~~

Suppose your curreny working directory is `~/workspace/`, running `git clone https://github.com/edwardtoday/git-example.git` will download the project (including its whole history) to `~/workspace/git-example/`.

Commit files
------------

To commit a changed file, whether it’s newly created or edited, you add it to the **Index** using

~~~~ {.bash}
git add <filename>
~~~~

To commit the changes currently in the **Index**, run

~~~~ {.bash}
git commit -m "Commit message describing the changes"
~~~~

Now the changes has been commit to HEAD of your local repository.

Sync with Remotes
-----------------

*Add Remotes*.
To get changes from a remote server to your local repository, you need to add that remote server with

~~~~ {.bash}
git remote add <remote name> <server>
~~~~

If the local repository was cloned from a remote server, that server has already been added as a remote called *origin*.

To list all the remotes currently added, run

~~~~ {.bash}
git remote -v
~~~~

1.  Push Changes to Remotes

You have finished a feature/function/bugfix/… and you want publish your local commits to a remote server. Run

~~~~ {.bash}
git push <remote name> <branch>
~~~~

So far, `<branch>` is normally `master`.

1.  Pull Changes from Remotes

You also wish to get the code written by others into your local repository. Run

~~~~ {.bash}
git pull <remote name> <branch>
~~~~

Useful Links
------------

> **Note**
>
> Some materials below have Chinese translations. I still recommend reading the original English versions since the translations appears to be so crappy to make some sections harder to understand.

-   [git- the simple guide](http://rogerdudler.github.io/git-guide/) [中文翻译](http://rogerdudler.github.io/git-guide/index.zh.html)

-   [Git Community Book](http://git-scm.com/book) [中文翻译](http://git-scm.com/book/zh)

-   [Git Magic](http://www-cs-students.stanford.edu/~blynn/gitmagic/) [中文翻译](http://www-cs-students.stanford.edu/\~blynn/gitmagic/intl/zh_cn/)

-   [GitHub Help](https://help.github.com/)

-   [A Visual Git Reference](http://marklodato.github.io/visual-git-guide/index-en.html) [中文翻译](http://marklodato.github.io/visual-git-guide/index-zh-cn.html)


