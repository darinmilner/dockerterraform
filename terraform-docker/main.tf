# PASS VARIABLES FROM MAIN to Module
# module block

module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source         = "./container"
  countIn        = each.value.containerCount
  for_each       = local.deployment
  name_in        = each.key
  image_in       = module.image[each.key].image_out
  internalPortIn = each.value.int
  externalPortIn = each.value.ext
  volumesIn      = each.value.volumes
}


