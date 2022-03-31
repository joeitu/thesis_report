# Building a CSS instance for CERN

As we explained earlier, CSS is built with a dependency injection called components.js. It allows CSS to take a different shape regarding a chosen configuration. We will call *recipe* a particular components.js configuration. This chapter is about the recipe we built for CERN's CSS instance. First, we will showcase a component we built to improve the CSS registration page; then, after a few tests on CSS storage options, we will showcase our server configuration and DevOps pipeline. Finally, we will describe the 2nd component we coded for our recipe: a Proof Of Concept profile viewer. 

