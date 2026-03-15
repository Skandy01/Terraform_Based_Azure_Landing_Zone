resource "azurerm_linux_virtual_machine" "VM" {
    name=var.vm_name
    resource_group_name=var.RG_name
    location=var.location
    size=var.vm_size

    admin_username=var.admin_username
    admin_password=var.admin_password

    network_interface_ids=[var.nic_id]

    os_disk{
        caching=var.os_disk_caching
        storage_account_type=var.storage_account_type
    }

    source_image_reference{
        publisher=var.image_publisher
        offer=var.image_offer
        sku=var.image_sku
        version=var.image_version
    }

    custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF
  )

}