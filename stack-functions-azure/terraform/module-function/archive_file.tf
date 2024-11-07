data "archive_file" "function_package" {
  type = "zip"
  source_dir = "${path.module}/../../git_function/azure-vnet"
  output_path = "${path.module}/function.zip"
}