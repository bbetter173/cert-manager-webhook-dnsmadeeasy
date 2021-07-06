# Cert-manager DNSMadeEasy webhook

Moved to k8s-at-home:
- container: https://github.com/k8s-at-home/dnsmadeeasy-webhook
- helm chart: https://github.com/k8s-at-home/charts/tree/master/charts/stable/dnsmadeeasy-webhook

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
