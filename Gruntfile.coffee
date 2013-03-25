
jqueryPluginAMD = (content, dependents) ->
  deps = ['jquery']

  if dependents? then deps = deps.concat dependents

  fnRegex = ///

    # Items to exclude from the replace string
    (?:[\s\t]+)?    # Empty space
    [!\(]?              # Function execution characters
    (?:[\s\t]+)?        # Empty space

    # Plugin function literal
    # Will show-up as $1 in replace string
    (
      function
      (?:[\s\t]+)?      # Empty space
      \(
      (?:[\s\t]+)?      # Empty space
      \$                # The jQuery parameter
      (?:[\s\t]+)?      # Empty space
      \)
      (?:[\s\t]+)?      # Empty space
      (.+[\n\r]+)+      # Code block
      }                 # Selects everything until the `}` character
    )

    (?:[\s\t]+)?        # Empty space
    \)?                 # End function execution characters
    (?:\.call)?         # In case of .call method
    (?:[\s\t]+)?        # Empty space
    \(
    (?:[\s\t]+)?        # Empty space
    (?:window,(\s+)?)?  # In case of .call method
    (?:window\.)?jQuery
    (?:[\s\t]+)?        # Empty space
    \)

  ///m

  defineStart = """
    \n\n
    !function (factory) {
      if (typeof define === 'function' && define.amd) {

        // AMD. Register as an anonymous module.
        define(['#{deps.join "', '"}'], factory);
      } else {

        // Browser globals
        factory(jQuery);
      }
    }($1)
  """

  content.replace fnRegex, defineStart


module.exports = (grunt) ->

  grunt.initConfig
    #pkg: grunt.file.readJSON 'package.json'

    copy:
      bootstrap:
        options:
          processContent: (content, srcpath) ->
            if /\/bootstrap-[\w\.]+\.js$/.test srcpath
              jqueryPluginAMD content
            else content
        expand: true
        cwd: 'components/'
        src: ['lib/**/*.js', 'bootstrap/js/*.js']
        dest: 'js/lib/'
        flatten: true
        filter: 'isFile'

      images:
        expand: true
        src: ['components/bootstrap/img/*']
        dest:'img/'
        flatten: true

    coffee:
      options:
        bare: true
      dev:
        expand: true
        cwd: 'src/coffee'
        src: ['**/*.coffee']
        dest: 'js/'
        ext: '.js'

    ember_templates:
      options:
        templateName: (filename) ->
          filename = filename.match(/[^\/]+$/).pop()
          # The dasherize code from ember
          filename = filename.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase()
          return filename.replace /[ _]/g, '-'
      dev:
        files: 'js/templates.js': ['src/templates/**/*']

    less:
      options:
        paths: ['components/bootstrap/less', 'src/less']
        strictImports: true
      dev:
        files: 'css/style.css': 'src/less/**/*.less'

    concat:
      bootstrap: # Switched to grunt-wrap for Bootstrap
        options:
          separator: ';'
        src: [
          'components/bootstrap/js/bootstrap-collapse.js'
        ,
          'components/bootstrap/js/bootstrap-transition.js'
        ,
          'components/bootstrap/js/bootstrap-modal.js'
        ]
        dest: 'js/lib/bootstrap.js'

    wrap:
      bootstrap:
        flatten: true
        expand: true
        filter: 'isFile'
        src: ['components/bootstrap/js/bootstrap-*.js']
        dest: 'js/lib/'
        wrapper: ['define([\'jquery\'], function(jQuery) {\nvar $ = jQuery;\n', '\n});']

    regarde:
      grunt:
        files: ['Gruntfile.coffee']
        tasks: ['compile']
      less:
        files: ['src/less/**/*.less']
        tasks: ['less:dev']
      coffee:
        files: ['src/coffee/**/*.coffee']
        tasks: ['coffee:dev']
      ember_templates:
        files: ['src/templates/**/*.{hbs, handlebars}']
        tasks: ['ember_templates:dev']

  # Loading Tasks
  grunt.loadNpmTasks 'grunt-wrap'
  grunt.loadNpmTasks 'grunt-regarde'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-ember-templates'

  # Defining Tasks
  grunt.registerTask 'compile', ['copy', 'coffee:dev', 'ember_templates:dev', 'less:dev']
  #grunt.registerTask 'compile:dist', []

  grunt.registerTask 'default', ['compile', 'regarde']