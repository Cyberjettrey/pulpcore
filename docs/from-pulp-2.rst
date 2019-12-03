Changes From Pulp 2
===================

Renamed Concepts
----------------

Importers -> Remotes
********************

CLI users may not have been aware of Importer objects because they were embedded into CLI commands
with repositories. In Pulp 3, this object is now called a :term:`remote`. The scope of this object
has been reduced to interactions with a single external source. They are no longer associated with a
repository.

Distributors -> Publication/Exporters
*************************************

CLI users may not have been aware of Distributor objects because they were also embedded into CLI
commands with repositories. In some cases these distributors created metadata along with the
published content, e.g. ``YumDistributor``. In other cases, Distributor objects pushed content to
remote services, such as the ``RsyncDistributor``.

For Pulp 2 Distributors that produce metadata, e.g. ``YumDistributor``, Pulp 3 introduces a
:term:`publication` that stores content and metadata created describing that content. The
responsibilities of serving a :term:`publication` are moved to a new object, the
:term:`distribution`. Only plugins that need metadata produced at publish time will have use
:term:`publications<publication>`.

For Pulp 2 Distributors that push content to remote systems, e.g. ``RsyncDistributor``, Pulp 3
introduces an :term:`exporter` that is used to push an existing :term:`publication` to a remote
location. For content types that don't use :term:`publications<publication>`, exporters can export
:term:`repository version<repositoryversion>` content directly.

New Concepts
------------

Repository Version
******************

A new feature of Pulp 3 is that the content set of a repository is versioned. Each time the content
set of a repository is changed, a new immutable :term:`repository version<repositoryversion>` is
created. An empty :term:`repository version<repositoryversion>` is created upon creation of a
repository.

Rollback
********

The combination of publications and distributions allows users to promote and rollback instantly.
With one call, the user can update a distribution (eg. "Production") to host any pre-created
publication.

Going Live is Atomic
********************

Content is served by a :term:`distribution` and goes live from Pulp's :term:`content app` as soon as
the database is configured to serve it. This guarantees a users view of a repository is consistent
and as the entire repository is made available atomically.
