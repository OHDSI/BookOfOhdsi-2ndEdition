Prototype
=========

(_This is kinda a weird issue.  It's mostly a running list of tasks to paste into a new issue when a chapter is being converted._)

Common Chapter Tasks
------------------

These apply to all chapters in the book.

- [ ] stub in Quarto

- [ ] abstract is ideally 2-8 sentences.

- [ ] chapter leads are clear

- [ ] convert docx to markdown (see #38 for some notes)

- [ ] split sentences on separate lines.
  This needs manual attention if it's within something nested, like a bullet list.

  - pattern: `(?<=[^\d])([\?\.])[ ]{1,2}(?=\w)`
  - sub (notice this is a single period/question-mark on the first line, followed by a blank second line):

    ```plain
    $1

    ```

    (or with two spaces for indented bullets)

- [ ] download figures (& rename if necessary)

- [ ] Delete any explicit section & subsection numbering.

    Pattern: `(#{1,5})\s+\d+(\.\d+){0,4}\s+`

    Sub (needs a trailing space after `$1`): `$1 `

    Explanation:

    * captures up to five `#`s
    * eats up all white spaces (including whatever unconventional spaces that seems to be inserted).
    * matches Chapter number
    * optionally matches up to four more sections
    * eats up subsequent white space
    * replaces with the `#`s, following by a single (conventional) spaces

- [ ] delete any empty section/subsection lines, with up to three newlines

    pattern: `#{1,5}\n{1,3}`

    sub: `` (ie, a zero-length character)

- [ ] Enclose capitalized table & column names in backticks.
  This guy get most of them, but still needs some manual review

  pattern:

  ```regex
  \b([A-Z][A-Z_\\]{5,}[A-Z0-9])\b(?![`\\])
  ```

  sub:

  ```regex
  `$1`
  ```

  vscode options: [case-sensitive](https://stackoverflow.com/questions/50533281/vs-code-regular-expression-search-only-uppercase-letters) and regex

  explanation: matches a 10+ character word that starts & ends with letters, and can have underscores and backslashes in between.  (Pandoc adds backlashes to escape underscores, so they're not interpreted as italics markup.)  But the negative lookahead (`(?!...)`) ignores words that end with a backtick or backslash (so it won't try to enclose terms a second time through).

  Then replace the `\_` with just `_` (because inside backticks, the underscore doesn't need to be escaped).
  This needs to be repeated a few times for worth that contain multiple underscores.

  pattern:

  ```regex
  (?<=`\w+)\\_(?=(\w+\\_){0,9}\w+`)
  ```

  sub: `_`

  explanation: Use a positive lookbehind and a positive lookahead (itself with an optional underscore segment) to identify backticks and words around an escaped underscore.
  Replace it with merely an underscore.

- [ ] convert manual lists into Markdown lists.  See below for styles.

- [ ] manually incorporate figures (paths, text, & references)

- [ ] Recreate tables.  I tried several [conversion options](https://pandoc.org/MANUAL.html#tables) in pandoc.  If the conversion doesn't produce the
  desired structure at first, I recommend switching
  to this approach that involves some manual work
  but eventually produces smaller and more manageable content.

  1. Copy basics from docx.  Ignore the caption or unnecessary headers.
  1. Paste into Excel or LibreOffice Calc; arrange the rough structure.  (This step can be skipped for really simple tables.)
  1. Copy & paste into this [converter](https://thisdavej.com/copy-table-in-excel-and-paste-as-a-markdown-table/)
  1. Copy & paste that into the Quarto markdown file.
  1. Specify the [alignment](https://quarto.org/docs/authoring/tables.html#markdown-tables) of each column
  1. Below that, add the table caption and anchor, such as.

    ```markdown
    : "Finding site of" relationship {#tbl-part-chapter-shorttableterm}
    ```

  For complicated tables, we should consider the `list-table` extension.  But I haven't figured out how to incorporate it with Quarto captions.

- [ ] clean up any confused headings

- [ ] replace curly quotes with straight quotes `[“”]` and `[‘’]`.
  Make sure any alt text containing double-quotes are enclosed in single quotes.
  But my vote is that alt-text never gets that complicated anyway.

- [ ] replace single quotes with double quotes, except for apostrophes.

- [ ] standardize hyphens.  Replace `—` with `--`.  This an em dash replaced by two hyphens (which Pandoc will convert to a dash when rendering the html).

- [ ] Replace dashes with asterisks for bullet lists.

  pattern: `(?<=^\s{0,6})-(?=\s)`

  sub: `*`

  explanation: uses positive look arounds to find single dashes at the beginning of
  a line, with optional spaces at the beginning and a mandatory space at the end.
  I don't have a strong preference, but we should be consistent and [markdownlint](https://github.com/DavidAnson/markdownlint/blob/v0.38.0/doc/md004.md) prefers asterisks

- [ ] add spaces around em-dashes.    This follows AP style guide, that's designed for [skinny newspapers](https://www.thepunctuationguide.com/em-dash.html).

  - add space before with pattern `(?<=[^ !-])-{2}(?![+-])` and sub ` --`
  - add space before with pattern `(?<![+-])-{2}(?=[^ >-])` and sub `-- `

- [ ] replace `+/-` with `&plusmn;` and [other scientific symbols](https://gist.github.com/webbedfeet/5cdbbb26a880e8fb159b579325d5e841).
    (You'll probably need to untoggle the regex option in the VSCode search bar.)

- [ ] "e.g." and "i.e." should be followed by a comma, and not italicized ([NIH](https://www.ncbi.nlm.nih.gov/books/NBK995/#:~:text=e.g.,and%20follow%20with%20a%20comma.))

- [ ] outgoing cross refs (make sure the references to other chapters/sections/figures/tables are resolved)

- [ ] incoming cross refs (define [anchors](https://quarto.org/docs/authoring/cross-references.html) for all headers for other chapters/sections to refer to)

    - Examples:

      - `{#sec-ohdsi-community}` is the anchor for the "community.md" chapter within the "ohdsi" part
      - `{#sec-ohdsi-community-adoption}` is the anchor for the "adoption" section within the "community" chapter.
      - `{#sec-ohdsi-community-adoption-notes}` is the anchor for the "notes" subsection within the "adoption" section.

    - Notes:

      - `#sec` is literal.  All anchors start with it.
      - Each [Part](https://quarto.org/docs/books/book-structure.html#parts-appendices)/[Chapter](https://quarto.org/docs/books/book-crossrefs.html)/[Section](https://quarto.org/docs/books/book-crossrefs.html#section-numbers)/Subsection/Subsubsection should be assigned a _single_ term.  So the chapter is "OHDSI Community" shortened to just "community"; the "Uniform Data Representation" is shortened to just "representation".  Try to find the single term that best chapters the meaning of the chapter.  Or use a commonly recognized abbreviation (e.g., "cdm" for Common Data Model).
      - This term must be unique among its siblings in the family tree.  But does not need to be unique among its cousins.

- [ ] Run [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) is VS Code to address remaining flags.
- [ ] Markdown Style Choices
  - [ ] [Headings](https://www.markdownguide.org/basic-syntax/#headings): use `#` instead of `=====` or `----`
  - [ ] [Bold](https://www.markdownguide.org/basic-syntax/#bold): use `**` instead of `__`
  - [ ] [Ordered lists](https://www.markdownguide.org/basic-syntax/#ordered-lists): use a sequence of `1.` ... `1.` values.  Not `1.` ... `2.` sequences.
  - [ ] [Unordered lists](https://www.markdownguide.org/basic-syntax/#unordered-lists): Use `*` instead of `-`.
  - [ ] Tables: are trickier, because some are simple and some have complex formats.
    * Simple tables: <https://quarto.org/docs/authoring/tables.html>
    * Complex tables: talk to @wibeasley.  We'll try to avoid grid tables b/c they're being [phased out](https://github.com/quarto-dev/quarto-cli/issues/8732).
- [ ] end each figure caption with a period
- [ ] schedule a walk-through with author
- [ ] walk-through with author

Specific Chapter Tasks
-------

These are generated by the editors as they convert to markdown and prepare the chapter for publishing.

- [ ] example 1: Ambiguous use of "they" in the paragraph starting "Among the OHDSI tools..."
- [ ] example 2: bad/old url for NIH group
- [ ] example 3: Screenshot of Atlas has very poor/low resolution.  Please retake the screenshot on a large desktop monitor, and maximize the window.

--------

Questions for @cgreich:

1. Are there any resources that require and account and aren't available to the public?

   For instance with N3C, add ` {{< fa lock title="Link requires an N3C Data Enclave account" >}}` (with a space separating the closing `)` and the leading `{{`)  (see #49 for some notes)

   - FA Lock: <https://fontawesome.com/icons/lock?s=solid&f=classic>
   - Quarto Extension: <https://github.com/quarto-ext/fontawesome>

1. In the rendered version, how should tables & columns be styles?
   Right now, they're inline code & fully uppercase.
