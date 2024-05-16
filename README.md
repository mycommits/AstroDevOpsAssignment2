# Assignment 2
AWS EKS clusters come with default AWS VPC CNI plugin that provides some excellent features like getting an address within the VPC subnet range. One limitation of AWS CNI comes from the number of IP addresses and ENI that you can assign to the single instance.

Refer to the (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI) which shows that limit.

In this assignment, to replace AWS VPC CNI (EKS default) with Calico for networking layer. The new EKS cluster should
have a mixture of spot and on demand node group. Deploy a sample service to illustrate that the cluster is using Calico
network layer instead of EKS VPC default.

- [ ] Ideally the candidate should have installed Calico networking layer in the kube-system namespace (pods: calico-kubecontroller, calico-node etc).
- [ ] Upon inspection (kubectl get pods –all-namespaces), only kubernetes system pods should be running on AWS VPC private IP while the rest of the pods should be running on Calico network (different IP range).

## Solving Approach
Similar to the previous assignment, I used Terraform modules to provision an EKS cluster and the necessary infrastructure. I utilized the basic parameters and skipped unrelated resources for Calico.

Since EKS comes with the aws-node daemonset by default, I provisioned a cluster without a node group and then removed the aws-node daemonset to disable AWS VPC networking for pods. To avoid further idempotency issues, I avoided using resources and providers such as null_resource and local_exec.

Next, I installed the Calico Operator and Calico itself. Finally, by uncommenting the "eks_managed_node_groups" and re-running the Terraform templates, the managed node group was added.

To verify the setup, I deployed a sample Nginx pod and service in the EKS cluster and checked its IP address.

## Getting Started
Before deployment, check the `variable.tf` file. All configurable parameters are listed there with clear descriptions for each parameter.

### Steps to Deploy
1. **Initialize Terraform**

    Execute the following command to download the required Terraform dependencies:
    ```sh
    terraform init
    ```

2. **Review Execution Plan**

    To check the execution plan, run the following command:
    ```sh
    terraform plan
    ```

3. **Deploy Resources**

    To deploy the resources, run the following command:
    ```sh
    terraform apply
    ```

4. **Remove aws-node Daemonset**

    To delete the daemonset, run the following command:
    ```sh
    kubectl delete daemonset -n kube-system aws-node
    ```

5. **Install Calico Operator**

    To install the Calico operator and its CRDs, run the following command:
    ```sh
    kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/tigera-operator.yaml
    ```

6. **Install Calico Itself**

    To install Calico, run the following command:
    ```sh
    kubectl create -f - <<EOF
    kind: Installation
    apiVersion: operator.tigera.io/v1
    metadata:
    name: default
    spec:
    kubernetesProvider: EKS
    cni:
        type: Calico
    calicoNetwork:
        bgp: Disabled
    EOF
    ```

7. **Deploy Test Application**

    To install Nginx, run the following command:
    ```sh
    kubectl apply -f demo.yaml
    ```
