
Abstract
========

Solid, for **So**cial **Li**nked **D**ata, is a new web standard that gives users control over their online data. Developed by the inventor of the World Wide Web, Sir Tim Berners-Lee, it aims to decouple web applications from data. In a Solid environment, users own a Personal Online Datastore (Pod) and consume zero data applications. The zero data application is connected to the user's Pod and reads and writes data on the user Pod instead of its database.

CERN, the birthplace of the Web, is interested in Solid and has defined a project to investigate how Solid could be used inside CERN's infrastructure. In particular, CERN shows interest in deploying its Solid server. A Solid server's goal is mainly to server Pods and authentification through an Identity Provider ( IDP ). Community Solid Server, released in August 2021, is one of the first open-source Solid servers that implement the Solid specification [css readme]. 

The central goal of this thesis is to investigate CSS as a solution for CERN's Solid server needs. CSS being a highly modular software, we created a custom configuration for CERN and argued upon the choices taken. In particular, we crafted two new components: an alternative, more user-friendly registration page, and a user profile viewer and manager. Finally, we deployed the result to CERN's infrastructure. As part of the investigation, we also tested if we could integrate CSS with CERN's Single Sign-On. Furthermore, as CSS comes with a minimalistic UI, we also tested to integrate different UI. Based on these experiences, we finally reviewed the software based on the ISO25010 quality software standard. 

The investigation concludes that even if CSS, and mostly its ecosystem, lack maturity, CSS is a software of high quality, with remarkable plasticity and a viable long-term solution for CERN to a certain discussed extent. 





