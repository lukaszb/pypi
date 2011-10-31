pypi = require '../../index'


client = new pypi.Client 'http://pypi.python.org/pypi'

client.getPackageReleases 'vcs', (versions) ->
    
    for version in versions
        client.getReleaseUrls 'vcs', version, (urls) ->
            for urlData in urls
                console.log(urlData)
            

