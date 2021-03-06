\newpage





<!--
TODO explain CSS != Cascading..
TODO define recipe
TODO define RDF

 -->
\newpage

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

To tackle those problems, Tim Berners-Lee has started the Solid project in 2016 as a mean to re-decentralize the web[@solidAbout]. Solid take advantage of the Semantic Web (also known as Web 3.0 but not to be confused with web3), a new set of standards extending the current World Wide Web to make the internet's data machine-readable. It is made machine-readable through Linked Data, a new way of formatting structured data to ensure its integration, interpolation,  and interpretation by machines in the Semantic Web. Solid - sometimes stylized SoLiD - stands for **So**cial **Li**nked **D**ata. It aims to give back data control to internet users and improve their privacy online. Solid is not a technology in itself, but rather a set of specifications that allows decoupling of web applications' authentification, data, and app logic[@solid-spec-protocol] . The end goal is to give internet users complete control over their data[@solidAbout] . However, the web needs a couple of new artifacts and vocabulary to allow this decoupling; the two most important are the Pod (decoupling data storage) and the Identity Provider (decoupling authentification).


<!-- TODO add zero data illu -->

A Pod (Personal Online Datastore) is where Solid users store their data online. Like a Unix filesystem, the WAC (Web Access Control) controls who can read, write or delete files stored in a Pod. Each of these permissions is defined in `.acl` "Access Control List" files, hosted on the Pod itself[@solidSpec].

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
 CERN is primarily a high-energy physics laboratory. Counting 12,400 users from institutions from more than 70 countries [@cernReport], strong computing infrastructure is of paramount importance. To facilitate the host and deployment of web applications inside its computing environment, CERN has deployed a Platform-as-a-Service (PaaS) to its users.
  
  PaaS is a cloud computing service meant for developers. Its goal is to simplify workload by offering the developer to quickly initiate, run and manage one or more web applications without worrying about the computing infrastructure part such as networking, storage, OS, and others. [@paas-intro] 
  
OKD4 or Openshift 4 is Red Hat's PaaS solution. The community version used at CERN is free and open source under the Apache 2 license [@okd.io]. It is powered by other popular open-source technologies such as Docker and Kubernetes.
  
CERN's Openshift allows its developers to quickly deploy web applications with strong DevOps tooling and provides them with a high-level integration to CERN's computing environment, such as user and access management[@cern-paas-doc].
<!--  - openshift compare to docker and oothers
 - good environment for testing solid, develop, migrating and create new app using solid ( Jan's abstract ) -->


## Thesis' plan
The main goal of this thesis is to investigate CSS by deploying a CSS instance inside CERN's infrastructure. First, we will explore the current solution for CSS regarding Single-Sign-On and User Interface integration. Next, we will describe a particular recipe we build for CERN and discuss our design choices. Subsequently, we will show the DevOps pipeline used to deploy our recipe to CERN's infrastructure. Finally, after explaining a potential security risk with Pods-hosted webpage, we will finish reviewing the software quality and open source dynamics. 

<!-- TODO: REDO AT THE END -->

\newpage

# CSS current status

In this section, we discuss the current status of CSS toward UI and Single-Sign-On ( SSO ) compatibility. First, we investigate CSS compatibility with CERN's SSO provider Keycloak, particularly a proxy solution developed by Digita. Then we analyze, compare and test potential UI for CSS, as CSS comes default without ( or a very minimalistic ) UI. Finally, we conclude on the available UIs.
<!--
TODO MITMProxy
TODO CHECK Penny
 -->

## Single-Sign-On Investigation 

 In this chapter, we discuss the integration of CSS with CERN's Single-Sign-On. After describing the challenges of this task and defining the main elements that compose it, we discuss and explain the chosen solution. 


*Context*

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

For the first solution, no answers were given from Keycloak on whether this should be on their roadmap [@210a4a93e5210ef9271f81d9f9f36dc9], but some pull requests have been submitted from the community in that direction, as we can see from this DPoP support proposal [@06c24be2df0d0cad658961e61d35cfa8]. However, there is no information on when this feature will be available.

For the second solution, Digita - a European-based company working on Solid - has created a middleware solution. The middleware is still in active development and in an early version. Its licensing is not defined yet, but it is currently closed-source, even if it might change in the future. In the context of this thesis, Digita granted us access to experiment with their solution at CERN.

*Implementation*

 We successfully deployed the Digita solution on a localhost machine and used the proxy as expected. However, we encountered an issue that was critical for the use of the middleware for CERN's CSS instance:

 During the OIDC protocol, when a solid app wants to connect to the OpenID Provider ( OP ) service to authenticate an end-user, it will need to register with the OpenID Provider to provide the OP with information about itself and obtains information needed to use it. This is part of the protocol is called Dynamic Client Registration ( DCR ).[@28bd7d2e75b2ee9c391d0214b461cad5]

Unfortunately, CERN's Keycloak instance does not support DCR. Therefore, a solid app that relies on DCR to manage authentification, which is the case of most available solid apps,  will not work with Keycloak as an OIDC issuer.

A workaround is to create a `static-client` in Keycloak and make the solid-app use the `static-client` instead of DCR. However, this would only work with custom-made solid applications and would not work with available solid applications that rely on DCR. 

*Evaluation*

Keycloak would break the authentification process of all the solid-app that rely on DCR since CSS default Identity Provider support DCR, but CERN's Keycloak does not. Therefore, Keycloak comes with disadvantages, as it would restrict CERN's CSS users only to authenticate to self-developed solid apps. Therefore, our choice has been to stay with CSS default Identity Provider to be able to use the already existing solid apps that require DCR.




## Pod UI comparison

This section compares different UI candidates for our CERN???s CSS instance. If the UI is not compatible with CSS, we investigate the root cause of the incompatibility. Finally, we discuss the state of CSS compatibility with UIs and the options for CERN???s CSS instance. <!-- [TODO CHECK IF TRUE] -->

<!--
GRAMMARLY DONE
TODO: add click illustraion and reference in text
TODO: add corelation between deprecited app and compatibility with CSS
     -> add last commit date
TODO: solidos : not tried cause initial desire to move to another platform
TODO: metric: loc of each project
TODO: feature list -> add more critera to the tests?
TODO: which have priority: internal above pod-based
TODO: test or explain why mashlib not tested
 -->

*Definition*

A *Pod UI* ( also called an *UI* in this paper ) is a particular type of solid application strongly related to a Pod or a WebID hosted on a solid server. We expect most of its features to be related to the agent ( user or organization ) represented by the WebID or interacting with the Pod content. Examples of standard features of a solid server UI can be:

 - a Pod file browser: allow users to explore and manage all the content of a Pod: add, edit or delete files, manage ACL authorization.
 - a profile page: create and manage information about the Pod's owner's personal information and WebID ( as name, profile picture among others )
 - contact or friends list related to the WebID
 - chat and messaging: communicate with the agent represented by the WebID

*Where to host a solid server UI*

As seen in figure \ref{UiLocation} , the Pod UI can be hosted in three different locations.
<!-- TODO figure not working -->

![ Different locations of a Pod UI \label{UiLocation} ](./assets/UI.jpg)

  - As an **external app**: hosted on a different server, the UI will still be able to interact with the solid server if the user provides the correct permission upon login. Compared to the two others options, it differs strongly by being hosted on a different URL than the Pod's URL and the WebID URL.

  - As an **internal app**: by creating a recipe with a particular components.js configuration, it is possible to host a Pod UI alongside CSS . In order to do so, a new node in the dependency injection graph needs to be added to create a `DefaultUiConverter` class that shall point to the UI entry point ( usually an `index.html` file ). Currently, two recipes exist, one using Mashlib and another using Penny as a Pod UI ( those two are also available as an external app ).
 - As a **Pod-based app**. It is possible to host HTML files on a Pod and serve them with the correct content type, so they get interpreted as client-side web applications by the browser. Using Inrupt Solid client-side library, one can build a solid application and, therefore, a Pod UI. [Pod-homepage](TODO) is an example of such Pod UI.

### UI comparison

In the following, we will experiment and test different Pod UI solutions against our CERN's CSS instance. Then, we will discuss the main differences between each solution and argue which solution we choose for CERN's use.

We found following candidates:

 - oh-my-pod
 - Inrupt's PodBrowser
 - Penny
 - Pod-homepage
 <!-- - Mashlib -->

For each of the candidates, we tested:

 - CSS integration: can the UI be integrated into a CSS instance
 - Pod Browsing features: How does the UI help the user manage the content of their Pod, which includes:

   - Browse Pod's content
   - Add a document to the Pod
   - Delete a document hosted on the Pod
   - Edit a document hosted on the Pod
   - Edit `.acl`: from the UI edit `.acl` files to manage access right

 - Profile's features: How does the UI can represent the owner of the Pod, which includes:

    - Display profile: when accessing the WebID URL, the UI displays a profile page with the user's information
    - Edit profile: a particular page is available in the UI to modify the user's profile information. Of course, if the UI offers the possibility to edit pod content, it should also be able to create and edit profile documents. However, in this test, we would like to see a dedicated interface where the user should not directly modify the source turtle file.

#### testing external app


In the following, we tested the 3 UIs available as external UI: Vincent Tunru's Penny UI, Inrupt's PodBrowser and Empathy's oh-my-pod. <!-- This external UI are essentially not integratable with CSS, the None Applicable ( NA ) is given by default to all the "CSS integration" criteria. --> For the "Display profile" criteria, the None Applicable value is given by default, as this is only relevant when the UI and the Solid Server are delivered under the same URL ( which is not the case for external UI ).

##### Penny 
https://penny.vincenttunru.com/

<!-- add small description about penny -->

 - CSS integration: OK
 - Browse Pod's content: OK
 - Add a document: OK 
 - Delete a document: OK 
 - Edit a document: OK
 - Edit `.acl`: OK
 - Display profile: NA
 - Edit profile: NO

##### oh-my-pod
https://ohmypod.netlify.app/

We could not log in using our WebID hosted in CERN's CSS instance. The error "WebID is not valid" is returned by the oh-my-pod login page during the sign-in process, and an error `POST /idp/reg 400 (Bad Request)` is prompted in the console.   <!-- ( TODO might come from legacy endpoint )
( REF https://github.com/CommunitySolidServer/CommunitySolidServer/discussions/1225 ) --> 
We found out that the issue comes from the library used for the sign-in. The library uses a depreciated username/password login only supported on NSS. More recent solid servers such as CSS and ESS use the safer sign-in based on JWT web token. Therefore, the oh-my-pod sign-in procedure needs to be updated to support JWT web-token-based authentification to be compatible with CSS. 
https://github.com/solid/solid-node-client/issues/15

We decided to bypass the error by signing in with our NSS account hosted on `solidcommunity.net` to be able to test oh-my-pod features.

<!-- TODO: in case it get fixed --> 

<!-- ##### oh-my-pod ( with solidcommunity.net )
https://ohmypod.netlify.app/
 -->
  - CSS integration: NO
  - Browse Pod's content: OK
  - Add a document: Not Working ERR: 403 forbiden 
  - Delete a document: Not available 
  - Edit a document: OK
  - Edit `.acl`: NO
  - Display profile: NA
  - Edit profile: OK


##### Inrupt's PodBrowser
https://podbrowser.inrupt.com/

Similar to oh-my-pod, we could not log in from our CSS instance. Inrupt's PodBrowser is mainly developed to work with Inrupt's Enterprise Solid Server. According to Pod Browser developers, the UI  is having trouble upgrading to the latest version of the authentification library, which causes compatibility issues with CSS [@0767d78a793abcd3629c4378cc1d73f0]
Nevertheless, PodBrowser is compatible with NSS, so we tried the UI with our `solidcommunity.net` account to test its features.

  - CSS integration: NO
  - Browse Pod's content: OK
  - Add a document: OK 
  - Delete a document: OK 
  - Edit a document: OK
  - Edit `.acl`: OK
  - Display profile: NA
  - Edit profile: OK


<!-- TODO mashlib
 -->
In fine, we can see that only Penny shows compatibility with our CSS instance. However, an important note is that it will split the UI and CSS-related functionality into two URLs. For example, The registration and password reset page will live under the solid server URL, whereas all the UI functionality ( Pod browsing, profile page, contact ...) will live under the external Pod UI URL.

#### testing internal Pod UI

##### Penny 
 - CSS integration: OK
 - Browse Pod's content: OK
 - Add a document: OK 
 - Delete a document: OK 
 - Edit a document: OK
 - Edit `.acl`: OK
 - Display profile: NO
 - Edit profile: NO


Pod Browser and oh-my-pod would not work as an internal Pod UI for the reasons mentioned in the previous section. Yet, this compatibility gap might be closed in the future. For that reason, we still tried to create a recipe to see if the UI could be integrated into CSS even without working. 

For Inrupt's solution, we could not build and run the standalone client-side app. The easiest way to integrate a UI to CSS is to have the UI in the form of a standalone client-side web application; this is how the Mashlib and Penny recipes are built. Then, we can use components.js to create a `DefaultUiConverter` class that will point to our UI web application entry point. However, PodBrowser needs to be run as a server-side application [@23d676867399859f34a23f94d1c3535d]. With compents.js, it is possible to use a server-side UI application, but such a configuration needs to be built from scratch. Of course, this work would only be worth it once the authentification compatibility issue is solved. Therefore, we did not investigate this solution further.

Similarly, we could not run oh-my-pod as a standalone client-side app, but we were able to connect to an NSS account when run as a server-side app. 



<!--  We test a recipe with penny alongside CSS. This has been
  - buggy: shared route cause of bug
  - not trivial to make one as dev: ( need to understand components.js and routing )
- talk about experimenting creation of PodBrowser recipe
- what is required to create a Pod UI
 - todo link recipe
 In this solution, the Solid Server and the Pod UI live under the same URL and this might be the source of bugs, as the two apps will share the same routing paths ( LINK GITHUB BUG).
  - even if the CSS' page and the UI are under the same URL, in contrary to external UI, they won't share the same UI, effort need to be made  -->



#### Testing Pod-based UI


Finally, we tested Pod-homepage, the only available Pod-based UI. Unfortunately, Pod-homepage uses a depreciated solid authentification library that does not support JWT web-token-based sign-in. Therefore, we could not test the UI as it needs to be upgraded from solid-node-client[@b411b15da61633329598be96a150f80f]  to Inrupt's solid-client-authn-js [@4f05783bd06a7c386bff274dd467d8a1]  to be compatible with CSS.

<!--  https://gitlab.com/angelo-v/pod-homepage
https://gitlab.com/angelo-v/pod-homepage/-/issues/2
https://github.com/solid/solid-node-client/issues/15
 -->

##### Pod-homepage 

  - CSS integration: NO
  - Browse Pod's content: Partially: only shows root's files
  - Add a document: NO 
  - Delete a document: NO 
  - Edit a document: NO
  - Edit `.acl`: NO
  - Display profile: YES
  - Edit profile: NO


<!--    - pod homemade by ... not working with CSS ( only NSS ) because of authentification specification changes ( cred instead of JWT token )
 - would be easy to add a link to CSS registration page
 - every user can choose its own Pod UI
 - need to allow HTML  in Pod
   - can be a security issue if open to the world, 
     - if open to the world ( everybody can make pod -> high security risk of phishing )
    - if reserved to CERN user, depends of the trust CERN has on the user group
 - no solution exist now
 -->

### Discussion

<!-- *global status of UI, penny most suitable candidate* -->

From our tests, we can see that the majority of the UI candidates, Penny excepted, are incompatible with CSS, primarily for authentification compatibility reasons. Solid specifications are still in a magmatic state and evolving fast [@8a5ac86b61ab1b810ea5ddb7cf6b93ac]. Therefore, it is not always easy for solid applications to keep up with the specification. Unlike the legacy NSS, CSS uses stronger authentification based on web token rather than username/password<!--( TODO SolidOIDC ?? )-->. Unfortunately, most of the UIs are built and tested toward NSS. Penny seems to be the most suited UI candidate for CSS, even if it only provides Pod managing features. 

<!-- *Same URL is better* -->
Contrary to external UI, Pod-based and internal UI is reachable from the same URL as the Pod URL or the WebID. Since the user will not have to remember a second URL for the UI of their Pod, we can argue that they both offer a better user experience. For example, two URLs are presented to the user after a CSS registration, the Pod URL and the WebID. We can easily assume that one of the first actions taken by the user after the registration will be to click those URLs. Therefore, we believe that it makes more sense if those URLs dereferences to a Pod UI instead of raw data.

<!-- TODO add click images and labels -->


<!-- *Pod-based live in one folder  -> one URL* -->
Pod-based and internal UIs, even if they both live under the solid server URL, still have their differences. A Pod-based UI will be accessible from the path where it is stored on the Pod. For example, if the CSS user Alice uploads a UI on her `ui` folder, the UI will only be accessible from `http://my-css-instance.net/alice/ui/index.html`, assuming that the UI is contained in an `index.html` file. Therefore it is also directly accessible from  `http://my-css-instance.net/alice/ui/`. The UI will not be accessible from, for example, `http://my-css-instance.net/alice/otherfolder/` unless we copy the UI to this folder.

<!-- *Pod-based template solution* -->
A new Pod template can be created to avoid the fastidious task of uploading the UI to each new Pod. CSS's `TemplateResourcesGenerator` class is responsible for creating the minimum required files to include in a Pod after its creation. The default behavior includes a `profile` folder containing the `card` holding the WebID and two `.acl` files in the `root` and `profile` folder. CSS also adds an unnecessary but helpful `README` file. It is possible with components.js to rewrite this class to point to a new template that includes our Pod-based UI. Then, each newly created Pod will, by default, include the UI.

<!--TODO: add link to CERN profile viewer-->




<!-- - two UI solution made by developers
- for profile use case, same URL better
   - assume that is can be intuitive for user to find the Pod UI on the same URL as their WebID or Pod URL ( profile page on WebID URL like solidOS)
 - Pod-based solution has interesting advantages, such as allowing each user to have their own UI, but need to allow interpret which can be a security issue as explained ./2_security.dr.MD
Complicated when Pod decoupled from WebID: how  thing should be interpreted and show explained to the user? profile_viewer should show the `maker` website or not?
see ./2_UI.dr.md
 -->

### Decision 

Penny is arguably the most suited candidate for UI integration into CERN's CSS instance, even if it only offers Pod management features. The last question remains whether it should be integrated to CSS as an internal UI or an external UI. 
We choose not to integrate it as an internal UI for our CSS instance. Using a UI as an external app has the substantial inconvenience of splitting the usage of the Solid Server into two different URLs; therefore, it might not be the optimal solution in terms of User Experience. However, we thought that UIs are not yet well developed for CSS, and it would be too soon to settle with one. Therefore, it seems most valuable to leave the space empty if new UIs get developed that suit CERN's needs or the current incompatible ones get upgraded or if CERN decides to develop its own UI.

<!-- TODO REWRITE LST SENTENCE
 --><!-- TODO? talk about penny not totally working as internal app -->
<!--TODO ADD transition to profile viewer -->

\newpage

# Building a CSS instance for CERN

As we explained earlier, CSS is built with a dependency injection called components.js. It allows CSS to take a different shape regarding a chosen configuration, called recipe. This chapter is about the recipe we built for CERN's CSS instance. First, we showcase a component we built to improve the CSS registration page; then, after a few tests on CSS storage options, we describe our server configuration and DevOps pipeline. Finally, we describe the 2nd component we coded for our recipe: a Proof Of Concept profile viewer. 


<!-- # inbox
 -> issue after test:
  - ??? talk about pim storage
  - ??? shoudl be a pim storage think in turtle webid
  - ??? spec not finish on that issue, current solid app just assume Pod hosted on same url as webid, but they should respect the webid claim. Issue is that expose public Pod address
  - ??? re-read the related github issue
 -->

## Easy-token: an improved registration page component

In this chapter, we discuss the easy-token component. In Solid servers, the Identity Provider and the Pod are decoupled. Therefore, it is possible to create only a Pod in the CSS registration page; and use the WebID from an external Solid Server. Easy-token is a component we build to facilitate the registration of new users already in possession of a WebID.
<!-- TODO explain Pod with ext. webId -->

### Motivation

As we stated previously, CSS  is a recent software, and some of its parts - even if functioning - still lack some user-friendliness. One clear example has been experienced early in the thesis when testing the registration process.

Data storage and identities are decoupled in the Solid specification; hence when a user wants to create a Pod on CSS, CSS registration will offer two options:

 - create a Pod and create a new WebID as the Pod owner
 - create a Pod and set the owner to an already existing WebID

Since CERN has done previous experimental work with Solid[@indico-jan][@indico-lukas] some of CERN's users already have a WebID, mainly hosted on `https://solidcommunity.net`. Therefore, it was essential to allow those users to create an account with their existing WebID. 
<!-- TODO: check with keycloak instance: use already existing WebID or need new one?
 -->
<!--  After explaining the complexity of the default CSS registration process, we will describe the solution we design and its implementation and its tests.
 -->


<!-- {Furthermore, with the default configured CSS version, my CERN supervisor Maria Dimou was not able to create a Pod with here existing WebID}. We will, in the following, explain why this process is fastidious and how we decided to fix it {REDO too familiar}. 
 -->
For legitimate security reasons, the user wanting to create a Pod with an existing external WebID needs to prove that they are the owner of the given external WebID. Otherwise, an attacker would be able to create a Pod usurping someone else identity and un-allowing the actual owner of the WebID to create a Pod <!-- TODO verify that -->. The purpose is similar to the verification email we receive when we sign-up on a platform with our email address.

To prove that the user is the owner of the claimed external WebID, CSS asks to add a verification token to the user's WebID document. By proving that they have modification rights to the WebID document, they prove that the document belongs to them. 

When creating a Pod with an external WebID, CSS will return a `400 - BadRequestHttpError` asking the user to add a given verification token, see figure \ref{token-error} . The error message is the following:

 > Error: Verification token not found. Please add the RDF triple `<https://alice.solidcommunity.net/profile/card#me>` `<http://www.w3.org/ns/solid/terms#oidcIssuerRegistrationToken>` `"276c3e90-1af4-437d-b46f-a5240933ce99".` to the WebID document at https://alice.solidcommunity.net/profile/card to prove it belongs to you. You can remove this triple again after validation.

As we can see, the error message refers to technical terms that are probably unfamiliar to newcomers.

![The error message shown by CSS highlighted in red. CSS does not give the user further help on how to achieve that task. \label{token-error} ](./assets/token.png){width=60%}


<!-- TODO: test Maira  -->

Currently, the fastest way to add a token to a WebID document is by doing the following tasks:

   - Copy the triple with the random token given in the CSS sign-up page
   - open a new page,
   - use an external Pod browser such as Penny
   - connect to their Pod through the Pod browser
   - navigate their Pod to the WebID document, typically `/profile/card`
   - add given token verification triple
   - return to the sign-up page and finish the login

The former flow also makes strong assumptions that the user knows a Pod browser Solid app and knows how to add a triple to its WebID document
 As shown in  figure \ref{token-error}, besides being a tedious process, one needs to be well aware of concepts such as RDF tripe and Pod architecture to understand the error message, which might not be the case for users with low experience with Solid.
<!-- Therefore, such a sign-up procedure in addition to being long and complicated, would also discriminate users that do not have strong skills with Solid, in other words, most of the people we can expect to use how CERN based CSS instance. -->
 <!-- [Users from CERN were not able to set up the token themself, with reason.] -->


<!--  possible to remove the token
Beside local testing environment, it would be unsage to remove the token for the reason explained previously. Therefore, a new login interaction needed to be designed.  -->


### Design

To tackle the problem formerly defined, we designed a new login interaction. We stated the following principle to base our new user interaction:

 - the user should not leave the sign-up page during the sign-up process
 - the user should be able to sign-up without knowledge of Solid specific vocabulary, such as "RDF"
 - the token should be added "behind the scene" and the user should be able to sign-up seamlessly
 - WebID verification should not imply interactions unfamiliar to newcomers with no Solid experience.

To achieve the former goals, we made the following design proposal:

 - A button is added to the sign-up page
 - The button redirects to the user ID Provider and asks them to login
 - Once logged in, they are automatically redirected to the CSS sign-up page; even if the user has left CSS sign-up page, the automatic redirection gives a seamless experience
 - Once the user authenticated, the script has the necessary authorization to write to the user's WebID document and add the verification token
 - The script adds the verification token to the user's WebID document.

In final, the user's only interaction is to click the "Verify my WebID" button and log in to their IDP.

<!-- {The user will leave the Registration page to login to their IDP, which contradicts our principle number {TODO}. However, it happens through two redirections. The first one redirects the user to the IDP. Once the user has logged in, the second one redirects the user back to the sign-up page. Therefore, we can say that it feels like the user has not left the sign-up page and give a seamless user experience.} -->
All the rest is taken care of in the background by the script. In parallel, the user can finish with their registration process. Timing-wise, by the time the user finishes the registration process, the script should be done adding the token to the WebID document.
<!-- { TODO measure time adding token } -->

<!-- {TODO should just be a button "verify my webid"} -->

### Sequence diagram

\
![Sequence diagram of the easy-token component](./assets/et_diagram.png)
\

### Implementation

#### Description of the javascript logic


 To implement the former design, we used Inrupt's Solid client browser authentification library[@solid-auth-lib] and Solid client library[@solid-client-lib]. Both are client-side javascript libraries. The first one handles the authentification to a Solid Pod, and the second performs basic CRUD action to a Pod once authenticated with the first library. 

Our implementation consists of 3 main functions:

 1. the login function
 1. fetch token function
 1. the add_token function

###### 1. the `login` function

The login function relies mainly on the Inrupt authentication library. Once called, it will redirect the user to their IDP. Once the user has been authenticated on its IDP ( usually using an email/password credential, but other methods can be used), the IDP redirects the user back to the sign-up page, which now benefits from a token stored in the browser's local storage. The token can be used by Inrupt's client library to edit the user's WebID document with authenticated CRUD action.

###### 2. the `fetch_token` function

The fetch function's primary goal is to get the verification token.
With the current state of CSS, the only way to get the verification token is to make a failed login attempt. After verifying that all the field of the sign-up form has been duly completed,  the registration page will then check if an "oidcIssuerRegistrationToken" exist on the user WebID document. If not, and this is the case for each first sign-up attempt, CSS will return an error stipulating that a triple needs to be added to the WebID document with the token's value.
<!-- {and if CSS config is set to token verification,} -->

In other words, at the current stage of CSS, the only way to get the verification token is to fail a sign-up attempt. Therefore, two registration attempts are needed to register with an external verified WebID: a first one to get the token and a second one after the token has been added to the WebID document. 



###### 3. the `add_token` function

After successfully logging in and getting the verification token, the `add_token` function has everything it needs to add the verification token to the user's WebID document.


#### Description of the HTML user interface


In the HTML part, we used the agile software development methodology. Therefore we went through a few iterations before achieving its final form. We first delivered a minimalistic prototype and then produced short and incremental iterations. For each one, we would get face-to-face feedback from the "client" ( here, the client was represented by Maria Dimou, CERN-Solid collaboration manager at CERN ). We asked the user to test the new feature on each iteration by creating an account with an external WebID. We will describe the first and final iteration of this agile process. 

<!-- TODO: add ref agile methodologies -->
  
The first iteration consisted of two parts:
  
  1. A text input where the user can enter the host of their WebID. The default value is solidcommunity.net, as it is a popular WebID host, see figure \ref{it-1-before}.
  2. A "Verify my WebID" button: once the user clicks the button and successfully logs in to their WebID's IDP, the WebID appears above the button, see figure \ref{it-1-after}.

![ The first iteration, before clicking the verification button  \label{it-1-before} ](./assets/it1_before_verif.png){width=60%}

![ The first iteration, after clicking the verification button  \label{it-1-after} ](./assets/it1_after_verif.png){width=60%}


Testing this implementation with a CERN user has raised a few tickets:

  1.  The user clicks the "Verify my WebID" button again after the WebID appears above the button. The arrival of a new item on the page ( see figure \ref{it-1-before} ) seems to create a new call for action for the user. More than being unnecessary to click the button twice, the script requests the verification token a second time and breaks the registration process. Therefore, a fix for this issue was critical.
  1. The user clicks the wrong permission when asked for the permission scope - also marked as a critical issue.
  1. This ticket does not come from user feedback, but it seems inconvenient for users not to have their WebID hosted on solidcommunity.net to type their WebID host manually. Since this would be highly improbable for CERN users, this issue was marked with low priority. 

In the latest and current iteration, we addressed all three issues with the following patches respectively:


 1. After the successful login to the ID Provider, the button turns green, its text change to "Verified" to signify to the user that our script did add the verification token to their WebID document, see figure \ref{it2-after-verif} . The change in color and text should indicate  that there is no more call for action. Furthermore, the button also becomes unclickable to prevent the user from clicking it twice, preventing the app from malfunctioning.
<!-- TODO REWRITE -->
2. We added a picture indicating which permission to give when the IDP asks for permission scope, see figure \ref{it2-after-verif} .
 3. We change the input text for an editable dropdown: it allows to select from a list of options or enter another one in a text field to let the users choose the host of their WebID.


We still display an input text field with the value of the WebID for convenience reasons, so the user can double-check that the WebID they are submitting to the form is indeed the correct one, see figure \ref{it2-after-verif}.

![ The final iteration before clicking the verification button \label{it2_before_verif} ](./assets/it2_before_verif.png){width=60%} 

![ The final iteration after clicking the verification button \label{it2-after-verif} ](./assets/it2_after_verif.png){width=60%} 

\

<!-- ![ A convienent editable dropdown was also added \label{it2_drop_down} ](./assets/it2_drop_down.png){width=60%} 
 -->
<!-- {TODO: after success, the user has proven they own the WebID, can finish fillup the registration form, and will successfully sign up with their external WebID} -->

#### Component.js configuration

If we first build this new registration page by directly editing CSS' source code, we quickly decided to take advantage of components.js' dependency injection library and refactor it as an independent component. By doing so, anyone who wants to add our new sign-up page to their CSS instance has to change a few lines in their CSS config file instead of merging two code bases. We will explain how the component has been designed.
<!-- ( REDO) -->
<!-- TODO add illustration componetsjs vs source code -->

First, we extracted all our editing files into a new folder. This folder contains five sub-folders:

  1. `components/` containing a necessary `context.jsonld` file to make our component importable to components.js library. 
  1. `src/` where we store our javascript source code. Using Webpack, all those source files will be compiled to: 
  1. `scripts/` which includes a minimized single javascript file that we will import into our HTML page.
  1. `templates/` with the alternative registration HTML page
  1. `config/` holds the `components.js` required config files that we will import from the main CSS' config file. It essentially has two things: <!-- TODO: REWRITE -->
      1. The first creates a `StaticAssetHandler` class that points to our `scripts/` folder. It will make the script accessible through an URL and therefore importable from our HTML file.
      1. The second creates a `BasicInteractionRoute` that will point the `/idp/register/` endpoint to our sign-up HTML page in the `template/` folder.

Then we need to edit the root config file to import the two former defined files instead of the ones from the default configuration. 

<!-- # discution

To avoid this double sign-up, a solution could be to modify the CSS server side code to send the client a verification token during page load and not after a fail attempt to sign up. However, this would makes the footprint and the scope of our module more ~impactfull ~important. Thanksfully, CSS offer an API that allow to register a new user through POST request. Therefore, the first failled attempt required to get the token can be done {TODO under the hood} by our script without the user noticing it. Even if that solution can seems hacky, it has the advantage to keep the scope of the module to the client side and does not require to modify server side code. Therefore the former solution has been ~prefered.

 -->



<!-- test localhost to avoid internet conecction noise -->
<!-- TODO test at CERN -->

##  File storage

In this part, we will discuss the possible option to store data with CSS, and after a few tests, we will explain why we choose to store data as files. 

Currently, CSS allows two options for user data storage:

  - RAM-based
  - file-based

Two aspects of storage are particularly relevant for us: how do the different options affect performance, and how sensitive information, such as passwords, are stored.<!--  After studying the two options and doing performance tests, we will argue why we choose to store user data as files for CERN's recipe.  -->

 If the CSS instance's machine shuts down, all user data will be lost with RAM storage configuration. Naturally, file storage was the preferred choice as it permits saving user data in a persistent external volume that can be mounted to CSS's host machine. Other benefits, such as the use of an external persistent volume are explained in the DevOps chapter. <!-- [TODO add link to chapter] -->
<!-- TODO expend PV benefice
 -->
With file-based data storage, CSS will store authentification data as a file, but sensitive data such as passwords will be hashed with the bcrypt algorithm [@b97c9517677c192ed4cbffd3077b3215]. Bcrypt is a robust hashing algorithm derived from Bruce Schneier's Blowfish, built to resist brute-forcing and rainbow tables attacks; the two primary attacks again hashed password[@bcryptWeb] . Other files are stored unencrypted. Therefore, anyone having access to the server ( either the official sysadmin or a potential hacker ) will have clear access to file content, even if the ACL permission file restricted the access to specific authorized users. Options to encrypt all user data files have been evoked but are not yet implemented. [@588682621b423279b63e743acadfc94b]

Amazon has realized that reducing its loading page by 100ms would result in a 1% sales increase[@amazon]. This example shows how much speed performance is of paramount importance for users' engagement in web applications. Consequently, measuring any performance differences between RAM and files-based storage seems relevant. Therefore, we ran a test to compare performances between both options to verify if one of them would represent a considerable disadvantage. 

<!-- *Hypothesis*
 -->
Our first hypothesis is that RAM storage should be faster than file-based storage. <!-- TODO depend harddrive --> We would also like to measure how much each option impacts speed performance.
<!-- TODO But that depends on the material, specialy SSD HDD -->

<!-- *Method*
 -->
To test our hypothesis, we created different recipes. The first one stores user data in RAM, and a second one stores user data on the hard drive filesystem. <!-- (TODO THREE?) + add ref to the recipe--> To protect the test from internet connection fluctuations, we decided to run the test on a local machine. <!-- TODO Also CERN use shared ressources -->

To see if the size of the file would impact performance, we generate a set of text files of randomly generated characters, ranging from approximately 1 kB to 1 GB. We generate them with the following bash script:

```bash
# Example generating a ~ 1 kB files of random character
tr -dc "A-Za-z0-9\n\r" < /dev/urandom | head -c 1000 > 1K.txt
```

Then we store those files in a `data` directory. We create a new Pod on each of our recipes and upload the files folder in each. For that purpose, we used Penny for our RAM-based recipe, and we copy-pasted the `data` folder inside the Pod for the files-based recipe. <!-- THREE -->

In order to not get an authorization error when trying to reach the file from our script, we need to change the `.acl` file in the root of each Pod to permit the public ( therefore our script ) to access all Pod-contained files. We must change the Pod's root `.acl` file for that purpose. More precisely, the `public` subject needs to use the `acl:default` predicate ( which gives access to the subject to the predicate folder and subfolder ) instead of the `acl:accessTo` ( which only gives the subject access to the object file ). The object remains the same ( `<./>` ), which represents the current folder ( in our case, the root folder ). Therefore, The `public` subject should be defined like so in the Pod's root folder:

```
<#public>
    a acl:Authorization;
    acl:agentClass foaf:Agent;
    acl:default <./>;
    acl:mode acl:Read.
```

  *We changed on line 4 `acl:accessTo <./>;` to `acl:default <./>;`*

Finally, we use a python script to fetch each file for each recipe. The python script will iterate through each Pod configuration, and for each config, the script will try to download all files ranging from 1kB to 1G. To get a more robust result,  we repeat each download an undread time and take the average download time.


*Results*

![\label{dlTimePercent}](./assets/Figure2.png){width=50%}
![\label{dlTimeAverage}](./assets/Figure1.png){width=50%}

As we can see, files under 1mB have more or less the same average download speed. We believe those results are biased by the constant time taken by CSS to process the file, and at that point, the size of the file is nugatory compared to the processing time. Interestingly, we can see that RAM-based storage gives poorer results with files under 1mB; we could not find the root cause of the phenomenon. Otherwise, RAM-based storage confirmed our hypothesis and showed better performance for files above 1mB. RAM seems to be 13% faster on average than file-based storage (with a standard deviation of 2 points of percentage). The downloading speed difference does not increase or decrease as the files grow in size.

<!-- TODO redo test, get difference time
 -->

*Discussion*

For current CERN's use case, performance is not yet a priority. Therefore, using file-based storage seems more advantageous than the performance gained with RAM-based storage. Nevertheless, it is valuable to know that downloading speed can be improved at this level. In such a case,  it would be essential to consider regular backups of the memory state to avoid any data loss if the host machine shuts down.

Furthermore, even if CSS authors stated that it is developed for experimental purposes only[@cssReadme], is it important to notice that their use up to date, secure hashing algorithm for passwords, which will provide state of the art protection in case of data leak ( 2nd recommended hashing algorithm by the web security OWASP organization [@6a917e104728b1507e59a731c3bd47bb] )


<!--
  TODO test with at CERN
  TODO: From HHD we see that XXX slower than SSD, depends on harddrive
  TODO: ask Michal which infrastructure they have
  TODO performance test between file storage and RAM ( also HDD vs SDD )
  TODO test on alien
 -->



<!-- RAM more expensive + no much storage space + delete file if shutdown 
SSD persistent storage but slower
RAM: choice for small file with no loss risk
SSD: good for CERN -->

<!--
[@bcryptWeb]: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.1072.20&rep=rep1&type=pdf
[@amazon]:  https://www.researchgate.net/publication/220475549_Online_Experiments_Lessons_Learned/citation/download
 -->

## Profile viewer component

### Motivation

The previous chapter on UI comparison  <!-- TODO link
 --> shows that no compatible UI has a profile viewer feature. Previous profile viewers/editors have been built in the past, but most of them are outdated. Previous chapters also show that with the quick evolution of Solid specification, outdated applications have a low chance to be compatible with CSS. Therefore we decided to build our own profile viewer and integrate it into the CSS UI. Furthermore, if CERN decides to build its UI in the future, this app could be a starting point, as it will provide the basic building block, such as login, routing, and CRUD actions to bootstrap a UI.
 <!-- internal, pod based? -->


VCard is a particular RDF vocabulary that represents various information about an agent ( individual or organization )[@931d5b006d34326b35d9573f538a2a81]. It holds common property such as name, role, address, mail, phone number. Our profile viewer will display a few vCard attributes of an agent.


 <!--  - CERN needed UI display profile
 - no compatible UI have this feature ( as shown prev ) 
   - recipe only penny mashlib ( podbrowser but no profile )
 - existing profile viewer/editor not working depreciated
 - decided to create a pod viewer ourself
 - also pedago tools for different UI, regarding choice of CERN in future, good place to start, compare available solution
   - give basic building block for a CERN UI: CRUD action
   - internal, external, Pod Based
 -->


### Architectural Analysis and Synthesis

#### System description

 The system goal is to display vCard information from a WebID or a profile document. An *editor* mode can be activated to edit and update the vCard information on the Pod data with new values. Once the values are updated, the system returns to the *viewer* mode and displays the edited values.

#### Features

The component has the following functionalities:


 1. On a profile document URL ( `/profile/card` ) a user can see the vCard information of the corresponding profile
 1. A user can sign in with their Solid IDP
 1. If the user is logged in and has permission to edit the profile, they can edit the vCard values.
 
  - `fn`: the full name of the agent holding the WebID document
  - `organization-name`: to which organization the agent is attached to
  - `role`: what is the role of the agent in the organization
  - `notes`: arbitrary text the agent can display, usually a short description of their activity 

Finally, the UI has a primary routing feature that displays different representations depending on the URL path, see figure \ref{profileViewerRoutingFlow}.

#### Type of Users

They are two types of users: the viewer, who read the vCard information, and the owner(s) of the profile document, which has the right to edit it. By default, the profile owner has the proper permission from the WAC to edit their profile document. However, this can be abstracted to a larger group of users with the `WRITE` permission on the profile document. For example, if the profile represents an organization and not an individual, a group of users from this organization( eg. the administrator ) could have the right to edit the organization profile.

### Design


We decided to implement this component with the least fioriture possible. Therefore, we build this component without any javascript or Cascading Style Sheet framework. The profile viewer should be displayed only when the URL matches a profile document URL ( ending with `profile/card` ). Other URLs should also be handled, but they are not the central focus of this component. If the URL does not match a profile document, a minimalistic message should be displayed to guide the user toward the possible actions. The component focuses on the primary CRUD action and Solid interaction, with less noise possible. Only the core logic elements are developed, so they can be easily extended to a framework of one's choice.<!-- TODO routing -->

The UI does not have any Pod management feature and should rely on Penny ( used as an external app ) to do such tasks. 

<!-- TODO #### Context diagram -->

#### Sequence diagram
\
&nbsp;  
\
![ Sequence diagram of the profile viewer component for the viewer mode \label{profileViewerSequenceViewerMode} ](./assets/viewer_sequence_anyone.drawio.png)
\
![ Sequence diagram of the profile viewer component for the editor mode \label{profileViewerSequenceEditorMode} ](./assets/viewer_sequence_owner.drawio.png)
\

### Implementation

The component is implemented as a client-side javascript application to be integrated into CSS. It consists of one HTML, one javascript, and one Cascading Style Sheet file. 

The app starts with the routing behavior to mimic the routing feature common to javascript frameworks. Then, based on the path of the current document URL, the app will display different representations, as shown in the flow chart \ref{profileViewerRoutingFlow}:


 - On the root path, i.e., the index page of our CSS instance: we return a page that invites the user to create a new Pod, learn about solid, or read a user-manual made for CERN's user.
  
\
![Representation of the root path](./assets/viewer_root.png)
\
  
 - On a user profile document path ( `/<pod_name>/profile/card#me` ):  we return our profile viewer, which will show the vCard information of the owner of `<pod_name>`, the main focus of this component.
  
\
![Representation of the profile, viewer mode](./assets/viewer_profile_view.png){width=50%}
![Representation of the profile, editor mode \label{editMode}](./assets/viewer_profile_edit.png "test" ){width=50%}
\
  
 - Otherwise, if we are not in the root path nor the profile document path, we are in the path of a Pod. Unfortunately, our app does not have any Pod browser feature, so we invite the user to explore their Pod with Penny, used as an external app.
   
\
![Representation of other Pod path](./assets/viewer_pod.png)
\
  


VCard elements are commonly readable by the public, but authorization is usually needed to edit them. Therefore, the profile viewer has two modes: the viewer mode, which displays the vCard information, and the editor mode. Editor mode needs a login and changes all the vCard elements into input fields, allowing users to edit them. A button `Save` also appears; saving will edit the profile document with the input value and return to the viewer mode. 

![ Profile viewer routing flow \label{profileViewerRoutingFlow} ](./assets/viewer_flow.jpg){width=100% margin=auto }


We submitted feature requests to prefill the OIDC issuer from Penny URL to facilitate the transition from the UI to Penny [@1e8682c69dffede3d2481fbbfb442fde]. The feature request got accepted, and the OIDC issuer can be prefilled with CERN's CSS instance. Therefore, our link to Penny will have the following form:

```html
<a href='https://penny.vincenttunru.com/?solid_server=${basenameUrl}'>
Penny</a>
```

With `basenameUrl` being defined by:
```javascript
const basenameUrl = 'https://' + document.location.hostname
```
The prefilled OIDC issuer filed will give a more seamless experience to the user, as they will not have to enter the URL of CERN's CSS instance when landing on Penny's page.

#### Integration to CSS

 To integrate the profile viewer into the CSS configuration, we first need to remove CSS' default minimalistic UI. Starting from CSS' default configuration file, we remove the creation of the original node that initiates the class `urn:solid-server:default:DefaultUiConverter` and create a new node in the dependency injection graph:


*`config-profile-viewer.json` graph*
```javascript
  "@graph": [
    {
      "comment": "Serve custom CERN profile viewer as default UI representation",
      "@id": "urn:solid-server:default:DefaultUiConverter",
      "@type": "ConstantConverter",
      "contentType": "text/html",
      "filePath": "./profile_viewer/dist/index.html",
      "options_container": true,
      "options_document": true,
      "options_minQuality": 1
    }
... other DI graph nodes
```

CSS will now serve our UI upon `text/html` request if the route does not point to a CSS page ( such as the registration page at `/idp/register/` ) or an HTML document hosted on a Pod,  meaning that Pod-based UI are still possible. We set both `options_container` and `options_document` so the UI is returned for container URL ( ending with a slash `/` ) and non-container URL ( ending without a slash ). The `minQuality` referer to the quality rules defined by RFC 7231 [@75609f6d12f6abaca567a48148e29bc2] is a weight ranging from 0.001 to 1 ( 1 being the most preferred), defining the quality of the representation. It is an HTTP standard to discriminate representation when a resource has multiple representations. The most important one is the `filePath` property, pointing to the profile viewer static files we build, hosted in the root directory under the `profile_viewer/dist` folders.  



<!--
   - can test performance, with less noise as possible from  js or CSS framework
   - restrict to the minimum in order to be easily readable and editable
 -
 - if the webid not hosted on the pod, not display webid but link to the original webid
   - ??? only for internal and pod based??

The components is stored in the root directory of the recipe.
Design choice? -> put it in NPM module 

### Discussion
### limitation 

 - need to be compiled with webpack ( inrupt library requirement )
 - fetch vcard data from webid
 - maker of the pod and not the webid included in the pod
 - usefull in case the pod is created with an external WebID
 - display vcard info
 - edit vcard info


### test
### we used lighthoue to create test
  - explain pod vs internal
  - explain different pods a c,d
    - a: self webid + pod
    - c: cacao webid ( empty)
    - d: dimou webid ( full profile )
  - explain metrics speed, first loaded, biggest loaded
  - check browser of much time each action

### discution
 podbased vs internal no differences between too
 - podbased: does serve every URL
 -->


<!-- TODO: routing sec. issue:
 - one open VM for experimenting, connected to a PV with only test user. - one close VM for CERN users.
 - TODO : how to test recipe again solid test suite
## Infrastructure setup
*descripe the infra setup, argue for the choices, how to reproduce*
 -->



## DevOps


*Setup description*

![ DevOps architecture diagram \label{devopsDiagram} ](./assets/cern_css_devops.drawio.png)

As seen in figure \ref{devopsDiagram}, the global architecture for the DevOps consists of 3 main entities:

 - the source code, where the developer(s) can edit CERN's CSS recipe
 - the remote repository, where the source code is published, reviewed and edited by other coders
<!-- where the developper(s)  the modification get tested again the Solid Test suite ( TODO investigate) through github action. -->
<!--  -   The CERN's official documentation ( ADD REF ) recommend the use of CERN's gitlab instance to host the remote to host the remote source code repository. Since the tests suite is already setup for through github actions ( CSS main repository is hosted on github ) we decided to keep our repo on github, to benefite from the already setup automated testing. To keep into consideration CERN's recomandation, a clone of the repo is available at CERN's gitlab instance ( ADD REF ). -->
 - the server in itself, hosted inside CERN's Openshift infrastructure, is built of two virtual machines (VM):
   - The App VM: serving the CSS instance, this VM leverage Openshift CI/CD to automatically build our CSS recipe from a git repository. If the repository contains a `package.json` file, Openshift is smart enough to understand that it has to build an NPM package. Therefore, it will first try to build the package with the default command `npm build`. Once the package is built, it will try to run the package with the default command `npm run`. The former can be edited through the global variable `NPM_RUN`, which we can set when starting the VM build. In our case, we do need to modify use `NPM_RUN` to set the server correctly:

      - we set up the running port 8080 to match the Openshift configuration:
      - we set up the path where CSS should store users' data which is the path where we mount the persistent volume for user data ( see next section )
      - we set up the basename. For Cross-Origin Resource Sharing reasons and to display links with the server's full URL correctly, CSS needs to know on what is the base name of our server URL 
<!--    ( - we setup the path of the given configuration TODO: explain that can have multple config )
 TODO: remove `-c myconfig.json` from package.json and put it in the NPM script 
 -->
   - Persistent Volume ( PV ): this VM acts as a simple file system that can be mounted to other VMs; it is where our CSS recipe stores users' data. Such a VM should be built only once, as rebuilding it would erase users' data. A good improvement would be to apply backup regularly to prevent any data loss. Since the goal of this thesis is mainly experimental, it has not been judged necessary to deploy any backup process.  
<!--    REMOVE?: Since this operation should be done only once, no scripting as been ...
TODO:
 --> 

The choice of separating data and application has a few benefices. The main one is that it allows the creation and experimentation of different recipes hosted on different VM. Then, the persistent volume can be attached to a new application from the Openshift interface. It allows testing the application in the hosted environment ( instead of locally ) before publishing it to end-users. Secondly, we were not able to create a script to update a recipe within an App VM; whereas rebuilding the whole application can be done with a few lines of bash script, see the following listing<!-- TODO add ref-->. In addition, it permits rolling back to a previous build from the Openshift platform.

*Bash script to deploy a CSS recipe to openshift from a git repository*
<!-- ```{#lst:captionAttr .bash .numberLines  caption="Bash script to deploy a CSS recipe to openshift from a git repository" label="my_sec"}
 -->
```bash
# Fill the following variables

APP_NAME=""
PROJECT_NAME=""
GIT_REPO=""
# path where the PV is mounted on openshift
DATA_STORAGE_PATH=""
# required but does not need to be meaningfull
PROJECT_DESC="$PROJECT_NAME"
# default openshift URL 
BASE_NAME="https://${APP_NAME}-${PROJECT_NAME}.app.cern.ch"

echo "remember to run sshuttle and login with oc"

# comment/uncomment the desired options:
# Create an app in a new project...
oc new-project "$PROJECT_NAME" \
  --description "$PROJECT_DESC"

# ... or form an existing one
# oc project $PROJECT_NAME

oc new-app "$GIT_REPO" \
  --name "$APP_NAME"

oc create route edge \
  --service=$APP_NAME \
  --insecure-policy='Redirect' \
  --port=8080

oc annotate route $APP_NAME \
  --overwrite haproxy.router.openshift.io/ip_whitelist=''

oc start-build $APP_NAME \
  --env=NPM_RUN="start -- -p 8080 -b $BASE_NAME \
    -f $DATA_STORAGE_PATH"
```




## Terra Incognita user test
### Context

CERN holds the *Terra Incognita* meetings once a month, where CERN's IT department members share ideas and ongoing work with their peers [@4f61086d732f028b7669b161a2324c00]. We presented on the 31st of January the CSS recipe to CERN's IT team. We took this opportunity to run a simple, informal user test. After presenting Solid and CSS, we asked CERN's members to create their Pod on CERN's CSS instance and use an external Solid application.

Most attendees did not have a Pod or a WebID, but some were already in possession of a WebID from `solidcommunity.net`, due to the previous CERN-Solid master thesis made by Jan Schill [@c57a228c12f1326798165422526fd172]. For that reason, the group was well suited to test the CERN's CSS instance, as some of them would need to create a Pod and link it to an already existing WebID, which was an excellent opportunity to test the *easy-token* component developed during this thesis. 

### Method

Alongside the presentation, the crowd, through a simple user manual hosted at https://github.com/joeitu/cern-css/manual/, was invited to go through the following steps:

 1. Create a Pod on CERN's CSS instance with or without an existing WebID
 1. Inspect the content of their Pod using an external UI such as Penny
 1. Consume Media Kraken Solid App. Media Kraken [@8cffcb8e71dbcbefcc367da37ff54e9d] is a simple solid app built by Noel De Martin that lets users search movies through IMDb API and adds them to a watchlist.
 1. Go back to Penny and see the changes on the Pod

### Result

All users creating both a Pod and a WebID could follow the experiment until the end without difficulty. 
However, a user employing his already existing WebID, could not finish the procedure. On the good side, the `easy-token` component did not raise any issues and seemed to work well, probably due to all the tests already done by the agile methodology, as explained in the `easy-token` chapter<!--TODO add ref-->. The issue came when using Media Kraken Solid app.
First, the user was confused during the login to Media Kraken, if their would have to enter the `solidcommunity.net` WebID or the CERN's CSS instance URL. Entering the `solidcommunity.net` WebID would have stored their data to the `solidcommunity.net` Pod. Once entered the correct input - CERN's instance URL - the Solid app still returned an error. We were able to reproduce the error with a test account; Kraken prompted the following error:

 > Couldn't determine if document at https://testkraken.solidcommunity.net/movies/ exists, got 500 response

The error ( code 500 means internal server error ) shows that the app is trying to save the movie into the storage of the WebID ( hosted on `solidcommunity.net` ) instead of our CSS instance. The app assumes that the WebID and the Pod are in the same server, and under the same URL.

We could not find the root cause of the issue in the Media Kraken source code. However, it is not the first time we encountered an issue when signing in with an account that has a Pod and WebID hosted on different servers. For example, in the app `hello` - a simple hello world Solid app - we can see in the login logic that the app will assume that the Pod and the WebID are on the same URL [@44052886efb8ec4a8cbcf632fd8a6747].

According to CSS' developer, the usual flow when using a solid app should be: [@3e34ec31be4239e82667cdd2d8f7c87f]

   1. Client asks the user what the WebID or OIDC provider is.
   1. Client uses authn library to connect to the provider and authenticate the user WebID.
   1. Client asks the user where their want to store their data.
   1. Client uses that URL to read/write the user's data.

However, step number 3 is often omitted by the Solid app, as it will assume the storage locations should be the same as the WebID.

A solution to the issue would be to register the different storage ( Pod ) linked to the WebID directly in the WebID document. But the solution has not reached a consensus. Since the WebID is a public document, this would expose a user's different storage location and imply security and privacy issues. [@9792f2171471009f8d9829f892eb491c]

In conclusion, our CSS instance and, in particular, our `easy-token` components performed well during the user test, even if rudimentary. However, this test has shown us that if the decoupling of the identity and the storage should work in theory, it is far from being a solved issue in practice. Currently, having the WebID and the Pod under the same URL shows stronger stability. 

<!-- * Why does Solid app return errors when trying to connect with an account where the WebID and the Pod are hosted on different servers?*

After looking at Hello world source code, we can see the following snippet in the `login` function []:

```{.typescript .numberLines}
```
TODO conclude decoupled webid pod not stable
TODO add in recommendation/ccl
-->


<!--  - TODO: investigate -->
<!-- -> since bug come from upstream specification definition, decided not worth implementating a solution until the issue solved upstream -->

<!--  - Also, user tried to delete his account to recreat one without a linked WebID. We realise this was not possible to do from the user, but only from the sysadmin ( TODO add how to delete account ( LINK issue with hash )) TODO LINK issue creating "user space" in CSS.
 -->
<!-- - wasnt hable to do, but also no way to know -> confusion
 -->
## Conclusion

In the previous chapter, we investigated the existing UI and SSO integration solution and explained their limitation.

Based on those results, we built an improved CSS instance in the this chapter. As Keyclaok was not a viable authentification solution, we had to use CSS authentification, which registration's page shows substantial usability limitations. We improved the registration process by automating the laborious token verification process with a simple button click.

Regarding UI, we realize that Penny is, at the moment, the only compatible UI candidate. Penny shows great Pod management features but lacks profile base qualities. Therefore we did not choose to use Penny as an internal UI but built our own instead. We build a Proof Of Concept UI that complement Penny by providing a user profile. Our POC links to Penny as an external app for pod management tasks. Vincent Tunru, Penny's developer, help us fluidity the transition between our UI and Penny by adding a URL parameter that allows our script to prefill Penny's login form with our CSS instance URL.

 We also built a DevOps pipeline to deploy our CSS instance into CERN's infrastructure. We argue that the storage is designed to allow persistent user data and flexibility to experiment with different CSS configs. However, by writing and running performance tests, we realize that this flexibility comes with a performance cost of about 13% in download speed, for relatively large files.

All those elements should give the next developer that works on the Solid-CERN project all the tooling and building blocks to push the project forward.

<!--
viewer
 Further elements could affect the pedagogic aspect of this component, its extensibility, as well as eventual performance tests.


The profile viewer is a simple POC that show how a UI for CERN could be developped. Since Penny has already good Pod managment features, our solution try to complete Penny's feature with a profile viewer and editor.

The profile viewer is not meant to be a usable app, but to facilitate the devlopment of a potential devlopment of a UI
*Improvement*
 npm package : imported with '/.node_modules/profile_viewer/dist/index.html'
 - what to do when the WebID doesn't belong to CSS

-->


\newpage

# Phishing risk of Pod hosting HTML files

The main goal of this thesis has never been to make an exhaustive security audit of the Community Solid Server. Nevertheless, our close work on CSS mechanisms has naturally led us to investigate the security aspect of some of its interactions. In particular, we tested how CSS could be prone to phishing attacks by using a fake look-alike login and registration webpage hosted on a trustable URL.

*Context*

A CSS Pod allows users to store files, particularly HTML files. If these files are publicly available through the ACL, CSS will serve them with the appropriate `content-type` header, making the browser interpret them not as text files but as client-side web applications, see figure \ref{PodWebAppExample}. Unfortunately, if this feature allows users to host their website on their Pod, it can also have a negative counterpart if used with evil intention.

<!-- TODO: add url to webpage is Podurl+pathtofile-->

![An example of a user webpage hosted in a Pod on a local CSS instance  \label{PodWebAppExample} ](./assets/illu_sec.png)


*Method*


As with any classic phishing attack, the following scenario does not require any advanced technical skills, apart from being able to clone a webpage. In the following scenario, Eve will try to steal  Alice's credentials. First, Eve will clone our CSS instance's original and legitimate login or registration web page. Then, edit its source code to change the behavior of the form: instead of submitting the form's data to CSS's API endpoint, the form will send them to a malicious server that will log and steal the credentials. Optionally, the phishing page can redirect the user to the original web page after submitting the form to make the attack more credible.

In a second time, Eve will create a new account and carefully choose the Pod name of that new account, as it will appear in the URL of the hosted webpage. In our case, we choose to call the Pod `password`. Then, Eve will host the fake registration page on the root of here Pod and change the ACL to make the page accessible to the public. Now, Eve should have hosted a login form at: `https://my-css-instance.net/password`

Finally, assuming that Eve has access to a chat or users' email addresses, it would be possible to send a highly credible phishing message that brings users to the un-legitimate page. 

<!-- see figure \label{LabelName}
 -->

*Tests*

 Testing this attack with CSS gives us good results. CSS does not have a banlist for username. Therefore,  we could create accounts with any arbitrary string such as `password`, `account` and others.

 Moreover, we were able to create accounts close to the `idp` keyword. `idp` is in front of the URL path of the login and the registration page ( `/idp/registration/` and `/idp/login/` ). We used different variation techniques such as homoglyph ( replacing a letter with a similar one: `idp` to `ldp` ) and transposition ( swaps two letters: `idp` to `ipd` ). By creating a `register` and `login` folder in the Pod named `ipd`; and then hosting an evil registration page on an `index.html` file, we were able to host a webpage under the URL `http://my-css-instance.net/ipd/register/` instead of the official `http://my-css-instance.net/idp/register/` ( the only difference is the permutation of the `p` and `d` in the `idp` part of the URL ).

<!--  Still possible with subfolder name -->

![ One the right side the original registration page. On the left, an evil registration page in a `index.html` file, contained in the `register` folder of a Pod named `ipd` \label{idp_ipd} ](./assets/idp_ipd.png )

For comparison purposes, we tried the same attack on the `solidcommunity.net` NSS server. We realized the NSS is using a banlist, and we could not create a Pod named `password`. However, due to the open-source nature of `solidcommunity.net`, we could find the original banlist [@banlistNss]. Therefore it was easier for us to find a Pod name that would pass the banlist verification, and we ended up creating a Pod named `password-recovery.`

We also confronted CSS to homograph attack - a kind of homoglyph attack known as Visual Spoofing Attack. Homographs appeared after switching from ASCII to the utf-8 character set. The goal is to replace a string of Latin characters by using a similar letter from a non-Latin alphabet. For example, the Cyrillic letter `e` looks identical to the Latin letter `e`[@homographAttack]. However, CSS replaces non-Latin characters with a minus character ( `-` ). Consequently, CSS is not prone to visual spoofing attacks. 

*Discution*

The consequent security impact is highly relative to whom the app is exposed. If the CERN's CSS instance is only available inside CERN's network and accessible to users who have VPN access to the network, it will not be as high as if the application is exposed to the whole world. When deploying an application to CERN's openshift platform, it will - by default - restrict its access to CERN's network. Assuming that all CERN's users can be considered trusted used, deploying a CSS instance on CERN's openshift platform should not compromise CERN's security. <!-- [TODO add ref already allowed to created website] -->

However, CERN's openshift platform allows exposing the instance publicly. It can be done by replacing the application router's `ip_whitelist` with an empty string. An easy way of doing so is by adding the following line in our script in the DevOps chapter <!-- [TODO add ref] -->, before the `oc start-build` command.

<!-- [@lst:my_sec] -->
<!-- ~~~{#lst:captionAttr .bash  caption="Removing CERN's IP whitelist restriction" label="my_sec"}

*Removing CERN's IP whitelist restriction*

~~~bash
--> oc annotate route $APP_NAME \
  --overwrite haproxy.router.openshift.io/ip_whitelist=''
~~~


 Then, we allow anyone to host a web page, therefore spoofing the CSS web page and any of CERN's registration/login pages under the `cern.ch` domain name and TLS certificate. In that case, the security risk should be taken seriously. In the following, we will discuss three potential solutions. From the most secure solution to the less secure:

  1. Do not allow CSS to serve webpage.

The most radical solution is to disable the rendering of web pages from CSS. Is it possible with components.js to create a `ContentTypeReplacer` class that replaces all response with the `text/html` content-type to `text/plain`. However, this would break the rendering of potential internal UIs and Pod-based UI, as they would be returned as plain text. According to CSS developers, making the content-type converter work alongside an internal UI is possible, but it would require advanced configuration ( by creating a `WaterfallHandler` class that can contain the original UI converter and the content type replacer ). [@contentTypeIssue]

  2. Do not allow users to choose their Pod name

A less restrictive solution would be to create all users with defined username, Pod name and a temporary password. It can be automated using CSS API with the following request. 

<!-- ```{#lst:captionAttr .bash caption="Create a new user from CSS' API" label="my_sec"}
 -->

*Create a new user from CSS' API* 

```bash
 curl -i  -H "Accept: application/json"
          -H "Content-Type: application/json"
          -X POST
          -d `{"email": "johndoe@mail.net",
               "password": "s3cr3t",
               "confirmPassword": "s3cr3t",
               "podName": "johndoe",
               "register": "on",
               "createWebId": "on",
               "createPod": "on"}`
          http://my-css-instance.net/idp/register/

```

   This solution still allows users to host their webpage but it allows the sysadmin to control the creation of new accounts. Plus, it will not allow them to create misleading URLs.

  3. Create a banlist for Pod names

   A strong banlist can prevent - but not avoid - creating a misleading Pod name. Nonetheless, as we have seen with the `solidcommunity.net` example, banlists have their limit. As mentioned above, users will still be able to host their webpage.

<!--    Black list proposal, just put link or  --> 

<!--  4. Use another URL base
 A solution that can only be implemented upstream, but the use of a second URL base from interpreted Pod content ( such as Github and github.io ) -->


<!-- DOS  register page -->
<!-- No security audits yet -->

*Conclusion*

 This section confirms the intention of CSS authors[@cssReadme]: CSS is built in priority for experimental purposes and does not come with highly secure default configurations. However, this investigation shows that thanks to components.js and CSS' high modular capability, a solution can be easily implemented to tackle security issues. Finding one security issue in CSS default configuration does not imply that CSS is insecure by essence but only by its default configuration. Work still needs to be done to build a hardened-secure configuration<!-- [ TODO REWRITE] -->. It does not seem unlikely that a secure-hardened CSS recipe will appear in the future. Until then, it is recommended for CERN to use CSS for its current purpose: experimentation; and the future Solid developer at CERN should consider particular attention to whom the application is exposed to and what data is hosted on the Pods.

<!--  TODO: OK for CERN profile
 -->


\newpage

# CSS quality review

With the understanding gained from the former investigation, we will review CSS software quality to the extent of our knowledge and experimentations. First, we will review the software, with criteria taken from the ISO25010 software quality standards. Then, we will analyze and study its open source community dynamics. 

<!--
 - TODO ADD Illustration ( see assests in report folder )
 - TODO: add two components not tested
 - TODO:
   - by any means able to do after 5month in a position to do  full exhaustive ISO25010 of CSS. But we can show what in our experience has been in favor of disfor of each of the given criteria.
 -  - review different models of soft quality review
 - a few critera from iso25010 taken
 - added community critera since open source project
 3 level of complexity :
  - standalone CSS
  - CSS ecosystem
  - CERN's recipe
-->


## CSS software quality review

Based on our experience in creating a CSS instance into CERN's infrastructure, we will go to a review of the software quality of CSS. We base our review on the ISO25010.

The ISO25000s are a series of software and data quality standards defined by the International Organization for Standardization, developing and publishing worldwide technical standards. In particular, the ISO25010 defines a framework to measure software quality. All ISO25010 criteria might not be relevant depending on the reviewed software. Also, in our case, criteria might apply CSS as standalone software or at our particular CERN's CSS recipe implementation.

The review is limited by the understanding and technical knowledge acquired in the process of this thesis. Therefore, it is by any means a complete and exhaustive ISO25010 review. We will, for each criterion, advance factual positive or negative arguments in favor or disfavor based on our experience. 

Each criterion will be stylized in *italic* and refer to the official ISO25010 definition. Therefore, we recommend the user either read the definition before or alongside the following section.

### Functional Suitability


The *functional completeness* and *functional correctness* are clearly defined by the Solid specification and the Solid test suit, respectively. The Solid test suit provides an independent test suite to confront software to the Solid specification. Currently, CSS passes all tests of Solid 0.9 specification[@d16fc2b67c9fb7b92525bb44110eae08]. Therefore we can say that CSS has strong  *functional completeness and correctness*. 

<!-- Only concern CSS as a standalone server, need redo test for specific implementation of CERN  -->

In practice, we have during the *Terra Incogigna* user test, experienced a user not being able to delete his account, and the intervention of the sys-admin was required to perform this action[@3637df5b30972795dc96baae7b8d2bba]. The former shows that CSS v2 lacks at least this point of *functional appropriateness*. We precise v2, because the issue has been reported and should be fixed in a later CSS iteration[@283840d93fea6619ced43de67b92edb9].

<!-- TODO NEED to split we instance and CSS standalone -->

<!-- Conserning CSS3 see https://github.com/CommunitySolidServer/CommunitySolidServer/discussions/1234 -->

<!-- https://github.com/solid/test-suite
->
<!-- TODO: Even if CSS has a very minimaliste UI, has it encosandboxed rage the decoupling of the UI, we would expect account deletion form this minimal UI.

As a final word, CSS addresses well the *functional suitability* for developers' needs. However, some tasks could be facilitated for the end-user in practice.

build: link github issue
CSS time behaviour show decent result as shown in section TODO ram_vs_disc.:

compared to solidcommunity.net
compared to raw express
 - memory
 - storage
run:
 - memory storage

    -> TODO run stress test, response time, ressource utilisation
    -> try to make it crash
    -> no benchmark available TODO: REF RUBENS
 -->

Did not run performance efficiency on CSS, as we didn't judge it of critical importance for CERN CSS needs. <!-- TODO REWRITE -->

However, regarding *capacity*, which only applies to our CERN's recipe, capacity can be effortlessly extended on the persistent volume with openshift infrastructure. Moreover, the DevOps setup splits the application and the storage; hence, the persistent volume can be switched to another hard drive with low maintenance. To achieve the former, one would need to copy an existing file to the other hard drive and mount the new hard drive to the application machine, for example, to switch from an SSH  to an HHD storage.

<!-- TODO: install test Performance -->

### Compatibility

Highly relying on linked data and W3C standard CSS show robust *interoperability* features.
<!-- TODO also API -->
A confirmation of this *interoperability* is its decoupling of the UI. Surely, we have experienced issues with some UI build for NSS, but these issues come from differences in authentification implementation between the two servers, and the authentification specification of Solid is still evolving<!--. Solid is still in an experimental phase and not widely used for production, therefore backward compatibility might not be importante.  [ TODO REF RUBEN ] -->. Another example of good *interoperability* is that we could create pods with external WebIDs hosted on an NSS server. <!-- [ TODO easytoken] -->

*Co-existent* is not relevant to us, as CSS runs in its sandboxed environment without other software.

<!-- 
### Usability TODO

TODO

#### for users: would require advance UI tests
Terra Incogigna

 - Appropriateness recognizability
   -> user test: can I delete file from penny?
 - Learnability
   -> user test: user able to performe task without help?
 - Operability
   -> Depends on the UI,to hard to mesur
 - User error protection. Degree to which a system protects users against making errors.
   -> allow user to do everything with their data: can be dangerous
   -> no mechanisme to prevent user from deleting sensitive data, except "typing the name of the file"
   -> no protection against wrong authorisation
 
 - User interface aesthetics
   - need user test
 - Accessibility
   - find w3c accessibility test?

#### for developsers

 - Learnability
   - poor doc for CSS
   - doc WIP for components.js
   - components.js important part of learning
   - good doc on linked data, jsonld and other requirement
    user test: user able to performe task without help?
-->


### Reliability

Concerning CSS *maturity*, even if CSS does most of the essential functions of a Solid Server, it would be hard to say that CSS is a mature software when we confront it in real-life practice. An example can be taken from our user test where a user could not delete their accounts. CSS comes by default with a minimum set of components<!-- at the total opposite of SolidOs ( that powers `solidcommunity.net` ), which contains a full set of built-in features TODO: solidos not a server -->. Therefore, from an end-user perspective, CSS relies strongly on its ecosystem. As we could witness from the limited amount of available UI, the ecosystem is still a work in progress and lacks maturity, affecting CSS end-experience and maturity. <!--On the bright side, with the growing enthusiasm  [TODO REF MAria slide] around Solid, time seems to be the only factor ... solving previouslly stated issue. TODO REWRITE . Can blame CSS youth for that, should be -->

<!-- - Availability
    - TODO test availabilty on CERN's CSS ( bot )
    - TODO add screenshots
 -->
Regarding *fault tolerance*, standalone CSS shows good features. Explicit errors are shown on its HTML form if fields are not fulfilled correctly. The same goes for the API, which shows clear error messages in case of a faulty request. We did not experience the server crashing, even under the stress of the speed test experiment. <!-- TODO should be further stress test , might be done by Solid lab ( add ref ) --> The registration form was also handling correctly non-Latin character set, as shown in the security chapter<!-- [TODO security chapter] -->.

The setup described in the DevOps <!-- [TODO devops] --> section should show good *recoverability* capacity. Indeed, decoupling the application and user data in a persistent volume should allow plugging another recipe ( for example, a previous version in case of a rollback ) while keeping the same routing and user data. 

CSS shows overall good *reliability* features to a certain extent. Undoubtedly, CSS is a young software that relies on third-party components and the fact that the ecosystem is not entirely mature yet affects CSS maturity.


### Security

CSS *authenticity* relies on Solid-OIDC, a more secure flavor of the standard and widely used Open ID Connect protocol.
<!--  TODO CSS benefice from OIDC experience and popularity [@1c83002daea661d3f6a394778aa471d9][@1943e678490cffbfc82c8dc4a0436084] -->
In that matter, CSS uses state-of-the-art authentication protocols.
<!-- TODO compare to NSS -->

Regarding *integrity* and *confidentiality*, CSS uses the Web of Access Control, defined by the Solid specification and common to all Solid servers. <!-- TODO Therefore cannot demarquer from other apps
 --> No resource has been found to measure the security implication of the Web Access Control mechanism.
 
<!-- Accountability minmal Logs are kept by CSS 
 -->

On a general note, it is essential to know that no security audit has been done on CSS yet. In our experience, we show that passwords were hashed using the OWASP recommended bcrypt algorithm. We also show in the security chapter<!-- [TODO security chapter] --> that CSS could be an opportunity for phishing attacks under default configuration. 

<!-- bcrypt password -->

<!-- 
TODO brute force registration, login 
 -->
 To conclude, we believe the security of CSS is uncertain. Unfortunately, not enough resources are available to give an enlighted judgment on that matter. <!-- TODO however should be safe if deployed to trusted crowded of users -->

### Maintainability

Maintainability plays a vital role in software quality because bad maintainability forces radical decisions, such as switching to another software solution.

Divided into small independent components with componentsjs and build with a client-server API design, CSS shows great *modularity* and *modifiability* features. 
In this thesis, we show of few examples of this modularity. We have been able to create our custom-made registration page with the easy-token implementation and integrate it into CSS without modifying the source code. We have been able to build our UI or plug existing UI into CSS. Developers can easily replace most CSS building blocks with other ones through its dependency injection.


Componentsjs also provide great *reusability* characteristics, as components can be imported and exported from one recipe to another. Moreover, general-purpose components can be exported from one software ( even non-CSS software ) to another as long as they are built with componentsjs.


<!-- *Testability* hard to test compatibility with other component ( UI for eg. ) highly configurable software => one test would require to be test on every configuration combination.
 -->
<!-- TODO testability and Analysability
 -->

 Globally, we can say that CSS shows excellent *maintainability* attributes that will allow it to evolve in time. Therefore, CSS can be considered a good long-term bet.


### Portability

As for *portability*, CSS has good *installability* and *adaptability* characteristics, as it can be deployed as an NPM package or through a Docker image. Therefore it is installable on any machine that can run the required NPM or Docker version. NPM and Docker are popular enough to be robust in the long-term evolution of infrastructure environment. In terms of *replaceability*, our recipe should be seamlessly replaced with another CSS recipe, thanks to the user storage and application decoupling. However, replacing it with another Solid Server would be more complicated. Even if the file-based storage should ease the switch to another software, user credentials might be complicated to transfer, depending on the implementation of the other Solid server.
<!--  -> Replaceability:
   -> user: with IDP POd based on standard, easy to switch to another Solid server.
   ->
 -->

CSS shows substantial *portability* characteristics, as it can be easily installed and transferred to various environments.






## Open-source community dynamics review

<!-- move licensing to CSS description -->

CSS is a free and open-source software under an MIT license, which means anyone with the necessary skills can contribute to the original project source code. Therefore, the community dynamics around the software greatly influence the software itself and the experience of developers working with it. This chapter will review the open-source quality of this software and, in particular, its community dynamics. After quickly talking about its licensing, we will analyze its community dynamics.
<!-- REVIEW IF STILL CORRECT -->

### MIT licensing

 The MIT license is one of the most popular permissive licenses<!-- [1] -->. A permissive licensing means few restrictions on how the software can be used, modified, and redistributed. In addition, it allows the software to have high license compatibility, meaning that it can easily be distributed with software under other licensing, including proprietary licenses.

### CSS open source community

During the experience of this thesis, we had to interact daily with CSS community. Those would include submitting issues and starting discussions on CSS' source code repository, chatting with the community on the Gitter channel, or Zoom meetings. Through personal experience interacting with CSS community, we had good support from the community, but mainly from the core developers. Ergo, we will make the following hypothesis and try to gather metrics to validate them.

   - For the moment, CSS is built mainly by core developers, and there is not so much contribution from the community
   - Most of the tickets answers come from core developers
   - Activity from the community is relatively small

<!--    - The core developers are dynamically working on the repo
   - The developers are quickly answering Pull Requests ( PR ) and tickets -->
 <!-- (REWRITE THE ABOVE) -->

 To verify the former hypothesis, we build a series of scripts specially crafted for this chapter <!-- ( ADD REF ) -->. Those scripts take advantage of `mergestat`, an open-source tool to make SQL queries to a git repository that we mainly used to get data from CSS' Github repository in a JSON format. We also query Github API directly when needed. 

<!-- ( we also compared how result with caludron )
(   - the used script can be seen  {here} and the cauldron rpor tis in the anexe {XXX})
TODO: sharing scripts to make the experience "reproductible" -->

*Results*

<!-- NB: Data has been gathered in December 2021
 add date or redo data-->

To interpret the gathered data correctly, we first need to define a few groups of Github users:

 - **bots**: Github's bot such as renovate, dependabot and gitter-badger are always removed from the gathered data, as we are only interested in human community dynamics.
 - **core-developers**: which consists of the following users: joachimvh, RubenVerborgh rubenswork and matthieubosquet[@coreDevs]. 

 Since Digita ( a European based company promoting Solid and working with CSS ) were highly influencing the results, we decided to create the two following groups:

 - **non-core developers**: are defined by all Github users that do not belong to the core developers, including Digita's team.
 - **newcomers**: are a subset of the non-core groups, excluding Digita's team.

<!-- TODO: make Ven diagram of the group -->

From the data gathered, we extracted the following information:

<!-- *dec 21 result* -->
 - 74% of the Pull Requests ( PR ) are made by the core-developers
 - 27 PR made by different non-core developers, totaling 128 new PR ( 1/5 of total PRs)
 - 25% of the issues are left unanswered and in particular:
   - 10% of non-core developers left unanswered
   - 2%  of newcomers left unanswered
 - non-core developers raise 40% of issues
<!-- *17 jan 22 data* -->
 - 73% of the raised issue get a first attention ( a first attention is the first answer in an issue threat )
 - core developers wrote 90% of the first attention

<!--  - TODO time to answer
 - TODO: number of activity by day by core ( show actively developped )
 - TODO: check draft not matching numbers
 -->

*Discussion*

With the former information, we can validate our hypothesis related to the involvement of the core developers in the community: they answer to most of the issues of newcomers <!-- (and answer fastTODO need data) -->. However, surprisingly, we can see that 20% of the PR comes from non-core developers, which shows a genuine enthusiasm for the software from the community. In conclusion, we can say that the core developers are strongly involved in the community, as they consistently answer issues and questions raised by newcomers. Of course, a community around the software is far from non-existent, but it seems that they are more active in creating issues and submitting PRs rather than solving issues raised by others. It might be because the community lacks expertise since CSS is still a young software.




\pagebreak

<!--  - CSS should be only available to CERN users, otherwise should be taken security consideration
 - SSO integration possible, need more work,
 - OKD4 and CSS show great DevOps characterics, easy to setup and experiment.
 -->

Conclustion {-}
============

  By creating a CSS recipe and, in particular, the development of two components, we have demonstrated the excellent modularity and extensibility features of CSS and how developers can adapt it to one's particular need. The former is the result of two factors: excellent code quality and modularity with dependency injection and API design, plus strong support from the core developers, as we showed in the previous chapter<!-- TODO add ref-->.
  Contrary to SolidOs - the UI used on `solidcommunity.net`, which comes with a wide range of built-in features, CSS comes with a bare minimum to run a solid server and a very minimalistic UI. However, it provides the building block to create one's own tailor-made Solid server solution. For that reason, CSS depends strongly on the community and the surrounding ecosystem.
<!-- TODO SolidOS molitique bloc,easier to make app work together, more friction and compatibility issues with CSS that is more decoupled-->

We have shown that this ecosystem lacks maturity. Nevertheless, as community and enthusiasm grow around Solid and its community server, more components and UIs should be available for CSS, from which CERN could benefice. 
CSS is still a young software made for experimental purposes, but it has all the potential to mature from experimental software to a production-ready solution.

We built a solid basis for the following work on the CERN-Solid by giving the necessary review, tools, and improvements to push to project forward. Currently, a UI still needs to be found for CERN's CSS instance. Two options are presented to the CERN, either use already existing UI, even if it needs some work to fix compatibility issues. For each UIs, we found the root cause of the issue in the UI chapter<!-- [TODO UI chapter] --> ). The option to build its own UI is also available, and we have built a simple UI to ease the bootstrapping of such an initiative. 

As the most prominent international scientific organization and the birthplace of the Web, CERN's notoriety in new technologies is not to be proven. By adopting qualitative software such as CSS as a Solid server, CERN will hold to its reputation.

<!-- help promoting good web -->

Even if one can argue that the web is facing a crisis on data and user privacy, it is good knowing that robust solutions are developed to build a more prolific and ethical World Wide Web.

\pagebreak

# Code repositories{-}

\

All the code made for this thesis can be found at:

[https://github.com/joeitu/thesis-code](https://github.com/joeitu/thesis-code)

\

The report source code can be found at:

[https://github.com/joeitu/thesis-report](https://github.com/joeitu/thesis-report)

\pagebreak

# Bibliography {-}
