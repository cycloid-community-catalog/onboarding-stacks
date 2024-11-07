data "archive_file" "function_package" {
  type = "zip"
  source_dir = "../git_function"
  output_path = "function.zip"
}