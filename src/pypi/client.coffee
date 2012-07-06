xmlrpc = require 'xmlrpc'

DEFAULT_URL = 'http://pypi.python.org/pypi'


class Client

    constructor: (url=DEFAULT_URL) ->
        @url = url
        @xmlrpcClient = xmlrpc.createClient @url

    callXmlrpc: (method, args, callback, onError) ->
        @xmlrpcClient.methodCall method, args, (error, value) ->
            if error and onError
                onError(error)
            else if callback
                callback(value)

    getPackageReleases: (pkg, callback, onError, showHidden=false) ->
        @callXmlrpc "package_releases", [pkg, showHidden], callback, onError

    getPackagesList: (callback, onError) ->
        @callXmlrpc "list_packages", [], callback, onError

    getPackageRoles: (pkg, callback, onError) ->
        @callXmlrpc "package_roles", [pkg], callback, onError

    getUserPackages: (pkg, callback, onError) ->
        @callXmlrpc "user_packages", [pkg], callback, onError

    getReleaseData: (pkg, version, callback, onError) ->
        @callXmlrpc "release_data", [pkg, version], callback, onError

    getReleaseDownloads: (pkg, version, callback, onError) ->
        @callXmlrpc "release_downloads", [pkg, version], callback, onError

    getReleaseUrls: (pkg, version, callback, onError) ->
        @callXmlrpc "release_urls", [pkg, version], callback, onError

    search: (pkg, callback, onError) ->
        @callXmlrpc "search", [{name: pkg}], callback, onError


module.exports = Client

