provider "aws" {
  region = "us-east-1"

  // For local testing, use a credentials file (see https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html_
  shared_credentials_files = ["~/.aws/creds"]

  // If using profiles, specify the profile name (see https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
  profile = "power"
}
