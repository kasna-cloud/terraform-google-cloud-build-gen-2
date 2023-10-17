resource "google_secret_manager_secret" "ghe_private_key" {
  count = (var.git_provider == "ghe" ? 1 : 0)

  secret_id = "${var.connection_name}-private-key"

  replication {
    auto {}
  }

  labels = var.labels
}

resource "google_secret_manager_secret" "ghe_webhook" {
  count = (var.git_provider == "ghe" ? 1 : 0)

  secret_id = "${var.connection_name}-webhook"

  replication {
    auto {}
  }

  labels = var.labels
}

resource "google_secret_manager_secret_iam_member" "cloud_build_ghe_private_key_member" {
  count = (var.git_provider == "ghe" ? 1 : 0)

  secret_id = google_secret_manager_secret.ghe_private_key[0].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret_iam_member" "cloud_build_ghe_webhook_member" {
  count = (var.git_provider == "ghe" ? 1 : 0)

  secret_id = google_secret_manager_secret.ghe_webhook[0].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}
