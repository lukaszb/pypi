PyPI Client for Node.js
=======================

``pypi`` is a simple client which can talk with `Python Package Index`_.


Example
-------

Fire up ``coffee`` console and run::

    coffee> pypi = require 'pypi'
    coffee> client = new pypi.Client
    coffee> client.getPackageReleases "Django", (versions) -> console.log versions
    coffee> [ '1.3.1', '1.3', '1.2.7', '1.2.6', '1.2.5', '1.2.4', '1.2.3', '1.2.2', '1.2.1', '1.2', '1.1.4', '1.1.3', '1.1.2', '1.0.4' ]


Overview
--------

Basically, ``Client`` objects talk with `xmlrpc PyPI interface`_ and runs
*callbacks* once server responses. Additionally, if underlying xmlrpc_ client
would return *error*, *onError* callback would be called (if passed) with
returned *error* as parameter.


pypi.Client API
---------------

callXmlrpc: (method, args, callback, onError)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is low level client's method to use underlying xmlrpc_ library to talk
with *PyPI* server. It accepts ``method`` paramter, list of arguments (``args``)
and *callback* that should be run with responded result or *onError* which
would be called in case of any error.


getPackageReleases (package, callback, onError, showHidden=false)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Callback would receive list of versions that are registered at PyPI_. If
``showHidden`` is set to ``true``, hidden versions would be included in
the response.

getPackagesList (callback, onError)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Callback would receive list of **ALL** packages registered at PyPI_.

getPackageRoles (package, callback, onError)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Callback would receive list of 2 elements lists (role, username). In example::

    coffee> client.getPackageRoles "Django", (roles) -> console.log roles
    coffee> [ [ 'Owner', 'ubernostrum' ], [ 'Owner', 'jacobian' ] ]

Roles may be one of ``Owner`` or ``Maintainer``.

getUserPackages (username, callback, onError)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Callback would receive list of 2 elements lists (role, packageName). In
example::

    coffee> client.getUserPackages "ubernostrum", (packages) -> console.log packages
    coffee> [ [ 'Owner', 'webcolors' ], [ 'Owner', 'pownce-api' ], [ 'Owner', 'django-registration' ], [ 'Owner', 'django-profiles' ], [ 'Owner', 'django-flashpolicies' ], [ 'Owner', 'Django' ], [ 'Owner', 'django-funserver' ] ]


getReleaseData (package, version, callback, onError)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Callback would receive dictionary with following keys:

- name
- version
- stable_version
- author
- author_email
- maintainer
- maintainer_email
- home_page
- license
- summary
- description
- keywords
- platform
- download_url
- classifiers (list of classifier strings)
- requires
- requires_dist
- provides
- provides_dist
- requires_external
- requires_python
- obsoletes
- obsoletes_dist
- project_url

Example::

    coffee> client.getReleaseData "vcs", (val) -> console.log val
    coffee> client.getReleaseData "vcs", "0.2.2", (data) -> console.log data
    coffee> { maintainer: null,
      requires_python: null,
      maintainer_email: null,
      cheesecake_code_kwalitee_id: null,
      keywords: null,
      package_url: 'http://pypi.python.org/pypi/vcs',
      author: 'Marcin Kuzminski, Lukasz Balcerzak',
      author_email: 'marcin@python-works.com',
      download_url: 'UNKNOWN',
      platform: 'UNKNOWN',
      version: '0.2.2',
      cheesecake_documentation_id: null,
      _pypi_hidden: false,
      description: '===\nVCS\n===\n\nvarious version control system management abstraction layer for python.\n\n------------\nIntroduction\n------------\n\n``vcs`` is abstraction layer over various version control systems. It is\ndesigned as feature-rich Python_ library with clean *API*.\n\nvcs uses `Semantic Versioning <http://semver.org/>`_\n\n**Features**\n\n- Common *API* for SCM backends\n- Fetching repositories data lazily\n- Simple caching mechanism so we don\'t hit repo too often\n\n**Incoming**\n\n- Simple commit api\n- Smart and powerfull in memory Workdirs\n\n-------------\nDocumentation\n-------------\n\nOnline documentation for development version is available at\nhttp://packages.python.org/vcs/.\n\nYou may also build documentation for yourself - go into ``docs/`` and run::\n\n   make html\n\n.. _python: http://www.python.org/\n.. _Sphinx: http://sphinx.pocoo.org/\n.. _mercurial: http://mercurial.selenic.com/\n.. _git: http://git-scm.com/',
      release_url: 'http://pypi.python.org/pypi/vcs/0.2.2',
      _pypi_ordering: 115,
      classifiers: [ 'Development Status :: 4 - Beta', 'Intended Audience :: Developers', 'License :: OSI Approved :: MIT License', 'Operating System :: OS Independent', 'Programming Language :: Python' ],
      bugtrack_url: null,
      name: 'vcs',
      license: 'UNKNOWN',
      summary: 'vcs\n    ~~~\n\n    Various version Control System (vcs) management abstraction layer for\n    Python.\n\n    :created_on: Apr 8, 2010\n    :copyright: (c) 2010-2011 by Marcin Kuzminski, Lukasz Balcerzak.',
      home_page: 'https://github.com/codeinn/vcs',
      stable_version: null,
      cheesecake_installability_id: null }


getReleaseDownloads (package, version, callback, onError)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Callback would receive list of 2 elements lists (filename, downloads count).
Example::

    coffee> client.getReleaseDownloads "Django", "1.3.1", (data) -> console.log data
    coffee> [ [ 'Django-1.3.1.tar.gz', 59412 ] ]



getReleaseUrls (package, version, callback, onError)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Callback would receive list of objects and each of those objects would have
following keys:

- url
- packagetype ('sdist', 'bdist', etc)
- filename
- size
- md5_digest
- downloads
- has_sig
- python_version (required version, or 'source', or 'any')
- comment_text

Example::

    coffee> client.getReleaseUrls "Django", "1.3.1", (urls) -> console.log urls
    coffee> [ { has_sig: false,
        upload_time: Sat, 10 Sep 2011 01:36:21 GMT,
        comment_text: '',
        python_version: 'source',
        url: 'http://pypi.python.org/packages/source/D/Django/Django-1.3.1.tar.gz',
        md5_digest: '62d8642fd06b9a0bf8544178f8500767',
        downloads: 59412,
        filename: 'Django-1.3.1.tar.gz',
        packagetype: 'sdist',
        size: 6514564 } ]


Usage examples
--------------

This snippet would print total number of downloads for a *Django* package::

    _    = require 'underscore'
    pypi = require 'pypi'


    sum = (numbers) -> _.reduce(numbers, (memo, num) ->
        memo + num
    , 0)

    showTotalDownloads = (package) ->
        client = new pypi.Client
        totalDownloads = 0
        client.getPackageReleases package, (versions) ->
            todo = versions.length
            onDone = ->
                console.log "Package #{package} was downloaded for #{totalDownloads} times."
                
            _.each versions, (version) ->
                client.getReleaseDownloads package, version, (downloads) ->
                    downloadCounts = (row[1] for row in downloads)
                    totalDownloads += sum(downloadCounts)
                    todo -= 1
                    if todo == 0
                        onDone()

    showTotalDownloads "Django"


.. _`Python Package Index`: http://pypi.python.org/pypi/
.. _`PyPI`: http://pypi.python.org/pypi/
.. _`xmlrpc PyPI interface`: http://wiki.python.org/moin/PyPiXmlRpc
.. _xmlrpc: https://github.com/baalexander/node-xmlrpc

