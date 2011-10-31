# This is the Hubot Loading Bay.  NPM uses it as an entry point.
#
#     Hubot = require 'hubot'
#     YourBot = Hubot.robot 'campfire', 'blah', 'yourbot'
Client = require './src/pypi/client'

exports.Client = Client

