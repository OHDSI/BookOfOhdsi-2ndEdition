Cache for Source Files
==================

This directory is intended to be populated only on local/development machines.
It provides a consistent places for docx files to be temporarily located
as they're being converted to Markdown files,
and relocated to their permanent location.

Files here will not be committed to the local repo
(nor uploaded to the server)
because the directory is listed in the root `.gitignore` file.

This bash script invokes [pandoc](https://pandoc.org/)
to convert the directory's _single_ docx to a markdown file called "temp.md".
Then copy the contents of the directory into the chapter's existing stub.

Run the script `sh _cache-source/convert.sh` from the repo's root directory.
If the repo is stored in the "ohdsi" folder in your "Documents",
the line will look like:

```bash
~/Documents/ohdsi/BookOfOhdsi-2ndEdition$ sh _cache-source/convert.sh
```

Resources:

* [Repo issue 38](https://github.com/OHDSI/BookOfOhdsi-2ndEdition/issues/38)
* [SharePoint](https://ohdsiorg.sharepoint.com/sites/Workgroup-EducationWorkingGroup/Shared%20Documents/Forms/AllItems.aspx?viewid=05fec2cc%2Dec8a%2D4d04%2Db565%2Dcf1289b96f67) containing the docx source files
