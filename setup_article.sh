#!/usr/bin/env bash

# Before running this script, make a new project on Overleaf and copy the git
# link. The script takes two parameters, the first being said git link and
# the second is what you would like to name your article.

# Check that at least two parameters are passed to the script.
if [[ $# -lt 2 ]] ; then
  echo Please provide a URL to the Overleaf git repository and a name for your article.
  exit 1
fi

# Make a directory to store the project.
mkdir "$2"

# Change active directory to project directory.
cd "$2"

# Create a git repository.
git init

# Create a .gitignore file.
cat << EOF > .gitignore
.Rproj.user
.Rhistory
.RData
.Ruserdata
EOF

# Create an R project file.
cat << EOF > "$2.Rproj"
Version: 1.0

RestoreWorkspace: Default
SaveWorkspace: Default
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: Sweave
LaTeX: pdfLaTeX
EOF

# Create a CSL file for Vancouver formatting (replace with another file from the
# Zotero Style Repsitory, https://www.zotero.org/styles, if desired).
# The following code was also taken from the Zotero Style Repository.
cat << EOF > vancouver-superscript.csl
<?xml version="1.0" encoding="utf-8"?>
<style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="sort-only" initialize-with-hyphen="false" page-range-format="minimal">
  <info>
    <title>Vancouver (superscript)</title>
    <id>http://www.zotero.org/styles/vancouver-superscript</id>
    <link href="http://www.zotero.org/styles/vancouver-superscript" rel="self"/>
    <link href="http://www.nlm.nih.gov/bsd/uniform_requirements.html" rel="documentation"/>
    <author>
      <name>Michael Berkowitz</name>
      <email>mberkowi@gmu.edu</email>
    </author>
    <contributor>
      <name>Sean Takats</name>
      <email>stakats@gmu.edu</email>
    </contributor>
    <contributor>
      <name>Sebastian Karcher</name>
    </contributor>
    <category citation-format="numeric"/>
    <category field="medicine"/>
    <summary>Vancouver style as outlined by International Committee of Medical Journal Editors Uniform Requirements for Manuscripts Submitted to Biomedical Journals: Sample References</summary>
    <updated>2022-04-14T13:48:43+00:00</updated>
    <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
  </info>
  <locale xml:lang="en">
    <date form="text" delimiter=" ">
      <date-part name="year"/>
      <date-part name="month" form="short" strip-periods="true"/>
      <date-part name="day"/>
    </date>
    <terms>
      <term name="collection-editor" form="long">
        <single>editor</single>
        <multiple>editors</multiple>
      </term>
      <term name="presented at">presented at</term>
      <term name="available at">available from</term>
      <term name="section" form="short">sect.</term>
    </terms>
  </locale>
  <locale xml:lang="fr">
    <date form="text" delimiter=" ">
      <date-part name="day"/>
      <date-part name="month" form="short" strip-periods="true"/>
      <date-part name="year"/>
    </date>
  </locale>
  <macro name="author">
    <names variable="author">
      <name sort-separator=" " initialize-with="" name-as-sort-order="all" delimiter=", " delimiter-precedes-last="always"/>
      <label form="long" prefix=", "/>
      <substitute>
        <names variable="editor"/>
      </substitute>
    </names>
  </macro>
  <macro name="editor">
    <names variable="editor" suffix=".">
      <name sort-separator=" " initialize-with="" name-as-sort-order="all" delimiter=", " delimiter-precedes-last="always"/>
      <label form="long" prefix=", "/>
    </names>
  </macro>
  <macro name="chapter-marker">
    <choose>
      <if type="chapter paper-conference entry-dictionary entry-encyclopedia" match="any">
        <text term="in" text-case="capitalize-first"/>
      </if>
    </choose>
  </macro>
  <macro name="publisher">
    <choose>
      <!--discard publisher info for articles-->
      <if type="article-journal article-magazine article-newspaper" match="none">
        <group delimiter=": " suffix=";">
          <choose>
            <if type="thesis">
              <text variable="publisher-place" prefix="[" suffix="]"/>
            </if>
            <else-if type="speech"/>
            <else>
              <text variable="publisher-place"/>
            </else>
          </choose>
          <text variable="publisher"/>
        </group>
      </if>
    </choose>
  </macro>
  <macro name="access">
    <choose>
      <if variable="URL">
        <group delimiter=": ">
          <text term="available at" text-case="capitalize-first"/>
          <text variable="URL"/>
        </group>
      </if>
    </choose>
  </macro>
  <macro name="accessed-date">
    <choose>
      <if variable="URL">
        <group prefix="[" suffix="]" delimiter=" ">
          <text term="cited" text-case="lowercase"/>
          <date variable="accessed" form="text"/>
        </group>
      </if>
    </choose>
  </macro>
  <macro name="container-title">
    <choose>
      <if type="article-journal article-magazine chapter paper-conference article-newspaper review review-book entry-dictionary entry-encyclopedia" match="any">
        <group suffix="." delimiter=" ">
          <choose>
            <if type="article-journal review review-book" match="any">
              <text variable="container-title" form="short" strip-periods="true"/>
            </if>
            <else>
              <text variable="container-title" strip-periods="true"/>
            </else>
          </choose>
          <choose>
            <if variable="URL">
              <text term="internet" prefix="[" suffix="]" text-case="capitalize-first"/>
            </if>
          </choose>
        </group>
        <text macro="edition" prefix=" "/>
      </if>
      <!--add event-name and event-place once they become available-->
      <else-if type="bill legislation" match="any">
        <group delimiter=", ">
          <group delimiter=". ">
            <text variable="container-title"/>
            <group delimiter=" ">
              <text term="section" form="short" text-case="capitalize-first"/>
              <text variable="section"/>
            </group>
          </group>
          <text variable="number"/>
        </group>
      </else-if>
      <else-if type="speech">
        <group delimiter=": " suffix=";">
          <group delimiter=" ">
            <text variable="genre" text-case="capitalize-first"/>
            <text term="presented at"/>
          </group>
          <text variable="event"/>
        </group>
      </else-if>
      <else>
        <group delimiter=", " suffix=".">
          <choose>
            <if variable="collection-title" match="none">
              <group delimiter=" ">
                <label variable="volume" form="short" text-case="capitalize-first"/>
                <text variable="volume"/>
              </group>
            </if>
          </choose>
          <text variable="container-title"/>
        </group>
      </else>
    </choose>
  </macro>
  <macro name="title">
    <text variable="title"/>
    <choose>
      <if type="article-journal article-magazine chapter paper-conference article-newspaper review review-book entry-dictionary entry-encyclopedia" match="none">
        <choose>
          <if variable="URL">
            <text term="internet" prefix=" [" suffix="]" text-case="capitalize-first"/>
          </if>
        </choose>
        <text macro="edition" prefix=". "/>
      </if>
    </choose>
    <choose>
      <if type="thesis">
        <text variable="genre" prefix=" [" suffix="]"/>
      </if>
    </choose>
  </macro>
  <macro name="edition">
    <choose>
      <if is-numeric="edition">
        <group delimiter=" ">
          <number variable="edition" form="ordinal"/>
          <text term="edition" form="short"/>
        </group>
      </if>
      <else>
        <text variable="edition" suffix="."/>
      </else>
    </choose>
  </macro>
  <macro name="date">
    <choose>
      <if type="article-journal article-magazine article-newspaper review review-book" match="any">
        <group suffix=";" delimiter=" ">
          <date variable="issued" form="text"/>
          <text macro="accessed-date"/>
        </group>
      </if>
      <else-if type="bill legislation" match="any">
        <group delimiter=", ">
          <date variable="issued" delimiter=" ">
            <date-part name="month" form="short" strip-periods="true"/>
            <date-part name="day"/>
          </date>
          <date variable="issued">
            <date-part name="year"/>
          </date>
        </group>
      </else-if>
      <else-if type="report">
        <date variable="issued" delimiter=" ">
          <date-part name="year"/>
          <date-part name="month" form="short" strip-periods="true"/>
        </date>
        <text macro="accessed-date" prefix=" "/>
      </else-if>
      <else-if type="patent">
        <group suffix=".">
          <group delimiter=", ">
            <text variable="number"/>
            <date variable="issued">
              <date-part name="year"/>
            </date>
          </group>
          <text macro="accessed-date" prefix=" "/>
        </group>
      </else-if>
      <else-if type="speech">
        <group delimiter="; ">
          <group delimiter=" ">
            <date variable="issued" delimiter=" ">
              <date-part name="year"/>
              <date-part name="month" form="short" strip-periods="true"/>
              <date-part name="day"/>
            </date>
            <text macro="accessed-date"/>
          </group>
          <text variable="event-place"/>
        </group>
      </else-if>
      <else>
        <group suffix=".">
          <date variable="issued">
            <date-part name="year"/>
          </date>
          <text macro="accessed-date" prefix=" "/>
        </group>
      </else>
    </choose>
  </macro>
  <macro name="pages">
    <choose>
      <if type="article-journal article-magazine article-newspaper review review-book" match="any">
        <text variable="page" prefix=":"/>
      </if>
      <else-if type="book" match="any">
        <text variable="number-of-pages" prefix=" "/>
        <choose>
          <if is-numeric="number-of-pages">
            <label variable="number-of-pages" form="short" prefix=" " plural="never"/>
          </if>
        </choose>
      </else-if>
      <else>
        <group prefix=" " delimiter=" ">
          <label variable="page" form="short" plural="never"/>
          <text variable="page"/>
        </group>
      </else>
    </choose>
  </macro>
  <macro name="journal-location">
    <choose>
      <if type="article-journal article-magazine review review-book" match="any">
        <text variable="volume"/>
        <text variable="issue" prefix="(" suffix=")"/>
      </if>
    </choose>
  </macro>
  <macro name="collection-details">
    <choose>
      <if type="article-journal article-magazine article-newspaper review review-book" match="none">
        <choose>
          <if variable="collection-title">
            <group delimiter=" " prefix="(" suffix=")">
              <names variable="collection-editor" suffix=".">
                <name sort-separator=" " initialize-with="" name-as-sort-order="all" delimiter=", " delimiter-precedes-last="always"/>
                <label form="long" prefix=", "/>
              </names>
              <group delimiter="; ">
                <text variable="collection-title"/>
                <group delimiter=" ">
                  <label variable="volume" form="short"/>
                  <text variable="volume"/>
                </group>
              </group>
            </group>
          </if>
        </choose>
      </if>
    </choose>
  </macro>
  <macro name="report-details">
    <choose>
      <if type="report">
        <text variable="number" prefix="Report No.: "/>
      </if>
    </choose>
  </macro>
  <citation collapse="citation-number">
    <sort>
      <key variable="citation-number"/>
    </sort>
    <layout delimiter="," vertical-align="sup">
      <text variable="citation-number"/>
    </layout>
  </citation>
  <bibliography et-al-min="7" et-al-use-first="6" second-field-align="flush">
    <layout>
      <text variable="citation-number" suffix=". "/>
      <group delimiter=". " suffix=". ">
        <text macro="author"/>
        <text macro="title"/>
      </group>
      <group delimiter=" " suffix=". ">
        <group delimiter=": ">
          <text macro="chapter-marker"/>
          <group delimiter=" ">
            <text macro="editor"/>
            <text macro="container-title"/>
          </group>
        </group>
        <text macro="publisher"/>
        <group>
          <text macro="date"/>
          <text macro="journal-location"/>
          <text macro="pages"/>
        </group>
      </group>
      <text macro="collection-details" suffix=". "/>
      <text macro="report-details" suffix=". "/>
      <text macro="access"/>
    </layout>
  </bibliography>
</style>
EOF

# Create a custom CSL file that can be used to preserve Biblatex cite keys.
cat << EOF > "preserve-cite-keys.csl"
<?xml version="1.0" encoding="utf-8"?>
<style class="in-text" version="1.0" xmlns="http://purl.org/net/xbiblio/csl">
  <info>
    <title>Preserve Citation Keys for Latex Conversion</title>
    <author>
      <name>Jonas Engström</name>
      <email>j.e.engstrom@gmail.com</email>
    </author>
  </info>
  <citation>
    <layout prefix="@STARTCITE@" suffix="@ENDCITE@">
      <text variable="citation-key"/>
    </layout>
  </citation>
  <bibliography>
    <layout>
      <text value="@BIBLIOGRAPHYLOCATION@"/>
    </layout>
  </bibliography>
</style>
EOF

# Create an RMarkdown file.
cat << EOF > "$2.Rmd"
---
title: "$2"
author: "Jonas Engström"
date: "$(date -I)"
knit: (function(inputFile, encoding)
        { 
          rmarkdown::render(
            inputFile,
            encoding=encoding, 
            output_file=file.path(dirname(inputFile), 'overleaf', 'main')
          )
        }
      )
output:
  pdf_document:
    keep_tex: true
bibliography: overleaf/references.bib
# Change csl to preserve-cite-keys.csl to keep cite keys for use with Biblatex.
csl: vancouver-superscript.csl
---

\`\`\`{r setup, include=FALSE}
knitr::opts_chunk\$set(echo = TRUE)
\`\`\`

This is a reference[@ronne1962antiproton].

## References
EOF

# Perform an initial commit to git before adding submodule.
git add -A
git commit -m "Initial commit."

# Add Overleaf git repository as submodule.
git submodule add "$1" overleaf

# Add PDF file to .gitignore for submodule, in order to not have it
# uploaded to Overleaf.
echo "main.pdf" > overleaf/.gitignore

# Check whether a references.bib file has been pulled from the remote
# repository and create one otherwise.
if [[ ! -f "overleaf/references.bib" ]] ; then
cat << EOF > overleaf/references.bib
@phdthesis{ronne1962antiproton,
year = {1962},
title = {Antiproton and Negative Pion Interactions in Complex Nuclei},
author = {Ronne, B. E.},
institution = {Stockholm University}
}
EOF
fi

# Commit changes and push to Overleaf.
git add -A
git commit -m "Added submodule."
cd overleaf
git add -A
git commit -m "Added submodule"
git push -u origin master
cd ..

# Create a pre commit hook in the Overleaf submodule to create relative
# paths for figures in order for them to render correctly on Overleaf.
# Simultaneously check if the preserve-cite-keys.csl file has been used
# and in that case replace the RMarkdown references and bibliography
# with Biblatex cite keys and bibliography.
cat << 'EOF' > .git/modules/overleaf/hooks/pre-commit
# Make figure paths relative instead of absolute.
sed -i '' "s/$(pwd | sed 's/\//\\\//g')/./g" main.tex

# Check if the preserve-cite-keys CSL file has been used
# and format citation keys to work with biblatex on
# Overleaf, if that is the case.
if [ $(grep -c @STARTCITE@ main.tex) -ge 1 ]
then
    perl -i -0pe 's{\@STARTCITE\@((?:.*))(\@ENDCITE\@)}{ join "", "\\cite\{", $1 =~ s/(\\)//gr, "\}" }xe' main.tex
    perl -i -0pe 's/\@BIBLIOGRAPHYLOCATION\@/\\printbibliography/g' main.tex

    perl -i -0pe 's/\\hypertarget[\S\s]*\\end{CSLReferences}/\\printbibliography/g' main.tex
    perl -i -0pe 's/pdfcreator={LaTeX via pandoc}}\n\n\\title{/pdfcreator={LaTeX via pandoc}}\n\n\\usepackage[style=vancouver]{biblatex}\n\\addbibresource{references.bib}\n\n\\title{/g' main.tex
fi

# Stage main.tex for commit again.
git add main.tex
EOF
chmod +x .git/modules/overleaf/hooks/pre-commit
