
\pagebreak

Abstract {-}
========

<!-- background -->
Solid, for **So**cial **Li**nked **D**ata, is a new web standard that gives users control over their online data. Developed by the inventor of the World Wide Web, Sir Tim Berners-Lee, it aims to decouple web applications from data. In a Solid environment, users own a Personal Online Datastore (Pod) and consume solid apps. A solid app is a zero-data web application connected to the user's Pod that reads or writes data on the user's Pod instead of its database.

<!-- Problem/Gap -->
CERN, the birthplace of the Web, is interested in Solid and has defined a project to investigate how Solid could be used inside CERN's infrastructure. Previously CERN has been using a third-party Solid server provider ( `solidcommunity.net` ) but is now interested in deploying its own server. A Solid server's goal is mainly to serve Pods and handle authentification through an Identity Provider ( IDP ). Community Solid Server ( CSS ), released in August 2021, is one of the first open-source Solid servers that implement the Solid specification [css readme]. However, by focusing on the server part, CSS is hardly usable on its own. In particular, it provides almost no user interface.

<!-- Contribution -->
The main contribution of this thesis has been the deployment of a CSS instance into the CERN infrastructure. CSS is built primarily for researchers, developers that want to experiment with Solid servers. Therefore, it comes with minimalistic UI and a default configuration that is not designed in priority for end-users. However, it is highly configurable and extendable. 

Therefore, we build a custom CSS instance suited for CERN's needs, we investigate at the different options, particularly in terms of storage, security, and integration with CERN's Single Sign-On. Furthermore, we extended CSS by building two components: a more user-friendly alternative registration page and a user profile viewer Proof of Concept. Also, we build a DevOps pipeline to deploy CSS instances to CERN infrastructure quickly. Finally, we will evaluate our CSS instance through a review of CSS software quality followed by a review of CSS' open source community dynamics. 

We wrote the thesis with the mindset that further work will be done on Solid-CERN project, and that the CSS instance will be furthermore developed. Thus, we cover a wide variety of subjects and argue as much as possible on the given choices,  with the intention to give a solid basis and as much freedom as possible for the following work.


<!--
The central goal of this thesis is to investigate CSS as a solution for CERN's Solid server needs by deploying a CSS instance inside CERN's infrastructure. We created our own CSS instance, with improvment on the registration page and designed a component to view user profile. 


The investigation concludes that even if CSS, and mostly its ecosystem, lack maturity, CSS is a software of high quality, with remarkable plasticity and a viable long-term solution for CERN to a certain discussed extent. 

Design and Implementation
Evaluation
Conclusion

*background*
*Problem/Gap:*
Cern currently doesn't have its own solid server, relying on solidcommunity.net for solid related activity 
*Contribution:*
We deployed a CSS instance into CERN. CSS minimalistic, so improved to fit CERN's need. 
*Design and Implementation:*
Build our own CSS instance with improvment on registration page and a simple profile viewer. Also a Devops pipeline.
*Evaluation:*
???

Conclusion: 
-->


\pagebreak







