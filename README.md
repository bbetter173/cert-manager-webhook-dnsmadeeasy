# Cert-manager DNSMadeEasy webhook

This is WIP - it build and deploys but still has problems with TLS Handshakes.

# Building the code

```bash
make build
```
# Deploying the webhook

```bash
kubectl apply -f deploy/rendered-manifest.yaml
```

or re-generate it with:

```bash
make rendered-manifest.yaml
```

# Running the test suite

Before you can run the test suite, you need to download the test binaries:

```bash
./scripts/fetch-test-binaries.sh
```

Then modify `testdata/dnsmadeeasy/apikey.yaml` to setup the configs.

Now you can run the test suite with:

```bash
make test
```
