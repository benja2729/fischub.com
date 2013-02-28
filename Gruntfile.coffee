
module.exports = (grunt) ->

  grunt.initConfig
    #pkg: grunt.file.readJSON 'package.json'

    copy:
      lib:
        files: [
          expand: true
          cwd: 'components/'
          src: ['lib/**/*.js', 'bootstrap/js/*.js']
          dest: 'js/lib/'
          flatten: true
          filter: 'isFile'
        ]

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

    regarde:
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
  grunt.loadNpmTasks 'grunt-regarde'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-ember-templates'

  # Defining Tasks
  grunt.registerTask 'compile', ['copy:lib', 'coffee:dev', 'ember_templates:dev', 'less:dev']
  #grunt.registerTask 'compile:dist', []

  grunt.registerTask 'default', ['dev']