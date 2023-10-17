variable "connection_name" {
  description = "Name of the Cloud Build connection"
  type        = string
}

variable "git_url" {
  description = "The Host URI of the Git Server you are connecting to."
  type        = string
  default     = null
}

variable "create_connection" {
  description = "Create the connection resource only after the secrets have been correctly set."
  type        = bool
  default     = false
}

variable "repositories" {
  description = "List of repositories to create connection to as name = value pair. Defaults to creating none"
  type        = map(string)
  default     = {}
}

variable "git_provider" {
  description = "Which git provider you are connecting to. Options are: gitlab, github, ghe"
  type        = string
}

variable "installation_id" {
  description = "Unique Identifier for the installation of the Cloud Build application in your Organisation (One application can have many installations)"
  type        = number
  default     = null
}

variable "app_id" {
  description = "Unique identifier for the Github Enterprise Application for Cloud Build"
  type        = number
  default     = null
}

variable "app_slug" {
  description = "URL friendly name of the Github Enterprise application"
  type        = string
  default     = null
}

variable "ssl_ca" {
  description = "SSL certificate to use for requests to GitHub Enterprise/Self-Hosted Gitlab "
  type        = string
  default     = null
}

variable "service_name" {
  description = "Service Directory name in format: projects/{project}/locations/{location}/namespaces/{namespace}/services/{service}."
  type        = string
  default     = null
}

variable "labels" {
  description = "List of labels to apply to the Secret resources"
  type        = map(string)
  default     = null
}

variable "connection_location" {
  description = "Region to create Cloud Build connection in."
  type        = string
}
