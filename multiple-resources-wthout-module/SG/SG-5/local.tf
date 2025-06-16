locals {
  ingress_rule = flatten([
                    for sg_names,rules in var.sg_rules:[
                     for port,cidrs in rules.ingress != null ? rules.ingress : {} :[
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

    egress_rule = flatten([
                    for sg_names,rules in var.sg_rules:[
                     for port,cidrs in rules.egress != null ? rules.egress : {} :[
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
