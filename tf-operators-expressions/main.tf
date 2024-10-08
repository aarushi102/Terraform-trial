terraform {}

#Number
variable "num_list" {
  type = list(number)
  default = [ 1,2,3,4 ]
}

variable "list_person" {
  type = list(object({
    fname = string
    lname = string
  }))

  default = [ {
    fname = "raju"
    lname = "rastogi"
  }, {
    fname = "shyam"
    lname = "bond"
  }]
}

variable "map_list" {
  type = map(number)

  default = {
    "one" = 1
    "two" = 2
    "three" = 3
  }
}

#calculations

locals {
  mul = 2 *2
  add = 2+2
  eq = 2!= 3

  double = [for num in var.num_list : num *2]
  odd = [for num in var.num_list : num if num%2 != 0 ]

  fname = [for person in var.list_person : person.fname]

  map_info = [for key, value in var.map_list : key]
  double_map = {for key,value in var.map_list: key => value *2}

}


output "output" {
#   value = local.add
#   value = local.eq
# value = var.num_list
# value = local.double
# value = local.odd
# value = local.fname
# value = local.map_info
value = local.double_map
}