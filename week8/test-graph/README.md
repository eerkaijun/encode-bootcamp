### Instructions for graph setup

```
npm install -g @graphprotocol/graph-cli
graph init --studio test-graph
graph auth --studio <AUTH KEY>
cd test-graph
graph codegen && graph build
graph deploy --studio test-graph
```