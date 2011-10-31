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

    getPackageReleases: (package, callback, onError, showHidden=false) ->
        @callXmlrpc "package_releases", [package, showHidden], callback, onError

    getPackagesList: (callback, onError) ->
        @callXmlrpc "list_packages", [], callback, onError

    getPackageRoles: (package, callback, onError) ->
        @callXmlrpc "package_roles", [package], callback, onError

    getUserPackages: (package, callback, onError) ->
        @callXmlrpc "user_packages", [package], callback, onError

    getReleaseData: (package, version, callback, onError) ->
        @callXmlrpc "release_data", [package, version], callback, onError

    getReleaseDownloads: (package, version, callback, onError) ->
        @callXmlrpc "release_downloads", [package, version], callback, onError

    getReleaseUrls: (package, version, callback, onError) ->
        @callXmlrpc "release_urls", [package, version], callback, onError

    search: (package, callback, onError) ->
        @callXmlrpc "search", [{name: package}], callback, onError


module.exports = Client

