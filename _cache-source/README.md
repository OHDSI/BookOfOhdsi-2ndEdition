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

```bash
source_file="_cache-source/*.docx"
destination_dir="_cache-source"
destination_file="temp"

pandoc \
-t markdown_strict \
--extract-media='$destination_dir/attachments/$file_name' \
$source_file \
-o $destination_dir/$destination_file.md
```

Resources:

* [Repo issue 38](https://github.com/OHDSI/BookOfOhdsi-2ndEdition/issues/38)
* [SharePoint](https://ohdsiorg.sharepoint.com/sites/Workgroup-EducationWorkingGroup/Shared%20Documents/Forms/AllItems.aspx?viewid=05fec2cc%2Dec8a%2D4d04%2Db565%2Dcf1289b96f67) containing the docx source files
