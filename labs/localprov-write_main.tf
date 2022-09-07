resource "null_resource" "empty_space" {
    depends_on = [ random_password.password ]
    provisioner "local-exec" {
        command = <<EOT
            echo "db_password: '${random_password.password.result}'" > results.yml
        EOT
    }
}
