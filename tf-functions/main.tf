terraform {}

locals {
  value = "Hello World"

}

variable "string_list" {
  type = list(string)
  default = [ "serv1", "serv2", "serv3" ]
}

output "output" {
#   value = upper(local.value)
# value = startswith(local.value, "H")
# value = split(" ", local.value)
# value = max(1,2,3,4,5,6,87,456,3,4)
value = abs(-15)
}