output "vm_id" {
  description = "Created VM's ID: "
  value       = vsphere_virtual_machine.vm.id
}

output "vm_name" {
  description = "Created VM's name: "
  value       = vsphere_virtual_machine.vm.name
}
