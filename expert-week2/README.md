## Use of Forge to test smart contracts

#### Getting Started

Prerequisite: Need to have Rust installed

```
curl -L https://foundry.paradigm.xyz | bash;
foundryup
```

1. To initialise a new project, run `forge init <project_name>`
2. To compile smart contracts, run `forge build`
3. To run tests, run `forge test`

In order for tests to work, standard library has to be installed. 
`forge install foundry-rs/forge-std`
