# Contributor Instructions

## Testing

### Manual Testing

There are two ways to test the module manually:

1. **Using the `examples` directory**: The `examples` directory contains a set of example configurations that demonstrate how to use the module. To test the module, you can run the example configuration using the following commands:
    ```bash
    cd examples/basic_usage
    terraform init
    terraform plan
    terraform apply
    ```
    After testing, you can destroy the resources created by running:
    ```bash
    terraform destroy
    ```

## Generating Documentation

This module uses [terraform-docs](https://terraform-docs.io/user-guide/introduction/) to generate documentation. To generate the documentation, run the following command from the root of the repository:

```bash
terraform-docs --config .terraform-docs.yml .
```

## Cutting a New Release

To prepare a new release:

1. Perform a manual test of the latest code on `main`, using one of the manual testing options detailed above.
2. Tag the release and push the tag to the repository:
    ```
    git tag -a vX.Y.Z -m vX.Y.Z
    git push origin vX.Y.Z
    ```
