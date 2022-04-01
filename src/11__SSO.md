<!--
TODO MITMProxy
TODO CHECK Penny
 -->

## Single-Sign-On Investigation 

 In this chapter, we discuss the integration of CSS with CERN's Single-Sign-On. After describing the challenges of this task and defining the main elements that compose it, we discuss and explain the chosen solution. 


- Context

Large organizations such as CERN, which usually contain a collection of web applications, tend to rely on Single Sign On ( SSO ) to allow them to have one login for all the different applications.

To implement their SSO solution, CERN uses Keycloak, an open-source identity and access management solution. Keycloak support multiple authentification protocol and in particular, OpenID Connect. 

On the other side, CSS is also built to be compatible with authentification protocol; we can use CSS only as a Pod provider using an external Identity Provider.

*Problem*

In the following, we investigate if we can use CSS only as a Pod provider and use CERN's Keycloak to manage the authentification.

We realized that a compatibility gap between all the current SSO providers ( including Keycloak ) and CSS makes this issue non-trivial. Indeed, CSS is compatible with the Solid-OIDC protocol, whereas Keycloak ( and all other SSO provider alternatives) only support standard OIDC.

Solid-OIDC is an extenssion of OIDC. It differs from OIDC mainly for two reasons:
 - OIDC can be extended in different ways, and Solid-OIDC extends OIDC with the most robust security features:Proof Key for Code Exchange ( PCKE ) and Demonstration of Proof of Possession ( DPoP ), which add security to token exchange. Solid-OIDC requires them both.
 - Also, and most importantly, Solid-OIDC adds a WebID claim in the OIDC protocol, which is an absolute requirement to make the WAC work.

*Solutions*

To close this compatibility gap, a few solutions exist:

 1. Keycloak gets upgraded with Solid-OIDC compatibility
 1. Use a middleware between CSS and Keycloak that implements the PCKE, DPop feature and add the WebID claim

For the first solution, no answers were given from Keycloak on whether this should be on their roadmap [https://github.com/keycloak/keycloak/discussions/9150], but some pull requests have been submitted from the community in that direction, as we can see from this DPoP support proposal [https://github.com/keycloak/keycloak/pull/8895]. However, there is no information on when this feature will be available.

For the second solution, Digita - a European-based company working on Solid - has created a middleware solution. The middleware is still in active development and in an early version. Its licensing is not defined yet, but it is currently closed-source, even if it might change in the future. In the context of this thesis, Digita granted us access to experiment with their solution at CERN.

*Implementation*

 We successfully deployed the Digita solution on a localhost machine and used the proxy as expected. However, we encountered an issue that was critical for the use of the middleware for CERN's CSS instance:

 During the OIDC protocol, when a solid app wants to connect to the OpenID Provider ( OP ) service to authenticate an end-user, it will need to register with the OpenID Provider to provide the OP with information about itself and obtains information needed to use it. This is part of the protocol is called Dynamic Client Registration ( DCR ).[https://openid.net/specs/openid-connect-registration-1_0.html]

Unfortunately, CERN's Keycloak instance does not support DCR. Therefore, a solid app that relies on DCR to manage authentification, which is the case of most available solid apps,  will not work with Keycloak as an OIDC issuer.

A workaround is to create a `static-client` in Keycloak and make the solid-app use the `static-client` instead of DCR. However, this would only work with custom-made solid applications and would not work with available solid applications that rely on DCR. 

*Evaluation*

Keycloak would break the authentification process of all the solid-app that rely on DCR since CSS default Identity Provider support DCR, but CERN's Keycloak does not. Therefore, Keycloak comes with disadvantages, as it would restrict CERN's CSS users only to authenticate to self-developed solid apps. Therefore, our choice has been to stay with CSS default Identity Provider to be able to use the already existing solid apps that require DCR.



