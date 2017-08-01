Postfix Testing Mail Relay
==========================

Contains:

* Postfix, running in a simple relay mode
* RSyslog

Processes are managed by supervisord, including cronjobs

The container provides a simple open relay for testing purposes that forwards all mail to a specific
mail address with headers (including From and To) left intact.


Exports
-------

* Postfix on `25`

Variables
---------

* `RELAY_HOST_NAME=relay.example.com`: A DNS name for this relay container (usually the same as the Docker's hostname)
* `ACCEPTED_NETWORKS=192.168.0.0/16 172.16.0.0/12 10.0.0.0/8`: A network (or a list of networks) to accept mail from
* `SMTP_LOGIN=`: Login to connect to the external relay (required, otherwise the container fails to start)
* `SMTP_PASSWORD=`: Password to connect to the external relay (required, otherwise the container fails to start)
* `USE_TLS=`: Remote require tls. Might be "yes" or "no". Default: no.
* `TLS_VERIFY=`: Trust level for checking the remote side cert. (none, may, encrypt, dane, dane-only, fingerprint, verify, secure). Default: may.

Example
-------

Launch Postfix container:

    $ docker run -d -h relay.example.com --name="mailrelay" -e SMTP_LOGIN=myLogin -e SMTP_PASSWORD=myPassword -p 25:25 alterrebe/postfix-relay

