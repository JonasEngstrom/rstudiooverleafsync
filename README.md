# RStudio Overleaf Sync

A bash script that sets up syncing of an R Markdown script with an Overleaf project.

## Instructions

### On Overleaf

1. Create a new project.
2. Open the project.
3. Click Menu.
4. Click Git.
5. Copy the URL. (Note, do not copy the `git clone` at the start of the same line.)

### In Terminal

1. Run `chmod +x setup_article.sh`.
2. Go to the directory in which you would like to create your project.
3. Run `setup_article.sh "<URL from Overleaf>" "<Name of project>"`.

### In RStudio

To upload to Overleaf run the following commands in the RStudio terminal:

```bash
cd overleaf
git add -A
git commit -m "Your commit message goes here."
git push -u origin master
```

The file `main.tex` will then have to be rendered on Overleaf.
