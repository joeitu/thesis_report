# Intro
goal: finding a solution for solid server at CERN, investigate Community Solid Server
Can CSS fulfill CERN's solid needs:

# 1 Description & context

*explain and define concept that are needed for the understanding of the later*

  - linked data ( req for componentsjs )
  - turtle, triple RDF
  - what is solid SEE [./src/solid_description.md.pdf](./src/solid_description.md.pdf]
    - what is an IDP
    - what is a Pod
    - what is a solid app ( internal, external, pod based )
  - a few words on CERN IT infrasctructure
    - what is keycloak SSO
  - what is Community Solid Server
    - what is component.js 

# 2 Deploying SCS at CERN

## 2.1  making a recipe for CERN's need

### 2.1.1 token login integration for already existing WebID

SEE [./src/easy_token.md.pdf](./src/easy_token.md.pdf)

    - description of the problem and motivation
    - proposed design solution
    - implementation
    - test

### 2.1.2 Creating CERN CSS recipe: How to configure SCS for CERN's needs
    - SCS component.js configuration for CERN
      - files based datastorage
        - security
        - performance tests compare to RAM based datastorage
      - index page

## 2.2  Deploying the recipe to CERN's infrasctructure

 - CI/CD setup, architecture and scripts

## 2.3 security

SEE [./src/security.md.pdf](./src/security.md.pdf)

## 2.4 tests

 - Terra Incognita user tests

## 2.5 Integratin with CERN's SOO
    - description of the problem
     Solving the compatibility gap between CERN's OIDC and SCS Solid-OIDC
    - description of digita's proxy solution
    - other solution
    - implementation of digita solution at CERN's infrasctructure

## 2.6 Discution and chapter conclustion

# 3 Evaluation of SCS software

## 3.1 Software quality
  - SCS code quality
    -> iso25010 like review
  - UI/UX integration review

## 3.2 Open source community dynamics

SEE [./src/css_community_review.md.pdf](./src/css_community_review.md.pdf)

  - SCS open source community review
    - stats

# Discution
 - What SCS is good for
   => flexible, configurable, easily hackable to one's needs
 - What are SCS limitation
   => not developped for production, lack of guarantees on security, lack mature ecosystem, not yet ready for certain use cases
 - Is SCS a viable solution for CERN's solid Pod
   => yes for experimental setup. Need to mature before used in production environment and with sensitive data

# Conclusion
 => CSS best available solution for CERN - good long terme solution -  but lack maturity in UI/UX integration, SSO integration, also quick evolving upstream spec makes it unstable for on now on certain aspect.
