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



