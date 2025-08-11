
Requirements: 
* cert-manager already set up and at least a cluster-issuer, 
* traefik

Issue that caused it:
 the --serversTransport.insecureSkipVerify global option no longer works on newer versions of traefik, it was replaced and now the way seems to be to define a serverstransport crd and an ingressroute. 

Deployment: Best used with ArgoCD. Just point it to this repository and select the external_services_helm directory. Then use a customized values.yaml.

It generates ExternalName services, middlewares, servertransports, certificates, and IngressRoutes.

Two working examples are provided to show intended usage.

A compose for your Traefik Ingress.

### Why? 

Defining ingresses almost became a full time job. All the seperate parts required for it to work to point to a service outside of the kubernetes was cumbersone, lots of redundant typing and specifying things over and over. This simplifies things so one smaller entry can define everything and the implimentation details are then generated from the specification.

This reduces the time it takes to create an ingress from 20+ minutes to 3-5 minutes. And if traefik decides to change their spec the templates can be updated to fix all of the IngressRoutes quickly. 

### So far

So far I'm running 26 IngressRoutes with this chart, including one for ArgoCD because one of the updates broke https backends. The ArgoCD is given the letsencrypt certificate for the domain it's running on, but the actual hostname of the pod is 'argocd' and not the FQDN. So the ingress creates a Internal Server Error when trying to use a regular kubernetes Ingress. I tried to tie the ingress to a ServerTransport CRD via annotations by following the documentation but it didn't work so instead I used this chart with an externalName pointing to argocd.argocd.svc.cluster.local and set insecureSkipVerify: true , and now argocd's ingress is working again.


### Roadmap

I'd like to make this work with regular Ingresses with all the features that this already supports. No timeline, may never get to it.
