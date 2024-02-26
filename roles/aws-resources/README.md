Overview
========
=> Role has tasks that build resources on AWS.

Design
======
=> I would have loved to split all the resource builds into different roles, but again I will have to deal with
- Bloated code..I.e too many roles.
- Each aws stack build has certain outputs which are variables feeding into the next stack..I will have to deal with crossing variables between roles