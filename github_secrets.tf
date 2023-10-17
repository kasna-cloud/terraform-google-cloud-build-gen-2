resource "google_secret_manager_secret" "github_oauth" {
  count = (var.git_provider == "github" ? 1 : 0)

  secret_id = "${var.connection_name}-github-oauth"

  replication {
    auto {}
  }

  labels = var.labels
}

resource "google_secret_manager_secret_iam_member" "cloud_build_github_oauth_member" {
  count = (var.git_provider == "github" ? 1 : 0)

  secret_id = google_secret_manager_secret.github_oauth[0].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}
