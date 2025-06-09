destination_dir="_cache-source"
destination_file="temp"
source_file="$destination_dir/*.docx"

pandoc \
-t markdown_strict+smart \
--extract-media=$destination_dir'/attachments/'$file_name \
$source_file \
--wrap=none \
-o $destination_dir/$destination_file.md
