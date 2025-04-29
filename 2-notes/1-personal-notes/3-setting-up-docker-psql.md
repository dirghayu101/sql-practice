# Docker Postgres Setup

- I used the following commands in conjunction to setup postgres locally:
  - `docker pull postgres`
  - `docker run --name postgresTrial -p 2135:5432 -e POSTGRES_PASSWORD=myPassword  -d postgres`
- 'myPassword' in above command is just an arbitrary placeholder. I was trying to figure out other ways of securely providing environment, but I figured out it is a big rabbit hole. I will look at it another day.
