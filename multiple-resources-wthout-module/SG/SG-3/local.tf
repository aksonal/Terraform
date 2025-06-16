locals {
  Security-groups = flatten([
                    for sg_names,ports in var.sg_names_n_ingress:[
                     for port,cidrs in ports:[
                      for cidr in cidrs:{
                            sg_name = sg_names 
                            key = "${tostring(port)}-${cidr}"
                            port = port
                            cidr = cidr
                        }
                       ]
                      ]
                      ]
                     )
}
