## Profile viewer component TODO

### motivation:
<!--  - CERN needed UI display profile
 - no compatible UI have this feature ( as shown prev ) 
   - recipe only penny mashlib ( podbrowser but no profile )
 - existing profile viewer/editor not working depreciated
 - decided to create a pod viewer ourself
 - also pedago tools for different UI, regarding choice of CERN in future, good place to start, compare available solution
   - give basic building block for a CERN UI: CRUD action
   - internal, external, Pod Based
 -->
### design:

<!--  - show vcard info
 - simplest UI and code
   - pure js, no framework, base mimum
   - can test performance, with less noise as possible from  js or css framework
   - based with essential CRUD function
   - restrict to the minimum in order to be easily readble and editable
 - possible to edit a few vcard info: full name, organizaation and role
 - if the webid not hosted on the pod, not display webid but link to the orginal webid
   - ??? only for internal and pod based??
 -->

### implementation

<!--   - need to be compiled with webpack ( inrupt librairy requirement )
 - fetch vcard data from webid
   - maker of the pod and not the webid inclued in the pod
     - usefull in case the pod is created with an exeternal WebID
 - display vcard info
 - edit vcard info
 -->

<!--
### test
### we used lighthoue to create test
  - explain pod vs internal
  - explain different pods a c,d
    - a: self webid + pod
    - c: cacao webid ( empty)
    - d: dimou webid ( full profile )
  - explain metrics speed, first loaded, biggest loaded
  - check browser of much time each action
-->

### discution
<!--  - podbased vs internal no differences between too
 - podbased: does serve every URL
 -->

