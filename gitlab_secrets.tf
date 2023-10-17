resource "google_secret_manager_secret" "gitlab_webhook" {
  count = (var.git_provider == "gitlab" ? 1 : 0)

  secret_id = "${var.connection_name}-webhook"

  replication {
    auto {}
  }

  labels = var.labels
}

resource "google_secret_manager_secret" "gitlab_read_authorizer" {
  count = (var.git_provider == "gitlab" ? 1 : 0)

  secret_id = "${var.connection_name}-read-authorizer"

  replication {
    auto {}
  }

  labels = var.labels
}

resource "google_secret_manager_secret" "gitlab_authorizer" {
  count = (var.git_provider == "gitlab" ? 1 : 0)

  secret_id = "${var.connection_name}-authorizer"

  replication {
    auto {}
  }

  labels = var.labels
}

resource "google_secret_manager_secret_iam_member" "cloud_build_webhook_member" {
  count = (var.git_provider == "gitlab" ? 1 : 0)

  secret_id = google_secret_manager_secret.gitlab_webhook[0].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret_iam_member" "cloud_build_read_authorizer_member" {
  count = (var.git_provider == "gitlab" ? 1 : 0)

  secret_id = google_secret_manager_secret.gitlab_read_authorizer[0].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

resource "google_secret_manager_secret_iam_member" "cloud_build_authorizer_member" {
  count = (var.git_provider == "gitlab" ? 1 : 0)

  secret_id = google_secret_manager_secret.gitlab_authorizer[0].id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}
