data "google_project" "project" {
  project_id = var.project_id
}

resource "google_cloudbuildv2_connection" "connection" {
  # Only create the connection after the secrets have been correctly filled in
  count = (var.create_connection ? 1 : 0)
  # disabled = false ### Check what this does

  location = var.connection_location
  name     = var.connection_name
  project  = var.project_id

  dynamic "gitlab_config" {
    for_each = (var.git_provider == "gitlab" ? [1] : [])
    content {
      authorizer_credential {
        user_token_secret_version = "${google_secret_manager_secret.gitlab_authorizer[0].id}/versions/latest"
      }

      host_uri = var.git_url

      read_authorizer_credential {
        user_token_secret_version = "${google_secret_manager_secret.gitlab_read_authorizer[0].id}/versions/latest"
      }

      dynamic "service_directory_config" {
        for_each = (var.service_name != null ? [1] : [])
        content {
          service = var.service_name
        }
      }

      ssl_ca                        = var.ssl_ca
      webhook_secret_secret_version = "${google_secret_manager_secret.gitlab_webhook[0].id}/versions/latest"

    }
  }

  dynamic "github_config" {
    for_each = (var.git_provider == "github" ? [1] : [])
    content {
      app_installation_id = var.installation_id
      authorizer_credential {
        oauth_token_secret_version = "${google_secret_manager_secret.github_oauth[0].id}/versions/latest"
      }
    }
  }
  dynamic "github_enterprise_config" {
    for_each = (var.git_provider == "ghe" ? [1] : [])
    content {
      app_id                     = var.app_id
      app_installation_id        = var.installation_id
      app_slug                   = var.app_slug
      host_uri                   = var.git_url
      private_key_secret_version = "${google_secret_manager_secret.ghe_private_key[0].id}/versions/latest"

      dynamic "service_directory_config" {
        for_each = (var.service_name != null ? [1] : [])
        content {
          service = var.service_name
        }
      }

      ssl_ca                        = var.ssl_ca
      webhook_secret_secret_version = "${google_secret_manager_secret.ghe_webhook[0].id}/versions/latest"
    }
  }
}

resource "google_cloudbuildv2_repository" "cloudbuild_repo" {
  # If the connection is not created we can't create any repositories.
  # If create_connection = true, use the repositories map, otherwise use an empty map
  for_each = ((var.create_connection ? var.repositories : {}))

  name              = each.key
  project           = var.project_id
  location          = var.connection_location
  parent_connection = google_cloudbuildv2_connection.connection[0].id
  remote_uri        = each.value
}

