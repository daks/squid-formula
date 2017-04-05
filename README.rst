squid
=====

squid
-----

Install and run the squid daemon


squid.includes
--------------

This state can be used to create configuration using Saltstack mine.
Each host will have its own separate file, included in global configuration.

As template used for per-host config must be provided and can be custom, you
only need a mine function which returns a dict host -> data, both are available
in the template.

