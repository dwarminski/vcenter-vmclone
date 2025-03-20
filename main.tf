provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = var.allow_unverified_ssl
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_folder" "target_folder" {
  path = var.vm_folder
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = var.host
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  folder           = data.vsphere_folder.target_folder.id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  host_system_id   = data.vsphere_host.host.id

  num_cpus = var.num_cpus
  memory   = var.memory_mb
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.adapter_type != "" ? var.adapter_type : data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  # if disk_size > 0, set it; otherwise use from template
  disk {
    label            = "disk0"
    size             = var.disk_size > 0 ? var.disk_size : data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name = var.vm_name
      }

      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_netmask
      }

      ipv4_gateway    = var.vm_gateway
      dns_server_list = var.dns_servers
    }
  }

  lifecycle {
    prevent_destroy = true #cannot be parametrized :<
  }
}
