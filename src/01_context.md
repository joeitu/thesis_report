
<!--
TODO explain CSS != Cascading..
TODO define recipe
TODO define RDF

 -->

# Context and terminology

In this chapter, we describe the principal elements needed to understand the context and motivation of this thesis. First, we go through a quick recall of the history of the web and its current challenges. Then we explain the motivation behind Solid and describe its main components.

## History and current state of the World Wide Web

In the 1980s, the  European Organization for Nuclear Research, also known as CERN, was looking for a way to make physicists easily share their work and data around the globe. Internet was at its beginning, the TCP/IP protocol was freshly invented, but at this time, sharing data across multiple computers was laborious and inefficient[@web30bd]. A layer was lacking to write, transmit and store information easily through the network.
In 1989, Sir Tim Bernes Lee submitted a proposal for an information management system to tackle the former issue with new concepts such as hypertext links, web browsers, the HTML language, and the HTTP protocol[@vox-www] [@w3-web-proposal].

<!-- ![Illustration from Berners-Lee 1989's proposal](./2-solid_description.md.d/fig_0.jpg){width=50%}-->

On 1991 August 6, the first website available on the world wide web, "http://info.cern.ch" was born. 

<!-- ![The first website *http://info.cern.ch*](./2-solid_description.md.d/fig_1.jpg){ width=50% } -->

Today's web might be far from the decentralized digital utopia imagined by Sir Tim Berners Lee in the early 90s. Currently, most services, data, and patents related to web technologies belong to only a few companies, commonly referred to as GAFAM[@centralised-web-article]. This oligopoly is in part due to a phenomenon called the "vendor lock-in": users tend to stay with the same platform <!-- TODO That holds there data--> since it is too hard to switch to another one<!-- [lukas p1] -->. Furthermore, the centralization of web services and data has been a the heart of the latest internet scandal such as Cambridge Analytica or the worldwide NSA information gathering revealed by Edward Snowden[@guardian-dweb].

<!--  - 
 - privacy issue: 2013 leak from Edward Snowden has shown that with backdoors to a few companies, the US government could spy on a large part of the world population.
 -->

## Solid: Tim Berners-Lee proposal to Re-Decentralise the web

To tackle those problems, Tim Berners-Lee has started the Solid project in 2016 as a mean to re-decentralize the web[@solid-wikip]. Solid take advantage of the Semantic Web (also known as Web 3.0 but not to be confused with web3), a new set of standards extending the current World Wide Web to make the internet's data machine-readable. It is made machine-readable through Linked Data, a new way of formatting structured data to ensure its integration, interpolation,  and interpretation by machines in the Semantic Web. Solid - sometimes stylized SoLiD - stands for **So**cial **Li**nked **D**ata. It aims to give back data control to internet users and improve their privacy online. Solid is not a technology in itself, but rather a set of specifications that allows decoupling of web applications' authentification, data, and app logic[@solid-spec-protocol] . The end goal is to give internet users complete control over their data[@solid-wikip] . However, the web needs a couple of new artifacts and vocabulary to allow this decoupling; the two most important are the Pod (decoupling data storage) and the Identity Provider (decoupling authentification).


<!-- TODO add zero data illu -->

A Pod (Personal Online Datastore) is where Solid users store their data online. Like a Unix filesystem, the WAC (Web Access Control) controls who can read, write or delete files stored in a Pod. Each of these permissions is defined in `.acl` "Access Control List" files, hosted on the Pod itself[@solid-wikip].

WebIDs are the standardization of a universal identifier used for authentification. More than replacing the traditional username, it is a fullUniform Resource Identifier ( URI ) that, once dereferenced, can give more information on the end-user. It usually has the form of:

```
https://my-webid-host.net/my-username/profile/card#me
```

The Identity Provider (IDP) permits the user to login into various applications with their WebID in the fashion of today's "Sign in with Google/Facebook". It uses The Solid-OIDC protocol - built on top of Open ID Connect - that manages authentification in a Solid environment.

 Identity Provider and Pod Provider are two decoupled services, but a Solid Server usually serves both. 

Let us illustrate all those new terms with an example:
Alice has a pod hosted on `http://alice.pod.org` where she stores her data, including a holiday picture at `http://alice.pod.org/picture/holiday.png`. By associating the `READ` permission to Bob's WebID  `https://bob.anotherpod.org/profile/card#me` in the ACL file `http://alice.pod.org/picture/holiday.acl`, now Bob, if authenticated <!-- to a third party picture viewer --> with his WebID will be authorized to access the picture at `http://alice.pod.org/picture/holiday.png`.


Those specifications are developed by the World Wide Web Consortium (W3C), an organization of web standard founded by Tim Berners-Lee, which promote technologies compatibility around the web. Tim Berners-Lee has also created a startup called Inrupt that aims to build a Solid commercial solution. Inrupt is financing a team of researchers from Ghent University to develop the Community Solid Server.

 


## Solid Community Server, an implementation of the Solid specifications

The Community Solid Server is an open-source Solid Server - i.e. a  Pod and Identity Provider - that implements Solid Specification. It can also deliver WebIDs. Currently, only two implementations fulfill the Solid-specification: CSS and NSS ( Node Solid Server). CSS can be considered a new replacement for the legacy NSS behind `https://solidcommunity.net`, currently the most used solid server. CSS is a newborn software under active development: version 1.0 was released in the symbolic month of August 2021, exactly 30 years after the World Wide Web first webpage, and version 3.0 was released the 23 February 2022 [@css-release]. Inrupt financially supports IDLab from Gent University (Belgium) to build the software<!-- TODO already said -->. It's copyrighted by Inrupt and IMEC research and development hub under the MIT license. Built in a modular fashion, it has been designed for researchers and developers who want to test Solid App and/or design new features and experiment with Solid[@css-readme]. Such modularity is operated using components.js, a dependency injection framework at the core of CSS.

<!--     Four core contributors: Joachim Van Herwegen, Ruben Verborgh, Ruben Taelman, and Matthieu Bosquet.
    Copyrighted by Inrupt Inc. and imec and available under the MIT License
Abbreviated CSS for now (might change in the future for CSS).
 -->

## Component.js: a dependency injection behind CSS modularity

Component.js is a javascript dependency injection developed by CSS authors. A Dependency Injection (DI) implements a form of inversion of control, a programming principle where part of a program receives its execution flow from a framework. Dependency injection will dynamically create (inject) the dependencies between the different components of a computer program. Therefore, the program execution flow is expressed not only through static code but also dynamically assigned during execution. In particular, components.js lets us describe the dependencies between CSS components from a JSON configuration file. A particular CSS configuration is called a *recipe*. Even if the CSS authors have written components.js mainly to answer CSS needs, it has been built as a general-purpose dependency injection framework and can be used for other software.
<!-- also used by digita proxy -->
  
The innovation of components.js, compared to other javascript DI frameworks such as `inversify` or `typedi`, is to be built around the concept of Linked Data. In other words, the configuration files leverage the power of the semantic web: each component can be uniquely and globally identified through a URI. Furthermore, having configuration files machine-readable and built under the same vocabulary makes it easy to generate, parse, compare, or edit them in a script.

<!-- 
TODO: - benefice of linked data config file
      - example + illustation
      - a particular CSS config.json file is called a recipe


( REF: https://componentsjs.readthedocs.io/en/latest/ )



 - why CSS use DI?
   - bring modularity and extensibility to CSS
   - allow to bring software modification to the config space instead of the source code
   - in particular allow to create recipe
 - def recipe
   - link recipe repo
 - based on linked data
   - more easy to fetch, build and tests configuration
 - example with and without
 -->
## CERN's IT infrastructure

<!-- 
 - CERN has special relation with Timbl
 - interested in development of OSS software? privacy stuff?
 - CERN show interest in opensource project
 - CERN has strong interest in solid as it can solve privacy requirement ( find ref )
 - Also, CERN show interest into solid, as its technology could solve some of CERN privacy requirement.
 -->

<!-- TODO add PaaS diagram illustration vs IaaS Saas -->
 CERN is primarily a high-energy physics laboratory. Counting 12,400 users from institutions from more than 70 countries [@cernWiki], strong computing infrastructure is of paramount importance. To facilitate the host and deployment of web applications inside its computing environment, CERN has deployed a Platform-as-a-Service (PaaS) to its users.
  
  PaaS is a cloud computing service meant for developers. Its goal is to simplify workload by offering the developer to quickly initiate, run and manage one or more web applications without worrying about the computing infrastructure part such as networking, storage, OS, and others. [@wiki-paas] 
  
OKD4 or Openshift 4 is Red Hat's PaaS solution. The community version used at CERN is free and open source under the Apache 2 license [@okd.io]. It is powered by other popular open-source technologies such as Docker and Kubernetes.
  
CERN's Openshift allows its developers to quickly deploy web applications with strong DevOps tooling and provides them with a high-level integration to CERN's computing environment, such as user and access management[@cern-paas-doc].
<!--  - openshift compare to docker and oothers
 - good environment for testing solid, develop, migrating and create new app using solid ( Jan's abstract ) -->


## Thesis' plan
The main goal of this thesis is to investigate CSS by deploying a CSS instance inside CERN's infrastructure. First, we will explore the current solution for CSS regarding Single-Sign-On and User Interface integration. Next, we will describe a particular recipe we build for CERN and discuss our design choices. Subsequently, we will show the DevOps pipeline used to deploy our recipe to CERN's infrastructure. Finally, after explaining a potential security risk with Pods-hosted webpage, we will finish reviewing the software quality and open source dynamics. 

<!-- TODO: REDO AT THE END -->

[^web30bd]: https://eu.usatoday.com/story/tech/news/2019/03/12/world-wide-web-turns-30-berners-lee-contract-thoughts-internet/3137726002/ 

[^vox-www]: https://www.vox.com/2019/3/12/18260709/30th-anniversary-world-wide-web-google-doodle-history

[^w3-web-proposal]: https://www.w3.org/History/1989/proposal.html

[^centralised-web-article]: https://www.cairn.info/article.php?ID_ARTICLE=COMLA_188_0061#

[^solid-wikip]: https://en.wikipedia.org/wiki/Solid_(web_decentralization_project)

[^solid-spec-protocol]: https://solid.github.io/specification/protocol

[^guardian-dweb]: https://www.theguardian.com/technology/2018/sep/08/decentralisation-next-big-step-for-the-world-wide-web-dweb-data-internet-censorship-brewster-kahle

[^css-release]: https://github.com/solid/community-server/releases

[^css-readme]: https://github.com/solid/community-server/

[^okd.io]: https://okd.io/about/

[^cern-paas-doc]: https://paas.docs.cern.ch/]

[^cern-wiki]: https://en.wikipedia.org/wiki/CERN

[^wiki-paas]: https://en.wikipedia.org/wiki/Platform_as_a_service

