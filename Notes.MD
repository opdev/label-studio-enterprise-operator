# Steps to install Label-Studio-Operator:

1. Install Operator:

```
make deploy
```

This will create a new namespace and install the operator in that namespace.

2. Create a secret with lse-license:

Link to step: https://labelstud.io/guide/install_enterprise_k8s.html#Configure-Kubernetes-secrets

3. Create a secret with dockerhub-credentials:

Link to step: https://labelstud.io/guide/install_enterprise_k8s.html#Configure-Kubernetes-secrets

4. Install postgresql and redis with bitnami charts in that namespace:

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm pull bitnami/postgresql  
helm install my-postgresql bitnami/postgresql
helm install my-redis bitnami/redis
export POSTGRES_PASSWORD=$(oc get secret --namespace label-studio-enterprise-operator-system my-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
export REDIS_PASSWORD=$(oc get secret --namespace label-studio-enterprise-operator-system my-redis -o jsonpath="{.data.redis-password}" | base64 -d)
```

5. Make changes to redis and postgresql to work on Openshift:

From the yaml file of the stateful set, remove the runAsUser: 1001 from the template:

6. Install the lse-operand:

```
oc create -f config/samples/charts_v1alpha1_labelstudioenterprise.yaml
```