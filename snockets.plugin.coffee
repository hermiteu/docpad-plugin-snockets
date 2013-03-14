# Export Plugin
module.exports = (BasePlugin) ->
  # Define Plugin
  class SnocketsPlugin extends BasePlugin
    # Plugin name
    name: 'snockets'

    # =============================
    # Renderers

    # Concatenate files
    concatenateFiles: (opts,next) ->
      # Prepare
      {inExtension,outExtension,content,file} = opts
      Snockets = require 'snockets'
      snockets = new Snockets()

      # Render
      opts.content = snockets.getConcatenation (file.get('fullPath')), async: false
      
      # Done
      next()


    # =============================
    # Events

    # Render
    # Called per document, for each extension conversion. Used to render one extension to another.
    render: (opts,next) ->
      # Prepare
      {inExtension,outExtension,content,file} = opts

      # CoffeeScript to JavaScript
      if inExtension in ['coffee'] and outExtension in ['js',null]
        
        # Render and complete        
        @concatenateFiles(opts,next)

      # Something else
      else
        # Nothing to do, return back to DocPad
        return next()