**This is hard copy/paste from GPT-5. This articles is WIP**

From Local Script to GitHub Automation: A Beginner-Friendly Walkthrough of Git, GitHub CLI, and Bash Scripting

Over the past few days, I went down a deep and extremely fun rabbit hole: writing a Linux shell script that initializes a Git repository, connects it to GitHub, and pushes the code automatically—no clicking “New Repository” in the GitHub web interface.

Along the way, I discovered a lot of subtle Bash behaviors, Git conventions, and GitHub CLI quirks that aren’t obvious at first glance. What started as a simple one-liner turned into a surprisingly educational journey. This article summarizes everything learned, step-by-step, in a way that would have saved me hours if I’d known it earlier.

The goal:
Turn a folder on my machine into a fully synced GitHub repository with a single script.

1. Understanding the read Commands

Everything begins with asking the user for input.
My original script used:

<code>read -p "Enter file path: " filepath</code>

This works, but there’s a more robust form:

<code>read -rp "Enter project directory: " dir</code>

The key difference is the -r flag:

-p displays the prompt text.

-r prevents Bash from treating backslashes (\) as escape characters.

This ensures that whatever the user types is stored raw, unchanged.
It’s a best practice in shell scripting because it avoids silent character loss when paths include special characters.

2. Validating the Directory Path

After collecting the target directory, the script needs to verify that it actually exists. The line that does this looks cryptic at first:

<code>cd "$dir" || { echo "Directory not found"; exit 1; }</code>

Breaking it down:

cd "$dir" attempts to enter the directory.

|| means “if the previous command failed…”

{ ... } groups commands together.

exit 1 stops the script with a standard error code.

This is simply a compact way to perform the same logic as:

<code>
if ! cd "$dir"; then
    echo "Directory not found"
    exit 1
fi
</code>

The shorter version keeps scripts clean without losing intent.

3. Automatically Guessing the Repository Name

Rather than forcing the user to type a repo name every time, the script extracts the current directory name:
<code>default_name=$(basename "$PWD")</code>

Breaking it down:

$PWD contains the full path to the current working directory.

basename strips everything except the final segment.

$( ... ) runs a command and inserts its output.

So this line converts:

<code>/home/me/Projects/my-app</code>
into:
<code>my-app</code>
and stores it in default_name.

This small trick improves script usability dramatically.

4. Ensuring the Repository Uses the main Branch

Git has evolved over the years, and different systems use different default branch names (master vs main).
To ensure consistency, the script uses this compatibility one-liner:
<code>git init -b main 2>/dev/null || git init</code>

This reads as:

1. Try to initialize the repo using main (-b main).

2. If that fails (older versions of Git), fall back to a normal git init.

3. 2>/dev/null hides the error message to prevent clutter.

Then, to guarantee the branch is named correctly:


<code>git branch -M main</code>

The -M force-renames the current branch to main, overwriting conflicting branches if necessary.

This ensures every environment ends with the same branch structure.

5. Adding Content and Making the First Commit

Git won’t commit or push if there are no files.
The script attempts:

<code>
git add .
git commit -m "Initial commit"
</code>

<code>nothing to commit</code>

if the directory is empty.
This caused an important discovery:

GitHub CLI cannot create a remote repository with --push unless the local repo has at least one commit.

A simple solution is creating a README when the folder is empty:

<code>
if [ -z "$(ls -A .)" ]; then
    echo "# $reponame" > README.md
fi
</code>

This way, the first commit always succeeds.

6. Authenticating with GitHub CLI

GitHub itself cannot be manipulated through plain Git commands; Git is only local.
To automatically create GitHub repositories, the GitHub CLI (gh) must be configured.

The correct login flow turned out to be:
<code>gh auth login</code>
And then choosing:

GitHub.com

SSH for Git operations

Login with a web browser (not a manual personal access token)

Once authenticated:
<code>gh auth status</code>
shows the account and confirms that SSH keys are configured correctly.

7. Automatically Creating & Pushing a GitHub Repo

The magic line that finally ties everything together is:
<code>
gh repo create "$reponame" \
  --"$vis" \
  --source=. \
  --remote=origin \
  --push
  </code>
This single command:

Creates the repository on GitHub.

Links the local repo’s origin to it.

Pushes the initial commit.

Makes the repository appear instantly on the GitHub dashboard.

This was the ultimate goal of the entire scripting journey.

8. The “Empty Directory” Gotcha

One of the biggest discoveries was that: 
<code>gh repo create --push</code>

fails silently if the local repo has no commits.

It prints:

<code>`--push` enabled but no commits found</code>

This was the main reason the script didn’t appear to work during initial testing.

Once a file (like a README) is present, everything behaves perfectly.

Conclusion

What began as a desire to automate repository creation turned into an unexpectedly rich lesson in:

input handling (read -rp)

safe directory checks (cd ... ||)

environment variables (PWD)

branch naming standards (git init -b main)

git workflows (add, commit, push)

GitHub API interaction through gh

SSH key authentication

edge-case behavior when directories are empty

The resulting script is small, but the number of concepts it touches is massive.
This project reminded me that even the simplest automation tasks open doors to deeper understanding of the tools behind them.

I’m proud of how much I learned building this, and I hope walking through it in detail helps someone else who’s beginning the journey into Git, GitHub, and shell scripting.