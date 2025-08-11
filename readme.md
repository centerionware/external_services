My original method of writing external services was getting long and difficult to maintain so I'mma try and write a helm chart to simplify things.

Requirements: 
* cert-manager already set up and at least a cluster-issuer, 
* traefik

Issue that caused it:
 the --serversTransport.insecureSkipVerify global option no longer works on newer versions of traefik, it was replaced and now the way seems to be to define a serverstransport crd and an ingressroute. 

A helm chart compatible with argocd is the ultimate goal.

