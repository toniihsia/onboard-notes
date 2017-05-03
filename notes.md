# Notes

General
======

### Git Configuration
- `git config -e --global`
  - Puts you in VIM editor. Press `i` to edit.
  - Change email address to Uncommon email address.
  - Press `esc`, then type `:wq` + enter.
- `git config -e` while in olympus directory.
  - Puts you in VIM eitor. Press `i` to edit.
  - Add line after `fetch =`: `push = HEAD:refs/for/master`
  - Press `esc`, then type `:wq` + enter.
  - You can also create a bash alias for this step.
- P.S. to quit without saving any changes, do: `esc` + `:q!` + `enter`;

### Committing/Pushing
- Commit as normal for new commits.
- When pushing...
  - If you are behind, type the following commands:
    - `git fetch --all`
    - `git pull --rebase`
  - If you followed git config above, you can just git push.
- If making changes to an old commit/task i.e. **amending an old commit**:
  - If the old commit is the last commit you made, you can:
    - `git add -A`
    - `git commit -a --amend --no-edit`
    - in order to add the changes you just made onto your last commit.
  - If the old commit is further back than your last commit, you can:
    - `git rebase -i HEAD~8` (you can change 8 to any # for any # of commits behind your HEAD)
    - This opens an editor inside your Terminal.
    - Find the commit you want to amend and change `pick` to `edit` before `esc`, `:vq`, + `enter`.
    - Make your changes.
    - `git -a --amend --noedit`
    - `git rebase --continue`
    - If there are merge conflicts, just stage and git rebase --continue
  - If you want to amend your last commit to the commit right before that:
    - `git rebase -i HEAD~2`
    - Change `pick` to `fixup` which will squash the two commits together using the older commit's message.
  - **Note:** that there is an alias for these along with a whole bunch of other commands for git that Erez will give you that can be a=copy pasted into your git config to be used; I mistakenly thought they were bash aliases at first so.. It's not. Put it in git config.
  - [**Good Reading on Amending**](https://www.atlassian.com/git/tutorials/rewriting-history)
  - [**Good Reading on Rebasing**](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)

### Editing Users in DB
- `db.user.find().sort({_id: -1})[0]` finds most recent User to sign up.
- `db.user.update({"_id" : ObjectId("5908f4c557d44c3c564eb936")}, {$set: {email_verified: true}})`
### Task Workflow
- Receive Asana Task
- Complete Task
  - Gerrit: Add code reveiewers (or you can do this through bash alias given by Erez thru Terminal)
  - Asana: Change 'Status' to 'Code Review' and leave notes (optional).
- After (+2) Code Review...
  - Gerrit: Submit (if there are weird parents, `Rebase` and get rid of them)
  - Asana: Re-assign task to QA.

Frontend
======
### Tablet/Mobile
- `@include responsive('__whatever__device__')`
- If you are only listening for click events and have to listen to touch events, remember to add `'touchstart @__event__': '__function__'` to `this.events` in the View
  - In the case of Modal, you should add to ModalBase
