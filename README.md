# RStudio Overleaf Sync

A bash script that sets up syncing of an R Markdown script with an Overleaf project. Supports keeping Biblatex cite keys for use on Overleaf.

## Instructions

### On Overleaf

1. Create a new project.
2. Open the project.
3. Click *Menu*.
4. Click *Git*.
5. Copy the URL. (Note, do not copy the `git clone` at the start of the same line.)

Optional: Click *New File*, then *From Zotero* or *From Mendeley*. Make sure that the file name is `references.bib`. This syncs Bibtex information from Zotero or Mendeley via Overleaf to your computer for use in RStudio. Remember to run `git pull` after syncing the Zotero data to Overleaf and not to change the `references.bib` file locally.

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

## Keeping Biblatex Cite Keys

Sometimes it can be desirable to keep the Biblatex cite keys and format the references and bibliography on Overleaf, rather than having them rendered by Knitr. To make this easy the script sets up a CSL file that puts placeholders around the cite keys in the manuscript. A git pre-commit hook in the submodule where the `main.tex` file is stored then replaces the placeholders with the appropriate Latex code.

To use the CSL file, replace the default `csl: vancouver-superscript.csl` with `csl: preserve-cite-keys.csl` in the YAML section at the top of the RMarkdown file. The pre-commit hook will take care of the rest. Note that the Biblatex style defaults to Vancouver. This can be changed in the Latex code.

## Prerequisites

The script was written to work with the following software versions:

- macOS Sonoma 14.0
- git 2.39.2
- GNU bash 3.2.57(1)
- RStudio 2023.06.0+421
- R 4.3.1 Beagle Scouts
- rmarkdown 2.23
- tinytex 0.45
- knitr 1.43
- bookdown 0.36

## Bonus Tip: Simpler Citing

If you opt to sync your library with Zotero, as described under [On Overleaf](#on-overleaf) above, you can facilitate the citing further by installing the [*Better BibTeX*](https://retorque.re/zotero-better-bibtex/) plugin and performing the following settings:

- Open *Settings* from the *Zotero* menu and go the *Better BibTex* category.
- Set the *Citation key formula* to `zotero.clean`.
- Set the *Quick-Copy/drag-and-drop citations* under *Quick-Copy* to *Pandoc citation*.
- Check the *Surround Pandoc citations with brackets* checkbox.
- Go to the *Export* category.
- Set the *Item Format* to *Better BibTeX Citation Key Quick Copy*.

You might also have to select all papers and right click and select the *Better BibTeX* submenu, followed by *Unpin BibTeX key* and then *Refresh BibTeX key* to get the same BibTeX keys on your local computer as on Zotero online, which is what syncs to Overleaf. NB! Be careful with this if you have previous papers using your synced Zotero library or if you have custom cite keys in your library, as this might break those links.

Now you should be able to select the papers you want to cite, press `Cmd + Shift + C` and then paste the references straight into your RMarkdown document. This should then work with your synced references. Just remember to press the *Refresh* button in the Overleaf web interface and do a `git pull` to get your Zotero references into your local project.
