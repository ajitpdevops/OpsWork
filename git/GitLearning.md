# Git Learning 

## Core Git Learning

### Git Basics:

| Command 				| Description |
| --- 					| --- |
|git init <directory> 	| Create empty Git repo in specified directory. Run with no arguments to initialize the current directory as a git repository |
|git clone <repo> 		| Clone repo located at <repo> onto local machine. Original repo can be located on the local filesystem or on a remote machine via HTTP or SSH |
|git status 			| List which files are staged, unstaged, and untracked |
|git log 				| Display the entire commit history using the default format. For customization see additional options |
|git diff 				| Show unstaged changes between your index and working director |
|git config --global user.name <name>					|Set a name that is identifiable for credit when review version history |
|git config --global user.email <email>					|Set an email address that will be associated with each history marker |
|git config --global alias. <alias-name> <git-command> 	|Create an alias for a command E.g. alias.glog For “log --graph --oneline” |
|git revert <commit> 				| Create new commit that undoes all of the changes made in <commit>, then apply it to the current branch |
|git reset <file>					| Remove <file> from the staging area, but leave the working directory unchanged. This unstages a file without overwriting any changes |
|git reset --hard <commit>			| Reset the staging area and working directory to match the version stored in <commit>|
|git --version  					| Checks the version of the installed locally |
|git config --global user.name "Your Name" 					| Sets up the name of the user|
|git config --global user.email "yourname@somemail.eu" 		| |
|git config --list 					| lists all the git configurations |
|git config --global --list			| lists all the git configurations |
|git config --global color.ui true 	| enables the color in the git |
|git help <verb> 					| e.g. git help config OR |
|git <verb> --help 					| |
|git init . 						| initializes the git repo in the current folder |
|touch .gitignore 					| creates a git ignore file |
|git status  						| check working tree - both on the git and on local |

### Add files:
- git add -A [adds all of the files for commiting]
- git add . [adds all of the files for commiting]
- git reset 	[removes files to be commited ]
- git reset somefile.js  	[removes somefile.js from the commit preparation]
- git commit -m "This is the commit message" 
- git log  [renders commit ids, authors, dates]
- got log --oneline [renders only first line for each commit ]
- git clone <url> <where to clone>
- git remote -v - lists info about the repo
- git branch -a [lists all of the branches]
- git diff [shows the difference made in the files]
- git pull origin master
- git push -u origin <name of the branch> [-u coordinates the two branches (local and on server)]
	
### Create a branch:
	git branch <name of the branch>

### Checkout a branch:
	git checkout <name of the branch>

Merge a branch:
	git checkout master
	git pull origin master
	git branch --merged - see which branches are merged 
	git merge <name of the branch you want to merge>
	git push origin master 

Delete a branch:
	git branch -d <name of the branch> - this deletes it locally!!!
	git branch -a - check the repo branches 
	git push origin --delete <name of the branch> - this deletes it from the repo!

Revert changes 
	Before Staging 
		- git checkout index.html => [File that is being reverted, it will fetch the file from repo]
	After Staging 
		- git reset HEAD index.html  => This will only revert the changes in staging 
		- git checkout index.html 

Secret Directory 
	.git 

=================== old notes ================================
## …or create a new repository on the command line
echo "# github-actions" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:whoajitpatil/github-actions.git
git push -u origin main
## …or push an existing repository from the command line
git remote add origin git@github.com:whoajitpatil/github-actions.git
git branch -M main
git push -u origin main


…or push an existing repository from the command line
git remote add origin https://github.com/TechMyName/PyBeginingProjects.git

# add remote origin using ssh 
git remote add origin git@github.com:whoajitpatil/java-project.git

git branch -M main
git push -u origin main

…to pull changes
git pull origin main

…unable to send changes to the repo
git pull origin main --rebase
git push

…to remove git remote origin
git remote rm origin

…error: src refspec master does not match any.
git push origin HEAD:<remoteBranch>

===========================


## Advanced Git Learning 
- What is a detached HEAD state?
