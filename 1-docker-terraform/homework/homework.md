# Question 1
What's the version of `pip` in the `python:3.13` image?
- Run this command `docker run -it --entrypoint=bash python:3.13`
- Then, run this command `pip --version`
- `pip 25.3`

# Question 2
Given the `docker-compose.yaml`, what is the hostname and port that `pgadmin` should use to connect to the `postgres` database?
- As `pgadmin` is a Docker container, so we are communicating on port `5432` as port `5433` is on the host machine.
- `postgres:5432`
- `db:5432`

# Question 3. Counting short trips
For the trips in November 2025 (lpep_pickup_datetime between '2025-11-01' and '2025-12-01', exclusive of the upper bound), how many trips had a trip_distance of less than or equal to 1 mile?
- 8,007

# Question 4. Longest trip for each day
Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles (to exclude data errors).

Use the pick up time for your calculations.
- 2025-11-14

# Question 5. Biggest pickup zone
Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025?
- East Harlem North

# Question 6. Largest tip
For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?

Note: it's tip , not trip. We need the name of the zone, not the ID.
- Yorkville West

# Question 7.
Terraform workflow for
1. Downloading the provider plugins and setting up backend = `terraform init`
2. Generating proposed changes and auto-executing the plan = `terraform apply -auto-approve`
3. Remove all resources managed by terraform = `terraform destroy`