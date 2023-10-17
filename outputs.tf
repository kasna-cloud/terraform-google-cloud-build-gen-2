## Secret IDs - Can be used to apply further IAM 

# Gitlab
output "gitlab_webhook_secret_id" {
  value       = (var.git_provider == "gitlab" ? google_secret_manager_secret.gitlab_webhook[0].id : null)
  description = "Secret ID for Gitlab Webhook in format: `projects/{{project}}/secrets/{{secret_id}}`"
}

output "gitlab_read_authorizer_secret_id" {
  value       = (var.git_provider == "gitlab" ? google_secret_manager_secret.gitlab_read_authorizer[0].id : null)
  description = "Secret ID for Gitlab Read Only Authorizer in format: `projects/{{project}}/secrets/{{secret_id}}`"
}

output "gitlab_authorizer_secret_id" {
  value       = (var.git_provider == "gitlab" ? google_secret_manager_secret.gitlab_authorizer[0].id : null)
  description = "Secret ID for Gitlab Read Write Authorizer in format: `projects/{{project}}/secrets/{{secret_id}}`"
}

# Github
output "github_oauth_secret_id" {
  value       = (var.git_provider == "github" ? google_secret_manager_secret.github_oauth[0].id : null)
  description = "Secret ID for GitHub Oauth in format: `projects/{{project}}/secrets/{{secret_id}}`"
}

# GHE
output "ghe_private_key_secret_id" {
  value       = (var.git_provider == "ghe" ? google_secret_manager_secret.ghe_private_key[0].id : null)
  description = "Secret ID for GHE Private Key in format: `projects/{{project}}/secrets/{{secret_id}}`"
}

output "ghe_webhook_secret_id" {
  value       = (var.git_provider == "ghe" ? google_secret_manager_secret.ghe_webhook[0].id : null)
  description = "Secret ID for GHE Webhook in format: `projects/{{project}}/secrets/{{secret_id}}`"
}

## Connection ID 
output "connection_id" {
  value       = (var.create_connection ? google_cloudbuildv2_connection.connection[0].id : null)
  description = "Unique Identifier for the connection in format: `projects/{{project}}/locations/{{location}}/connections/{{name}}`"
}

output "repository_ids" {
  value = {
    for repo_name in google_cloudbuildv2_repository.cloudbuild_repo : repo_name.name => repo_name.id
  }
  description = "Unique identifier for the repository resources managed by the connection. Access via `module_name.repository_ids[$var.repositories.key]`. In format: `projects/{{project}}/locations/{{location}}/connections/{{parent_connection}}/repositories/{{name}}`"
}
