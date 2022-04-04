
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
 - **core-developers**: which consists of the following users: joachimvh, RubenVerborgh rubenswork and matthieubosquet[^coreDevs]. 

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


[^coreDevs]: https://github.com/solid/community-server#-license

