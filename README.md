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

Optional: You can change the author name in the script to your own name to make the process of setting up a new article even quicker.

### In RStudio

To upload to Overleaf run the following commands in the RStudio terminal:

```bash
cd overleaf
git add -A
git commit -m "Your commit message goes here."
git push -u origin master
```

The file `main.tex` will then have to be rendered on Overleaf.

### Prerequisites

The script was written to work with the following software versions:

- macOS Ventura 13.5.1
- git 2.39.2
- GNU bash 3.2.57(1)
- RStudio 2023.06.0+421
- R 4.3.1 Beagle Scouts
- rmarkdown 2.23
- tinytex 0.45
- knitr 1.43
