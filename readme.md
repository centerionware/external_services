
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

From 39 lines of yaml for the simplest kubernetes external service to 10 lines (+9 for the certificate, but the certificates can often be re-used across multiple ingressRoutes)

```
  - name: n8n-centerionware-com-ingressroute
    secretName: centerionware-default
    routes:
      - kind: Rule
        match: Host(`n8n.centerionware.com`) && PathPrefix(`/`)
        services:
          - type: ExternalName
            name: n8n-routing-centerionware-com-service
            externalName: n8n.centerionware.lan
            port: 80
            scheme: http
```

And this generates all the manifests for all the things. 

348 lines was the largest definition I had for a specific set of ingresses, and this replaced it with 56(+9) lines of specification (centerionware-ingress in the examples). This doesn't include the middlewares required for this part for either side. Middlewares definitions with this are also made smaller but by a fixed amount.

Technically the `type: ExternalName` isn't used either, they're all ExternalName services so that's one more line that can be removed.

### Roadmap

I'd like to make this work with regular Ingresses with all the features that this already supports. No timeline, may never get to it.
