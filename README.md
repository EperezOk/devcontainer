# Audits devcontainer

Devcontainer for audits.

## Features

Applications:

- `foundry`
- `medusa`
- `slither`
- `nvm`, `yarn`, `npm`, `pnpm`

VsCode Extensions:

```json
[
    "NomicFoundation.hardhat-solidity",
    "tintinweb.solidity-visual-auditor",
    "trailofbits.weaudit",
    "tintinweb.solidity-metrics"
]
```

## Scripts

Scripts should be used for tasks that require that the container is already up and running to execute.

They are mounted within the container, so they can be executed from the `/workspaces` directory.
