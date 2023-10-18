module "cloudbuild_v2" {
  source = "github.com/kasna-cloud/terraform-google-cloud-build-gen-2"
  # source = "../../"

  project_id          = "your-project-id"
  connection_name     = "example-gitlab"
  create_connection   = true # set to true once the secrets are added
  git_provider        = "gitlab"
  connection_location = "us-central1"

  git_url = "https://gitlab.com"

  labels = {
    test = "val"
  }

}
