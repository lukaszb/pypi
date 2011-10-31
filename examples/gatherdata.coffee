pypi = require 'pypi'
_    = require 'underscore'


client = new pypi.Client "http://pypi.python.org/pypi"

if process.argv.length != 3
    console.log "usage: coffee gatherdata.coffee PACKAGE_NAME"
    process.exit 1
else
    package = process.argv[2]

client.getPackageReleases package, (versions) ->
    toFetch = versions.length
    
    data = {versions: {}}

    totalDownloads = 0
    totalUrls = 0

    latestVersion = versions.length and _.clone(versions).sort()[versions.length - 1]

    _.each versions, (version) ->
        client.getReleaseUrls package, version, (urls) ->
            
            for urlData in urls
                totalDownloads += urlData.downloads
                totalUrls += 1
                date = new Date urlData.upload_time

            toFetch--
            if toFetch == 0
                onDone()

    onDone = ->
        console.log "Package: #{package}"
        console.log "Versions count: #{versions.length}"
        console.log "Total urls count: #{totalUrls}"
        console.log "Total downloads: #{totalDownloads}"
        console.log "Latest version: #{latestVersion}"
        
        
        process.exit(0)

