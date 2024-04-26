# node-engine

A dockerized engine for running nodes

## Getting Started

1. Add any node binaries you need to the `node-bin` directory
2. Create a `<brand>.env` file for the nodes you'll be working with. This should have credentials to access the given brand

```sh
NODE_LOG_LEVEL=debug # optional but I like it to view the output
NODE_EMAIL="your_email"
NODE_PASSWORD="your_password"
```

3. Add entries to `docker-compose.yaml` for the brands/licenses to run.

```docker-compose
x-<brand>:
  &<brand>
  << : *service
  env_file:
    - ./<brand>.env
  entrypoint: /entrypoint.sh <brand (or other name of binary)>

  ...

services:
  <brand>-1:
    << : *<brand>
    environment:
      - NODE_NAME=<brand>-1
  <brand>-2:
    << : *<brand>
    environment:
      - NODE_NAME=<brand>-2

  ...

  <brand>-n:
    << : *<brand>
    environment:
      - NODE_NAME=<brand>-n

# If you can find a way to make this programmatically create new `NODE_NAME`s I'm all ears. Until then, it's this silly copy pasta 😭😭😭
```

4. Run the nodes with `docker compose up --remove-orphans --build` (use `-d` if you want to silence the output)
6. Profit


Note, if you have a bunch of nodes with a single brand you may see some rolling failures at the beginning. I believe this happens because of throttling the credential calls. If you just let if keep trying fora little bit it should resolve itself.
