# Docker and Terraform
- Docker container vs image, image is like blueprint while container is using that image as base to operate

## Dockerfile stuff

## Docker compose file
The structure is usually in this format:
```yaml
services:
  <service-name>:
    image:
    build:
    container_name:
    ports:
    volumes:
    environment:
    env_file:
    depends_on:
    networks:

volumes:
networks:
```
## SQL stuff
The SQL usually has this order of execution.
```sql
FROM/JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
LIMIT/OFFSET
```
The usage is mostly dependent on experience of the practitioner.

## Terraform
- Used to provision infrastructure resources
- It is a infrastructure as code, any changes and management can be done in a safe, consistent and repeatable manner by defining the resource configurations
- The main files involved are: `main.tf`, `variables.tf`, `.tfstate`, optionally `resources.tf` and `output.tf`
- Some declarations:
  - `terraform`: Basic Terraform settings like `required_version`, `backend`, `required_providers`
  - `provider`: Data or resource types managed by Terraform on the Terraform Registry
  - `resource`: Blocks to define components of the infrastructure
  - `variables`, `locals`: Runtime arguments and constants

- Steps:
  - `terraform init`
  - `terraform plan`
  - `terraform apply`
  - `terraform destroy`