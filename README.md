# 🚀 EKS + ArgoCD + NGINX GitOps Deployment

This project provisions an Amazon EKS cluster using Terraform, deploys an NGINX application using Kubernetes manifests, and sets up ArgoCD for GitOps-style continuous delivery. Optionally, it also exposes the application via Ingress and custom DNS domain.

---

## 📦 Project Structure


---

## ✅ Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform  installed
- `kubectl` installed and configured
- GitHub repo to host Kubernetes manifests (for ArgoCD sync)
- Domain and DNS provider (e.g., Route 53)

---

## ⚙️ Step 1: Provision EKS Cluster Using Terraform

### 1. Navigate to Terraform Directory

cd terraform/

Inside You can all Infra related files created to deploy Infrastructire on aws cloud using terraform using custom modules.
once Infra created Installed Prerequisites to deploy "Nginx " Application.
Installed tools & Services on EKS cluster:-
1. Nginx-ingress-conroller
2. cert-manager
3. argocd
4. Nginx Deployment

Argocd Installation:- 
**kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml**
created Ingress file  in argocd/ folder to access argocd via ui.



To access Nginx application click here :- https://nginx.cloudearn.in/

To access Argocd Via Ui click here:- https://argocd.cloudearn.in/
username:- admin
password:- admin-argocd



