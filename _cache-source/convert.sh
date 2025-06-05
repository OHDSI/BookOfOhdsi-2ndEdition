source_file="_cache-source/*.docx"
destination_dir="_cache-source"
destination_file="temp"

pandoc \
-t markdown_strict \
--extract-media='$destination_dir/attachments/$file_name' \
$source_file \
-o $destination_dir/$destination_file.md