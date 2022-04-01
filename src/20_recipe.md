# Building a CSS instance for CERN

As we explained earlier, CSS is built with a dependency injection called components.js. It allows CSS to take a different shape regarding a chosen configuration, called recipe. This chapter is about the recipe we built for CERN's CSS instance. First, we showcase a component we built to improve the CSS registration page; then, after a few tests on CSS storage options, we describe our server configuration and DevOps pipeline. Finally, we describe the 2nd component we coded for our recipe: a Proof Of Concept profile viewer. 

