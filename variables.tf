variable "vsphere_user" {
  description = "vCenter user"
  type        = string
}

variable "vsphere_password" {
  description = "vCenter password"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "vCenter addrr"
  type        = string
}

variable "allow_unverified_ssl" {
  description = "Ignore SSL? (true/false)"
  type        = bool
  default     = true
}

variable "datacenter" {
  description = "Datacenter name"
  type        = string
}

variable "vm_folder" {
  description = "vSphere dst dir"
  type        = string
}

variable "cluster" {
  description = "vSphere cluster name"
  type        = string
}

variable "datastore" {
  description = "Datastore name"
  type        = string
}

variable "network" {
  description = "vNet name"
  type        = string
}

variable "template_name" {
  description = "Template name"
  type        = string
}

variable "vm_name" {
  description = "New VM name"
  type        = string
}

variable "num_cpus" {
  description = "CPU count"
  type        = number
  default     = 2
}

variable "memory_mb" {
  description = "RAM size"
  type        = number
  default     = 8192
}

variable "adapter_type" {
  description = "NIC type"
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "Disk size"
  type        = number
  default     = 0
}

variable "host" {
  description = "dst ESXi host"
  type        = string
}

variable "vm_ip" {
  description = "IP addrr"
  type        = string
  default     = ""
}

variable "vm_netmask" {
  description = "Prefix (24 -> 255.255.255.0 25 -> 255.255.255.128)"
  type        = number
  default     = 24
}

variable "vm_gateway" {
  description = "Gateway"
  type        = string
  default     = ""
}

variable "dns_servers" {
  description = "DNS servers"
  type        = list(string)
  default     = []
}

/*
variable "prevent_destroy" {
  description = "Protect vm"
  type        = bool
  default     = true
}
*/
