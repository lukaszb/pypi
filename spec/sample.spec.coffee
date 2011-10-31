pypi     = require '../index'
nodemock = require 'nodemock'


describe "pypi.Client", ->
    client = null

    beforeEach ->
        client = new pypi.Client "http://pypi.python.org/pypi"

    mockMethodCall = (error, value) ->
        return (method, args, callback) ->
            return callback(error, value)

    it "callXmlrpc calls callback on success", ->
        client.xmlrpcClient.methodCall = mockMethodCall undefined, "FOOBAR"
        callback = jasmine.createSpy()
        client.callXmlrpc "method", [], callback
        expect(callback).toHaveBeenCalledWith('FOOBAR')

    it "callXmlrpc calls onError on error", ->
        client.xmlrpcClient.methodCall = mockMethodCall "FOOBAR", undefined
        callback = jasmine.createSpy()
        onError = jasmine.createSpy('onError')
        client.callXmlrpc "method", [], callback, onError
        expect(onError).toHaveBeenCalledWith('FOOBAR')
        expect(callback).not.toHaveBeenCalled()

    it "getPackagesList", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.getPackagesList callback, onError
        expect(client.callXmlrpc).toHaveBeenCalledWith('list_packages',
            [], callback, onError)

    it "getPackageReleases", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.getPackageReleases "pip", callback, onError, true
        expect(client.callXmlrpc).toHaveBeenCalledWith('package_releases',
            ['pip', true], callback, onError)

    it "getPackageRoles", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.getPackageRoles "Django", callback, onError
        expect(client.callXmlrpc).toHaveBeenCalledWith('package_roles',
            ['Django'], callback, onError)

    it "getUserPackages", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.getUserPackages "username", callback, onError
        expect(client.callXmlrpc).toHaveBeenCalledWith('user_packages',
            ['username'], callback, onError)

    it "getReleaseData", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.getReleaseData "Django", "1.3.1", callback, onError
        expect(client.callXmlrpc).toHaveBeenCalledWith('release_data',
            ['Django', '1.3.1'], callback, onError)

    it "getReleaseDownloads", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.getReleaseDownloads "Django", "1.3.1", callback, onError
        expect(client.callXmlrpc).toHaveBeenCalledWith('release_downloads',
            ['Django', '1.3.1'], callback, onError)

    it "getReleaseUrls", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.getReleaseUrls "Django", "1.3.1", callback, onError
        expect(client.callXmlrpc).toHaveBeenCalledWith('release_urls',
            ['Django', '1.3.1'], callback, onError)

    it "search", ->
        client.callXmlrpc = jasmine.createSpy 'callXmlrpc'
        callback = jasmine.createSpy 'callback'
        onError = jasmine.createSpy 'onError'
        client.search 'Django', callback, onError
        expect(client.callXmlrpc).toHaveBeenCalledWith('search',
            [{name: 'Django'}], callback, onError)

