
variable "image" {
  type        = map(any)
  description = "image for container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana"
      prod = "grafana/grafana"
    }
  }
}

variable "extPort" {
  type = map(any)
  #   sensitive = true


  # validation {
  #   condition     = max(var.extPort["dev"]...) <= 65535 && min(var.extPort["dev"]...) >= 1980
  #   error_message = "The external port must be between 0 and 65535."
  # }

  # validation {
  #   condition     = max(var.extPort["prod"]...) < 1980 && min(var.extPort["prod"]...) >= 1880
  #   error_message = "The external port must be between 0 and 65535."
  # }
}

variable "intPort" {
  type    = number
  default = 1880

  validation {
    condition     = var.intPort == 1880
    error_message = "Internal port must be 1880."
  }
}

# variable "containerCount" {
#   type    = number
#   default = 3
# }



