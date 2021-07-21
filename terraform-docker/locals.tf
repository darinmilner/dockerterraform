locals {
  deployment = {
    nodered = {
      containerCount = length(var.extPort["nodered"][terraform.workspace])
      image          = var.image["nodered"][terraform.workspace]
      int            = 1880
      ext            = var.extPort["nodered"][terraform.workspace]
      container_path = "/data"
      volumes = [
        { containerPathEach = "/data" }
      ]
    }
    influxdb = {
      containerCount = length(var.extPort["influxdb"][terraform.workspace])
      image          = var.image["influxdb"][terraform.workspace]
      int            = 8086
      ext            = var.extPort["influxdb"][terraform.workspace]
      volumes = [
        { containerPathEach = "/var/lib/influxdb" }
      ]

    }
    grafana = {
      containerCount = length(var.extPort["grafana"][terraform.workspace])
      image          = var.image["grafana"][terraform.workspace]
      int            = 8086
      ext            = var.extPort["grafana"][terraform.workspace]
      volumes = [
        { containerPathEach = "/var/lib/grafana" },
        { containerPathEach = "/etc/grafana" }
      ]

    }
  }
}
