/* Alta3 Research - rzfeeser@alta3.com
   Working with "for_each" within a null_resource */


/* a list of local variables */
locals {
  fellowship = ["strider", "frodo", "gandalf"]
}

/* The null_resource */
resource "null_resource" "fellowship" {
  for_each = toset(local.fellowship)
  triggers = {
    name = each.value
  }
}

/* We want these outputs */
output "fellowship" {
  value = null_resource.fellowship
}
